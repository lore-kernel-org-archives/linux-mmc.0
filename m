From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: dw_mmc: Don't allow Runtime PM for SDIO cards
Date: Tue, 18 Apr 2017 21:15:29 +0200
Message-ID: <CAPDyKFoK+zv+dY1+qrWg10kBE9S7enDkxbKQTy=XejsKmq+Z3A@mail.gmail.com>
References: <20170411225543.987-1-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vk0-f46.google.com ([209.85.213.46]:35310 "EHLO
        mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751520AbdDRTPa (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Apr 2017 15:15:30 -0400
Received: by mail-vk0-f46.google.com with SMTP id r69so1320825vke.2
        for <linux-mmc@vger.kernel.org>; Tue, 18 Apr 2017 12:15:30 -0700 (PDT)
In-Reply-To: <20170411225543.987-1-dianders@chromium.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Douglas Anderson <dianders@chromium.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Brian Norris <briannorris@chromium.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Shawn Lin <shawn.lin@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, kevin@archlinuxarm.org, Alexandru Stan <amstan@chromium.org>, Ziyuan Xu <xzy.xu@rock-chips.com>, "# 4.0+" <stable@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 12 April 2017 at 00:55, Douglas Anderson <dianders@chromium.org> wrote:
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

Thanks, applied for fixes!

I think this is the easiest way to fix the problem for stable and for 4.11.
However I think we should be able to revert this change for 4.12 or
perhaps for 4.13, once we find a more fine-grained solution. As you
probably noticed, I also gave that a try [1]. If you want to test it,
don't forget to revert $subject patch before testing.

Kind regards
Uffe

[1]
https://patchwork.kernel.org/patch/9685461/
https://patchwork.kernel.org/patch/9685463/
https://patchwork.kernel.org/patch/9685465/

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
