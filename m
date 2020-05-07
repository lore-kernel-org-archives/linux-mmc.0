Return-Path: <SRS0=7UF0=6V=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4688C38A24
	for <linux-mmc@archiver.kernel.org>; Thu,  7 May 2020 09:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A253E20747
	for <linux-mmc@archiver.kernel.org>; Thu,  7 May 2020 09:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qa4HS12L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725809AbgEGJ3r (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 7 May 2020 05:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726519AbgEGJ3q (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 7 May 2020 05:29:46 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B0EC061A10
        for <linux-mmc@vger.kernel.org>; Thu,  7 May 2020 02:29:46 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id w68so1323000vke.5
        for <linux-mmc@vger.kernel.org>; Thu, 07 May 2020 02:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8FdO2PTULjEQDv3sH6+0kA5GeBLoJoWyIIOLXESk+Hs=;
        b=Qa4HS12LPrBV4IpkojZrDQokTbcF38kdN72Y5x4ntVT8m0L9fFrQyuwS2tUEvxrRPh
         4lnG/3GMAevaV8CSNZTH5TRx9p3aiECiW9QZ8HTGOPfo3WLOFJFAJJi+2jtaO7pfXPsT
         8cZ26U9V8pgHGngR/9GdNGMbmElRfgVo/8YvTdaenKcU9SONFPoevqXROMgm/KtULITJ
         zkiT1wLLQJlZtMMLFSWcLBTOhLxjD83RzOYPscee1oz6ECGzPt9qRA8HQdP3CcaGlMBE
         zJUPTS6BbDwRC/pBTphe1iaL5CzIOtqiqPrMCiClMNFkY1dbY3jxMiOBNbK6BTJcgW8f
         WtXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8FdO2PTULjEQDv3sH6+0kA5GeBLoJoWyIIOLXESk+Hs=;
        b=FApNoR1t5tcwZhZZOcLas5NCbT7PNu7aoMrAcsTnhoqn/Qn6lt2IDFvldcvRaPxVIw
         NRzfRV6xOIPGK4+l0y4bclVWyEQHW7gQPXl89JCcQV8JnuqwcyKfhucCRM3GZuCaj5Nc
         aSd7vNHpzAHMsemLclktLy5xawLKNpz+sq/oY8Yw6ALLMzNN4WnlAGnCJ90XRM6FcclF
         0TUzubrYxcNl9NGzOX56FjyfgHdcvG4IgKH/BNCdP6IJboew81mXauG0mw9y6PAB6fUy
         8TwZpoERy9NJdNK+tlRX5BJyLKXJ/b5ub2HA/KzhZk5BRcKQYyugUU2lb6+013vDRn3q
         MAZg==
X-Gm-Message-State: AGi0PuZZGW+RwrI4Vv+L+Pd8zLePRrzB0ENBGRf1AJFZ2aytttvBtivg
        jIo6/wraktrfZ/lcKzwFRnJ8IkxlD8PkeaHk0ZNh1g==
X-Google-Smtp-Source: APiQypKKkANYeT0w7b6XXbm2jhqBUeRY+i8BM0s4iLv9yKc2u9aYi41QBiu3he4kOLZ9vpqqVEr0Cg6wwyFm1lHsmO0=
X-Received: by 2002:a1f:ff11:: with SMTP id p17mr10519319vki.25.1588843785652;
 Thu, 07 May 2020 02:29:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200502142840.19418-1-wsa@kernel.org>
In-Reply-To: <20200502142840.19418-1-wsa@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 7 May 2020 11:29:09 +0200
Message-ID: <CAPDyKFp3XSvbxTiyTu_EOOXtee4tK7DLXCsygAF=x8XVkb_org@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-esdhc: update contact email
To:     Wolfram Sang <wsa@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, 2 May 2020 at 16:28, Wolfram Sang <wsa@kernel.org> wrote:
>
> The 'pengutronix' address is defunct for years. Use the proper contact
> address.
>
> Signed-off-by: Wolfram Sang <wsa@kernel.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-esdhc.h              | 2 +-
>  include/linux/platform_data/mmc-esdhc-imx.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc.h b/drivers/mmc/host/sdhci-esdhc.h
> index 947212f16bc6..a30796e79b1c 100644
> --- a/drivers/mmc/host/sdhci-esdhc.h
> +++ b/drivers/mmc/host/sdhci-esdhc.h
> @@ -5,7 +5,7 @@
>   * Copyright (c) 2007 Freescale Semiconductor, Inc.
>   * Copyright (c) 2009 MontaVista Software, Inc.
>   * Copyright (c) 2010 Pengutronix e.K.
> - *   Author: Wolfram Sang <w.sang@pengutronix.de>
> + *   Author: Wolfram Sang <kernel@pengutronix.de>
>   */
>
>  #ifndef _DRIVERS_MMC_SDHCI_ESDHC_H
> diff --git a/include/linux/platform_data/mmc-esdhc-imx.h b/include/linux/platform_data/mmc-esdhc-imx.h
> index 0434f68eda86..cba1184b364c 100644
> --- a/include/linux/platform_data/mmc-esdhc-imx.h
> +++ b/include/linux/platform_data/mmc-esdhc-imx.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0-only */
>  /*
> - * Copyright 2010 Wolfram Sang <w.sang@pengutronix.de>
> + * Copyright 2010 Wolfram Sang <kernel@pengutronix.de>
>   */
>
>  #ifndef __ASM_ARCH_IMX_ESDHC_H
> --
> 2.20.1
>
