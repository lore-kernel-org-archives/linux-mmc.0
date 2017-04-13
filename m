From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: dw_mmc: Don't allow Runtime PM for SDIO cards
Date: Thu, 13 Apr 2017 11:32:48 +0200
Message-ID: <CAPDyKFo4FMu0F5DwBNb4b5JTp5UwHAUBQdvk00J5zzvbk6OZSQ@mail.gmail.com>
References: <20170411225543.987-1-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20170411225543.987-1-dianders@chromium.org>
Sender: stable-owner@vger.kernel.org
To: Douglas Anderson <dianders@chromium.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Brian Norris <briannorris@chromium.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Shawn Lin <shawn.lin@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, kevin@archlinuxarm.org, Alexandru Stan <amstan@chromium.org>, Ziyuan Xu <xzy.xu@rock-chips.com>, "# 4.0+" <stable@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 12 April 2017 at 00:55, Douglas Anderson <dianders@chromium.org> wrote:
> According to the SDIO standard interrupts are normally signalled in a
> very complicated way.  They require the card clock to be running and
> require the controller to be paying close attention to the signals
> coming from the card.  This simply can't happen with the clock stopped
> or with the controller in a low power mode.

Right - unless we have a possibility to re-route the SDIO irq line to
GPIO irq for wake-up when the controller enters low power state.

>
> To that end, we'll disable runtime_pm when we detect that an SDIO card
> was inserted.  This is much like with what we do with the special
> "SDMMC_CLKEN_LOW_PWR" bit that dw_mmc supports.

I wonder whether this is related to SDIO IRQs but not generic to SDIO.

For example, when we have a WIFI chip with a dedicated and separate
IRQ line, enabling SDMMC_CLKEN_LOW_PWR could make sense.

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

Thanks for the detailed clarification.

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

I understand this "quick" fix in dw_mmc takes care of the problem.
However, allow me to try to make this a bit more generic. I intend to
post something within a few days. If I fail, let's go with this
solution.

Kind regards
Uffe

>
> Fixes: e9ed8835e990 ("mmc: dw_mmc: add runtime PM callback")
> Cc: <stable@vger.kernel.org>
> Reported-by: Brian Norris <briannorris@chromium.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
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
>                 if (card->type == MMC_TYPE_SDIO ||
>                     card->type == MMC_TYPE_SD_COMBO) {
> -                       set_bit(DW_MMC_CARD_NO_LOW_PWR, &slot->flags);
> +                       if (!test_bit(DW_MMC_CARD_NO_LOW_PWR, &slot->flags)) {
> +                               pm_runtime_get_noresume(mmc->parent);
> +                               set_bit(DW_MMC_CARD_NO_LOW_PWR, &slot->flags);
> +                       }
>                         clk_en_a = clk_en_a_old & ~clken_low_pwr;
>                 } else {
> -                       clear_bit(DW_MMC_CARD_NO_LOW_PWR, &slot->flags);
> +                       if (test_bit(DW_MMC_CARD_NO_LOW_PWR, &slot->flags)) {
> +                               pm_runtime_put_noidle(mmc->parent);
> +                               clear_bit(DW_MMC_CARD_NO_LOW_PWR, &slot->flags);
> +                       }
>                         clk_en_a = clk_en_a_old | clken_low_pwr;
>                 }
>
> --
> 2.12.2.715.g7642488e1d-goog
>
