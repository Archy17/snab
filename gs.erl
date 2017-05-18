-module(gs).

-behaviour(gen_server).

-export([start_link/0,
        create_account/2,
        predl/2,
        spros/2,
        delete_account/1]).

-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
         terminate/2, code_change/3]).

-define(SERVER, ?MODULE).


start_link() ->
  gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).

create_account(Name, Email) ->
  gen_server:cast(?SERVER, {create, Name, Email}).

predl(Name, P_predl) ->
  gen_server:call(?SERVER, {deposit, Name, P_predl}).


spros(Name, P_spros) ->
  gen_server:call(?SERVER, {spros, Name, P_spros}).

delete_account(Name) ->
  gen_server:cast(?SERVER, {destroy, Name}).

init([]) ->
 ?MODULE = dets:open_file(?MODULE, [set, my_dets]).



handle_call({predl, Name, P_predl}, _From, State) ->
  case dets:first(my_dets) of
    {ok, Value} ->
      New_predl = P_predl + Old_predl,
      Response = {ok, predl},
      NewState = dets:insert(Name, New_predl, State),
      {reply, Response, NewState};
    error ->
      {reply, {error, account_does_not_exist}, State}
end;



handle_call({spros, Name, P_spros}, _From, State) ->
  case dets:first(my_dets) of
    {ok, Value} ->
      New_spros = P_spros + Old_spros,
      Response = {ok, spros},
      NewState = dets:insert(Name, New_spros, State),
      {reply, Response, NewState};
    error ->
      {reply, {error, account_does_not_exist}, State}
  end.




handle_cast({create, Name, Email}, State) ->
  {noreply, dets:insert(my_dets,{Name, Email, Old_predl, Old_spros}, State)};
handle_cast({destroy, Name}, State) ->
  {noreply, dets:delete(my_dets, {Name, _,_,_}, State)};
handle_cast(_Msg, State) ->
  {noreply, State}.

handle_info(_Info, State) ->
  {noreply, State}.


terminate(_Reason, _State) ->
  ok.

code_change(_OldVsn, State, _Extra) ->
  {ok, State}.