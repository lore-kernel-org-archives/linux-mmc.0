From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 3/8] mmc: core: Add mmc_regulator_set_vqmmc()
Date: Wed, 2 Sep 2015 13:38:31 +0200
Message-ID: <CAPDyKFqJp3VuOeTh4Abkn2X6gQxNHDXwJj8N51OxxSo+Agespw@mail.gmail.com>
References: <1441045446-30858-1-git-send-email-heiko@sntech.de>
	<1441045446-30858-4-git-send-email-heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:38163 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753698AbbIBLic (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Sep 2015 07:38:32 -0400
Received: by wiclp12 with SMTP id lp12so15878853wic.1
        for <linux-mmc@vger.kernel.org>; Wed, 02 Sep 2015 04:38:31 -0700 (PDT)
In-Reply-To: <1441045446-30858-4-git-send-email-heiko@sntech.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiko Stuebner <heiko@sntech.de>, Douglas Anderson <dianders@chromium.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, "tgih.jun@samsung.com" <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, linux-clk@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 31 August 2015 at 20:24, Heiko Stuebner <heiko@sntech.de> wrote:
> From: Douglas Anderson <dianders@chromium.org>
>
> This adds logic to the MMC core to set VQMMC.  This is expected to be
> called by MMC drivers like dw_mmc as part of (or instead of) their
> start_signal_voltage_switch() callback.
>
> A few notes:
>
> * When setting the signal voltage to 3.3V we do our best to make VQMMC
>   and VMMC match.  It's been reported that this makes some old cards
>   happy since they were tested back in the day before UHS when VQMMC
>   and VMMC were provided by the same regulator.  A nice side effect of
>   this is that we don't end up on the hairy edge of VQMMC (2.7V),
>   which some EEs claim is a little too close to the minimum for
>   comfort.
>   If this is not supported by the supplying regulator we try to find
>   a suitable voltage within the whole 2.7V-3.6V area of the spec.
>
> * When setting the signal voltage to 1.8V or 1.2V we aim for that
>   specific voltage instead of picking the lowest one in the range.
>
> * We very purposely don't print errors in mmc_regulator_set_vqmmc().
>   There are cases where the MMC core will try several different
>   voltages and we don't want to pollute the logs.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  drivers/mmc/core/core.c  | 68 ++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mmc/host.h |  7 +++++
>  2 files changed, 75 insertions(+)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 0520064..9dc0b65 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1437,6 +1437,74 @@ int mmc_regulator_set_ocr(struct mmc_host *mmc,
>  }
>  EXPORT_SYMBOL_GPL(mmc_regulator_set_ocr);
>
> +static int mmc_regulator_set_voltage_if_supported(struct regulator *regulator,
> +                                                 int min_uV, int target_uV,
> +                                                 int max_uV)
> +{
> +       /*
> +        * Check if supported first to avoid errors since we may try several
> +        * signal levels during power up and don't want to show errors.
> +        */
> +       if (!regulator_is_supported_voltage(regulator, min_uV, max_uV))
> +               return -EINVAL;
> +
> +       return regulator_set_voltage_triplet(regulator, min_uV, target_uV,
> +                                            max_uV);
> +}
> +
> +/**
> + * mmc_regulator_set_vqmmc - Set VQMMC as per the ios
> + *
> + * For 3.3V signaling, we try to match VQMMC to VMMC as closely as possible.

Looking at the code, I don't think this statement is entirely true.
Isn't it so that we will be trying with a maximum tolerance of 0.3 V
towards the VMMC voltage level (then fall-back to the complete range)?
Perhaps you can find a better way to describe that in the change log.

Just to be clear, I believe this approach make sense but I appreciate
some more details about the policy, both in the code and in the change
log.

> + * That will match the behavior of old boards where VQMMC and VMMC were supplied
> + * by the same supply.  The Bus Operating conditions for 3.3V signaling in the
> + * SD card spec also define VQMMC in terms of VMMC.
> + * If this is not possible we'll try the full 2.7-3.6V of the spec.
> + *
> + * For 1.2V and 1.8V signaling we'll try to get as close as possible to the
> + * requested voltage.  This is definitely a good idea for UHS where there's a
> + * separate regulator on the card that's trying to make 1.8V and it's best if
> + * we match.
> + *
> + * This function is expected to be used by a controller's
> + * start_signal_voltage_switch() function.
> + */
> +int mmc_regulator_set_vqmmc(struct mmc_host *mmc, struct mmc_ios *ios)
> +{
> +       int volt, min_uV, max_uV;
> +
> +       /* If no vqmmc supply then we can't change the voltage */
> +       if (IS_ERR(mmc->supply.vqmmc))
> +               return -EINVAL;

In general vqmmc is considered as an optional regulator and that's
also how host drivers treat it. So perhaps it would make sense to
return 0 here instead of an error code or what do you think?

> +
> +       switch (ios->signal_voltage) {
> +       case MMC_SIGNAL_VOLTAGE_120:
> +               return mmc_regulator_set_voltage_if_supported(mmc->supply.vqmmc,
> +                                               1100000, 1200000, 1300000);
> +       case MMC_SIGNAL_VOLTAGE_180:
> +               return mmc_regulator_set_voltage_if_supported(mmc->supply.vqmmc,
> +                                               1700000, 1800000, 1950000);
> +       case MMC_SIGNAL_VOLTAGE_330:
> +               volt = regulator_get_voltage(mmc->supply.vmmc);

Before invoking regulator_get_voltage(), we need to check for an
existing regulator handle for vmmc.

Moreover, as the regulator handle to vmmc is optional, perhaps we
should fall-back to use the ios->vdd bit to find the current voltage
level?

> +               if (volt < 0)
> +                       return volt;
> +
> +               min_uV = max(volt - 300000, 2700000);
> +               max_uV = min(volt + 300000, 3600000);

These calculations deserves a comment.

> +
> +               /* try to stay close to vmmc at first */
> +               if (!mmc_regulator_set_voltage_if_supported(mmc->supply.vqmmc,
> +                                               min_uV, volt, max_uV))
> +                       return 0;
> +
> +               return mmc_regulator_set_voltage_if_supported(mmc->supply.vqmmc,
> +                                               2700000, volt, 3600000);
> +       default:
> +               return -EINVAL;
> +       }
> +}
> +EXPORT_SYMBOL_GPL(mmc_regulator_set_vqmmc);
> +
>  #endif /* CONFIG_REGULATOR */
>
>  int mmc_regulator_get_supply(struct mmc_host *mmc)
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 83b81fd..a2a78eb 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -423,6 +423,7 @@ int mmc_regulator_get_ocrmask(struct regulator *supply);
>  int mmc_regulator_set_ocr(struct mmc_host *mmc,
>                         struct regulator *supply,
>                         unsigned short vdd_bit);
> +int mmc_regulator_set_vqmmc(struct mmc_host *mmc, struct mmc_ios *ios);
>  #else
>  static inline int mmc_regulator_get_ocrmask(struct regulator *supply)
>  {
> @@ -435,6 +436,12 @@ static inline int mmc_regulator_set_ocr(struct mmc_host *mmc,
>  {
>         return 0;
>  }
> +
> +static inline int mmc_regulator_set_vqmmc(struct mmc_host *mmc,
> +                                         struct mmc_ios *ios)
> +{
> +       return -EINVAL;

According to my upper comment about vqmmc being optional, perhaps this
shouldn't be treated as an error!?

> +}
>  #endif
>
>  int mmc_regulator_get_supply(struct mmc_host *mmc);
> --
> 2.1.4
>

Finally, I wonder if you have considered to handle the
regulator_enable|disable() calls from within this new API? Currently
host driver deals with that themselves, but it would be nice to get
some consolidation around that. Similar to what we already have for
the vmmc regulator through the mmc_regulator_set_ocr() API.

If you considered this, I am fine with adding that kind of
functionality as a separate patch on top of this one, it gets easier
to discuss/review.

Kind regards
Uffe
