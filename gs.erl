-module(gs).

-behaviour(gen_server).


-export([start_link/0, create/3, read/1, close/0]).


-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
         terminate/2, code_change/3]).


-define(SERVER, ?MODULE).

  
start_link() ->
  gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).

  create(Name, Adress,Bissnes) ->
  gen_server:call(?SERVER, {create, Name , Adress, Bissnes}).
  
  read(Name) ->
  gen_server:call(?SERVER, {read, Name}).

  close() -> gen_server:call(?SERVER, {close}).
	  
init([]) ->
  {ok, dets:open_file(md,  [{type, set}])}.

handle_call({create, Name, Adress,Bissnes}, _From, State) ->
 case dets:lookup(md, Name) of
  [] -> dets:insert(md, {Name, Adress,Bissnes}),
  {reply, {oke}, State};
  _else -> 
  {reply, {error}, State}
			end;

			
			
handle_call({read, Name}, _From, State) ->
 case dets:lookup(md, Name) of
  [] -> dets:lookup(md, Name),
  {reply, {error}, State};
  _else -> 
  {reply, dets:lookup(md, Name), State}
			end;
			
			
%% handle_call({read, Name}, _From, State) ->
%%   dets:lookup(md, Name),
%%   {reply, {ok}, State};
  
			
			
handle_call({close}, _From, State) -> dets:close(md),
	{reply, {okeKlose}, State};
									 

handle_call(_Request, _From, State) ->
  Reply = ok,
  {reply, Reply, State}.

									   
handle_cast(_Msg, State) ->
  {noreply, State}.


handle_info(_Info, State) ->
  {noreply, State}.


terminate(_Reason, _State) ->
  ok.


code_change(_OldVsn, State, _Extra) ->
{ok, State}.