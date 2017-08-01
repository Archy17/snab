-module(gs).

-behaviour(gen_server).


-export([start_link/0, create/3, close/0]).


-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
         terminate/2, code_change/3]).


-define(SERVER, ?MODULE).


start_link() ->
  gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).

<<<<<<< HEAD
  create(Name, Adress,Bissnes) ->
  gen_server:call(?SERVER, {create, Name , Adress, Bissnes}).
=======
  create(Name) ->
  gen_server:call(?SERVER, {create, Name}).

>>>>>>> 03581d4df352f29b19e6273d57d02eea75180127

  close() -> gen_server:call(?SERVER, {close}).
	  
init([]) ->
<<<<<<< HEAD
  {ok, dets:open_file(md,  [{type, set}])}.

handle_call({create, Name, Adress,Bissnes}, _From, State) ->
 case dets:lookup(md, Name) of
  [] -> dets:insert(md, {Name, Adress,Bissnes}),
  {reply, {oke}, State};
  _else -> 
  {reply, {error}, State}
			end;

handle_call({close}, _From, State) -> dets:close(md),
	{reply, {oke}, State}
									   end;

handle_call(_Request, _From, State) ->
  Reply = ok,
  {reply, Reply, State}.

									   
=======
  dets:open_file(md, []).

handle_call({create, Name}, _From, State) ->
 case dets:lookup(md, Name) of
  [] -> dets:insert(md, {Name}),
  {reply, {oke}, State};
  _else -> 
  {reply, {error}, State}
  
 end.

>>>>>>> 03581d4df352f29b19e6273d57d02eea75180127
handle_cast(_Msg, State) ->
  {noreply, State}.


handle_info(_Info, State) ->
  {noreply, State}.


terminate(_Reason, _State) ->
  ok.


code_change(_OldVsn, State, _Extra) ->
{ok, State}.
