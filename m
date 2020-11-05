Return-Path: <SRS0=4qKy=EL=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A8EDC388F9
	for <linux-mmc@archiver.kernel.org>; Thu,  5 Nov 2020 13:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7F2F22228
	for <linux-mmc@archiver.kernel.org>; Thu,  5 Nov 2020 13:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nf6wpifI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731124AbgKENAC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 5 Nov 2020 08:00:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731085AbgKEM75 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Nov 2020 07:59:57 -0500
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A6FC0613D2
        for <linux-mmc@vger.kernel.org>; Thu,  5 Nov 2020 04:59:56 -0800 (PST)
Received: by mail-vs1-xe43.google.com with SMTP id u7so695637vsq.11
        for <linux-mmc@vger.kernel.org>; Thu, 05 Nov 2020 04:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G6PP6WiZhXC9WViPxlbziqm6I6Gyzrz5WTViUQZxV/M=;
        b=Nf6wpifIEeaAnkDmCBDNfmLONk65c37blngt2b2UHWA9r4vtV/7l+uofhkJfdGVUwQ
         pl1U4b9cTm/kile0e80PnSGAc9+POy4Ql8pvsrHmULVb7YHOD646yWkZQdftyIM7oAXM
         p+yw1i391J/KWaLwu/LzlOplcNH9l0T+yx0+BLPq9AHQiUUKNzzqiHF+lKxKgtZhdch5
         EBwUOo4WSr6HcfhVW+xLTd97e4q8w1Q8FOYD1tJas2YIfmPy2M3pP2CD66Z7VzTLYtpP
         gCTvUHNcscILqy9+auVJiRnnbY4IDmxe1X3u8M5x4PS00sIS95M7arLTMlNfFkDzqc7W
         Hcaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G6PP6WiZhXC9WViPxlbziqm6I6Gyzrz5WTViUQZxV/M=;
        b=ZE041hmOlFUxJst5KvYJm3n3FevtBRu7qnuG7x0Ow0v5Rh8tq7jEFZmemtak2PNgMf
         6HYkiKEH+OqFmcslDe3qsBttr/Tzo1FUIbk4Pdn9P2WsMU6mHmLQPjr8SxhpRElh2noH
         KJvHQkYQKVgXjr9ACMow1ybmPPVMnrlJ0RvKGMcoTiTuBNGlPEHz/lQ6HEToeLZDAx82
         gSf/KntvXRJQGQHP9IkhuwZCsKKmlarU2+JSq6S966ds3rFmZls6bskTKh12GlLFJ67C
         OqxN9houw6x7RALQP9b1jPx+zC7b3szKQx4NPan4lbVs0i7xoD9ySUaMBjIFGQyBCyPm
         H0hA==
X-Gm-Message-State: AOAM533XBKSIeguY9s0KdaRTCcRV13DdfbMRTHIa9aFqikY7WO6KEirC
        XM6/69O0umyyXKvH+b+BXrLabcg07D0VRrsgQyySKHfLSro=
X-Google-Smtp-Source: ABdhPJyoNiM/ag+LidwccpVnOIb07kGVjO1/kpG8K++Dkey70N0aK3bODr2qSZZ2AqMAhkLvQw82DMn4uur4yVyXpAc=
X-Received: by 2002:a67:f417:: with SMTP id p23mr989475vsn.42.1604581195545;
 Thu, 05 Nov 2020 04:59:55 -0800 (PST)
MIME-Version: 1.0
References: <1604397269-2780-1-git-send-email-rui_feng@realsil.com.cn>
In-Reply-To: <1604397269-2780-1-git-send-email-rui_feng@realsil.com.cn>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 5 Nov 2020 13:59:18 +0100
Message-ID: <CAPDyKFqQeWGBXJBdyCVXOtfPWC6g4ZTG5yqsyRPkrWBf5ZQX5Q@mail.gmail.com>
Subject: Re: [PATCH 1/8] mmc: rtsx: Add test mode for RTS5261
To:     Rui Feng <rui_feng@realsil.com.cn>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 3 Nov 2020 at 10:54, <rui_feng@realsil.com.cn> wrote:
>
> From: Rui Feng <rui_feng@realsil.com.cn>
>
> This patch add test mode for RTS5261.
> If test mode is set, reader will switch to SD Express mode
> mandatorily, and this mode is used by factory testing only.
>
> Signed-off-by: Rui Feng <rui_feng@realsil.com.cn>

The series applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/misc/cardreader/rts5261.h |  5 -----
>  drivers/mmc/host/rtsx_pci_sdmmc.c | 19 ++++++++++++++++---
>  include/linux/rtsx_pci.h          |  4 ++++
>  3 files changed, 20 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/misc/cardreader/rts5261.h b/drivers/misc/cardreader/rts5261.h
> index 8d80f0d5d5d6..80179353bc46 100644
> --- a/drivers/misc/cardreader/rts5261.h
> +++ b/drivers/misc/cardreader/rts5261.h
> @@ -60,11 +60,6 @@
>  /* DMACTL 0xFE2C */
>  #define RTS5261_DMA_PACK_SIZE_MASK     0xF0
>
> -/* FW config info register */
> -#define RTS5261_FW_CFG_INFO0           0xFF50
> -#define RTS5261_FW_EXPRESS_TEST_MASK   (0x01<<0)
> -#define RTS5261_FW_EA_MODE_MASK                (0x01<<5)
> -
>  /* FW status register */
>  #define RTS5261_FW_STATUS              0xFF56
>  #define RTS5261_EXPRESS_LINK_FAIL_MASK (0x01<<7)
> diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
> index c453ad403aa8..26be11a096cb 100644
> --- a/drivers/mmc/host/rtsx_pci_sdmmc.c
> +++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
> @@ -47,6 +47,8 @@ struct realtek_pci_sdmmc {
>         bool                    using_cookie;
>  };
>
> +static int sdmmc_init_sd_express(struct mmc_host *mmc, struct mmc_ios *ios);
> +
>  static inline struct device *sdmmc_dev(struct realtek_pci_sdmmc *host)
>  {
>         return &(host->pdev->dev);
> @@ -898,6 +900,7 @@ static int sd_power_on(struct realtek_pci_sdmmc *host)
>         struct mmc_host *mmc = host->mmc;
>         int err;
>         u32 val;
> +       u8 test_mode;
>
>         if (host->power_state == SDMMC_POWER_ON)
>                 return 0;
> @@ -925,6 +928,15 @@ static int sd_power_on(struct realtek_pci_sdmmc *host)
>                 return err;
>
>         if (PCI_PID(pcr) == PID_5261) {
> +               /*
> +                * If test mode is set switch to SD Express mandatorily,
> +                * this is only for factory testing.
> +                */
> +               rtsx_pci_read_register(pcr, RTS5261_FW_CFG_INFO0, &test_mode);
> +               if (test_mode & RTS5261_FW_EXPRESS_TEST_MASK) {
> +                       sdmmc_init_sd_express(mmc, NULL);
> +                       return 0;
> +               }
>                 if (pcr->extra_caps & EXTRA_CAPS_SD_EXPRESS)
>                         mmc->caps2 |= MMC_CAP2_SD_EXP | MMC_CAP2_SD_EXP_1_2V;
>                 /*
> @@ -1354,11 +1366,12 @@ static int sdmmc_init_sd_express(struct mmc_host *mmc, struct mmc_ios *ios)
>                 RTS5261_AUX_CLK_16M_EN, RTS5261_AUX_CLK_16M_EN);
>         rtsx_pci_write_register(pcr, RTS5261_FW_CFG0,
>                 RTS5261_FW_ENTER_EXPRESS, RTS5261_FW_ENTER_EXPRESS);
> +       rtsx_pci_write_register(pcr, RTS5261_FW_CFG1,
> +               RTS5261_MCU_CLOCK_GATING, RTS5261_MCU_CLOCK_GATING);
>         rtsx_pci_write_register(pcr, RTS5261_FW_CFG1,
>                 RTS5261_MCU_BUS_SEL_MASK | RTS5261_MCU_CLOCK_SEL_MASK
> -               | RTS5261_MCU_CLOCK_GATING | RTS5261_DRIVER_ENABLE_FW,
> -               RTS5261_MCU_CLOCK_SEL_16M | RTS5261_MCU_CLOCK_GATING
> -               | RTS5261_DRIVER_ENABLE_FW);
> +               | RTS5261_DRIVER_ENABLE_FW,
> +               RTS5261_MCU_CLOCK_SEL_16M | RTS5261_DRIVER_ENABLE_FW);
>         host->eject = true;
>         return 0;
>  }
> diff --git a/include/linux/rtsx_pci.h b/include/linux/rtsx_pci.h
> index b47959f48ccd..db249e8707f3 100644
> --- a/include/linux/rtsx_pci.h
> +++ b/include/linux/rtsx_pci.h
> @@ -658,6 +658,10 @@
>  #define   PM_WAKE_EN                   0x01
>  #define PM_CTRL4                       0xFF47
>
> +/* FW config info register */
> +#define RTS5261_FW_CFG_INFO0           0xFF50
> +#define   RTS5261_FW_EXPRESS_TEST_MASK (0x01 << 0)
> +#define   RTS5261_FW_EA_MODE_MASK      (0x01 << 5)
>  #define RTS5261_FW_CFG0                        0xFF54
>  #define   RTS5261_FW_ENTER_EXPRESS     (0x01 << 0)
>
> --
> 2.17.1
>
