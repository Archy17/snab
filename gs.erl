-module(gsl).
 
-behaviour(gen_server).
 
-export([start_link/0,
        create_acc/2,
       
 
-export([init/1, handle_call/3, handle_info/2,
         terminate/2, code_change/3]),
 

 
 
start_link() ->
  gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).
 
creat_acc(Name, Email) -> gen_server:call(?SERVER, {creat, Name, Email}).
 


init([]) ->
 ?MODULE = dets:open_file(?MODULE, [set, my_dets]).
 
handle_call({creat, Name, Email}, _From, State) ->
  case dets:lookup(my_dets, Name) of
     [{Name, _, _}] -> 
        error,
     [] ->
        dets:insert(Name, Email),
        {reply, Response , State};
  end.
 
 
handle_info(_Info, State) ->
 {noreply, State}.
 
 
terminate(_Reason, _State) ->
  ok.
 
code_change(_OldVsn, State, _Extra) ->
  {ok, State}.
