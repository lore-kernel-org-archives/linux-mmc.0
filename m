From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: Re: [PATCH] sdhci: wakeup from runtime PM
Date: Thu, 7 Apr 2016 17:12:08 +0200
Message-ID: <20160407151208.GA13961@odux.rfo.atmel.com>
References: <1458921903-11133-1-git-send-email-ludovic.desroches@atmel.com>
 <5703B241.6030007@intel.com>
 <CAPDyKFpvE2N+B3-S+tOKJ7+ViWddpxWxCWRGs2LBjWS9CmMxwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.243]:28329 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756448AbcDGPND (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 7 Apr 2016 11:13:03 -0400
Content-Disposition: inline
In-Reply-To: <CAPDyKFpvE2N+B3-S+tOKJ7+ViWddpxWxCWRGs2LBjWS9CmMxwA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Ludovic Desroches <ludovic.desroches@atmel.com>, Adrian Hunter <adrian.hunter@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Nicolas Ferre <nicolas.ferre@atmel.com>

On Thu, Apr 07, 2016 at 11:11:08AM +0200, Ulf Hansson wrote:
> On 5 April 2016 at 14:40, Adrian Hunter <adrian.hunter@intel.com> wrote:
> > On 25/03/16 18:05, Ludovic Desroches wrote:
> >> Hi,
> >>
> >> When not using the SDHCI controller, it is logical to save power by suspending
> >> it. The issue is that SDHCI assumes that the controller is completely disabled.
> >> It means the only way to wake up on a card event is to have a gpio for the card
> >> detection (so two pins for the same signal). A possible workaround is to use
> >> polling but the controller will be resumed/suspended between each attempts.
> >>
> >> We have already discussed a long time about this and it seems we don't agree.
> >> In my opinion, even if I can't disable all clocks, I should use runtime PM
> >> to save some power.
> >>
> >> I propose two patches, one which is a draft to try to solve it at sdhci level
> >> and one at sdhci-of-at91 level.
> >>
> >> Concerning the first one, I don't understand why we need to reject irqs if
> >> runtime_suspended is true.
> >
> > The interrupt handler might be called because the interrupt is shared i.e.
> > the interrupt is for a different device.  In that case the host controller
> > might be off and the registers inaccessible.  In that case we cannot even
> > look at the interrupt register to determine if we were expecting the interrupt.

Ok, I have missed we can get a shared irq.

> >
> >>                            Only SDHCI_INT_CARD_INT irq is enabled so why we
> >> should have other IRQs than this one?
> >
> > In the case of SDIO Card interrupt, it is delivered via the host controller,
> > so we have to assume the registers are accessible if we are
> > runtime-suspended with the SDIO IRQ enabled.
> >
> >>
> >> Since you were not in favour of allowing to wakeup on SDHCI_INT_CARD_INSERT or
> >> SDHCI_INT_CARD_REMOVE, I assume you won't take it so I
> >> solved my issue only by modifying my driver.
> >
> > I don't mind allowing card detect interrupts while runtime suspended, but we
> > need a flag so that:
> > - runtime suspend leaves the insert/remove interrupts enabled
> > - irq handler knows it can access registers
> 
> To me, this seem like the wrong way of how to configure wake-ups for
> these kind of devices.

We are definitely not in agreement on this point. It means I have to
rely on polling for card detection. I did it but I had in mind it would
be a temporary workaround while waiting to find a better one.

> 
> I don't think the regular IRQs shall be enabled and the driver
> shouldn't assume the registers are accessible without first runtime
> resuming the device.
> 
> > - irq thread handler knows to runtime resume before doing anything else
> >
> > But it seems like you need to persuade Ulf first.
> 

It will be a difficult task :)

> For a more thorough explanation to why I don't like, please have a
> look at my comment for another related thread on the mmc list.
> http://www.spinics.net/lists/linux-mmc/msg36132.html
> 

To facilitate discussion, I copy a part of your explanation here:

> My interpretation of how runtime PM should be deployed, it's s that a
> device shall not process data in the runtime suspend state. To do
> that, it first needs to be runtime resumed. I think this conforms to
> what the runtime PM documentation also recommends in section 2, Device
> Runtime PM Callbacks.

So simply invoking the resume callback when the card detect irq is
received should be in accordance with the PM documentation.

> Moreover I think it's an SoC specific detail whether a driver *can*
> access a device's registers in the runtime suspend state (thus it
> shouldn't do it). Especially, devices may reside in a PM domain, which
> could enter a retention state, because all its devices are runtime
> suspended. Typically for an ARM SoC is that devices looses their
> register's context in such retention state.

Maybe it's a SoC specific detail but that doesn't mean that this detail
should not be taken into account. The PM documentation mentions 'the PM
core regards the device as suspended, which need not mean that it has been  
put into a low power state'. It sounds like we can access to the
registers, there is no requirement to disable all the clocks.

I am not arguing for SD card detection wake-up itself but for saving power
when I don't use my SDHCI controller. I boot Linux without a SD card,
the controller is runtime suspended, it seems obvious that the controller
should be resumed when I insert a card. I really want to use runtime PM
because the controller should be most of the time suspended excepting if the
rootfs is on the SD card.

Am I the only one to find that the constraint is too big to use runtime PM?


Regards

Ludovic
