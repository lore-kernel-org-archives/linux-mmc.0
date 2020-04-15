Return-Path: <SRS0=Q6+y=57=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58257C2BA19
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Apr 2020 08:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D16E20656
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Apr 2020 08:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TGriCENO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894719AbgDOIlM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 15 Apr 2020 04:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2894777AbgDOIlI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Apr 2020 04:41:08 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A69C061A0C
        for <linux-mmc@vger.kernel.org>; Wed, 15 Apr 2020 01:41:07 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id 21so1035500uae.4
        for <linux-mmc@vger.kernel.org>; Wed, 15 Apr 2020 01:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G2k8McS/K5NefTNba5xsVsO/fUtMzpQPzb5n8a6auMs=;
        b=TGriCENOdLxLP77jm7Tb8Oa/5P93+8TDkF3Qd46iveBgLU6Nga83FMgYT9ME+mC5x9
         lU0PK3AO550ADRm4eh6Q5LHgaMRgqa5SAC4T+alOhC88n/M5T5QK4Rp+i4q9plVm+XnO
         0tTfRspCoFo5GG0eEszFEez168zIm0cZdFM4K6XJRPSmB0G08+599039AlRNwJ7E0eMf
         iHg/SRa5UnDVph5xioqQTLMjgsvIXPucWU8nNAn82N7Pxfzi43DkqkS7uZFGXKLH/jhp
         QGKgusZOcJerGc31W+hh49QxUQDDAv3FqqcazcJr+q7OgJBgUESTPih2hNFTJegku/Wu
         8DOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G2k8McS/K5NefTNba5xsVsO/fUtMzpQPzb5n8a6auMs=;
        b=PSh3JbXS5Qn3pRmymbZPy4Gkv16fvagreokj8jdGXbFtIrcPRFsUgUzgBYC20ykmqt
         k0hIqONBrEn1VRRUBGSKCpmrh6HDjFmJGTjp4quK3a/pHkFVmsTdwBdga376oFlfbeCp
         9gUg0TklinY7/HJGzCxnWEt+HeOO/nBW2KEaTJwEvZXMqZi46iKelyDRxV19SQd1phaa
         rHq3oubV925TWrnXAURYAgZfK/LVEGJfGaX5L/MLZpsIINd15+dqz4rOep0T1A0sUjto
         hqpP/nZq3T/wyA6dMNPzzFo5iHfGm8ix9fo/MGK3yQBv8ol+DB/8y63e79O5s4aJUrkm
         zhbA==
X-Gm-Message-State: AGi0PuZjeB1gI030HlOgqhIimzuxP0a297A/zo8U1GXvul3hqyTO5Rit
        PsqogWgTizm/qmSJjNxVRbkS+nMb7meCjOiNEh3gRA==
X-Google-Smtp-Source: APiQypInceMAHxuFWj5L8A7rNn9xiU0htqIhPLdEK0hmWs+SiG0rjpK4lzRvRh91FpVELvUuGl4DSB9mPofIb7/yCK0=
X-Received: by 2002:ab0:2ea:: with SMTP id 97mr3644293uah.129.1586940065768;
 Wed, 15 Apr 2020 01:41:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200401195722.208157-1-marex@denx.de>
In-Reply-To: <20200401195722.208157-1-marex@denx.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 15 Apr 2020 10:40:30 +0200
Message-ID: <CAPDyKFoDB=d5B-2u_Y0e-XVzPQE46JBUTPwY_b_xzESm3NnjwQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] mmc: Prepare all code for mmc_set_signal_voltage()
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

On Wed, 1 Apr 2020 at 21:57, Marek Vasut <marex@denx.de> wrote:
>
> Patch all drivers and core code which uses mmc_set_signal_voltage()
> and prepare it for the fact that mmc_set_signal_voltage() can return
> a value > 0, which would happen if the signal voltage switch did NOT
> happen, because the voltage was already set correctly.

I am not sure why you want to change mmc_set_signal_voltage(), can you
elaborate on that?

I thought we discussed changing mmc_regulator_set_vqmmc(), what am I missing?

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
> ---
>  drivers/mmc/core/core.c              | 10 +++++-----
>  drivers/mmc/core/mmc.c               | 16 ++++++++--------
>  drivers/mmc/host/dw_mmc-k3.c         |  2 +-
>  drivers/mmc/host/dw_mmc.c            |  3 +--
>  drivers/mmc/host/mtk-sd.c            |  2 +-
>  drivers/mmc/host/renesas_sdhi_core.c |  2 +-
>  drivers/mmc/host/sdhci-sprd.c        |  2 +-
>  drivers/mmc/host/sdhci.c             |  6 +++---
>  8 files changed, 21 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 4c5de6d37ac7..98a3552205cb 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1142,7 +1142,7 @@ int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage)
>         if (host->ops->start_signal_voltage_switch)
>                 err = host->ops->start_signal_voltage_switch(host, &host->ios);
>
> -       if (err)
> +       if (err < 0)
>                 host->ios.signal_voltage = old_signal_voltage;
>
>         return err;
> @@ -1152,11 +1152,11 @@ int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage)
>  void mmc_set_initial_signal_voltage(struct mmc_host *host)
>  {
>         /* Try to set signal voltage to 3.3V but fall back to 1.8v or 1.2v */
> -       if (!mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_330))
> +       if (mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_330) >= 0)
>                 dev_dbg(mmc_dev(host), "Initial signal voltage of 3.3v\n");
> -       else if (!mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180))
> +       else if (mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180) >= 0)
>                 dev_dbg(mmc_dev(host), "Initial signal voltage of 1.8v\n");
> -       else if (!mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_120))
> +       else if (mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_120) >= 0)
>                 dev_dbg(mmc_dev(host), "Initial signal voltage of 1.2v\n");
>  }
>
> @@ -1172,7 +1172,7 @@ int mmc_host_set_uhs_voltage(struct mmc_host *host)
>         host->ios.clock = 0;
>         mmc_set_ios(host);
>
> -       if (mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180))
> +       if (mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180) < 0)
>                 return -EAGAIN;
>
>         /* Keep clock gated for at least 10 ms, though spec only says 5 ms */
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index de94fbe629bd..9f5aae051f6d 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1121,7 +1121,7 @@ static int mmc_select_hs_ddr(struct mmc_card *card)
>          */
>         if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_DDR_1_2V) {
>                 err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_120);
> -               if (!err)
> +               if (err >= 0)
>                         return 0;
>         }
>
> @@ -1130,7 +1130,7 @@ static int mmc_select_hs_ddr(struct mmc_card *card)
>                 err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180);
>
>         /* make sure vccq is 3.3v after switching disaster */
> -       if (err)
> +       if (err < 0)
>                 err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_330);
>
>         return err;
> @@ -1339,11 +1339,11 @@ static int mmc_select_hs400es(struct mmc_card *card)
>         if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS400_1_2V)
>                 err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_120);
>
> -       if (err && card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS400_1_8V)
> +       if (err < 0 && card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS400_1_8V)
>                 err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180);
>
>         /* If fails try again during next card power cycle */
> -       if (err)
> +       if (err < 0)
>                 goto out_err;
>
>         err = mmc_select_bus_width(card);
> @@ -1437,11 +1437,11 @@ static int mmc_select_hs200(struct mmc_card *card)
>         if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS200_1_2V)
>                 err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_120);
>
> -       if (err && card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS200_1_8V)
> +       if (err < 0 && card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS200_1_8V)
>                 err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180);
>
>         /* If fails try again during next card power cycle */
> -       if (err)
> +       if (err < 0)
>                 return err;
>
>         mmc_select_driver_type(card);
> @@ -1480,7 +1480,7 @@ static int mmc_select_hs200(struct mmc_card *card)
>  err:
>         if (err) {
>                 /* fall back to the old signal voltage, if fails report error */
> -               if (mmc_set_signal_voltage(host, old_signal_voltage))
> +               if (mmc_set_signal_voltage(host, old_signal_voltage) < 0)
>                         err = -EIO;
>
>                 pr_err("%s: %s failed, error %d\n", mmc_hostname(card->host),
> @@ -1769,7 +1769,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>                 err = mmc_select_bus_width(card);
>                 if (err > 0 && mmc_card_hs(card)) {
>                         err = mmc_select_hs_ddr(card);
> -                       if (err)
> +                       if (err < 0)
>                                 goto free_card;
>                 }
>         }
> diff --git a/drivers/mmc/host/dw_mmc-k3.c b/drivers/mmc/host/dw_mmc-k3.c
> index 23b6f65b3785..50977ff18074 100644
> --- a/drivers/mmc/host/dw_mmc-k3.c
> +++ b/drivers/mmc/host/dw_mmc-k3.c
> @@ -424,7 +424,7 @@ static int dw_mci_hi3660_switch_voltage(struct mmc_host *mmc,
>
>         if (!IS_ERR(mmc->supply.vqmmc)) {
>                 ret = mmc_regulator_set_vqmmc(mmc, ios);
> -               if (ret) {
> +               if (ret < 0) {

This change makes sense to me, however it's also a bit confusing, as
the changelog refers to changes for mmc_set_signal_voltage().

As I understand it, we want mmc_regulator_set_vqmmc() to return 1, in
case the current voltage level is the same as the requested "new"
target".

>                         dev_err(host->dev, "Regulator set error %d\n", ret);
>                         return ret;
>                 }

[...]

So, to conclude, it seems like $subject patch needs to be reworked a
bit - just keep the changes you have made to the host drivers, then
throw away the other parts in core.

Kind regards
Uffe
