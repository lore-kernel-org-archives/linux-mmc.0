Return-Path: <SRS0=NquR=6B=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B3A5C38A29
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Apr 2020 09:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E968121D91
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Apr 2020 09:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a90SQsS+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730284AbgDQJbe (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 17 Apr 2020 05:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730309AbgDQJbd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Apr 2020 05:31:33 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF1AC061A0C
        for <linux-mmc@vger.kernel.org>; Fri, 17 Apr 2020 02:31:33 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id y185so755294vsy.8
        for <linux-mmc@vger.kernel.org>; Fri, 17 Apr 2020 02:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LteAXIIsrp1CuT0bJHfTfTXVVjJ2aQC98EY5Gd5exSE=;
        b=a90SQsS+roE5+U+X4bxzqK0mpeiSMkioucChZFQIp90eE4W6v8cw/F7FmXrdJGxXho
         PFJzBkUeXcVvnka/NofI8TI4oLpXT7J/6FYfLOeiCHnHWRU9TwvXA0sZs/jXUT28HWFT
         ZoY89T5KEBOI0cgG4edFgzvjK07sR3qCftOej1NF5FosfdAP+nmRTbQ+pJCZGRCoKGgF
         3FqxFZ0OM353lAy/l/xcOy4OBiDDSKH80SeigpG3mBtIFCHIfy64A4blNkmZZMImYExz
         xKyT8AxIlEkedMXawuAcesLmaKt+QOIyoNy0CmNrr6gogLlzhYZPqY/0RyaHFoW0WjIs
         zHUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LteAXIIsrp1CuT0bJHfTfTXVVjJ2aQC98EY5Gd5exSE=;
        b=eito1u17M9HyrXLrI1ZNdLiMrzrPAK5DJJVoXrQa4OYQoyHf0V4vsBsjG60ZPNQ8jI
         Xw0Rg/JDQq1tUiD4M5UqIi9gLUHzv3XWsgXz/mlBXB6JdEK1u95xPyStcdbxcfu5j5sV
         4o4n3+OjbbkxrC1XsMR62fcTksrKpOOpDV+XsMKGJoz6scBR9QyTlu+kmbmNF2P2yPlM
         CLQ6fxQsy6Vo08WUTCMDHLJCDI92r68hJpFwJsdVMOpkf4j5fxBbHVdgiHWxwyGBEcNa
         0CNA3EiiKYYA9SXVVdIs2c1an55Bhu7KIbC4YJXrMgV6EA5obFH7qwEDrqNs2X3RoomU
         4URA==
X-Gm-Message-State: AGi0PubOzP/pdnUydq+Ha+exR6HKr2eaFDv9xEMZS6/CiUvoMRar9HOK
        2gsPilS/nEdRE49EB2K662eiutr6TfDcyPF8ErNHsg==
X-Google-Smtp-Source: APiQypL2WzeLmIOCanhciVl3me04EqW3Y3QAwA9q/jllkerSQWRBY8QgsJ3vJn8SDIZXQibjU1bnf2OS8n+A0G1WOZo=
X-Received: by 2002:a67:8b09:: with SMTP id n9mr1450579vsd.191.1587115892956;
 Fri, 17 Apr 2020 02:31:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200416163649.336967-1-marex@denx.de>
In-Reply-To: <20200416163649.336967-1-marex@denx.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 17 Apr 2020 11:30:57 +0200
Message-ID: <CAPDyKFqztJDfTrc+1q9mdyf0f2s=gE91J3eM92rzmm+FJNBW9A@mail.gmail.com>
Subject: Re: [PATCH V2 1/3] mmc: Prepare all code for mmc_regulator_set_vqmmc()
 returning > 0
To:     Marek Vasut <marex@denx.de>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ludovic Barre <ludovic.barre@st.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        Patrick Delaunay <patrick.delaunay@st.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 16 Apr 2020 at 18:36, Marek Vasut <marex@denx.de> wrote:
>
> Patch all drivers which use mmc_regulator_set_vqmmc() and prepare them for
> the fact that mmc_regulator_set_vqmmc() can return a value > 0, which would
> happen if the signal voltage switch did NOT happen, because the voltage was
> already set correctly.
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Alexandre Torgue <alexandre.torgue@st.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Ludovic Barre <ludovic.barre@st.com>
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Patrice Chotard <patrice.chotard@st.com>
> Cc: Patrick Delaunay <patrick.delaunay@st.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-stm32@st-md-mailman.stormreply.com
> To: linux-mmc@vger.kernel.org

Applied for next, thanks!

I took the liberty to re-work and simplify some of the code, please
have a look at my next branch to make sure I didn't screw something
up.

Kind regards
Uffe

diff --git a/drivers/mmc/host/dw_mmc-k3.c b/drivers/mmc/host/dw_mmc-k3.c
index 23b6f65b3785..50977ff18074 100644
--- a/drivers/mmc/host/dw_mmc-k3.c
+++ b/drivers/mmc/host/dw_mmc-k3.c
@@ -424,7 +424,7 @@ static int dw_mci_hi3660_switch_voltage(struct
mmc_host *mmc,

        if (!IS_ERR(mmc->supply.vqmmc)) {
                ret = mmc_regulator_set_vqmmc(mmc, ios);
-               if (ret) {
+               if (ret < 0) {
                        dev_err(host->dev, "Regulator set error %d\n", ret);
                        return ret;
                }
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index bc5278ab5707..5d1f8a3ec3a5 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1546,8 +1546,7 @@ static int dw_mci_switch_voltage(struct mmc_host
*mmc, struct mmc_ios *ios)

        if (!IS_ERR(mmc->supply.vqmmc)) {
                ret = mmc_regulator_set_vqmmc(mmc, ios);
-
-               if (ret) {
+               if (ret < 0) {
                        dev_dbg(&mmc->class_dev,
                                         "Regulator set error %d - %s V\n",
                                         ret, uhs & v18 ? "1.8" : "3.3");



> ---
> V2: Patch only mmc_regulator_set_vqmmc()
> ---
>  drivers/mmc/host/dw_mmc-k3.c         |  2 ++
>  drivers/mmc/host/dw_mmc.c            |  2 ++
>  drivers/mmc/host/meson-gx-mmc.c      |  7 ++++++-
>  drivers/mmc/host/mtk-sd.c            |  2 ++
>  drivers/mmc/host/renesas_sdhi_core.c |  2 ++
>  drivers/mmc/host/sdhci-sprd.c        |  2 ++
>  drivers/mmc/host/sdhci.c             |  6 ++++++
>  drivers/mmc/host/sunxi-mmc.c         | 10 ++++++++--
>  drivers/mmc/host/usdhi6rol0.c        |  2 ++
>  9 files changed, 32 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc-k3.c b/drivers/mmc/host/dw_mmc-k3.c
> index 23b6f65b3785..695e29452367 100644
> --- a/drivers/mmc/host/dw_mmc-k3.c
> +++ b/drivers/mmc/host/dw_mmc-k3.c
> @@ -424,6 +424,8 @@ static int dw_mci_hi3660_switch_voltage(struct mmc_host *mmc,
>
>         if (!IS_ERR(mmc->supply.vqmmc)) {
>                 ret = mmc_regulator_set_vqmmc(mmc, ios);
> +               if (ret > 0)
> +                       ret = 0;
>                 if (ret) {
>                         dev_err(host->dev, "Regulator set error %d\n", ret);
>                         return ret;
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index bc5278ab5707..3f82170f1d98 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1546,6 +1546,8 @@ static int dw_mci_switch_voltage(struct mmc_host *mmc, struct mmc_ios *ios)
>
>         if (!IS_ERR(mmc->supply.vqmmc)) {
>                 ret = mmc_regulator_set_vqmmc(mmc, ios);
> +               if (ret > 0)
> +                       ret = 0;
>
>                 if (ret) {
>                         dev_dbg(&mmc->class_dev,
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index 35400cf2a2e4..79e15fa6f4fd 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -1004,6 +1004,8 @@ static int meson_mmc_card_busy(struct mmc_host *mmc)
>
>  static int meson_mmc_voltage_switch(struct mmc_host *mmc, struct mmc_ios *ios)
>  {
> +       int ret;
> +
>         /* vqmmc regulator is available */
>         if (!IS_ERR(mmc->supply.vqmmc)) {
>                 /*
> @@ -1013,7 +1015,10 @@ static int meson_mmc_voltage_switch(struct mmc_host *mmc, struct mmc_ios *ios)
>                  * to 1.8v. Please make sure the regulator framework is aware
>                  * of your own regulator constraints
>                  */
> -               return mmc_regulator_set_vqmmc(mmc, ios);
> +               ret = mmc_regulator_set_vqmmc(mmc, ios);
> +               if (ret > 0)
> +                       ret = 0;
> +               return ret;
>         }
>
>         /* no vqmmc regulator, assume fixed regulator at 3/3.3V */
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index b221c02cc71f..9688797f097d 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -1379,6 +1379,8 @@ static int msdc_ops_switch_volt(struct mmc_host *mmc, struct mmc_ios *ios)
>                 }
>
>                 ret = mmc_regulator_set_vqmmc(mmc, ios);
> +               if (ret > 0)
> +                       ret = 0;
>                 if (ret) {
>                         dev_dbg(host->dev, "Regulator set error %d (%d)\n",
>                                 ret, ios->signal_voltage);
> diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
> index 68432bb0255b..7ffe17bb1e62 100644
> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -237,6 +237,8 @@ static int renesas_sdhi_start_signal_voltage_switch(struct mmc_host *mmc,
>                         MMC_SIGNAL_VOLTAGE_330 ? 0 : -EINVAL;
>
>         ret = mmc_regulator_set_vqmmc(host->mmc, ios);
> +       if (ret > 0)
> +               ret = 0;
>         if (ret)
>                 return ret;
>
> diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> index 60c3a4c620f9..2a27af3eceef 100644
> --- a/drivers/mmc/host/sdhci-sprd.c
> +++ b/drivers/mmc/host/sdhci-sprd.c
> @@ -434,6 +434,8 @@ static int sdhci_sprd_voltage_switch(struct mmc_host *mmc, struct mmc_ios *ios)
>
>         if (!IS_ERR(mmc->supply.vqmmc)) {
>                 ret = mmc_regulator_set_vqmmc(mmc, ios);
> +               if (ret > 0)
> +                       ret = 0;
>                 if (ret) {
>                         pr_err("%s: Switching signalling voltage failed\n",
>                                mmc_hostname(mmc));
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 344a7e0e33fe..a100fb633b40 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2411,6 +2411,8 @@ int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
>
>                 if (!IS_ERR(mmc->supply.vqmmc)) {
>                         ret = mmc_regulator_set_vqmmc(mmc, ios);
> +                       if (ret > 0)
> +                               ret = 0;
>                         if (ret) {
>                                 pr_warn("%s: Switching to 3.3V signalling voltage failed\n",
>                                         mmc_hostname(mmc));
> @@ -2434,6 +2436,8 @@ int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
>                         return -EINVAL;
>                 if (!IS_ERR(mmc->supply.vqmmc)) {
>                         ret = mmc_regulator_set_vqmmc(mmc, ios);
> +                       if (ret > 0)
> +                               ret = 0;
>                         if (ret) {
>                                 pr_warn("%s: Switching to 1.8V signalling voltage failed\n",
>                                         mmc_hostname(mmc));
> @@ -2466,6 +2470,8 @@ int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
>                         return -EINVAL;
>                 if (!IS_ERR(mmc->supply.vqmmc)) {
>                         ret = mmc_regulator_set_vqmmc(mmc, ios);
> +                       if (ret > 0)
> +                               ret = 0;
>                         if (ret) {
>                                 pr_warn("%s: Switching to 1.2V signalling voltage failed\n",
>                                         mmc_hostname(mmc));
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index f87d7967457f..f70a4249b72b 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -951,9 +951,15 @@ static void sunxi_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>
>  static int sunxi_mmc_volt_switch(struct mmc_host *mmc, struct mmc_ios *ios)
>  {
> +       int ret;
> +
>         /* vqmmc regulator is available */
> -       if (!IS_ERR(mmc->supply.vqmmc))
> -               return mmc_regulator_set_vqmmc(mmc, ios);
> +       if (!IS_ERR(mmc->supply.vqmmc)) {
> +               ret = mmc_regulator_set_vqmmc(mmc, ios);
> +               if (ret > 0)
> +                       ret = 0;
> +               return ret;
> +       }
>
>         /* no vqmmc regulator, assume fixed regulator at 3/3.3V */
>         if (mmc->ios.signal_voltage == MMC_SIGNAL_VOLTAGE_330)
> diff --git a/drivers/mmc/host/usdhi6rol0.c b/drivers/mmc/host/usdhi6rol0.c
> index 9a0b1e4e405d..72e698071ddf 100644
> --- a/drivers/mmc/host/usdhi6rol0.c
> +++ b/drivers/mmc/host/usdhi6rol0.c
> @@ -1174,6 +1174,8 @@ static int usdhi6_sig_volt_switch(struct mmc_host *mmc, struct mmc_ios *ios)
>         int ret;
>
>         ret = mmc_regulator_set_vqmmc(mmc, ios);
> +       if (ret > 0)
> +               ret = 0;
>         if (ret < 0)
>                 return ret;
>
> --
> 2.25.1
>
