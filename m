From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: Re: [RFC PATCH] mmc: sdhci-of-at91: don't put device in suspend
 after probe
Date: Wed, 10 Feb 2016 15:16:24 +0100
Message-ID: <20160210141624.GC14937@odux.rfo.atmel.com>
References: <1455098283-14500-1-git-send-email-ludovic.desroches@atmel.com>
 <56BB2414.1040606@intel.com>
 <20160210125139.GB14937@odux.rfo.atmel.com>
 <56BB3459.6090506@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.243]:59764 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751168AbcBJOQ2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Feb 2016 09:16:28 -0500
Content-Disposition: inline
In-Reply-To: <56BB3459.6090506@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: nicolas.ferre@atmel.com, Ludovic Desroches <ludovic.desroches@atmel.com>, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Feb 10, 2016 at 03:00:09PM +0200, Adrian Hunter wrote:
> On 10/02/16 14:51, Ludovic Desroches wrote:
> > Hi Adrian,
> > 
> > On Wed, Feb 10, 2016 at 01:50:44PM +0200, Adrian Hunter wrote:
> >> On 10/02/16 11:58, Ludovic Desroches wrote:
> >>> By putting the device in suspend at the end of the probe, it is
> >>> impossible to wake up on non software event such as card
> >>> insertion/removal.
> >>>
> >>> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> >>> ---
> >>>
> >>> Hi,
> >>>
> >>> Since I had no feedback on this topic:
> >>> http://permalink.gmane.org/gmane.linux.kernel.mmc/35160
> >>>
> >>> I would like to no more put the device in suspend at the end of the probe. If
> >>> my device is suspended at the end of the probe, I have no issue to resume on
> >>> a software event such as mounting my sdcard but hardware event such as card
> >>> insertion and removal do not trigger a resume.
> >>
> >> You can't use runtime PM unless you have a way to wake-up.
> >>
> > 
> > Thanks for your feedback. I am a bit disappointed since Ulf advised me to use
> > runtime PM instead of system PM.
> > 
> >> Currently, sdhci disables card detect interrupts when runtime suspended,
> >> and drivers use a card-detect GPIO to wake-up.
> >>
> > 
> > It is what I have seen going through the sdhci layer. So next question is:
> > is it normal to not take care of card detect interrupts? We keep enabled
> > some IRQs probably for SDIO modules IRQ but not for card detection. I
> > don't understand the reason.
> 
> Does sdhci-of-at91.c generate card detect interrupts while runtime suspended?

It could if I keep one or two clocks enabled (need extra tests to be
sure about the clock needed to get this interrupt). I have tried to modify
quickly sdhci_runtime_suspend_host() to enable card insertion/removal,
there is an irq generated but the kernel complains this irq is not
handled. I didn't dig further, it was only to do a simple test.

> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
