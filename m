Return-Path: <SRS0=0Sxg=EK=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7940C2D0A3
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Nov 2020 12:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52661221F8
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Nov 2020 12:38:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vHCesrKk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729918AbgKDMim (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 4 Nov 2020 07:38:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729929AbgKDMig (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Nov 2020 07:38:36 -0500
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331F5C061A4A
        for <linux-mmc@vger.kernel.org>; Wed,  4 Nov 2020 04:38:35 -0800 (PST)
Received: by mail-vs1-xe41.google.com with SMTP id y78so11374213vsy.6
        for <linux-mmc@vger.kernel.org>; Wed, 04 Nov 2020 04:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/S4zGDHNvBcp/JjgO0AP61FUw/3vZ8bf/zKjIqYowfM=;
        b=vHCesrKkyHuFBvBeiM0yHWA+EJXvJsNfwNNvS2zTDIQrNEwlw3Ae/ItTrhNJzVlLHY
         BjM0AIP3d1wusAoesybRXeCqwWh6Vso6Tm44LiCcMH6wOahcJ+XULMwFSkRQNm3x79Lz
         rCirFMmYpKQACmIkW3C8JZiuF2dnGEfr1vTZmimO6cxceADjfzqC1jWdPJG/nTu2Lox+
         SPkCLevAADmcss77zcfJf0dXzUePyRP+ECqj/2c2vIiGAXmMQ1plnEk4s7xzEp3zy4Es
         3QnxVlGMAWLL5d+CHHwmi6TdrqLsOYqY3M4u6QyR4ZoZaxIoAB4uh8qBnfXOV9FY3EmB
         mstQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/S4zGDHNvBcp/JjgO0AP61FUw/3vZ8bf/zKjIqYowfM=;
        b=Gg39XSWYy8HvcksVfIjI4fsKioTK8iJhYNNoEBILiNF884Iz5ZDKx/cpEK/dn6voET
         0WpPfvbRWY64FmJ+4LXnSzw2Dwzoff9QbO+Nz4ZFZy33xIXDHRObUtatB+OxgQySKhNF
         3kakJuuGyBrqcLEmMLPnwiyADhodaR3rs3VzWvYfJRkoV2MNUvIgB6DfCdWg6DwfIYxJ
         tafoqh4XyVpBXQ2xlGcFaDchJSq56uxlcuQhZNI4n9/Jl088mNxb6oPPRvCg14JB/+Ws
         08khaOSURHSpGQ2ewWO+ifB0Zga6gcTFEBQV/0o0Cw2XnnA1dUSSrbo1XvCskLuJI97J
         E9DA==
X-Gm-Message-State: AOAM5335jCVvGwLiFgS/u00K1TJ1jeMHBdcGQ7LUO5treOM2pxFz8Zqg
        jrH6xRquSW7yFRgGLIMaoekhB32YwVTAC0ww0Rtdq1gz/2Q=
X-Google-Smtp-Source: ABdhPJyS91N6lay7O8vyXFPFYene+RcpLftepL+AuA9BOvUrx7p4sCRuRAMeGzx8x/tYj2lN+4O+72NEujp+Eh0v6VU=
X-Received: by 2002:a67:ec9a:: with SMTP id h26mr21851524vsp.34.1604493514271;
 Wed, 04 Nov 2020 04:38:34 -0800 (PST)
MIME-Version: 1.0
References: <1604397269-2780-1-git-send-email-rui_feng@realsil.com.cn>
In-Reply-To: <1604397269-2780-1-git-send-email-rui_feng@realsil.com.cn>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 4 Nov 2020 13:37:57 +0100
Message-ID: <CAPDyKFru7TbT-rFMr+BsaqcahOo1K2Lk_DFtLOpSy-QuEVpmFg@mail.gmail.com>
Subject: Re: [PATCH 1/8] mmc: rtsx: Add test mode for RTS5261
To:     Rui Feng <rui_feng@realsil.com.cn>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
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

Greg,

It seems this series is best funneld via my mmc tree, due to
dependency to recent changes I have queued.

I am fine to pick this as well, but awaiting an ack from you before I go ahead.

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
