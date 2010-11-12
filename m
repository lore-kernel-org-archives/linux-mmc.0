From: Peppe CAVALLARO <peppe.cavallaro@st.com>
Subject: Re: [PATCH 2/5] mmc: do not clear the host->pm_flags when suspend
Date: Fri, 12 Nov 2010 09:06:52 +0100
Message-ID: <4CDCF59C.5000903@st.com>
References: <1289402889-14160-1-git-send-email-peppe.cavallaro@st.com>
 <1289402889-14160-2-git-send-email-peppe.cavallaro@st.com>
 <1289402889-14160-3-git-send-email-peppe.cavallaro@st.com>
 <1289402889-14160-4-git-send-email-peppe.cavallaro@st.com>
 <AANLkTik1c0G2HNcXGboP8WA8vo9YvwYkUpM2=MGf-cLW@mail.gmail.com>
 <4CDB9A28.5030408@st.com>
 <AANLkTikEEFXOf5=aiCMiG4HpRsxO13_7rx21xOGR1PCk@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog105.obsmtp.com ([207.126.144.119]:46898 "EHLO
	eu1sys200aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752052Ab0KLIH4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 12 Nov 2010 03:07:56 -0500
In-Reply-To: <AANLkTikEEFXOf5=aiCMiG4HpRsxO13_7rx21xOGR1PCk@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Wolfram Sang <w.sang@pengutronix.de>

Hi Ohad,

On 11/12/2010 12:45 AM, Ohad Ben-Cohen wrote:
>
> MMC_PM_KEEP_POWER indicates that a card wishes to preserve its power
> during system suspend; SDIO function drivers set it, if desired, and
> if the host supports it.
>
> If you permanently set it in sdhci-pltfm, you completely change the
> interface. Drivers will be very surprised with such a default power-on
> behavior.
>

Yes.

> > It is set in the pm_flags. When the sdhci suspend is invoked, it can
> > call the mmc_suspend_host without free the interrupt if
> > MMC_PM_KEEP_POWER is set.
> > Then the sdhci_set_wakeup programs the HC to be able to wake up the
> system.
>
> MMC_PM_KEEP_POWER does not necessarily mean the user wants the system
> to wake up on any SDIO events (e.g. it might be desired to keep a card
> powered in a low power mode, without any wake-up expectancies, just to
> be able to bring it up very quickly when the system resumes).
>

This is also true. I wanted to use this macro to indicate that the
wakeup is possible.
I mean, if the driver preserves the power could be wakeup capable.
>
> > When the resume is invoked the pm_flags is used to avoid to request
> the irq.
> > For this reason I removed the inst "host->pm_flags = 0;" from the
> > mmc_suspend_host
> > function. Maybe I could not remove it but add a check if the driver
> > wants to wakeup
>
> Who is this driver ? Host controller ? I don't think it should decide
> whether the system will wake up or not on these events. Host
> controller should merely provide capabilities (by means of pm_caps),
> and let the upper layers choose.
>
IIUC, the driver should set its capabilities in pm_caps and I could use
the device_can_wakeup
in suspend and resume;

I mean, in the suspend, for example, I should use:
  if (!(device_may_wake_up(host->mmc->parent)))
           ...
instead of
  if (!(host->mmc->pm_flags & MMC_PM_KEEP_POWER)) {
   ...
>
> > the system and the MMC_PM_KEEP_POWER is set. What do you think?
>
> Beyond MMC_PM_WAKE_SDIO_IRQ, which is already established, you seem to
> add two additional wake up events: card insertion and card removal.
>
> The insertion event, at least (still need to think about the removal
> one), have little to do with the SDIO function driver itself (e.g., if
> the system is suspended, and the user inserts a card, obviously there
> is no driver loaded for it yet that could have set pm_flags).
>

Thanks! Now I understand why the pm_flags is clear in the mmc suspend.
Please see the following test scenario.
I suspend the STB, then I want to to remove the card (and the box is
always in power down).
In the end, I want to reinsert the card and wake up the system ;-).
In this case, the pm_flags is cleared (when I enter in the sdhci resume).
If I suspend the box again, I won't be able to get any info about the
wakeup event has to
be triggered. Am I missing anything?

So I've not clear if I should use the pm_caps instead of pm_flags.

> These events seem to be more system-wide and not driver-specific: does
> the user want the host to wake up on card insertion or not ?
>

Yes user does.

I wanted to actually use:

MMC_PM_WAKE_SDIO_IRQ
  for programming the HC to wakeup on card interrupt
MMC_PM_WAKE_SDIO_CARD_INS
  for programming the HC to wakeup on card insertion
MMC_PM_WAKE_SDIO_CARD_REM
  for programming the HC to wakeup on card removal


> One idea that comes to mind is to use the PM core's wakeup sysfs
> device attribute to control this; this way the user will be able to
> directly enable/disable these wakeup events.
>
AFAIK, I can only enable/disable wakeup by using:
     /sys/devices/platform/sdhci.0/power/wakeup

I need to pass which events has to wakeup the HC (card int, insert, rem).
Indeed, I wanted to enable/disable them at user level by using the new
option:

 bash-3.00 echo X > /sys/module/sdhci/parameters/wakeup

where X could be:
 0: no wakeup
 1: Card Interrupts
 2: Card Insertion
 3: Card Removal

Maybe it's worth having more parameters instead of the
wakeup. I mean, something like this (welcome feedback):
 wake_on_card_int
 wake_on_card_ins
 wake_on_card_re

What do you think?

> It might still make sense to use pm_flags and pm_caps here, and then
> the user will manipulate the sysfs entries of the mmc host class_dev
> rather than manipulating the host controller device directly. Not sure
> how big an advantage is that, though.
>

I think you are right.

Welcome other feedback so I'll rework these patch and align them to
mmc-next as Wolfram suggested.

Many thanks for your feedback and details.

Regards
Peppe
