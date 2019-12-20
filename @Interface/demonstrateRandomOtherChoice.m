function [key time]=demonstrateRandomOtherChoice(this,R,Pl)
            if nargin<3; Pl=struct; end;
			this.resetScreen();
			og=Pl.group;
			s=size(R.groups); ngroups=s(1);
			while og==Pl.group; og=randi(ngroups,1); end;
			group=R.groups(og,:);
			left=randi(2); right=3-left;
			p1=group(left); p2=group(right);
			Pl.randomGroup=og; Pl.randGrLeftPlayer=p1; Pl.randGrRightPlayer=p2;
			good1=R.Players(p1).myGood(); good2=R.Players(p2).myGood();
			type1=R.Players(p1).myType(); type2=R.Players(p2).myType();
			Pl.randGrLeftType=type1; Pl.randGrLeftGood=good1; Pl.randGrRightType=type2; Pl.randGrRightGood=good2;
			will1=R.Players(p1).shouldIExchange(good2,R); will2=R.Players(p2).shouldIExchange(good1,R);
			Pl.randGrLeftAccepts=will1; Pl.randGrRightAccepts=will2;
            texts={'Voici un autre joueur tir� au sort :', ' '}; textcolor=this.black;
            Screen('FillRect',this.window,this.white);
            this.drawExchangeQuestion(type1,good1,type2,good2,[],texts,textcolor,0);
			codes=[this.leftCode this.rightCode];
			if(this.spacesAtInfoScreen); codes=this.spaceCode; end;
            if this.alreadyLaunched; Screen('Flip', this.window); end;
			% Screen('Flip', this.window);
			WaitSecs(2);
			if will1; 
				texts{2}='Le joueur � gauche SOUHAITE r�aliser l''�change'; 
				key=1; 
			else;  
				texts{2}='Le joueur � gauche NE souhaite PAS r�aliser l''�change';
				% texts={'Le joueur � gauche ne souhaite pas r�aliser l''�change' }; 
				key=0; 
			end;
            % if(~this.useIntervalEverythere); [key time]=this.waitKeyPress(-this.exchangeConfirmTime); else [key time]=this.waitKeyPress(2); end;
            %this.alreadyLaunched=1;
			this.resetScreen();
			this.drawExchangeQuestion(type1,good1,type2,good2,key,texts,textcolor,2);
			Screen('Flip', this.window);
			codes=[this.leftCode this.rightCode];
			if(this.spacesAtInfoScreen); codes=this.spaceCode; end;
			WaitSecs(1);
			[key time]=this.waitKeyPress(Inf,codes);
			this.alreadyLaunched=1;
			this.waitKeyRelease(0.3,codes);
			% WaitSecs(2);
			% [key time]=this.waitKeyPress(2,codes);
			% this.resetScreen();
            %if key; this.animExchange(othertype,othergood); else this.resetScreen; end;
            rep=key;
end