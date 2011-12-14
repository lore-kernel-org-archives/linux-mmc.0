From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH/RFC] mmc: add a device PM QoS constraint when a host is first claimed
Date: Wed, 14 Dec 2011 22:36:26 +0100
Message-ID: <201112142236.26739.rjw@sisk.pl>
References: <Pine.LNX.4.64.1112121642080.10378@axis700.grange> <201112141115.00945.rjw@sisk.pl> <4EE8849D.1010401@stericsson.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <4EE8849D.1010401@stericsson.com>
Sender: linux-sh-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Chris Ball <cjb@laptop.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Wednesday, December 14, 2011, Ulf Hansson wrote:
> 
> >> You have a point. But I am not convinced. :-)
> >>
> >> Some host drivers already make use of autosuspend. I think this is most 
> >> straightforward solution to this problem right now.
> > 
> > The problem is not about _when_ to suspend (which autosuspend is about),
> > but _what_ _state_ to go when suspended.  That's quite a different issue.
> 
> I was kind of taking a more simple approach, I were considering 
> runtime_suspend as _one_ state. Right now there is no host driver having 
> different levels of runtime_suspend state, if I am correct. But ofcourse 
> that could be the future.

Yes, there is, or more precisely there's going to be shortly.  We have
PM domains on SH7372 and when we enable all of them to be powered off
at run time, there will be many power states for the controller which
is located in one of them.  Hence the $subject patch. :-)

> Moreover, I definitely do not think that a fixed timeout of 100us is 
> applicable for all use cases, this must at least be configurable.

Well, this isn't a timeout.  Have you read my reply to Linus?

I agree that it should be configurable _eventually_, but no one seems to
know how to implement that configurability.  Ideally, that value should
result from some user space input, possibly after a conversion by the
driver to a useful number, but we don't seem to have any agreement as to
what the interface for passing that user space input to the driver should
look like.

> >> However, we could also do pm_runtime_get_sync of the host device in 
> >> claim host and vice verse in release host, thus preventing the host 
> >> driver from triggering runtime_suspend|resume for every request. Though, 
> >> I am not 100% sure this is really what you want either.
> > 
> > No, I don't want that.  I want the device to be suspended when possible,
> > but I don't want that to cause the system to go into an overly deep power
> > state as a result.
> 
> Before just skipping my proposal, I think you should know some more 
> background to why I suggested this:
> 
> 1.
> mmc_claim_host is using mmc_host_enable, which kind of mean the same 
> thing for a host driver as doing get_sync. Vice verse for mmc_release_host.
> 
> 2.
> When executing mmc/sd commands/requests the host must always be claimed 
> (and thus the host is always enabled). But more important some mmc/sd 
> commands must be executed as a sequence, without the host being disabled 
> in between the commands (since a disable might mean that the clock to 
> card gets disabled). To solve this, the mmc_claim_host is used, to make 
> sure the host is enabled during the complete command sequence.
> 
> I happily continue this discussion, to see if someone more can break the 
> idea about having get_sync in mmc_host_enable. :-)

I'll leave this one to Guennadi, if you don't mind. :-)

> >> Using PM QoS as you propose, might prevent some hosts from doing 
> >> runtime_suspend|resume completely and thus those might not fulfill power 
> >> consumption requirements instead.
> > 
> > I'm not sure what scenario you have in mind.  Care to elaborate?
> 
> Well, suppose a the host drivers start considering the PM QoS 
> requirement, but never can fulfill the requirement of 100us for it's 
> runtime_suspend callback function...

OK, that's a valid concern.  This means there should be a way for user space
to specify the constraint somehow, because it's a user space's role to define
policies.

> >> I do not think we can take this decision at this level. Is performance more
> >> important than power save, that is kind of the question.
> > 
> > Yes, it is.  Also, the number used here is somewhat arbitrary.
> 
> For you maybe power management is less important, but I doubt everybody 
> else agree to that. It is a more complex balance I believe.

You're right.

> > However, since no one except for SH7372 is now using device PM QoS, no one
> > else will be affected by this change at the moment.
> 
> True, but that is not a good reason for adding more stuff to the mmc core.

Good point.

Thanks,
Rafael
