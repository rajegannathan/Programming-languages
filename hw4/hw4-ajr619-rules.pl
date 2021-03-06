%% Question 1
%% creating 6 users
user(@tony).
user(@anirudhan).
user(@narasimman).
user(@vivek).
user(@shan).
user(@shu).
user(@gopi).


%% queestion 2
%% creating relationships between the users
follows(@tony, @anirudhan).
follows(@shan, @anirudhan).
follows(@shu, @anirudhan).
follows(@vivek, @shu).
follows(@anirudhan, @narasimman).
follows(@narasimman, @vivek).
follows(@gopi, @tony).
follows(@shu, @gopi).


%% queestion 3
%% creating tweets for users
tweet(@anirudhan, t1, [anirudhan, first, tweet]).
tweet(@anirudhan, t2, [anirudhan, second, tweet]).
tweet(@anirudhan, t3, [anirudhan, third, tweet]).
tweet(@anirudhan, t4, [anirudhan, fourth, tweet]).
tweet(@tony, t5, [tony, first, tweet]).
tweet(@tony, t6, [tony, second, tweet]).
tweet(@narasimman, t7, [narasimman, first, tweet]).
tweet(@narasimman, t8, [narasimman, second, tweet]).
tweet(@vivek, t9, [@narasimman, direct, message]).
tweet(@shan, t10, [@narasimman, second, direct, message]).
tweet(@anirudhan, t11, [anirudhan, redireciton, test]).


%% queestion 4
%% creating retweets
retweet(@shan, t8).
retweet(@shu, t3).
retweet(@vivek, t1).
retweet(@shan, t1).
retweet(@narasimman, t5).
retweet(@narasimman, t1).
retweet(@shan, t2).
retweet(@shu, t2).
retweet(@tony, t11).
retweet(@gopi, t11).
retweet(@shu, t11).

%% queestion 5
%% The feedhelper function.  Returns tweets and retweeets for the users followers
feedhelper(U, F, M, I) :- follows(U, F), (tweet(F,I,M);retweet(F,I)).

%% functions given as a part of assignment text itself
remove_ident([],[]).
remove_ident([[_|Y]|T1],[H2|T2]) :- Y=H2,remove_ident(T1,T2).

uniquefeed(U,R) :- setof([I,F|M],feedhelper(U,F,M,I),R).
feed(U,M) :- uniquefeed(U,O),remove_ident(O,M).

%% search
%% question 6

search(K, U, M) :- tweet(U, _, M), memberchk(K, M).

%% isviral (S, I, R)
%% question 7
%% S = Un, R =  U1, I = Id.
isviral(S, I, R) :- tweet(S, I, _), follows(R, S).
isviral(S, I, R) :- retweet(User, I), follows(R, User), isviral(S, I, User).

%% isviral (S, I, R, M)
%% question 8
isviral(S, I, R, M) :- tweet(S, I, _), follows(R, S), M =< 1.
isviral(S, I, R, M) :- retweet(User, I), follows(R, User), N is M-1, isviral(S, I, User, N).

%%queries
numretweets(I, Length) :- findall(I, retweet(_, I), B), length(B, Length).

%% direct message
show_inbox(U, M) :- tweet(_, _, M), nth0(0, M, U).

