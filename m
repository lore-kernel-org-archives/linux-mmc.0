From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] sdhci: wakeup from runtime PM
Date: Tue, 5 Apr 2016 15:40:33 +0300
Message-ID: <5703B241.6030007@intel.com>
References: <1458921903-11133-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1458921903-11133-1-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-pm-owner@vger.kernel.org
To: Ludovic Desroches <ludovic.desroches@atmel.com>, ulf.hansson@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-pm@vger.kernel.org, nicolas.ferre@atmel.com
List-Id: linux-mmc@vger.kernel.org

On 25/03/16 18:05, Ludovic Desroches wrote:
> Hi,
> 
> When not using the SDHCI controller, it is logical to save power by suspending
> it. The issue is that SDHCI assumes that the controller is completely disabled.
> It means the only way to wake up on a card event is to have a gpio for the card
> detection (so two pins for the same signal). A possible workaround is to use
> polling but the controller will be resumed/suspended between each attempts.
> 
> We have already discussed a long time about this and it seems we don't agree.
> In my opinion, even if I can't disable all clocks, I should use runtime PM 
> to save some power.
> 
> I propose two patches, one which is a draft to try to solve it at sdhci level
> and one at sdhci-of-at91 level.
> 
> Concerning the first one, I don't understand why we need to reject irqs if
> runtime_suspended is true.

The interrupt handler might be called because the interrupt is shared i.e.
the interrupt is for a different device.  In that case the host controller
might be off and the registers inaccessible.  In that case we cannot even
look at the interrupt register to determine if we were expecting the interrupt.

>                            Only SDHCI_INT_CARD_INT irq is enabled so why we
> should have other IRQs than this one?

In the case of SDIO Card interrupt, it is delivered via the host controller,
so we have to assume the registers are accessible if we are
runtime-suspended with the SDIO IRQ enabled.

> 
> Since you were not in favour of allowing to wakeup on SDHCI_INT_CARD_INSERT or
> SDHCI_INT_CARD_REMOVE, I assume you won't take it so I
> solved my issue only by modifying my driver.

I don't mind allowing card detect interrupts while runtime suspended, but we
need a flag so that:
- runtime suspend leaves the insert/remove interrupts enabled
- irq handler knows it can access registers
- irq thread handler knows to runtime resume before doing anything else

But it seems like you need to persuade Ulf first.

