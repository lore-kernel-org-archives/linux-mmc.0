From: Arnd Hannemann <arnd@arndnet.de>
Subject: Re: outstanding TMIO MMC patches
Date: Wed, 05 Jan 2011 22:16:24 +0100
Message-ID: <4D24DFA8.3030201@arndnet.de>
References: <Pine.LNX.4.64.1012281211560.21647@axis700.grange> <AANLkTi=NWFmskvAosK9fO65OGNLrqEY-_PdvKydyn=G2@mail.gmail.com> <20110105045347.GA23889@linux-sh.org> <20110105165757.GA7876@void.printf.net> <20110105173029.GG23889@linux-sh.org> <20110105185717.GA9016@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20110105185717.GA9016@void.printf.net>
Sender: linux-sh-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-mmc@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Ian Molton <ian@mnementh.co.uk>, Magnus Damm <damm@opensource.se>, linux-sh@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Chris,

Am 05.01.2011 19:57, schrieb Chris Ball:
> On Thu, Jan 06, 2011 at 02:30:30AM +0900, Paul Mundt wrote:
>> Again, this isn't the first time this has happened. Any perceived
>> hostility in this matter is not directed at you directly since you did
>> come in to things rather late and were possibly unaware of the situation.
>> It's more absentee maintainers I have a problem with. In any event, you
>> were Cc'ed on mails that pointed out the problem (at least in summary),
>> you've presumably seen the mails with the patches that went by with pings
>> by people looking for answers, and it still took a strongly worded email
>> to elicit any sort of response. Make of that what you will.
> 
> A politely-worded email would have achieved just as good a response as the
> insultingly-worded one.  You should reach for politeness first when dealing
> with someone who might simply be misunderstanding your expectations of them.
> 
> Since I came in late, I've been reluctant to overrule driver maintainers
> without someone asking me to do so explicitly (I'm happy to do it when
> asked to).  I do sympathize with the frustration, though; let's move on.
> 
>> In any event, we seem to have shaken out the beginnings of a way forward
>> now, so this is progress!
>>
>>> So, let's come up with a workflow.  With Ian absent, it would be good to
>>> have someone with TMIO hardware (I don't have any) who's willing to help
>>> test and review/ACK patches.  I don't generally like to take arch code
>>> in through the MMC tree, so it would also be good to break up some of
>>> the patchsets into MMC-only if possible.
>>>
>> This is basically where the problem lies. Ian has some version of the
>> hardware that we don't, and he likewise doesn't have access to the
>> version that we do (of course there would be no problem in making the
>> hardware available to whoever decides to step up and look after TMIO in a
>> more constructive fashion, though). There are likewise issues with
>> regards to who has access to what specifications, and there are cases
>> where neither Ian nor any of the people from our side have any specs at
>> all. With this sort of a scenario it can be quite difficult to avoid
>> stepping on other peoples toes and making sure that things aren't being
>> inadvertently broken, and this is something I don't see any specific
>> resolution to, other than if you're not around to test and object in a
>> timely fashion, you lose. I don't know if other MMC drivers have the same
>> problem or not, but I can't imagine that this situation is terribly
>> unique when you have both corporations and hobbyists working on the same
>> driver from vastly different angles.
> 
> I see.  So, if most patches are coming from your side, it seems that the
> largest problem for the moment is that no-one except Ian can test your
> patches against his hardware.  Do we think there's any chance of someone
> (I guess ideally you but possibly me) getting hold of hardware with Ian's
> MMC block in, for at least occasional testing before releases?
> 
> If not, is there any kind of split in the driver that we could use to try
> to isolate changes more?
> 
> If not, I guess I agree that we just have to try and be clear about what
> we're merging and the chance that we're breaking something in the process.
> 
>> For the moment Guennadi and Arnd have been doing the work, with the
>> occasional patch from Magnus and others. All of this work however is done
>> on the same set of hardware and roughly by the same set of people with an
>> identical set of interests working for the same company, which makes
>> objective code review a bit problematic. Ian has provided useful feedback
>> in the past, which is why I've generally given him the benefit of the
>> doubt and let patches sit around for a month or two before pushing on
>> people. I note that the driver is 'maintained' for example instead of
>> 'supported', so it's understandable that people do somethings get pulled
>> away by other things from time to time. If one persistently can't even do
>> the bare minimum however, then it should simply be orphaned.
>>
>> As it is now however we are quickly building up an unwieldly patch stack
>> with more future work to be done, and I'm hesitant to have anyone begin
>> any future work when the existing dependencies are wildly out of sync
>> with upstream already. If we can get some sort of process in place that
>> makes this less of a problem, then of course I'm pretty open to anything.
>> The main thing I want to avoid is a feedback loop where things go in to
>> -mm purgatory, get bounced off of Ian once a month or so, and then the
>> process repeats itself.
> 
> Yes, I expect we can start by merging many of the outstanding patches.
> It looks like all except Arnd's six-part series can be merged via the
> MMC tree, since the MFD changes have an ACK from Samuel already. 
> I'll do that today.
> 
> Arnd, can I take just patches 1/2 from your six-part series, and have
> you send the rest through the arch/ maintainers later?

Sure, should be no problem.
Ah, just saw that you already pushed those two, thanks.

@Paul: 
Maybe it would be best that you ACK those arch patches (if you think
they are ok) and that they also go in via the mmc-next tree?
Otherwise we would need to wait until mmc-next for .38 is merged in your trees,
right?

Thanks,
Arnd
