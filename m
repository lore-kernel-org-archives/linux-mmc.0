From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH/RFC] mmc: add a device PM QoS constraint when a host is first claimed
Date: Sat, 3 Mar 2012 21:53:15 +0100
Message-ID: <201203032153.15889.rjw@sisk.pl>
References: <Pine.LNX.4.64.1112121642080.10378@axis700.grange> <Pine.LNX.4.64.1112160954030.6572@axis700.grange> <4EEF2B54.6050108@stericsson.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <4EEF2B54.6050108@stericsson.com>
Sender: linux-sh-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Chris Ball <cjb@laptop.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

Sorry for the late respones.

On Monday, December 19, 2011, Ulf Hansson wrote:
> Guennadi Liakhovetski wrote:
> > On Wed, 14 Dec 2011, Rafael J. Wysocki wrote:
> > 
> >> On Wednesday, December 14, 2011, Ulf Hansson wrote:
> > 
> > [snip]
> > 
> >>> 2.
> >>> When executing mmc/sd commands/requests the host must always be claimed 
> >>> (and thus the host is always enabled).
> > 
> > Why? Why cannot we save some power between IO operations - if we can do 
> > this quickly and safely without affecting functionality and throughput?
> > 
> >>> But more important some mmc/sd 
> >>> commands must be executed as a sequence, without the host being disabled 
> >>> in between the commands (since a disable might mean that the clock to 
> >>> card gets disabled).
> > 
> > Ok, there might well be such command sequences, but my question is: who 
> > knows about them? Is this mandated by the MMC(/SD/SDIO/...) standard or is 
> > it host-specific? Also "might mean" is actually interesting here. I think 
> > we eventually need a combination of timing-oriented PM constraints and 
> > "stateful" ones. During such a command sequence you would require the card 
> > clock to stay on.
> 
> MMC/SD/SDIO standard sets the requirement and must somehow "notify" the 
> host about how to act in certain scenarios.
> 
> Just for information, I think one interesting host driver to look at is 
> omap_hsmmc. For it's enable function is does pm_runtime_get_sync and for 
> it's disable function it does pm_runtime_put_autosuspend, this to make 
> sure the clock is enabled when it is needed.

That's OK, but that doesn't solve the issue the $subject patch tries to
address.

> >>> To solve this, the mmc_claim_host is used, to make 
> >>> sure the host is enabled during the complete command sequence.
> >>>
> >>> I happily continue this discussion, to see if someone more can break the 
> >>> idea about having get_sync in mmc_host_enable. :-)
> >> I'll leave this one to Guennadi, if you don't mind. :-)
> > 
> > As I said above, I think, we need both - to be able to require a certain 
> > responsiveness / throughput and specific interface parameters like 
> > supplying clock, power, etc.
> > 
> > Also notice, that setting a constraint doesn't affect in principle, when 
> > the device is allowed to suspend. This is done as usual per 
> > pm_runtime_get*() and _put*(). I think, a reasonable solution to use PM 
> > QoS to impose timing constraints but at the same time to not disable the 
> > hardware, when this is disallowed, is to tie pm_runtime_get() and _put() 
> > calls to driver's .set_ios() method, like tmio_mmc and sh_mmcif drivers 
> > currently do. Those drivers only call pm_runtime_put() when the interface 
> > clock is gated. So, as long as the core is aware, that that IO sequence 
> > has to run uninterrupted without stopping the clock between single 
> > transfers, it just has to avoid gating the clock for that period and the 
> > interface will not enter any power-saving mode.
> > 
> > So, I don't think we need to enforce pm_runtime_get_sync() in 
> > mmc_claim_host().
> 
> You might be right; but still we need a way for the mmc framework to 
> prevent the host driver from disabling clock etc to the card for some 
> command sequences. As the omap driver solves it is to implement the 
> enable/disable function and then call for get_sync and put in these 
> functions, maybe that is the way how to solve this!?

You still seem to be confusing preventing the clock from being disabled
at all (which may be necessary for some command sequences etc.) with preventing
the host adapter from being put into an overly deep low-power state _after_
_the_ _clock_ _has_ _been_ _disabled_.  They are two _different_ issues
and there's no way we can address them both by using timeouts.

With PM domains support on SH7372 we can easily have a situation in which
the controller's runtime PM causes a whole domain to go off (or in a more
complicated scenario, the runtime PM of some _other_ device in the same PM
domain causes it to go off while the MMC controller is in the "suspended"
state) and that leads to an overly long delay in the MMC subsystem.  So,
we need to address this issue _in_ _addition_ to ensuring that the controller
is _not_ suspended when it shouldn't be.

Thanks,
Rafael
