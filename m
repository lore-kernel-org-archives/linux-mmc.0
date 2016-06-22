From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: host: use the defined function to check whether
 card is removable
Date: Wed, 22 Jun 2016 17:23:51 +0200
Message-ID: <CAPDyKFr2ObKLWB7wY_SFqhzycsoDn7uqfN=k74mG1_cAsaw3uA@mail.gmail.com>
References: <1466471606-3909-1-git-send-email-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:38263 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752969AbcFVPXx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Jun 2016 11:23:53 -0400
Received: by mail-wm0-f47.google.com with SMTP id r201so11148471wme.1
        for <linux-mmc@vger.kernel.org>; Wed, 22 Jun 2016 08:23:53 -0700 (PDT)
In-Reply-To: <1466471606-3909-1-git-send-email-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Shawn Lin <shawn.lin@rock-chips.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>

On 21 June 2016 at 03:13, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> In linux/mmc/host.h, mmc_card_is_removable() is already defined.
> It should be maintainted more easier than now.
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
> Changelog V2:
>         - Added the missed host controller (sdhci-of-at91.c)
>
>  drivers/mmc/host/dw_mmc.c         | 3 +--
>  drivers/mmc/host/mxcmmc.c         | 2 +-
>  drivers/mmc/host/sdhci-bcm-kona.c | 6 +++---
>  drivers/mmc/host/sdhci-of-at91.c  | 2 +-
>  drivers/mmc/host/sdhci-st.c       | 2 +-
>  drivers/mmc/host/sdhci.c          | 6 +++---
>  drivers/mmc/host/tmio_mmc_pio.c   | 2 +-
>  7 files changed, 11 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 2cc6123..8012858 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1451,8 +1451,7 @@ static int dw_mci_get_cd(struct mmc_host *mmc)
>         int gpio_cd = mmc_gpio_get_cd(mmc);
>
>         /* Use platform get_cd function, else try onboard card detect */
> -       if ((mmc->caps & MMC_CAP_NEEDS_POLL) ||
> -           (mmc->caps & MMC_CAP_NONREMOVABLE))
> +       if ((mmc->caps & MMC_CAP_NEEDS_POLL) || !mmc_card_is_removable(mmc))
>                 present = 1;
>         else if (gpio_cd >= 0)
>                 present = gpio_cd;
> diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
> index 3d1ea5e..fb3ca82 100644
> --- a/drivers/mmc/host/mxcmmc.c
> +++ b/drivers/mmc/host/mxcmmc.c
> @@ -1065,7 +1065,7 @@ static int mxcmci_probe(struct platform_device *pdev)
>
>         if (pdata)
>                 dat3_card_detect = pdata->dat3_card_detect;
> -       else if (!(mmc->caps & MMC_CAP_NONREMOVABLE)
> +       else if (mmc_card_is_removable(mmc)
>                         && !of_property_read_bool(pdev->dev.of_node, "cd-gpios"))
>                 dat3_card_detect = true;
>
> diff --git a/drivers/mmc/host/sdhci-bcm-kona.c b/drivers/mmc/host/sdhci-bcm-kona.c
> index 00a8a40..1d64712 100644
> --- a/drivers/mmc/host/sdhci-bcm-kona.c
> +++ b/drivers/mmc/host/sdhci-bcm-kona.c
> @@ -264,12 +264,12 @@ static int sdhci_bcm_kona_probe(struct platform_device *pdev)
>         }
>
>         dev_dbg(dev, "non-removable=%c\n",
> -               (host->mmc->caps & MMC_CAP_NONREMOVABLE) ? 'Y' : 'N');
> +               mmc_card_is_removable(host->mmc) ? 'N' : 'Y');
>         dev_dbg(dev, "cd_gpio %c, wp_gpio %c\n",
>                 (mmc_gpio_get_cd(host->mmc) != -ENOSYS) ? 'Y' : 'N',
>                 (mmc_gpio_get_ro(host->mmc) != -ENOSYS) ? 'Y' : 'N');
>
> -       if (host->mmc->caps & MMC_CAP_NONREMOVABLE)
> +       if (!mmc_card_is_removable(host->mmc))
>                 host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
>
>         dev_dbg(dev, "is_8bit=%c\n",
> @@ -288,7 +288,7 @@ static int sdhci_bcm_kona_probe(struct platform_device *pdev)
>         }
>
>         /* if device is eMMC, emulate card insert right here */
> -       if (host->mmc->caps & MMC_CAP_NONREMOVABLE) {
> +       if (!mmc_card_is_removable(host->mmc)) {
>                 ret = sdhci_bcm_kona_sd_card_emulate(host, 1);
>                 if (ret) {
>                         dev_err(dev,
> diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
> index d4cef71..a9b7fc0 100644
> --- a/drivers/mmc/host/sdhci-of-at91.c
> +++ b/drivers/mmc/host/sdhci-of-at91.c
> @@ -288,7 +288,7 @@ static int sdhci_at91_probe(struct platform_device *pdev)
>          * Disable SDHCI_QUIRK_BROKEN_CARD_DETECTION to be sure nobody tries
>          * to enable polling via device tree with broken-cd property.
>          */
> -       if (!(host->mmc->caps & MMC_CAP_NONREMOVABLE) &&
> +       if (mmc_card_is_removable(host->mmc) &&
>             mmc_gpio_get_cd(host->mmc) < 0) {
>                 host->mmc->caps |= MMC_CAP_NEEDS_POLL;
>                 host->quirks &= ~SDHCI_QUIRK_BROKEN_CARD_DETECTION;
> diff --git a/drivers/mmc/host/sdhci-st.c b/drivers/mmc/host/sdhci-st.c
> index 320e1c2..c95ba83 100644
> --- a/drivers/mmc/host/sdhci-st.c
> +++ b/drivers/mmc/host/sdhci-st.c
> @@ -183,7 +183,7 @@ static void st_mmcss_cconfig(struct device_node *np, struct sdhci_host *host)
>
>         writel_relaxed(cconf2, host->ioaddr + ST_MMC_CCONFIG_REG_2);
>
> -       if (mhost->caps & MMC_CAP_NONREMOVABLE)
> +       if (!mmc_card_is_removable(mhost))
>                 cconf3 |= ST_MMC_CCONFIG_EMMC_SLOT_TYPE;
>         else
>                 /* CARD _D ET_CTRL */
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 040af1b..b965461 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -117,7 +117,7 @@ static void sdhci_set_card_detection(struct sdhci_host *host, bool enable)
>         u32 present;
>
>         if ((host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION) ||
> -           (host->mmc->caps & MMC_CAP_NONREMOVABLE))
> +           !mmc_card_is_removable(host->mmc))
>                 return;
>
>         if (enable) {
> @@ -1617,7 +1617,7 @@ static int sdhci_get_cd(struct mmc_host *mmc)
>                 return 0;
>
>         /* If nonremovable, assume that the card is always present. */
> -       if (host->mmc->caps & MMC_CAP_NONREMOVABLE)
> +       if (!mmc_card_is_removable(host->mmc))
>                 return 1;
>
>         /*
> @@ -3089,7 +3089,7 @@ int sdhci_add_host(struct sdhci_host *host)
>                 mmc->caps |= MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED;
>
>         if ((host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION) &&
> -           !(mmc->caps & MMC_CAP_NONREMOVABLE) &&
> +           mmc_card_is_removable(mmc) &&
>             mmc_gpio_get_cd(host->mmc) < 0)
>                 mmc->caps |= MMC_CAP_NEEDS_POLL;
>
> diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
> index f44e2ab..92467ef 100644
> --- a/drivers/mmc/host/tmio_mmc_pio.c
> +++ b/drivers/mmc/host/tmio_mmc_pio.c
> @@ -1086,7 +1086,7 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host,
>
>         _host->native_hotplug = !(pdata->flags & TMIO_MMC_USE_GPIO_CD ||
>                                   mmc->caps & MMC_CAP_NEEDS_POLL ||
> -                                 mmc->caps & MMC_CAP_NONREMOVABLE ||
> +                                 !mmc_card_is_removable(mmc) ||
>                                   mmc->slot.cd_irq >= 0);
>
>         if (tmio_mmc_clk_enable(_host) < 0) {
> --
> 1.9.1
>
