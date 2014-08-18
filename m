From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci: check 1.2v IO capability for SDHC host
Date: Mon, 18 Aug 2014 11:38:46 +0200
Message-ID: <CAPDyKFo=Ua6to8cTjZiS6pU=LRHC5r6xnBC5j8Gcwr3_abDa+A@mail.gmail.com>
References: <20140814100559.GB3933@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171]:41002 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753384AbaHRJir (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Aug 2014 05:38:47 -0400
Received: by mail-qc0-f171.google.com with SMTP id r5so4565390qcx.30
        for <linux-mmc@vger.kernel.org>; Mon, 18 Aug 2014 02:38:46 -0700 (PDT)
In-Reply-To: <20140814100559.GB3933@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chuanxiao Dong <chuanxiao.dong@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, chris@printf.org

On 14 August 2014 12:05, Chuanxiao Dong <chuanxiao.dong@intel.com> wrote:
> Right now enable 1.2v IO voltage for SDHC is by using vqmmc.
> Thus for the host which doesn't have vqmmc, or its vqmmc does
> not support 1.2v, directly use MMC_CAP2_HS200 may cause HS200
> failure.
>
> So needs to check if vqmmc is able to support 1.2v. If it does
> not support, disable 1.2v IO for HS200.
>
> Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>
> ---
>  drivers/mmc/host/sdhci.c |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index c026ec8..6b701e1 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2999,8 +2999,12 @@ int sdhci_add_host(struct sdhci_host *host)
>                 /* SD3.0: SDR104 is supported so (for eMMC) the caps2
>                  * field can be promoted to support HS200.
>                  */
> -               if (!(host->quirks2 & SDHCI_QUIRK2_BROKEN_HS200))
> +               if (!(host->quirks2 & SDHCI_QUIRK2_BROKEN_HS200)) {
>                         mmc->caps2 |= MMC_CAP2_HS200;
> +                       if (!host->vqmmc || !regulator_is_supported_voltage

This needs a rebase and please use IS_ERR.

(!IS_ERR(mmc->supply.vqmmc) ...

Kind regards
Uffe


> +                                       (host->vqmmc, 1100000, 1300000))
> +                               mmc->caps2 &= ~MMC_CAP2_HS200_1_2V_SDR;
> +               }
>         } else if (caps[1] & SDHCI_SUPPORT_SDR50)
>                 mmc->caps |= MMC_CAP_UHS_SDR50;
>
> --
> 1.7.10.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
