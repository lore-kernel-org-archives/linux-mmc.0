From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/2] mmc: use PM QoS instead of delayed clock gating
Date: Fri, 3 Feb 2012 20:25:27 +0100
Message-ID: <201202032025.27814.rjw@sisk.pl>
References: <Pine.LNX.4.64.1201191631210.12537@axis700.grange> <201202012214.19531.rjw@sisk.pl> <Pine.LNX.4.64.1202031200300.6211@axis700.grange>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1202031200300.6211@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Chris Ball <cjb@laptop.org>, linux-sh@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Friday, February 03, 2012, Guennadi Liakhovetski wrote:
> On Wed, 1 Feb 2012, Rafael J. Wysocki wrote:
[...]
> > > > As for the patches, I'll reply to each of them separately.
> > > 
> > > Right, thanks for the review. Basically your comments are the same for 
> > > both:
> > > 
> > > 1. you'd like not just to change the default initial delay to 0, but to 
> > > prohibit changing it from the userspace completely.
> > 
> > No, I haven't said that. :-)
> > 
> > I said that setting the delay to 0 initially in the driver wasn't sufficient
> > to prevent the delay from being used.
> 
> Yes, sure, I realise that.
> 
> > If your intention was to use the PM QoS
> > _along_ with the delay, then you shouldn't advertise that as a regression fix
> > and I don't see a point setting the delay to 0 initially in the driver in that
> > case.
> 
> Hmm, I'm not sure to follow here. Firstly, I'm not sure why using both 
> cannot classify as a fix, secondly, do you mean, that when using QoS we 
> don't have to set the delay to 0? But with the delay left at 200ms PM QoS 
> doesn't have much left to say?
> 
> > > For that we need Chris' opinion and that cannot be done in MMC host drivers
> > > so far, AFAICS. 
> > > Actually, I'm not even sure I agree on this: if the user knows about that 
> > > possibility and consciously adjusts the timeout - why should we prevent 
> > > them from doing so?
> > 
> > Well, if you want to keep the delay pretty much as is, then there are two
> > choices that make sense to me: either you change the delay _globally_ to 0,
> > which kind of reverts the problematic commit, or you keep the default as is
> > and don't touch it from the driver.  Changing it initially to 0 in the
> > driver doesn't really help, because it'll requires user space to act
> > differently depending on what driver is used at the low level (the default will
> > differ from one driver to another).
> 
> Well, following this logic, we should not change the default in the 
> driver, and just either ask to revert that commit or rely on user-space to 
> set the delay to 0.

Yes, I meant that.  There's one more option, actually, which is to set the
default to 0 globally, at least for 3.3.  That would make us keep the current
behavior with the possibility to switch to a different delay for whoever wants
that.

> > > So far we don't have any user-space interface to 
> > > change device PM QoS parameters, right?
> > 
> > That's because people have been opposing interfeces at the struct device
> > level and the argument has always been "frameworks will add proper interfaces
> > for PM QoS", while what's happening here is frameworks adding their own power
> > management features with questionable interfaces _instead_ _of_ PM QoS.
> > 
> > I thought you wanted to reverse that trend, but apparently I was wrong. :-)
> > 
> > > So, this gives at least some control to the user.
> > 
> > How useful it is is rather unknown at the moment, though.
> > 
> > > 2. you suggest to separate delay=0 and PM QoS. Can do that of course, but 
> > > I thought they were related and that gave us a chance to push PM QoS up 
> > > sooner, rather than later, as a fix. Without it we'd potentially cause the 
> > > controller and the domain to runtime suspend and resume between all 
> > > transactions?
> > 
> > The problem is that using PM QoS here doesn't fix anything.  Changing the
> > default delay to 0 kind of does, although I don't like it (for reasons given
> > above).
> > 
> > I also asked why the PM QoS request was added for the parent of the devices
> > being handled rather than for the device itself.
> 
> Do you think we should apply constraints to the mmc host class-device?... 
> .parent is just a pointer to the actual underlying hardware device, the 
> platform device in our case.

OK

Thanks,
Rafael
