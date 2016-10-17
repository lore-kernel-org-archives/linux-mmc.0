From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci: put together into one condition checking
Date: Mon, 17 Oct 2016 15:49:37 +0200
Message-ID: <CAPDyKFo_15YOJ_kcJ7J_1Xmumaz8XiDFCu05XntbQ_rr-+32Ow@mail.gmail.com>
References: <1475816923-24532-1-git-send-email-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f179.google.com ([209.85.161.179]:33993 "EHLO
        mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758050AbcJQNtj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Oct 2016 09:49:39 -0400
Received: by mail-yw0-f179.google.com with SMTP id w3so115355640ywg.1
        for <linux-mmc@vger.kernel.org>; Mon, 17 Oct 2016 06:49:39 -0700 (PDT)
In-Reply-To: <1475816923-24532-1-git-send-email-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>

On 7 October 2016 at 07:08, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> value of ios->timing is not related with SDCHI v3.0.
> If Controller version is v3.0, SDHCI_QUIRK_NO_HISPD_BIT is meaningless.
> To prevent the setting wrong bit moves into one codntion checking.
> (e.g sdhci-s3c doesn't use SDHCI_CTRL_HISPD bit, instead using this bit as
>  other purpose.)
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 4805566..f854c66 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1619,7 +1619,14 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>         ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
>
>         if ((ios->timing == MMC_TIMING_SD_HS ||
> -            ios->timing == MMC_TIMING_MMC_HS)
> +            ios->timing == MMC_TIMING_MMC_HS ||
> +            ios->timing == MMC_TIMING_MMC_HS400 ||
> +            ios->timing == MMC_TIMING_MMC_HS200 ||
> +            ios->timing == MMC_TIMING_MMC_DDR52 ||
> +            ios->timing == MMC_TIMING_UHS_SDR50 ||
> +            ios->timing == MMC_TIMING_UHS_SDR104 ||
> +            ios->timing == MMC_TIMING_UHS_DDR50 ||
> +            ios->timing == MMC_TIMING_UHS_SDR25)
>             && !(host->quirks & SDHCI_QUIRK_NO_HISPD_BIT))
>                 ctrl |= SDHCI_CTRL_HISPD;
>         else
> @@ -1628,16 +1635,6 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>         if (host->version >= SDHCI_SPEC_300) {
>                 u16 clk, ctrl_2;
>
> -               /* In case of UHS-I modes, set High Speed Enable */
> -               if ((ios->timing == MMC_TIMING_MMC_HS400) ||
> -                   (ios->timing == MMC_TIMING_MMC_HS200) ||
> -                   (ios->timing == MMC_TIMING_MMC_DDR52) ||
> -                   (ios->timing == MMC_TIMING_UHS_SDR50) ||
> -                   (ios->timing == MMC_TIMING_UHS_SDR104) ||
> -                   (ios->timing == MMC_TIMING_UHS_DDR50) ||
> -                   (ios->timing == MMC_TIMING_UHS_SDR25))
> -                       ctrl |= SDHCI_CTRL_HISPD;
> -
>                 if (!host->preset_enabled) {
>                         sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
>                         /*
> --
> 1.9.1
>
