-module(gs).

-behaviour(gen_server).


-export([start_link/0, create/1, del/1]).


-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
         terminate/2, code_change/3]).

-record(state, {}).
-define(SERVER, ?MODULE).


start_link() ->
  gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).

  create(Name) ->
  gen_server:call(?SERVER, {create, Name}).

 del(Name) ->
  gen_server:call(?SERVER, {del, Name}).

init([]) ->
  {ok, dets:open_file(md, [])}.

handle_call({create, Name}, _From, State) ->
 case dets:lookup(md, Name) of
  [] -> dets:insert(md, {Name}),
  {reply, {oke}, State};
  _else -> 
  {reply, {error}, State}
  end;

  
  
handle_call({del, Name}, _From, State) ->
 dets:delete(md, {Name}),
  {reply, {okedel}, State};
  _else -> 
  {reply, {error}, State}
  
 end.


handle_cast(_Msg, State) ->
  {noreply, State}.


handle_info(_Info, State) ->
  {noreply, State}.


terminate(_Reason, _State) ->
  ok.


code_change(_OldVsn, State, _Extra) ->
  {ok, State}.
