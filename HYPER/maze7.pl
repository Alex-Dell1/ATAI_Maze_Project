%% Background Knowledge
size(L) :- numlist(1,7,L).

obstacle((1,2)).
obstacle((2,2)).
obstacle((3,2)).
obstacle((5,5)).
obstacle((4,5)).
obstacle((3,5)).
obstacle((2,5)).
obstacle((1,5)).
obstacle((5,6)).
obstacle((4,6)).
obstacle((3,6)).
obstacle((2,6)).
obstacle((1,6)).
obstacle((1,7)).
obstacle((6,1)).
obstacle((7,1)).

start((1,1)).
goal((2,7)).