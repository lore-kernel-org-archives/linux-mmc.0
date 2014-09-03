From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2] mmc: sdhci: check 1.2v IO capability for SDHC host
Date: Wed, 3 Sep 2014 09:25:49 +0200
Message-ID: <CAPDyKFr4k47-OuUwYFXziP=teiDizuP6Lv8uJ_MPLufFmbJiww@mail.gmail.com>
References: <20140819030240.GA3201@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:48771 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755570AbaICHZu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 3 Sep 2014 03:25:50 -0400
Received: by mail-lb0-f180.google.com with SMTP id w7so8925833lbi.39
        for <linux-mmc@vger.kernel.org>; Wed, 03 Sep 2014 00:25:49 -0700 (PDT)
In-Reply-To: <20140819030240.GA3201@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chuanxiao Dong <chuanxiao.dong@intel.com>
Cc: "chris@printf.org" <chris@printf.org>, linux-mmc <linux-mmc@vger.kernel.org>

On 19 August 2014 05:02, Chuanxiao Dong <chuanxiao.dong@intel.com> wrote:
> Right now enable 1.2v IO voltage for SDHC is by using vqmmc.
> Thus for the host which doesn't have vqmmc, or its vqmmc does
> not support 1.2v, directly use MMC_CAP2_HS200 may cause HS200
> failure.
>
> So needs to check if vqmmc is able to support 1.2v. If it does
> not support, disable 1.2v IO for HS200.
>
> Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>

Thanks! Applied for next!

Kind regards
Uffe

> ---
> Changelog V2: rebase this patch, and use IS_ERR to check vqmmc.
>
>  drivers/mmc/host/sdhci.c |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 4cc2ff9..a23738c 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -3009,8 +3009,13 @@ int sdhci_add_host(struct sdhci_host *host)
>                 /* SD3.0: SDR104 is supported so (for eMMC) the caps2
>                  * field can be promoted to support HS200.
>                  */
> -               if (!(host->quirks2 & SDHCI_QUIRK2_BROKEN_HS200))
> +               if (!(host->quirks2 & SDHCI_QUIRK2_BROKEN_HS200)) {
>                         mmc->caps2 |= MMC_CAP2_HS200;
> +                       if (IS_ERR(mmc->supply.vqmmc) ||
> +                                       !regulator_is_supported_voltage
> +                                       (mmc->supply.vqmmc, 1100000, 1300000))
> +                               mmc->caps2 &= ~MMC_CAP2_HS200_1_2V_SDR;
> +               }
>         } else if (caps[1] & SDHCI_SUPPORT_SDR50)
>                 mmc->caps |= MMC_CAP_UHS_SDR50;
>
> --
> 1.7.10.4
>
