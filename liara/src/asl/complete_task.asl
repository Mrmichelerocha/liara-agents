// Agent complete_task in project liara

/* Initial beliefs and rules */

has_block(Type):- thing(X,Y,block,Type) & attached(X,Y) & carrying_block & (math.abs(X) + math.abs(Y)) == 1.
has_block_at(XDel,YDel,Type) :- thing(XDel,YDel,block,Type) & attached(XDel,YDel) & carrying_block & (math.abs(XDel) + math.abs(YDel)) == 1.

/* Initial goals */

/* Simple task (1 block) */
/* In case the block is at correct position - DELIVER */
+!deliver_task(TName,[req(XDel,YDel,Type)])[_]: position(X,Y) & goalZone(X,Y)[source(memory)] & has_block_at(XDel,YDel,Type)
	<- 	-movingToGoalZone(_,_);
		!submit_task(TName).

/* In case the block is not at correct position - ROTATE (CW - clockwise | or | CCW - counterclockwise) */
/* In case cannot rotate because obstacles, clear the obstacles */

+!deliver_task(TName,[req(0,1,Type)])[_]: position(X,Y) & goalZone(X,Y)[source(memory)] & has_block_at(-1,0,Type) & thing(0,1,obstacle,_) <- clear(0,1).	
+!deliver_task(TName,[req(0,1,Type)])[_]: position(X,Y) & goalZone(X,Y)[source(memory)] & has_block_at(-1,0,Type) & not(obstacle_at(0,1)) <- rotate(ccw).
+!deliver_task(TName,[req(0,1,Type)])[_]: position(X,Y) & goalZone(X,Y)[source(memory)] & has_block_at(1,0,Type)  & thing(0,1,obstacle,_) <- clear(0,1).	
+!deliver_task(TName,[req(0,1,Type)])[_]: position(X,Y) & goalZone(X,Y)[source(memory)] & has_block_at(1,0,Type)  & not(obstacle_at(0,1)) <- rotate(cw).
+!deliver_task(TName,[req(0,1,Type)])[_]: position(X,Y) & goalZone(X,Y)[source(memory)] & has_block_at(0,-1,Type) & thing(1,0,obstacle,_)  & not(obstacle_at(-1,0)) <- rotate(ccw).	
+!deliver_task(TName,[req(0,1,Type)])[_]: position(X,Y) & goalZone(X,Y)[source(memory)] & has_block_at(0,-1,Type) & thing(-1,0,obstacle,_) & not(obstacle_at(1,0))  <- rotate(cw).	
+!deliver_task(TName,[req(0,1,Type)])[_]: position(X,Y) & goalZone(X,Y)[source(memory)] & has_block_at(0,-1,Type) & thing(-1,0,obstacle,_) & thing(1,0,obstacle,_)  <- clear(1,0).	

+!deliver_task(TName,[req(0,-1,Type)])[_]: position(X,Y) & goalZone(X,Y)[source(memory)] & has_block_at(-1,0,Type) & thing(0,-1,obstacle,_) <- clear(0,-1).	
+!deliver_task(TName,[req(0,-1,Type)])[_]: position(X,Y) & goalZone(X,Y)[source(memory)] & has_block_at(-1,0,Type) & not(obstacle_at(0,-1)) <- rotate(cw).
+!deliver_task(TName,[req(0,-1,Type)])[_]: position(X,Y) & goalZone(X,Y)[source(memory)] & has_block_at(1,0,Type)  & thing(0,-1,obstacle,_) <- clear(0,-1).	
+!deliver_task(TName,[req(0,-1,Type)])[_]: position(X,Y) & goalZone(X,Y)[source(memory)] & has_block_at(1,0,Type)  & not(obstacle_at(0,-1)) <- rotate(ccw).
+!deliver_task(TName,[req(0,-1,Type)])[_]: position(X,Y) & goalZone(X,Y)[source(memory)] & has_block_at(0,1,Type)  & thing(1,0,obstacle,_)  & not(obstacle_at(-1,0)) <- rotate(cw).	
+!deliver_task(TName,[req(0,-1,Type)])[_]: position(X,Y) & goalZone(X,Y)[source(memory)] & has_block_at(0,1,Type)  & thing(-1,0,obstacle,_) & not(obstacle_at(1,0))  <- rotate(ccw).	
+!deliver_task(TName,[req(0,-1,Type)])[_]: position(X,Y) & goalZone(X,Y)[source(memory)] & has_block_at(0,1,Type)  & thing(-1,0,obstacle,_) & thing(1,0,obstacle,_)  <- clear(1,0).	

+!deliver_task(TName,[req(-1,0,Type)])[_]: position(X,Y) & goalZone(X,Y)[source(memory)] & has_block_at(0,-1,Type) & thing(-1,0,obstacle,_) <- clear(-1,0).	
+!deliver_task(TName,[req(-1,0,Type)])[_]: position(X,Y) & goalZone(X,Y)[source(memory)] & has_block_at(0,-1,Type) & not(obstacle_at(-1,0)) <- rotate(ccw).
+!deliver_task(TName,[req(-1,0,Type)])[_]: position(X,Y) & goalZone(X,Y)[source(memory)] & has_block_at(0,1,Type)  & thing(-1,0,obstacle,_) <- clear(-1,0).	
+!deliver_task(TName,[req(-1,0,Type)])[_]: position(X,Y) & goalZone(X,Y)[source(memory)] & has_block_at(0,1,Type)  & not(obstacle_at(-1,0)) <- rotate(cw).
+!deliver_task(TName,[req(-1,0,Type)])[_]: position(X,Y) & goalZone(X,Y)[source(memory)] & has_block_at(1,0,Type)  & thing(0,-1,obstacle,_) & not(obstacle_at(0,1))  <- rotate(cw).	
+!deliver_task(TName,[req(-1,0,Type)])[_]: position(X,Y) & goalZone(X,Y)[source(memory)] & has_block_at(1,0,Type)  & thing(0,1,obstacle,_)  & not(obstacle_at(0,-1)) <- rotate(ccw).	
+!deliver_task(TName,[req(-1,0,Type)])[_]: position(X,Y) & goalZone(X,Y)[source(memory)] & has_block_at(1,0,Type)  & thing(0,1,obstacle,_)  & thing(0,-1,obstacle,_) <- clear(0,1).	

+!deliver_task(TName,[req(1,0,Type)])[_]: position(X,Y) & goalZone(X,Y)[source(memory)] & has_block_at(0,-1,Type) & thing(1,0,obstacle,_) <- clear(1,0).	
+!deliver_task(TName,[req(1,0,Type)])[_]: position(X,Y) & goalZone(X,Y)[source(memory)] & has_block_at(0,-1,Type) & not(obstacle_at(1,0)) <- rotate(cw).
+!deliver_task(TName,[req(1,0,Type)])[_]: position(X,Y) & goalZone(X,Y)[source(memory)] & has_block_at(0,1,Type)  & thing(1,0,obstacle,_) <- clear(1,0).	
+!deliver_task(TName,[req(1,0,Type)])[_]: position(X,Y) & goalZone(X,Y)[source(memory)] & has_block_at(0,1,Type)  & not(obstacle_at(1,0)) <- rotate(ccw).
+!deliver_task(TName,[req(1,0,Type)])[_]: position(X,Y) & goalZone(X,Y)[source(memory)] & has_block_at(-1,0,Type) & thing(0,-1,obstacle,_) & not(obstacle_at(0,1))  <- rotate(ccw).	
+!deliver_task(TName,[req(1,0,Type)])[_]: position(X,Y) & goalZone(X,Y)[source(memory)] & has_block_at(-1,0,Type) & thing(0,1,obstacle,_)  & not(obstacle_at(0,-1)) <- rotate(cw).	
+!deliver_task(TName,[req(1,0,Type)])[_]: position(X,Y) & goalZone(X,Y)[source(memory)] & has_block_at(-1,0,Type) & thing(0,1,obstacle,_)  & thing(0,-1,obstacle,_) <- clear(0,-1).	
	
+!deliver_task(TName,[req(XDel,YDel,Type)])[_]: position(X,Y) & goalZone(X,Y)[source(memory)] <- rotate(cw).

/* in case it is not at goalZone - MOVE */
//+!deliver_task(TName,[req(XDel,YDel,Type)])[_]: position(XMy,YMy) & goalZone(X1,Y1)[source(memory)] & 
//		not(goalZone(X2,Y2)[source(memory)] & math.abs((X1-XMy) + (Y1-YMy)) > math.abs((X2-XMy) + (Y2-YMy)))
//	<- 	-movingToGoalZone(_,_);
//		+movingToGoalZone(X1,Y1);
//		!moveTo(X1,Y1,goalzone).
	
 +!deliver_task(TName,[req(XDel,YDel,Type)])[_]: goalZone(X,Y)[source(memory)] // (TO DO) get the closer one
	<- 	-movingToGoalZone(_,_);
		+movingToGoalZone(X,Y);
		!moveTo(X,Y,goalzone). 

		
+!submit_task(TName) <- submit(TName).

+!cancel_task(Ag,TName) <- .send(Ag,achieve,drop_task(TName)); -helping(_,TName,_,_,_,_,_,_).

+!drop_task(TName): helping(_,TName,_,_,_,_,_,_) <- -helping(_,TName,_,_,_,_,_,_).