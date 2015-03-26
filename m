From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2 11/15] mmc: sdhci: Change to new way of doing re-tuning
Date: Thu, 26 Mar 2015 17:06:16 +0100
Message-ID: <CAPDyKFpzz6xUZM0p55eEE-EDNLDbxk9THTn0J5aOdw+Q+sZLBg@mail.gmail.com>
References: <1422522030-17793-1-git-send-email-adrian.hunter@intel.com>
	<1422522030-17793-12-git-send-email-adrian.hunter@intel.com>
	<CAPDyKFpTuttvhP91qNF_g_2sWV3NZmYMCnqFVGYEnb1L8kXVeg@mail.gmail.com>
	<54FD5BDD.9060004@intel.com>
	<CAPDyKFr9bpE3FXu0339q4ndOm_KSNpATBODecTWkkrLifvSing@mail.gmail.com>
	<54FEFDB0.5050104@intel.com>
	<CAPDyKFpvCz9kTaX=632hWGsWfLKC2aFJomFc1xECnNvQpNVU2A@mail.gmail.com>
	<5510227F.70605@intel.com>
	<CAPDyKFqJ3ahAPXec6LRmMtzucS3N=b5wOYGQcd0ELHZByeudJA@mail.gmail.com>
	<5510817D.2080807@intel.com>
	<CAPDyKFqnqxiFrrg3S9=w_xqJha1=+fre5w4puEGw7Z=LJZ-T3w@mail.gmail.com>
	<5512BCBA.3010905@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f45.google.com ([209.85.192.45]:33412 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002AbbCZQGo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Mar 2015 12:06:44 -0400
Received: by qgfa8 with SMTP id a8so98188786qgf.0
        for <linux-mmc@vger.kernel.org>; Thu, 26 Mar 2015 09:06:43 -0700 (PDT)
In-Reply-To: <5512BCBA.3010905@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Neil Brown <neilb@suse.de>, Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Girish K S <girish.shivananjappa@linaro.org>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

On 25 March 2015 at 14:48, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 24/03/15 23:12, Ulf Hansson wrote:
> > On 23 March 2015 at 22:11, Adrian Hunter <adrian.hunter@intel.com> wrote:
> >> On 23/03/2015 5:02 p.m., Ulf Hansson wrote:
> >>>
> >>> [...]
> >>>
> >>>>
> >>>> I have no locking issues, so I am not sure what you mean here.
> >>>
> >>>
> >>> Okay, I should have stated race conditions.
> >>
> >>
> >> Which I resolved using runtime get / put calls.
> >
> > Yes, I noticed that and it works! Though, I would rather avoid to add
> > yet another pair of host ops callbacks for this.
> >
> > What do you think if these options instead?
> > 1) Do runtime PM get/put from the host ops ->enable|disable()
> > callbacks. As omap_hsmmc does.
> > 2) Or even better, do runtime PM get/put directly of the host device
> > from mmc_claim|release_host().
>
> Claiming the host is not directly related to host controller runtime pm. It
> is possible to imagine cases for claiming the host for synchronization
> reasons that do not need the host controller powered up. And card drivers
> could reasonably assume that they can claim the host for long periods
> without affecting the runtime pm of the host controller.


Yes, it _may_ power up the host controller sometimes when not needed.
I don't think this will be an issue, mostly because it should be rare
and not happening frequently - if ever.

The only users of mmc_claim_host() for SD/MMC is the core itself, so I
don't see any issue with misbehaving "card drivers" here.

SDIO is again different, since it's up to the SDIO func drivers to
behave - as you stated. But, if they don't they anyway need to be
fixed, right!?

>
> Currently we have that the host controller driver is the exclusive owner of
> runtime pm for the host controller. So the first thing is to decide if we
> want to keep that or let the core be involved as well. I would argue for
> sticking with the status quo. Let the host controller driver know what is
> going on and leave it to do the right thing with its own power management.

The problem I see with the current solution, is that we will be
scheduling a runtime PM suspend for each an every request towards the
host.

It's ineffective, due to that we will unnecessary involve the runtime
PM core, thus increasing CPU utilization - when we actually don't need
to.

I will send a patch for this tomorrow, let's discuss it separately.

[...]

> >
> > I have thought more about this since yesterday and I somewhat agree
> > with your suggestion. Especially in that sense that I think we should
> > consider Neil's issue as an "idle operation" for SDIO.
> >
> > For "idle operations" for MMC/SD cards, runtime PM is already
> > deployed. So, I think it's just a matter of extending that support to
> > cover more "idle operations" besides the MMC_CAP_AGGRESSIVE_PM thing.
> >
> > What we need to figure out is how to make this work for SDIO - and
> > that's when it becomes more complex. I really would like us to avoid
> > exporting new SDIO APIs, unless really needed.
> >
> > Today runtime PM is deployed by the following SDIO func drivers:
> > drivers/net/wireless/libertas/if_sdio.c
> > drivers/net/wireless/ti/wl1251/sdio.c
> > drivers/net/wireless/ti/wlcore/sdio.c
> >
> > We _could_ consider to convert above drivers to use something else
> > than runtime PM to control the power to the card. I think that would
> > be the ideal solution, since then we can deploy runtime PM for SDIO
> > fairly similar to how MMC/SDIO is done. That means doing runtime PM
> > get/put of the device for the struct mmc_card, inside the mmc core
> > while handling SDIO requests.
> >
> > The above requires some work, both in the mmc core and in the SDIO
> > func drivers. The nice thing is that we don't need to export new APIs
> > to the SDIO func drivers and we can keep the complexity of dealing
> > with "idle operations" inside the mmc core.
> >
> > Thoughts?
>
> There isn't necessarily any link between "idle operations" and runtime pm.

I think this is exactly what runtime PM is designed for so I don't
want us to re-invent something that is specific for mmc.

>
> For example for eMMC background operations I would expect to see:
>
> - queue is empty so block driver enables "idle operations".
> - core waits (delayed work?) a few milliseconds and then starts bkops.
> - a new I/O request arrives, block driver wakes up and tells the core to
> stop "idle operations" ASAP, and waits until it does.
> - or, the core notifies (callback perhaps) the block driver that "idle
> operations" are finished, so the block driver can runtime-put the card
>
> Also need to stop "idle operations" for system suspend, maybe other places.

Conceptual wise, I fully agree. Though, I want to make use of runtime PM.

For the eMMC/SD case, the runtime PM suspend callbacks (specified per
bus_ops) should be able to act as the "trigger" point to kick off
"idle operations".

Now, the thing to figure out, is how to execute "idle operations" and
at the same time being able to interrupt/abort them from another
context. An option for how to deal with this, could be to schedule a
"delayed work" from the runtime PM suspend callback. But if we can
avoid it, I think we should.

>
> Now in Neil's case there is a relation to runtime pm in that it would be
> nice if the switch to 1-bit mode was delayed by the host controllers
> autosuspend_delay. But potentially the host controller driver could
> routinely set the delay so that it matches the autosuspend_delay anyway.
>
> Currently the SDIO function drivers all use sdio_claim_host(). So for Neil's
> case I would see:
>
> - host controller driver sees the switch to 4-bit mode and does a runtime
> "get" to prevent runtime suspend
> - sdio_release_host enables "idle operations"
> - the core sees that someone has requested a switch to 1-bit mode after a
> certain delay, so it waits that delay (delayed work?) and does the switch
> - host controller driver sees the switch to 1-bit mode and runtime suspends
> via a pm_runtime_put
> - sdio_claim_host tells the core to stop "idle operations" ASAP and waits
> until it has
> - host controller driver sees the switch to 4-bit mode and does a runtime
> "get" to prevent runtime suspend

That seems like a way forward!

Still I rather would like the above mentioned SDIO func drivers to use
something else than runtime PM to control the power to the cards, as I
suggested. But that might be too much to fix!?

Kind regards
Uffe
