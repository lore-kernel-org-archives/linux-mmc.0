Return-Path: <SRS0=qSan=CQ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59EF4C2BB84
	for <linux-mmc@archiver.kernel.org>; Mon,  7 Sep 2020 17:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17807208C7
	for <linux-mmc@archiver.kernel.org>; Mon,  7 Sep 2020 17:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wwLasW2b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729216AbgIGRt2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 7 Sep 2020 13:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729299AbgIGMSB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Sep 2020 08:18:01 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C47C061574
        for <linux-mmc@vger.kernel.org>; Mon,  7 Sep 2020 05:18:00 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id x142so3263983vke.0
        for <linux-mmc@vger.kernel.org>; Mon, 07 Sep 2020 05:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+l9vktXI4U4uuSrp4OVvdq7wfruoEhmAAsNBKcHjn1Y=;
        b=wwLasW2btmoYC0TFlQEKjMZOYLaLBHecFWUgLUiHNG1qYCf769Gd2usd9retfFzOPx
         RtXnFVsnDlGlVB3YKrTRsu93XO2Gb0JYHsIf380+B0/Hh5T3d1YO66Xoo48V9oqXjwWO
         qePsgLJ+aZP84Beu3LwN4PCnielOPkvwP6TY4LA27pYVzhcAS09h23t/RYlbq6OK5Tyt
         mqpQdgA3QB1A+dQTQdXuPz/oIbeCP8ef4tjSmYzfFAGp3a/fbciqy92ijJdCP9BNJU0p
         Q7otRg43ziqzKQx0cQE/XlcGI+ZXjJcKO8PS82gjojJvbQkyBfRbciySbqp600rP3Ru7
         /ySw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+l9vktXI4U4uuSrp4OVvdq7wfruoEhmAAsNBKcHjn1Y=;
        b=GUbQrdusIe+1Vi9KtQiJAu7jyLKeqi309Ilpwl9wV1DTnkVe5EMzrEifSxuny6TOcR
         XqQ5nHQlpvf7ObgaRxfcQIQZLbO4KyBiTWkm+CPmGZRDhqM3pQ9dFkFXsBnAiQNGeo8M
         uLH99IpaJ53lUKwuOV84PATXtP2PVE2/UgWDvaIqUi3f1JJ6Us2SvNz7BfTkvZIOns9Z
         OSS5z8ITiKshMXzGdbphEY4RU5/Y/IIPZR2B4pR5yyU5nIXvDftaBYcuoe2uDZdMbdEG
         uv2SZ/OiIocgJ44u65IrtwkOvav/2bA0CqrhwLsLmRdiBB99E2HSxQRYjiJRDfL2uaVD
         eUIw==
X-Gm-Message-State: AOAM531aF4efTPdsgd0McMxednPc7bvMwqtxjCkdf+Sm2PLUuziKvfxz
        cXLRdLmzigzdz5sTG354us79bOgQiJ47cl1VFKcvdA==
X-Google-Smtp-Source: ABdhPJxU62/1W0/nJK8t26GOQ/HOLcD8SDlE1oqG+58etM4Yd1VUv4hhcrbtXf+/0XXqVo/0lzjSgFBMVweHQRGZg1E=
X-Received: by 2002:a1f:e443:: with SMTP id b64mr11853616vkh.17.1599481079602;
 Mon, 07 Sep 2020 05:17:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200907105254.31097-1-krzk@kernel.org>
In-Reply-To: <20200907105254.31097-1-krzk@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 7 Sep 2020 14:17:23 +0200
Message-ID: <CAPDyKFr=88Z48hHwAFkDqk4Rg_sNrQ5bstnRzCXLSA-WiX-asA@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: host: Enable compile testing of multiple drivers
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 7 Sep 2020 at 12:53, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Multiple MMC host controller driver can be compile tested as they do not
> depend on architecture specific headers.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied for next, thanks!

>
> ---
>
> Changes since v2:
> 1. Rebase.
>
> Please expect conflicts around MMC_SDHCI_S3C with:
> https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git/log/?h=next/soc-s3c-cleanup

I see. Thanks for sharing. Looks like the fixup should be possible to
carry for Stephen in linux-next.

Kind regards
Uffe

>
> Possible resolution:
> -depends on PLAT_SAMSUNG || COMPILE_TEST
> +depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
> ---
>  drivers/mmc/host/Kconfig | 40 +++++++++++++++++++++-------------------
>  1 file changed, 21 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index ddbed6f41c41..dc646359b4ff 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -178,7 +178,7 @@ config MMC_SDHCI_OF_AT91
>  config MMC_SDHCI_OF_ESDHC
>         tristate "SDHCI OF support for the Freescale eSDHC controller"
>         depends on MMC_SDHCI_PLTFM
> -       depends on PPC || ARCH_MXC || ARCH_LAYERSCAPE
> +       depends on PPC || ARCH_MXC || ARCH_LAYERSCAPE || COMPILE_TEST
>         select MMC_SDHCI_IO_ACCESSORS
>         select FSL_GUTS
>         help
> @@ -216,7 +216,7 @@ config MMC_SDHCI_OF_DWCMSHC
>  config MMC_SDHCI_OF_SPARX5
>         tristate "SDHCI OF support for the MCHP Sparx5 SoC"
>         depends on MMC_SDHCI_PLTFM
> -       depends on ARCH_SPARX5
> +       depends on ARCH_SPARX5 || COMPILE_TEST
>         help
>           This selects the Secure Digital Host Controller Interface (SDHCI)
>           found in the MCHP Sparx5 SoC.
> @@ -238,7 +238,7 @@ config MMC_SDHCI_CADENCE
>
>  config MMC_SDHCI_CNS3XXX
>         tristate "SDHCI support on the Cavium Networks CNS3xxx SoC"
> -       depends on ARCH_CNS3XXX
> +       depends on ARCH_CNS3XXX || COMPILE_TEST
>         depends on MMC_SDHCI_PLTFM
>         help
>           This selects the SDHCI support for CNS3xxx System-on-Chip devices.
> @@ -262,7 +262,7 @@ config MMC_SDHCI_ESDHC_MCF
>
>  config MMC_SDHCI_ESDHC_IMX
>         tristate "SDHCI support for the Freescale eSDHC/uSDHC i.MX controller"
> -       depends on ARCH_MXC
> +       depends on ARCH_MXC || COMPILE_TEST
>         depends on MMC_SDHCI_PLTFM
>         select MMC_SDHCI_IO_ACCESSORS
>         select MMC_CQHCI
> @@ -276,7 +276,7 @@ config MMC_SDHCI_ESDHC_IMX
>
>  config MMC_SDHCI_DOVE
>         tristate "SDHCI support on Marvell's Dove SoC"
> -       depends on ARCH_DOVE || MACH_DOVE
> +       depends on ARCH_DOVE || MACH_DOVE || COMPILE_TEST
>         depends on MMC_SDHCI_PLTFM
>         select MMC_SDHCI_IO_ACCESSORS
>         help
> @@ -289,7 +289,7 @@ config MMC_SDHCI_DOVE
>
>  config MMC_SDHCI_TEGRA
>         tristate "SDHCI platform support for the Tegra SD/MMC Controller"
> -       depends on ARCH_TEGRA
> +       depends on ARCH_TEGRA || COMPILE_TEST
>         depends on MMC_SDHCI_PLTFM
>         select MMC_SDHCI_IO_ACCESSORS
>         select MMC_CQHCI
> @@ -301,7 +301,8 @@ config MMC_SDHCI_TEGRA
>
>  config MMC_SDHCI_S3C
>         tristate "SDHCI support on Samsung S3C SoC"
> -       depends on MMC_SDHCI && PLAT_SAMSUNG
> +       depends on MMC_SDHCI
> +       depends on PLAT_SAMSUNG || COMPILE_TEST
>         help
>           This selects the Secure Digital Host Controller Interface (SDHCI)
>           often referrered to as the HSMMC block in some of the Samsung S3C
> @@ -313,7 +314,7 @@ config MMC_SDHCI_S3C
>
>  config MMC_SDHCI_SIRF
>         tristate "SDHCI support on CSR SiRFprimaII and SiRFmarco SoCs"
> -       depends on ARCH_SIRF
> +       depends on ARCH_SIRF || COMPILE_TEST
>         depends on MMC_SDHCI_PLTFM
>         select MMC_SDHCI_IO_ACCESSORS
>         help
> @@ -351,7 +352,8 @@ config MMC_SDHCI_PXAV2
>
>  config MMC_SDHCI_SPEAR
>         tristate "SDHCI support on ST SPEAr platform"
> -       depends on MMC_SDHCI && PLAT_SPEAR
> +       depends on MMC_SDHCI
> +       depends on PLAT_SPEAR || COMPILE_TEST
>         depends on OF
>         help
>           This selects the Secure Digital Host Controller Interface (SDHCI)
> @@ -374,7 +376,7 @@ config MMC_SDHCI_S3C_DMA
>
>  config MMC_SDHCI_BCM_KONA
>         tristate "SDHCI support on Broadcom KONA platform"
> -       depends on ARCH_BCM_MOBILE
> +       depends on ARCH_BCM_MOBILE || COMPILE_TEST
>         depends on MMC_SDHCI_PLTFM
>         help
>           This selects the Broadcom Kona Secure Digital Host Controller
> @@ -422,7 +424,7 @@ config MMC_SDHCI_IPROC
>
>  config MMC_MESON_GX
>         tristate "Amlogic S905/GX*/AXG SD/MMC Host Controller support"
> -       depends on ARCH_MESON
> +       depends on ARCH_MESON|| COMPILE_TEST
>         help
>           This selects support for the Amlogic SD/MMC Host Controller
>           found on the S905/GX*/AXG family of SoCs.  This controller is
> @@ -458,7 +460,7 @@ config MMC_MESON_MX_SDIO
>
>  config MMC_MOXART
>         tristate "MOXART SD/MMC Host Controller support"
> -       depends on ARCH_MOXART
> +       depends on ARCH_MOXART || COMPILE_TEST
>         help
>           This selects support for the MOXART SD/MMC Host Controller.
>           MOXA provides one multi-functional card reader which can
> @@ -467,7 +469,7 @@ config MMC_MOXART
>
>  config MMC_SDHCI_ST
>         tristate "SDHCI support on STMicroelectronics SoC"
> -       depends on ARCH_STI || FSP2
> +       depends on ARCH_STI || FSP2 || COMPILE_TEST
>         depends on MMC_SDHCI_PLTFM
>         select MMC_SDHCI_IO_ACCESSORS
>         help
> @@ -587,7 +589,7 @@ config MMC_TIFM_SD
>
>  config MMC_MVSDIO
>         tristate "Marvell MMC/SD/SDIO host driver"
> -       depends on PLAT_ORION
> +       depends on PLAT_ORION || (COMPILE_TEST && ARM)
>         depends on OF
>         help
>           This selects the Marvell SDIO host driver.
> @@ -599,7 +601,7 @@ config MMC_MVSDIO
>
>  config MMC_DAVINCI
>         tristate "TI DAVINCI Multimedia Card Interface support"
> -       depends on ARCH_DAVINCI
> +       depends on ARCH_DAVINCI || COMPILE_TEST
>         help
>           This selects the TI DAVINCI Multimedia card Interface.
>           If you have an DAVINCI board with a Multimedia Card slot,
> @@ -628,7 +630,7 @@ config MMC_SPI
>
>  config MMC_S3C
>         tristate "Samsung S3C SD/MMC Card Interface support"
> -       depends on ARCH_S3C24XX
> +       depends on ARCH_S3C24XX || COMPILE_TEST
>         depends on S3C24XX_DMAC
>         help
>           This selects a driver for the MCI interface found in
> @@ -681,7 +683,7 @@ config MMC_SDRICOH_CS
>
>  config MMC_SDHCI_SPRD
>         tristate "Spreadtrum SDIO host Controller"
> -       depends on ARCH_SPRD
> +       depends on ARCH_SPRD || COMPILE_TEST
>         depends on MMC_SDHCI_PLTFM
>         select MMC_SDHCI_IO_ACCESSORS
>         select MMC_HSQ
> @@ -698,7 +700,7 @@ config MMC_TMIO_CORE
>
>  config MMC_TMIO
>         tristate "Toshiba Mobile IO Controller (TMIO) MMC/SD function support"
> -       depends on MFD_TMIO || MFD_ASIC3
> +       depends on MFD_TMIO || MFD_ASIC3 || COMPILE_TEST
>         select MMC_TMIO_CORE
>         help
>           This provides support for the SD/MMC cell found in TC6393XB,
> @@ -971,7 +973,7 @@ config MMC_REALTEK_USB
>
>  config MMC_SUNXI
>         tristate "Allwinner sunxi SD/MMC Host Controller support"
> -       depends on ARCH_SUNXI
> +       depends on ARCH_SUNXI || COMPILE_TEST
>         help
>           This selects support for the SD/MMC Host Controller on
>           Allwinner sunxi SoCs.
> --
> 2.17.1
>
