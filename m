From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [v2] mmc: sdhci: fix SDHCI_QUIRK_NO_HISPD_BIT handling
Date: Tue, 22 Aug 2017 13:14:38 +0200
Message-ID: <CAPDyKFqPKTH4Xbtb5+x65AzW-WYgQy=HLrj2yEu1wX6xY+OjMg@mail.gmail.com>
References: <1502763407-49116-1-git-send-email-yangbo.lu@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f176.google.com ([209.85.216.176]:35720 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932350AbdHVLOj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Aug 2017 07:14:39 -0400
Received: by mail-qt0-f176.google.com with SMTP id x36so26418110qtx.2
        for <linux-mmc@vger.kernel.org>; Tue, 22 Aug 2017 04:14:38 -0700 (PDT)
In-Reply-To: <1502763407-49116-1-git-send-email-yangbo.lu@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yangbo Lu <yangbo.lu@nxp.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Xiaobo Xie <xiaobo.xie@nxp.com>

On 15 August 2017 at 04:16, Yangbo Lu <yangbo.lu@nxp.com> wrote:
> SD controller with SDHCI_QUIRK_NO_HISPD_BIT quirk probably
> use high speed enable bit for other purpose. So this bit
> shouldn't be changed for high speed enabling for this type of
> SD controller.
>
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
> Changes for v2:
>         - Removed duplicate perenthesis.
>         - Added "Acked-by: Adrian Hunter".
> ---
>  drivers/mmc/host/sdhci.c | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index a1ad2dd..315bded 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1641,19 +1641,20 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>
>         ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
>
> -       if ((ios->timing == MMC_TIMING_SD_HS ||
> -            ios->timing == MMC_TIMING_MMC_HS ||
> -            ios->timing == MMC_TIMING_MMC_HS400 ||
> -            ios->timing == MMC_TIMING_MMC_HS200 ||
> -            ios->timing == MMC_TIMING_MMC_DDR52 ||
> -            ios->timing == MMC_TIMING_UHS_SDR50 ||
> -            ios->timing == MMC_TIMING_UHS_SDR104 ||
> -            ios->timing == MMC_TIMING_UHS_DDR50 ||
> -            ios->timing == MMC_TIMING_UHS_SDR25)
> -           && !(host->quirks & SDHCI_QUIRK_NO_HISPD_BIT))
> -               ctrl |= SDHCI_CTRL_HISPD;
> -       else
> -               ctrl &= ~SDHCI_CTRL_HISPD;
> +       if (!(host->quirks & SDHCI_QUIRK_NO_HISPD_BIT)) {
> +               if (ios->timing == MMC_TIMING_SD_HS ||
> +                    ios->timing == MMC_TIMING_MMC_HS ||
> +                    ios->timing == MMC_TIMING_MMC_HS400 ||
> +                    ios->timing == MMC_TIMING_MMC_HS200 ||
> +                    ios->timing == MMC_TIMING_MMC_DDR52 ||
> +                    ios->timing == MMC_TIMING_UHS_SDR50 ||
> +                    ios->timing == MMC_TIMING_UHS_SDR104 ||
> +                    ios->timing == MMC_TIMING_UHS_DDR50 ||
> +                    ios->timing == MMC_TIMING_UHS_SDR25)
> +                       ctrl |= SDHCI_CTRL_HISPD;
> +               else
> +                       ctrl &= ~SDHCI_CTRL_HISPD;
> +       }
>
>         if (host->version >= SDHCI_SPEC_300) {
>                 u16 clk, ctrl_2;
> --
> 2.1.0.27.g96db324
>
