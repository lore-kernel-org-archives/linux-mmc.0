Return-Path: <SRS0=DxaD=D4=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF344C55178
	for <linux-mmc@archiver.kernel.org>; Wed, 21 Oct 2020 14:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90D5121481
	for <linux-mmc@archiver.kernel.org>; Wed, 21 Oct 2020 14:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N8Eu7Nwh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440331AbgJUOAd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 21 Oct 2020 10:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440277AbgJUOAd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Oct 2020 10:00:33 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E28C0613CE
        for <linux-mmc@vger.kernel.org>; Wed, 21 Oct 2020 07:00:31 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id x26so685103uau.0
        for <linux-mmc@vger.kernel.org>; Wed, 21 Oct 2020 07:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DbFKB/LnXIc5ByyvItMxrnJsOup4anUlSfkgQwTGBWk=;
        b=N8Eu7NwhEUHjdZpFGDGkih1b12ni3owWD1PW6IfeMlDRUDiGpoNn2jak/RGBXJk8kF
         RT3NjvseX+rNSax+D337BqkaCgz2TcrXdHdhJxbn7zSa+zyEOWmK8+NXC/p8t3h1IX1N
         I1eQmmKKdy3ZBHltBDGZ/b2JgaJ8BOJeEWJ6/My+IdR2VHD21rfo2VL+eA4m0Zrb7n4o
         ylhS8Y9SwgZBA37espbSwnv8TUtzb4RSr7VAOxj9+cFAnpx0RiGqJvht5ntHmW/4nQ5i
         FIKmmd4EKckuzP4ThR40T2BYADmOWy3VX7KfcJ3WsolzG4SDE0keYNFskgvmpjAfeL3T
         dzgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DbFKB/LnXIc5ByyvItMxrnJsOup4anUlSfkgQwTGBWk=;
        b=G7V6FMWvCA6s9OMdkEhgYikeCQQapeVJAOBpYhEx+kEKa0rVdwJJT3/ZDDwQ5doBVs
         +F4XmvjE+lLBaEintWXTOQvsZH8O/en7zrF1AaG0nahvy6Zc15ej/BeCcglPGRnJduWt
         Zjfg7rW1TNZBtYtIyIoKGhDLvASzROZ7LyWnQeZMHnCBqd5PtFmesZOsTNZ3M3VqQgrr
         mPuLDc70+ThQzQJ9QzNXaUPwoT6mpkDRsc4khhYMprk7uR5wl7waadRfDptj8XzN399l
         3sZBF1KVXdjeHhk8POZUAijYlaGEAmTqTrKodm7Z6wcsOxrwl9vQ2rG91dL/3eFCrbkV
         /pbw==
X-Gm-Message-State: AOAM532y2o3EyxRStAmriF9nLBLCSxBKScB+tLV7djKl8n0sD7la5MUl
        EQtyREmJbSTImQcuGPM1zd/jjuJICAJ6r3Mh7x8dtQ==
X-Google-Smtp-Source: ABdhPJzuh20Q+swAqLTGoDnQcnMn28mov845EEq2fD2gR+cu42KByTHk+Arp0oagDVH2YqQm62lkgFQGgxX3uMqNWGE=
X-Received: by 2002:a9f:31ce:: with SMTP id w14mr1926440uad.104.1603288829963;
 Wed, 21 Oct 2020 07:00:29 -0700 (PDT)
MIME-Version: 1.0
References: <1600999061-13669-1-git-send-email-rui_feng@realsil.com.cn>
In-Reply-To: <1600999061-13669-1-git-send-email-rui_feng@realsil.com.cn>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 21 Oct 2020 15:59:53 +0200
Message-ID: <CAPDyKFrnkF3mU5PJsy0VtEjPSToktSsRRtyMvQF97vymc+rY5A@mail.gmail.com>
Subject: Re: [PATCH 3/3] mmc: rtsx: Add SD Express mode support for RTS5261
To:     Rui Feng <rui_feng@realsil.com.cn>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 25 Sep 2020 at 03:57, <rui_feng@realsil.com.cn> wrote:
>
> From: Rui Feng <rui_feng@realsil.com.cn>
>
> RTS5261 support legacy SD mode and SD Express mode.
> In SD7.x, SD association introduce SD Express as a new mode.
> This patch makes RTS5261 support SD Express mode.

As per patch 2, can you please add some more information about what
changes are needed to support SD Express? This just states that the
support is implemented, but please elaborate how.

>
> Signed-off-by: Rui Feng <rui_feng@realsil.com.cn>
> ---
>  drivers/mmc/host/rtsx_pci_sdmmc.c | 59 +++++++++++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
>
> diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
> index 2763a376b054..efde374a4a5e 100644
> --- a/drivers/mmc/host/rtsx_pci_sdmmc.c
> +++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
> @@ -895,7 +895,9 @@ static int sd_set_bus_width(struct realtek_pci_sdmmc *host,
>  static int sd_power_on(struct realtek_pci_sdmmc *host)
>  {
>         struct rtsx_pcr *pcr = host->pcr;
> +       struct mmc_host *mmc = host->mmc;
>         int err;
> +       u32 val;
>
>         if (host->power_state == SDMMC_POWER_ON)
>                 return 0;
> @@ -922,6 +924,14 @@ static int sd_power_on(struct realtek_pci_sdmmc *host)
>         if (err < 0)
>                 return err;
>
> +       if (PCI_PID(pcr) == PID_5261) {
> +               val = rtsx_pci_readl(pcr, RTSX_BIPR);
> +               if (val & SD_WRITE_PROTECT) {
> +                       pcr->extra_caps &= ~EXTRA_CAPS_SD_EXPRESS;
> +                       mmc->caps2 &= ~(MMC_CAP2_SD_EXP | MMC_CAP2_SD_EXP_1_2V);

This looks a bit weird to me. For a write protected card you want to
disable the SD_EXPRESS support, right?

Is there no mechanism to support read-only PCIe/NVMe based storage
devices? If that is the case, maybe it's simply better to not support
the readonly option at all for SD express cards?

> +               }
> +       }
> +
>         host->power_state = SDMMC_POWER_ON;
>         return 0;
>  }
> @@ -1127,6 +1137,8 @@ static int sdmmc_get_cd(struct mmc_host *mmc)
>         if (val & SD_EXIST)
>                 cd = 1;
>
> +       if (pcr->extra_caps & EXTRA_CAPS_SD_EXPRESS)
> +               mmc->caps2 |= MMC_CAP2_SD_EXP | MMC_CAP2_SD_EXP_1_2V;

This looks wrong. You shouldn't be using the ->get_cd() callback to
re-enable mmc caps.

Normally set the mmc caps while host probes (from the ->probe()
callback), but I guess this is kind of a special case, as the
read-only switch state isn't known until we have powered on the card,
right?

If that is the case, I suggest to re-enable the mmc caps from the
->set_ios() callback instead, when ios->power_mode == MMC_POWER_OFF.

>         mutex_unlock(&pcr->pcr_mutex);
>
>         return cd;
> @@ -1308,6 +1320,50 @@ static int sdmmc_execute_tuning(struct mmc_host *mmc, u32 opcode)
>         return err;
>  }
>
> +static int sdmmc_init_sd_express(struct mmc_host *mmc, struct mmc_ios *ios)
> +{
> +       u32 relink_time, val;
> +       struct realtek_pci_sdmmc *host = mmc_priv(mmc);
> +       struct rtsx_pcr *pcr = host->pcr;
> +
> +       /*
> +        * If card has PCIe availability and WP if off,
> +        * reader switch to PCIe mode.
> +        */
> +       val = rtsx_pci_readl(pcr, RTSX_BIPR);
> +       if (!(val & SD_WRITE_PROTECT)) {

This should not be needed, as you have already checked the write
protect bit before enabling the mmc caps for SD EXPRESS, right?

> +               /* Set relink_time for changing to PCIe card */
> +               relink_time = 0x8FFF;
> +
> +               rtsx_pci_write_register(pcr, 0xFF01, 0xFF, relink_time);
> +               rtsx_pci_write_register(pcr, 0xFF02, 0xFF, relink_time >> 8);
> +               rtsx_pci_write_register(pcr, 0xFF03, 0x01, relink_time >> 16);
> +
> +               rtsx_pci_write_register(pcr, PETXCFG, 0x80, 0x80);
> +               rtsx_pci_write_register(pcr, LDO_VCC_CFG0,
> +                       RTS5261_LDO1_OCP_THD_MASK,
> +                       pcr->option.sd_800mA_ocp_thd);
> +
> +               if (pcr->ops->disable_auto_blink)
> +                       pcr->ops->disable_auto_blink(pcr);
> +
> +               /* For PCIe/NVMe mode can't enter delink issue */
> +               pcr->hw_param.interrupt_en &= ~(SD_INT_EN);
> +               rtsx_pci_writel(pcr, RTSX_BIER, pcr->hw_param.interrupt_en);
> +
> +               rtsx_pci_write_register(pcr, RTS5260_AUTOLOAD_CFG4,
> +                       RTS5261_AUX_CLK_16M_EN, RTS5261_AUX_CLK_16M_EN);
> +               rtsx_pci_write_register(pcr, RTS5261_FW_CFG0,
> +                       RTS5261_FW_ENTER_EXPRESS, RTS5261_FW_ENTER_EXPRESS);
> +               rtsx_pci_write_register(pcr, RTS5261_FW_CFG1,
> +                       RTS5261_MCU_BUS_SEL_MASK | RTS5261_MCU_CLOCK_SEL_MASK
> +                       | RTS5261_MCU_CLOCK_GATING | RTS5261_DRIVER_ENABLE_FW,
> +                       RTS5261_MCU_CLOCK_SEL_16M | RTS5261_MCU_CLOCK_GATING
> +                       | RTS5261_DRIVER_ENABLE_FW);
> +       }
> +       return 0;
> +}
> +
>  static const struct mmc_host_ops realtek_pci_sdmmc_ops = {
>         .pre_req = sdmmc_pre_req,
>         .post_req = sdmmc_post_req,
> @@ -1317,6 +1373,7 @@ static const struct mmc_host_ops realtek_pci_sdmmc_ops = {
>         .get_cd = sdmmc_get_cd,
>         .start_signal_voltage_switch = sdmmc_switch_voltage,
>         .execute_tuning = sdmmc_execute_tuning,
> +       .init_sd_express = sdmmc_init_sd_express,
>  };
>
>  static void init_extra_caps(struct realtek_pci_sdmmc *host)
> @@ -1338,6 +1395,8 @@ static void init_extra_caps(struct realtek_pci_sdmmc *host)
>                 mmc->caps |= MMC_CAP_8_BIT_DATA;
>         if (pcr->extra_caps & EXTRA_CAPS_NO_MMC)
>                 mmc->caps2 |= MMC_CAP2_NO_MMC;
> +       if (pcr->extra_caps & EXTRA_CAPS_SD_EXPRESS)
> +               mmc->caps2 |= MMC_CAP2_SD_EXP | MMC_CAP2_SD_EXP_1_2V;
>  }
>
>  static void realtek_init_host(struct realtek_pci_sdmmc *host)
> --
> 2.17.1
>

A follow up question:

Based upon your feedback from our earlier discussions, I believe you
stated that the card reader driver (rtsx_pci_driver) will unregister
the corresponding mfd/platform device that corresponds to the
rtsx_pci_sdmmc_driver - when it gets configured to manage a PCIe/NVMe
based storage device. Correct?

Perhaps I didn't get that part correctly, but if this is the case, it
means that the ->remove() callback (rtsx_pci_sdmmc_drv_remove()) will
be invoked. Furthermore, this will cause the ->set_ios() callback to
be invoked when the core calls mmc_power_off() in that path. Isn't
that a problem that you need to address?

Kind regards
Uffe
