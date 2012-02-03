From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 0/2] mmc: use PM QoS instead of delayed clock gating
Date: Fri, 3 Feb 2012 12:07:49 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1202031200300.6211@axis700.grange>
References: <Pine.LNX.4.64.1201191631210.12537@axis700.grange>
 <201201281335.35397.rjw@sisk.pl> <Pine.LNX.4.64.1202011401370.24739@axis700.grange>
 <201202012214.19531.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:63260 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755690Ab2BCLHz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Feb 2012 06:07:55 -0500
In-Reply-To: <201202012214.19531.rjw@sisk.pl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-mmc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Chris Ball <cjb@laptop.org>, linux-sh@vger.kernel.org

On Wed, 1 Feb 2012, Rafael J. Wysocki wrote:

> On Wednesday, February 01, 2012, Guennadi Liakhovetski wrote:
> > On Sat, 28 Jan 2012, Rafael J. Wysocki wrote:
> > 
> > > Hi,
> > > 
> > > On Thursday, January 19, 2012, Guennadi Liakhovetski wrote:
> > > > Hi all
> > > > 
> > > > I've already sent one of these two patches yesterday, but I forgot to 
> > > > include Rafael on the CC list and forgot to mention, that the patch should 
> > > > be treated as a regression fix and should go into 3.3. The reason why the 
> > > > commit
> > > > 
> > > > commit 7e09bedba1b87f9c7b34ba895b57baf0c36ccdc8
> > > 
> > > I think that should be 597dd9d79cfbbb1636d00a7fd0880355d9b20c41, right?
> > > 
> > > > Author: Sujit Reddy Thumma <sthumma@codeaurora.org>
> > > > Date:   Mon Nov 14 13:53:29 2011 +0530
> > > > 
> > > >     mmc: core: Use delayed work in clock gating framework
> > > > 
> > > > can be considered a regression is, that it extends the powered-on time of 
> > > > the controller(s) and, possibly, of respective power domains by 200ms (by 
> > > > default), which is an essential change in behaviour in the negative 
> > > > direction.
> > > > 
> > > > However, if this is indeed the desired change, maybe the better approach 
> > > > now would be to modify this behaviour in individual drivers, which is 
> > > > exactly what the two patches in this series are doing.
> > > 
> > > I agree that doing such things at the framework level is not a good idea,
> > > which this example clearly shows.
> > > 
> > > The commit above had made the assumption that every platform would
> > > regard performance as more important than power saving and made a wholesale
> > > change that affected everyone.  In some cases, however, the change is not
> > > welcome and is not too easy to work around (because of the user space interface
> > > file added in the process).
> > > 
> > > Quite frankly, I think it would be better to simply revert that commit (along
> > > with the later one fixing it) at this point, because there may be more cases
> > > where it actually makes things worse.
> > 
> > Well, it's not my call to decide upon this, I don't know what the global 
> > MMC preference is, Chris?
> 
> The question is whether or not everyone (or at least the majority of
> people who care) agrees that it's valid to sacrifice power savings for
> better performance.

Are we going to vote? :-)

> > > As for the patches, I'll reply to each of them separately.
> > 
> > Right, thanks for the review. Basically your comments are the same for 
> > both:
> > 
> > 1. you'd like not just to change the default initial delay to 0, but to 
> > prohibit changing it from the userspace completely.
> 
> No, I haven't said that. :-)
> 
> I said that setting the delay to 0 initially in the driver wasn't sufficient
> to prevent the delay from being used.

Yes, sure, I realise that.

> If your intention was to use the PM QoS
> _along_ with the delay, then you shouldn't advertise that as a regression fix
> and I don't see a point setting the delay to 0 initially in the driver in that
> case.

Hmm, I'm not sure to follow here. Firstly, I'm not sure why using both 
cannot classify as a fix, secondly, do you mean, that when using QoS we 
don't have to set the delay to 0? But with the delay left at 200ms PM QoS 
doesn't have much left to say?

> > For that we need Chris' opinion and that cannot be done in MMC host drivers
> > so far, AFAICS. 
> > Actually, I'm not even sure I agree on this: if the user knows about that 
> > possibility and consciously adjusts the timeout - why should we prevent 
> > them from doing so?
> 
> Well, if you want to keep the delay pretty much as is, then there are two
> choices that make sense to me: either you change the delay _globally_ to 0,
> which kind of reverts the problematic commit, or you keep the default as is
> and don't touch it from the driver.  Changing it initially to 0 in the
> driver doesn't really help, because it'll requires user space to act
> differently depending on what driver is used at the low level (the default will
> differ from one driver to another).

Well, following this logic, we should not change the default in the 
driver, and just either ask to revert that commit or rely on user-space to 
set the delay to 0.

> > So far we don't have any user-space interface to 
> > change device PM QoS parameters, right?
> 
> That's because people have been opposing interfeces at the struct device
> level and the argument has always been "frameworks will add proper interfaces
> for PM QoS", while what's happening here is frameworks adding their own power
> management features with questionable interfaces _instead_ _of_ PM QoS.
> 
> I thought you wanted to reverse that trend, but apparently I was wrong. :-)
> 
> > So, this gives at least some control to the user.
> 
> How useful it is is rather unknown at the moment, though.
> 
> > 2. you suggest to separate delay=0 and PM QoS. Can do that of course, but 
> > I thought they were related and that gave us a chance to push PM QoS up 
> > sooner, rather than later, as a fix. Without it we'd potentially cause the 
> > controller and the domain to runtime suspend and resume between all 
> > transactions?
> 
> The problem is that using PM QoS here doesn't fix anything.  Changing the
> default delay to 0 kind of does, although I don't like it (for reasons given
> above).
> 
> I also asked why the PM QoS request was added for the parent of the devices
> being handled rather than for the device itself.

Do you think we should apply constraints to the mmc host class-device?... 
.parent is just a pointer to the actual underlying hardware device, the 
platform device in our case.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
