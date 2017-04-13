From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH] mmc: dw_mmc: Don't allow Runtime PM for SDIO cards
Date: Thu, 13 Apr 2017 16:33:01 +0800
Message-ID: <13eda64f-3421-3db5-05ce-69a9fd4c85cb@rock-chips.com>
References: <20170411225543.987-1-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:41349 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751439AbdDMIdH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Apr 2017 04:33:07 -0400
In-Reply-To: <20170411225543.987-1-dianders@chromium.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Douglas Anderson <dianders@chromium.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, briannorris@chromium.org, linux-rockchip@lists.infradead.org, Heiko Stuebner <heiko@sntech.de>, kevin@archlinuxarm.org, amstan@chromium.org, xzy.xu@rock-chips.com, stable@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org



On 2017/4/12 6:55, Douglas Anderson wrote:
> According to the SDIO standard interrupts are normally signalled in a
> very complicated way.  They require the card clock to be running and
> require the controller to be paying close attention to the signals
> coming from the card.  This simply can't happen with the clock stopped
> or with the controller in a low power mode.
>
> To that end, we'll disable runtime_pm when we detect that an SDIO card
> was inserted.  This is much like with what we do with the special
> "SDMMC_CLKEN_LOW_PWR" bit that dw_mmc supports.
>
> NOTE: we specifically do this Runtime PM disabling at card init time
> rather than in the enable_sdio_irq() callback.  This is _different_
> than how SDHCI does it.  Why do we do it differently?
>
> - Unlike SDHCI, dw_mmc uses the standard sdio_irq code in Linux (AKA
>   dw_mmc doesn't set MMC_CAP2_SDIO_IRQ_NOTHREAD).
> - Because we use the standard sdio_irq code:
>   - We see a constant stream of enable_sdio_irq(0) and
>     enable_sdio_irq(1) calls.  This is because the standard code
>     disables interrupts while processing and re-enables them after.
>   - While interrupts are disabled, there's technically a period where
>     we could get runtime disabled while processing interrupts.
>   - If we are runtime disabled while processing interrupts, we'll
>     reset the controller at resume time (see dw_mci_runtime_resume),
>     which seems like a terrible idea because we could possibly have
>     another interrupt pending.
>
> To fix the above isues we'd want to put something in the standard
> sdio_irq code that makes sure to call pm_runtime get/put when
> interrupts are being actively being processed.  That's possible to do,
> but it seems like a more complicated mechanism when we really just
> want the runtime pm disabled always for SDIO cards given that all the
> other bits needed to get Runtime PM vs. SDIO just aren't there.
>
> NOTE: at some point in time someone might come up with a fancy way to
> do SDIO interrupts and still allow (some) amount of runtime PM.
> Technically we could turn off the card clock if we used an alternate
> way of signaling SDIO interrupts (and out of band interrupt is one way
> to do this).  We probably wouldn't actually want to fully runtime
> suspend in this case though--at least not with the current
> dw_mci_runtime_resume() which basically fully resets the controller at
> resume time.
>
> Fixes: e9ed8835e990 ("mmc: dw_mmc: add runtime PM callback")
> Cc: <stable@vger.kernel.org>
> Reported-by: Brian Norris <briannorris@chromium.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Thanks, Doug, for this fix.

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>


> ---
>  drivers/mmc/host/dw_mmc.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 249ded65192e..e45129f48174 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -23,6 +23,7 @@
>  #include <linux/ioport.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/seq_file.h>
>  #include <linux/slab.h>
>  #include <linux/stat.h>
> @@ -1620,10 +1621,16 @@ static void dw_mci_init_card(struct mmc_host *mmc, struct mmc_card *card)
>
>  		if (card->type == MMC_TYPE_SDIO ||
>  		    card->type == MMC_TYPE_SD_COMBO) {
> -			set_bit(DW_MMC_CARD_NO_LOW_PWR, &slot->flags);
> +			if (!test_bit(DW_MMC_CARD_NO_LOW_PWR, &slot->flags)) {
> +				pm_runtime_get_noresume(mmc->parent);
> +				set_bit(DW_MMC_CARD_NO_LOW_PWR, &slot->flags);
> +			}
>  			clk_en_a = clk_en_a_old & ~clken_low_pwr;
>  		} else {
> -			clear_bit(DW_MMC_CARD_NO_LOW_PWR, &slot->flags);
> +			if (test_bit(DW_MMC_CARD_NO_LOW_PWR, &slot->flags)) {
> +				pm_runtime_put_noidle(mmc->parent);
> +				clear_bit(DW_MMC_CARD_NO_LOW_PWR, &slot->flags);
> +			}
>  			clk_en_a = clk_en_a_old | clken_low_pwr;
>  		}
>
>

