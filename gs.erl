-module(gs).

-behaviour(gen_server).


-export([start_link/0, create/1]).


-export([init/1, handle_cast/2, handle_info/2,
         terminate/2, code_change/3]).

-record(state, {}).
-define(SERVER, ?MODULE).


start_link() ->
  gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).

  create(Name) ->
  gen_server:cast(?SERVER, {create, Name}).


init([]) ->
  {ok, dets:open_file(md, [])}.





handle_cast({create, Name}, State) ->
  case dets:lookup(md, Name) of
  [{Name}] -> error,
        
    {noreply, State};
  [] -> dets:insert(md, {Name}),
  {noreply, State}
  end.


handle_info(_Info, State) ->
  {noreply, State}.


terminate(_Reason, _State) ->
  ok.


code_change(_OldVsn, State, _Extra) ->
  {ok, State}.