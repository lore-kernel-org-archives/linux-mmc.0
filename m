From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3] mmc: remove MMC_CAP_ERASE to enable trim in eMMC device
Date: Tue, 11 Feb 2014 23:38:21 +0100
Message-ID: <CAPDyKFpYXHku6pQ-VvCL2DJH6MH8bfQkETyv+mjyYk4zg61FsA@mail.gmail.com>
References: <1392144035-12895-1-git-send-email-puthik@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f48.google.com ([209.85.216.48]:55633 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751996AbaBKWqi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Feb 2014 17:46:38 -0500
Received: by mail-qa0-f48.google.com with SMTP id f11so12641650qae.21
        for <linux-mmc@vger.kernel.org>; Tue, 11 Feb 2014 14:46:37 -0800 (PST)
In-Reply-To: <1392144035-12895-1-git-send-email-puthik@chromium.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Puthikorn Voravootivat <puthik@chromium.org>
Cc: Chris Ball <chris@printf.net>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, MMC list <linux-mmc@vger.kernel.org>, Gwendal Grignou <gwendal@chromium.org>, Grant Grundler <grundler@chromium.org>

On 11 February 2014 19:40, Puthikorn Voravootivat <puthik@chromium.org> wrote:
> Remove host erase capacity check to enable trim and
> discard feature in supported eMMC device.

I guess your patch applies for SD cards as well. Maybe some more
information in the commit message about this.

>
> Signed-off-by: Puthikorn Voravootivat <puthik@chromium.org>
> ---
> v3 change:
> As suggested by Jaehoon, this patch remove MMC_CAP_ERASE instead of
> force enable it.
>
> v2 change:
> Instead of add MMC_CAP_ERASE just only for dw_mmc, this patch adds
> this capability to all host.
>
>  arch/arm/mach-ux500/board-mop500-sdi.c | 3 ---

You need acks from ux500 SOC maintainer for this, I suggest you resend.

Depending on his input, you might be advised to handle this in more
step-by-step procedure, but let's see.

Otherwise, it looks good.

Kind regards
Ulf Hansson

>  drivers/mmc/core/core.c                | 6 ++----
>  drivers/mmc/host/omap_hsmmc.c          | 2 +-
>  drivers/mmc/host/sdhci.c               | 2 +-
>  include/linux/mmc/host.h               | 1 -
>  5 files changed, 4 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm/mach-ux500/board-mop500-sdi.c b/arch/arm/mach-ux500/board-mop500-sdi.c
> index fcbf3a1..6d9feb8 100644
> --- a/arch/arm/mach-ux500/board-mop500-sdi.c
> +++ b/arch/arm/mach-ux500/board-mop500-sdi.c
> @@ -48,7 +48,6 @@ struct mmci_platform_data mop500_sdi0_data = {
>         .capabilities   = MMC_CAP_4_BIT_DATA |
>                                 MMC_CAP_SD_HIGHSPEED |
>                                 MMC_CAP_MMC_HIGHSPEED |
> -                               MMC_CAP_ERASE |
>                                 MMC_CAP_UHS_SDR12 |
>                                 MMC_CAP_UHS_SDR25,
>         .gpio_wp        = -1,
> @@ -119,7 +118,6 @@ struct mmci_platform_data mop500_sdi2_data = {
>                                 MMC_CAP_8_BIT_DATA |
>                                 MMC_CAP_NONREMOVABLE |
>                                 MMC_CAP_MMC_HIGHSPEED |
> -                               MMC_CAP_ERASE |
>                                 MMC_CAP_CMD23,
>         .gpio_cd        = -1,
>         .gpio_wp        = -1,
> @@ -154,7 +152,6 @@ struct mmci_platform_data mop500_sdi4_data = {
>                                 MMC_CAP_8_BIT_DATA |
>                                 MMC_CAP_NONREMOVABLE |
>                                 MMC_CAP_MMC_HIGHSPEED |
> -                               MMC_CAP_ERASE |
>                                 MMC_CAP_CMD23,
>         .gpio_cd        = -1,
>         .gpio_wp        = -1,
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 098374b..82de9f1 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2007,8 +2007,7 @@ int mmc_erase(struct mmc_card *card, unsigned int from, unsigned int nr,
>  {
>         unsigned int rem, to = from + nr;
>
> -       if (!(card->host->caps & MMC_CAP_ERASE) ||
> -           !(card->csd.cmdclass & CCC_ERASE))
> +       if (!(card->csd.cmdclass & CCC_ERASE))
>                 return -EOPNOTSUPP;
>
>         if (!card->erase_size)
> @@ -2062,8 +2061,7 @@ EXPORT_SYMBOL(mmc_erase);
>
>  int mmc_can_erase(struct mmc_card *card)
>  {
> -       if ((card->host->caps & MMC_CAP_ERASE) &&
> -           (card->csd.cmdclass & CCC_ERASE) && card->erase_size)
> +       if ((card->csd.cmdclass & CCC_ERASE) && card->erase_size)
>                 return 1;
>         return 0;
>  }
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index dbd32ad..99d8558 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1873,7 +1873,7 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
>         mmc->max_seg_size = mmc->max_req_size;
>
>         mmc->caps |= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
> -                    MMC_CAP_WAIT_WHILE_BUSY | MMC_CAP_ERASE;
> +                    MMC_CAP_WAIT_WHILE_BUSY;
>
>         mmc->caps |= mmc_slot(host).caps;
>         if (mmc->caps & MMC_CAP_8_BIT_DATA)
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 9ddef47..6a50141 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2943,7 +2943,7 @@ int sdhci_add_host(struct sdhci_host *host)
>
>         mmc->max_discard_to = (1 << 27) / host->timeout_clk;
>
> -       mmc->caps |= MMC_CAP_SDIO_IRQ | MMC_CAP_ERASE | MMC_CAP_CMD23;
> +       mmc->caps |= MMC_CAP_SDIO_IRQ | MMC_CAP_CMD23;
>
>         if (host->quirks & SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12)
>                 host->flags |= SDHCI_AUTO_CMD12;
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 99f5709..8b1bfab 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -242,7 +242,6 @@ struct mmc_host {
>  #define MMC_CAP_AGGRESSIVE_PM  (1 << 7)        /* Suspend (e)MMC/SD at idle  */
>  #define MMC_CAP_NONREMOVABLE   (1 << 8)        /* Nonremovable e.g. eMMC */
>  #define MMC_CAP_WAIT_WHILE_BUSY        (1 << 9)        /* Waits while card is busy */
> -#define MMC_CAP_ERASE          (1 << 10)       /* Allow erase/trim commands */
>  #define MMC_CAP_1_8V_DDR       (1 << 11)       /* can support */
>                                                 /* DDR mode at 1.8V */
>  #define MMC_CAP_1_2V_DDR       (1 << 12)       /* can support */
> --
> 1.9.0.rc1.175.g0b1dcb5
>
