From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: sunxi: Prevent against null dereference for vmmc
Date: Fri, 21 Oct 2016 10:21:31 +0200
Message-ID: <CAPDyKFpS-N-BbAgHMegB5FMAoFUbbcroXTdWTPN+EYR8BtT=cA@mail.gmail.com>
References: <20161019133304.22915-1-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f182.google.com ([209.85.216.182]:36371 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752976AbcJUIVd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Oct 2016 04:21:33 -0400
Received: by mail-qt0-f182.google.com with SMTP id m5so76925582qtb.3
        for <linux-mmc@vger.kernel.org>; Fri, 21 Oct 2016 01:21:33 -0700 (PDT)
In-Reply-To: <20161019133304.22915-1-maxime.ripard@free-electrons.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Chen-Yu Tsai <wens@csie.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 19 October 2016 at 15:33, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> VMMC is an optional regulator, which means that mmc_regulator_get_supply
> will only return an error in case of a deferred probe, but not when the
> regulator is not set in the DT.
>
> However, the sunxi driver assumes that VMMC is always there, and doesn't
> check the value of the regulator pointer before using it, which obviously
> leads to a (close to) null pointer dereference.
>
> Add proper checks to prevent that.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks, applied for next!

Kind regards
Uffe

>
> ---
> Changes from v1:
>   - remove redundant error message
> ---
>  drivers/mmc/host/sunxi-mmc.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index c0a5c676d0e8..b1d1303389a7 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -822,10 +822,13 @@ static void sunxi_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>                 break;
>
>         case MMC_POWER_UP:
> -               host->ferror = mmc_regulator_set_ocr(mmc, mmc->supply.vmmc,
> -                                                    ios->vdd);
> -               if (host->ferror)
> -                       return;
> +               if (!IS_ERR(mmc->supply.vmmc)) {
> +                       host->ferror = mmc_regulator_set_ocr(mmc,
> +                                                            mmc->supply.vmmc,
> +                                                            ios->vdd);
> +                       if (host->ferror)
> +                               return;
> +               }
>
>                 if (!IS_ERR(mmc->supply.vqmmc)) {
>                         host->ferror = regulator_enable(mmc->supply.vqmmc);
> @@ -847,7 +850,9 @@ static void sunxi_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>         case MMC_POWER_OFF:
>                 dev_dbg(mmc_dev(mmc), "power off!\n");
>                 sunxi_mmc_reset_host(host);
> -               mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
> +               if (!IS_ERR(mmc->supply.vmmc))
> +                       mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
> +
>                 if (!IS_ERR(mmc->supply.vqmmc) && host->vqmmc_enabled)
>                         regulator_disable(mmc->supply.vqmmc);
>                 host->vqmmc_enabled = false;
> --
> 2.9.3
>
