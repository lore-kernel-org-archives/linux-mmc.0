From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: Re: [PATCH] sdhci: wakeup from runtime PM
Date: Mon, 11 Apr 2016 14:09:05 +0200
Message-ID: <20160411120905.GA7269@odux.rfo.atmel.com>
References: <1458921903-11133-1-git-send-email-ludovic.desroches@atmel.com>
 <5703B241.6030007@intel.com>
 <CAPDyKFpvE2N+B3-S+tOKJ7+ViWddpxWxCWRGs2LBjWS9CmMxwA@mail.gmail.com>
 <20160407151208.GA13961@odux.rfo.atmel.com>
 <CAPDyKFqJ4Q9hdsv427GaT_2qFpvv=Nn3rZQUS+P8O7FF-gKgyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.243]:40608 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753441AbcDKMJz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Apr 2016 08:09:55 -0400
Content-Disposition: inline
In-Reply-To: <CAPDyKFqJ4Q9hdsv427GaT_2qFpvv=Nn3rZQUS+P8O7FF-gKgyw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Ludovic Desroches <ludovic.desroches@atmel.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Adrian Hunter <adrian.hunter@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>

On Fri, Apr 08, 2016 at 10:35:00AM +0200, Ulf Hansson wrote:
> - linux-kernel list
> 
> On 7 April 2016 at 17:12, Ludovic Desroches <ludovic.desroches@atmel.com> wrote:
> > On Thu, Apr 07, 2016 at 11:11:08AM +0200, Ulf Hansson wrote:
> >> On 5 April 2016 at 14:40, Adrian Hunter <adrian.hunter@intel.com> wrote:
> >> > On 25/03/16 18:05, Ludovic Desroches wrote:
> >> >> Hi,
> >> >>
> >> >> When not using the SDHCI controller, it is logical to save power by suspending
> >> >> it. The issue is that SDHCI assumes that the controller is completely disabled.
> >> >> It means the only way to wake up on a card event is to have a gpio for the card
> >> >> detection (so two pins for the same signal). A possible workaround is to use
> >> >> polling but the controller will be resumed/suspended between each attempts.
> >> >>
> 
> From power consumption point if view we already discussed this
> particular case in an earlier thread, but let me elaborate what I
> think one more time:
> 
> Now, this is relevant for removable cards lacking GPIO card detect, as
> for other cases and non-removable cards I think we are in agreement
> that their is no issue from power consumption point of view, right!?
> 
> 1. The current solution:
> - Use MMC_CAP_NEEDS_POLL which makes the mmc core to re-schedule a
> work once every second to poll for a card (Why is it one second? Could
> we perhaps have that configurable?).
> 
> In case of no card inserted, the polling consists of runtime resuming
> the SDHCI controller and then reading a couple of registers to find
> out if there is a new card. I assume this will be a fast operation. In
> the below calculation I have neglected its impact which of course is a
> simplification.
> 
> This solution allows the driver in runtime suspend to *gate all three
> clocks* used by the SDHCI controller. In-between polling attempts it
> will thus save power.
> 
> Currently the mmc core *always* respects runtime PM autosuspend when
> putting the controller device back to runtime suspend. I suggest we
> change this in cases when the polling operation doesn't detect any
> changes.
> 
> For the sdhci-of-at91 driver case, the autosuspend timeout is set to
> 50 ms (which is a common value among mmc host drivers).
> 
> In the current code this means for a period over ~10 s, *all three
> clocks* will be ungated for 50 ms x 10 times = ~500 ms.
> 
> If we adopt to what I propose above, this time will become significant
> lesser as the autosuspend timer will not be respected.
> 
> 2. What you propose (I think):
> * Don't use MMC_CAP_NEEDS_POLL, but instead rely on the SDHCI
> controller to pick up card detect IRQs in runtime suspended state.
> 
> In case of no card inserted, the controller would then stay runtime
> suspended but with IRQs enabled to deal with card detect IRQs.
> According to what you told me earlier, this means that the controller
> requires one of the three clocks to be ungated in the runtime suspend
> state. So, only two clocks can be managed by runtime PM.
> 
> Assuming that no cards get inserted over a period of ~10 s, *one clock
> will be ungated* for ~10 s.
> 
> 
> Can you show that option 2) is better in saving power than option 1) ?

Unfortunately not. I have discussed with hardware guys. They confirmed me
that the power consumption to keep the interface enabled is very low but it
will be difficult to measure the consumption difference between the two
options because it would be minimal.

If in practice the result was almost the same, it is not useful to
continue this debate. I'll keep the polling workaround and I'll update system
PM callbacks.

[...]

Regards

Ludovic
