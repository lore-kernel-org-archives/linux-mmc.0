From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH v2 4/8] mmc: dw_mmc: Use mmc_regulator_set_vqmmc in start_signal_voltage_switch
Date: Fri, 9 Oct 2015 21:06:25 +0200
Message-ID: <CAMAWPa9o=bQJPK+tJ38=5jngTFcOsAi=s9RcETbPN=3SsyQ8gA@mail.gmail.com>
References: <1443622064-14362-1-git-send-email-heiko@sntech.de>
	<1443622064-14362-5-git-send-email-heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:35391 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753187AbbJITGd (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 9 Oct 2015 15:06:33 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id C5A62207C7
	for <linux-mmc@vger.kernel.org>; Fri,  9 Oct 2015 19:06:31 +0000 (UTC)
Received: from mail-wi0-f178.google.com (mail-wi0-f178.google.com [209.85.212.178])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 0C1F1207AD
	for <linux-mmc@vger.kernel.org>; Fri,  9 Oct 2015 19:06:28 +0000 (UTC)
Received: by wiclk2 with SMTP id lk2so79353642wic.1
        for <linux-mmc@vger.kernel.org>; Fri, 09 Oct 2015 12:06:26 -0700 (PDT)
In-Reply-To: <1443622064-14362-5-git-send-email-heiko@sntech.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiko Stuebner <heiko@sntech.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Michael Turquette <mturquette@baylibre.com>, "sboyd@codeaurora.org" <sboyd@codeaurora.org>, tgih.jun@samsung.com, jh80.chung@samsung.com, Alexandru Stan <amstan@chromium.org>, linux-mmc <linux-mmc@vger.kernel.org>, Doug Anderson <dianders@chromium.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, linux-clk@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tyler Baker <tyler.baker@linaro.org>, Olof Johansson <olof@lixom.net>, =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski@samsung.com>

On Wed, Sep 30, 2015 at 4:07 PM, Heiko Stuebner <heiko@sntech.de> wrote:
> From: Douglas Anderson <dianders@chromium.org>
>
> We've introduced a new helper in the MMC core:
> mmc_regulator_set_vqmmc().  Let's use this in dw_mmc.  Using this new
> helper has some advantages:
>
> 1. We get the mmc_regulator_set_vqmmc() behavior of trying to match
>    VQMMC and VMMC when the signal voltage is 3.3V.  This ensures max
>    compatibility.
>
> 2. We get rid of a few more warnings when probing unsupported
>    voltages.
>
> 3. We get rid of some non-dw_mmc specific code in dw_mmc.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

kernelci.org found a new failure in linux-next on
exynos5800-peach-pi[1] and it was bisected down to this patch, which
has hit linux-next in the form of commit fba2e23128d0 (mmc: dw_mmc:
Use mmc_regulator_set_vqmmc in start_signal_voltage_switch).  Based on
a quick glance at the boot log[2], it looks to be a bad pointer
dereference in regulator_get_voltage().

I confirmed that reverting this patch on top of next-20151009 gets my
peach-pi booting again.

Note that the boot failure is only on exynos_defconfig, not multi_v7_defconfig.

Kevin


[1] http://kernelci.org/boot/exynos5800-peach-pi/job/next/kernel/next-20151009/defconfig/exynos_defconfig/lab/lab-khilman/?_id=56177d3659b514a50c6c3267

[2] http://storage.kernelci.org/next/next-20151009/arm-exynos_defconfig/lab-khilman/boot-exynos5800-peach-pi.html


> ---
>  drivers/mmc/host/dw_mmc.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index fcbf552..b1b7e7f 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1279,7 +1279,6 @@ static int dw_mci_switch_voltage(struct mmc_host *mmc, struct mmc_ios *ios)
>         const struct dw_mci_drv_data *drv_data = host->drv_data;
>         u32 uhs;
>         u32 v18 = SDMMC_UHS_18V << slot->id;
> -       int min_uv, max_uv;
>         int ret;
>
>         if (drv_data && drv_data->switch_voltage)
> @@ -1291,22 +1290,18 @@ static int dw_mci_switch_voltage(struct mmc_host *mmc, struct mmc_ios *ios)
>          * does no harm but you need to set the regulator directly.  Try both.
>          */
>         uhs = mci_readl(host, UHS_REG);
> -       if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_330) {
> -               min_uv = 2700000;
> -               max_uv = 3600000;
> +       if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_330)
>                 uhs &= ~v18;
> -       } else {
> -               min_uv = 1700000;
> -               max_uv = 1950000;
> +       else
>                 uhs |= v18;
> -       }
> +
>         if (!IS_ERR(mmc->supply.vqmmc)) {
> -               ret = regulator_set_voltage(mmc->supply.vqmmc, min_uv, max_uv);
> +               ret = mmc_regulator_set_vqmmc(mmc, ios);
>
>                 if (ret) {
>                         dev_dbg(&mmc->class_dev,
> -                                        "Regulator set error %d: %d - %d\n",
> -                                        ret, min_uv, max_uv);
> +                                        "Regulator set error %d - %s V\n",
> +                                        ret, uhs & v18 ? "1.8" : "3.3");
>                         return ret;
>                 }
>         }
> --
> 2.5.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
