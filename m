Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0697C4338F
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Aug 2021 11:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4DEA61008
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Aug 2021 11:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237768AbhHDLfs (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 4 Aug 2021 07:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237592AbhHDLfr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Aug 2021 07:35:47 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5E1C06179A
        for <linux-mmc@vger.kernel.org>; Wed,  4 Aug 2021 04:35:34 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id 91so716402uas.10
        for <linux-mmc@vger.kernel.org>; Wed, 04 Aug 2021 04:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GJegJFwVm20ORnlkmvxDZfnK1lDL7HuFBtCqp8AL7RI=;
        b=StgM0cGz0m8s0GyqVZ4fqk32AfonGg+laHvo/013QZDYaAdgWrl3Ww+kRsht6Eu3+8
         MS7x9O9smW31yWz3qIiVWQDGLonDqCgVRpfqDkArB9FSrED6pKbVFvDa5Vln56dpkBgc
         Co61/33bqfgQMhNnBP1RVKZ/RgVGx9K23rgtPIsHkb5yDzjj594Zbuzj9fopVkyRJrK9
         EFaC9r/MI3S+SLTHzsQIojiL2LAPU+Ohn3opcgoR10ctBxFQuhX5m/WRT2lRAMP/5McW
         S8Yk8m03tqayvNXOeXsaa94JUX7kSvU+QLHG3NqzMPObA9Q3kyxjru+/gev8WPUvfoc9
         Reig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GJegJFwVm20ORnlkmvxDZfnK1lDL7HuFBtCqp8AL7RI=;
        b=ioJ4gEXJCbga44CWG+DJ50fh6wmDWNAFT5v5f+P0BUu4Ad+7b58xinOoTFVBU9nece
         t692HTXuhY5I7Cib9hoUPcgHIOQI8ZMZ7bCs8ef+uuNngE0bmnavR2SChwj9k5kxxJ6h
         ZxUcuIyXxw88gOHlCXyLa0dx5dvr0eJyVPw6b9YidXv7Ik6EjhGYw2fGGbbzQIfoyy8T
         TMJWcPCoTVnolujPCQFiyVvxv4SUrzGtX+1qZUsak4KByOfHjNSdp/5FsGEukfedMYqR
         RgTNOpirSS83ijX9V7sRYLo80Xk0r6gx+wrIyjIPbWPOlkhdiWxxd6GMWAUVEp9RIJ7l
         YhoA==
X-Gm-Message-State: AOAM5311cqiOnsXlSqxjcr07glgc4ixnz99AQ4zn7RaWIt9DbjslhtO1
        LyWC4N3D6tR5UMaoUCW2+xaqHOxHYVvKc/PtbGBtew==
X-Google-Smtp-Source: ABdhPJzvVPzepoJ7BdSwEREjqqV2HJFdMRbbqsDMpncElUpIUZse+posCzzbSGDQC8QwEnEOLPnOeqA3trIUYo8P6Ws=
X-Received: by 2002:ab0:60c9:: with SMTP id g9mr9854370uam.100.1628076933258;
 Wed, 04 Aug 2021 04:35:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210719193413.3792615-1-festevam@gmail.com>
In-Reply-To: <20210719193413.3792615-1-festevam@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 4 Aug 2021 13:34:56 +0200
Message-ID: <CAPDyKFqa8wDOHOsGp7hD6JYhWfdkwadQkeyJPP4pFWxHMWjP+w@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: Remove unneeded mmc-esdhc-imx.h header
To:     Fabio Estevam <festevam@gmail.com>
Cc:     dl-linux-imx <linux-imx@nxp.com>,
        linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 19 Jul 2021 at 21:34, Fabio Estevam <festevam@gmail.com> wrote:
>
> After the i.MX conversion to a DT-only platform, the mmc-esdhc-imx.h
> header file is no longer used outside the driver, so move its content
> to the sdhci-esdhc-imx driver and remove the header.
>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c          | 33 +++++++++++++++-
>  include/linux/platform_data/mmc-esdhc-imx.h | 42 ---------------------
>  2 files changed, 32 insertions(+), 43 deletions(-)
>  delete mode 100644 include/linux/platform_data/mmc-esdhc-imx.h
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 72c0bf0c1887..57b19ca1ad6d 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -24,7 +24,6 @@
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/pinctrl/consumer.h>
> -#include <linux/platform_data/mmc-esdhc-imx.h>
>  #include <linux/pm_runtime.h>
>  #include "sdhci-pltfm.h"
>  #include "sdhci-esdhc.h"
> @@ -191,6 +190,38 @@
>   */
>  #define ESDHC_FLAG_BROKEN_AUTO_CMD23   BIT(16)
>
> +enum wp_types {
> +       ESDHC_WP_NONE,          /* no WP, neither controller nor gpio */
> +       ESDHC_WP_CONTROLLER,    /* mmc controller internal WP */
> +       ESDHC_WP_GPIO,          /* external gpio pin for WP */
> +};
> +
> +enum cd_types {
> +       ESDHC_CD_NONE,          /* no CD, neither controller nor gpio */
> +       ESDHC_CD_CONTROLLER,    /* mmc controller internal CD */
> +       ESDHC_CD_GPIO,          /* external gpio pin for CD */
> +       ESDHC_CD_PERMANENT,     /* no CD, card permanently wired to host */
> +};
> +
> +/*
> + * struct esdhc_platform_data - platform data for esdhc on i.MX
> + *
> + * ESDHC_WP(CD)_CONTROLLER type is not available on i.MX25/35.
> + *
> + * @wp_type:   type of write_protect method (see wp_types enum above)
> + * @cd_type:   type of card_detect method (see cd_types enum above)
> + */
> +
> +struct esdhc_platform_data {
> +       enum wp_types wp_type;
> +       enum cd_types cd_type;
> +       int max_bus_width;
> +       unsigned int delay_line;
> +       unsigned int tuning_step;       /* The delay cell steps in tuning procedure */
> +       unsigned int tuning_start_tap;  /* The start delay cell point in tuning procedure */
> +       unsigned int strobe_dll_delay_target;   /* The delay cell for strobe pad (read clock) */
> +};
> +
>  struct esdhc_soc_data {
>         u32 flags;
>  };
> diff --git a/include/linux/platform_data/mmc-esdhc-imx.h b/include/linux/platform_data/mmc-esdhc-imx.h
> deleted file mode 100644
> index cba1184b364c..000000000000
> --- a/include/linux/platform_data/mmc-esdhc-imx.h
> +++ /dev/null
> @@ -1,42 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - * Copyright 2010 Wolfram Sang <kernel@pengutronix.de>
> - */
> -
> -#ifndef __ASM_ARCH_IMX_ESDHC_H
> -#define __ASM_ARCH_IMX_ESDHC_H
> -
> -#include <linux/types.h>
> -
> -enum wp_types {
> -       ESDHC_WP_NONE,          /* no WP, neither controller nor gpio */
> -       ESDHC_WP_CONTROLLER,    /* mmc controller internal WP */
> -       ESDHC_WP_GPIO,          /* external gpio pin for WP */
> -};
> -
> -enum cd_types {
> -       ESDHC_CD_NONE,          /* no CD, neither controller nor gpio */
> -       ESDHC_CD_CONTROLLER,    /* mmc controller internal CD */
> -       ESDHC_CD_GPIO,          /* external gpio pin for CD */
> -       ESDHC_CD_PERMANENT,     /* no CD, card permanently wired to host */
> -};
> -
> -/**
> - * struct esdhc_platform_data - platform data for esdhc on i.MX
> - *
> - * ESDHC_WP(CD)_CONTROLLER type is not available on i.MX25/35.
> - *
> - * @wp_type:   type of write_protect method (see wp_types enum above)
> - * @cd_type:   type of card_detect method (see cd_types enum above)
> - */
> -
> -struct esdhc_platform_data {
> -       enum wp_types wp_type;
> -       enum cd_types cd_type;
> -       int max_bus_width;
> -       unsigned int delay_line;
> -       unsigned int tuning_step;       /* The delay cell steps in tuning procedure */
> -       unsigned int tuning_start_tap;  /* The start delay cell point in tuning procedure */
> -       unsigned int strobe_dll_delay_target;   /* The delay cell for strobe pad (read clock) */
> -};
> -#endif /* __ASM_ARCH_IMX_ESDHC_H */
> --
> 2.25.1
>
