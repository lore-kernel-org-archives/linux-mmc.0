From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: core: Remove fixed voltage regulator logic
Date: Tue, 12 Aug 2014 10:49:28 +0200
Message-ID: <CAPDyKFo1pAyx2DNH2Q0R6RF5=dPSccvKi0vgQ0KeZ3gf+xisWQ@mail.gmail.com>
References: <1407819913-2488-1-git-send-email-tim.kryger@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f50.google.com ([209.85.216.50]:62669 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665AbaHLIt3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Aug 2014 04:49:29 -0400
Received: by mail-qa0-f50.google.com with SMTP id s7so8772079qap.9
        for <linux-mmc@vger.kernel.org>; Tue, 12 Aug 2014 01:49:28 -0700 (PDT)
In-Reply-To: <1407819913-2488-1-git-send-email-tim.kryger@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tim Kryger <tim.kryger@gmail.com>
Cc: Chris Ball <chris@printf.net>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 12 August 2014 07:05, Tim Kryger <tim.kryger@gmail.com> wrote:
> There is no need for regulator consumers to include special logic for
> fixed voltage regulators as they support regulator_set_voltage() just
> like their non-fixed regulator counterparts.
>
> Signed-off-by: Tim Kryger <tim.kryger@gmail.com>

Thanks! Queued for 3.18.

Kind regards
Uffe

> ---
>
> Changes in v2:
>   - Remove query of the current voltage, just set the desired voltage
>
>
> This simplification of logic is possible due to a recent change that
> allows fixed regulators to return success for regulator_set_voltage
> operations if the requested range overlaps with the fixed voltage.
>
> c00dc35 regulator: core: Allow regulator_set_voltage for fixed regulators
>
> I have verified this change on a BeagleBone Black where the eMMC and SD
> card receive a fixed 3.3v supply.  The TI HSMMC driver used on the BBB,
> like the Intel PXA MMC driver, ensures that software only requests VMMC
> be set to supported voltage ranges by calling mmc_regulator_get_ocrmask.
> This function considers the capabilities of the regulator in order to
> determine an appropriate OCR mask of supported voltages that constrains
> the set of values which may later be passed into mmc_regulator_set_ocr.
>
> Once the following (queued) patch is merged, the SDHCI driver will call
> mmc_regulator_get_supply which then calls mmc_regulator_get_ocrmask.
>
> https://lkml.org/lkml/2014/6/13/451
>
> The Atmel, ARM, Freescale MXC, SuperH Internal MMCIF, Allwinner sunxi,
> Toshiba Mobile IO Controller, and Renesas USDHI6ROL0 drivers already
> call mmc_regulator_get_supply so they too only request voltages that
> are achievable.
>
> There are no other callers of mmc_regulator_set_ocr so this patch should
> be safe.
>
>
>  drivers/mmc/core/core.c |   18 +-----------------
>  1 file changed, 1 insertion(+), 17 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 7dc0c85..1a3e35b 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1263,7 +1263,6 @@ int mmc_regulator_set_ocr(struct mmc_host *mmc,
>
>         if (vdd_bit) {
>                 int             tmp;
> -               int             voltage;
>
>                 /*
>                  * REVISIT mmc_vddrange_to_ocrmask() may have set some
> @@ -1280,22 +1279,7 @@ int mmc_regulator_set_ocr(struct mmc_host *mmc,
>                         max_uV = min_uV + 100 * 1000;
>                 }
>
> -               /*
> -                * If we're using a fixed/static regulator, don't call
> -                * regulator_set_voltage; it would fail.
> -                */
> -               voltage = regulator_get_voltage(supply);
> -
> -               if (!regulator_can_change_voltage(supply))
> -                       min_uV = max_uV = voltage;
> -
> -               if (voltage < 0)
> -                       result = voltage;
> -               else if (voltage < min_uV || voltage > max_uV)
> -                       result = regulator_set_voltage(supply, min_uV, max_uV);
> -               else
> -                       result = 0;
> -
> +               result = regulator_set_voltage(supply, min_uV, max_uV);
>                 if (result == 0 && !mmc->regulator_enabled) {
>                         result = regulator_enable(supply);
>                         if (!result)
> --
> 1.7.9.5
>
