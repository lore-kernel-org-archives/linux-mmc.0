Return-Path: <SRS0=qSan=CQ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C81C433E2
	for <linux-mmc@archiver.kernel.org>; Mon,  7 Sep 2020 10:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCEE42166E
	for <linux-mmc@archiver.kernel.org>; Mon,  7 Sep 2020 10:08:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GdR9hDKN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbgIGKIZ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 7 Sep 2020 06:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728508AbgIGKH6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Sep 2020 06:07:58 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E63C061573
        for <linux-mmc@vger.kernel.org>; Mon,  7 Sep 2020 03:07:58 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id y15so4010144uan.9
        for <linux-mmc@vger.kernel.org>; Mon, 07 Sep 2020 03:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QuNLltsEiIW4LCbpFyTWl1p44IkTT3QJmbdClg97dn0=;
        b=GdR9hDKN5L9o4E+D9klMf226TdSBiyQrmIJFqTy1wvu7JgUOP5hnq9D/dbGUt34nVN
         XTE9ZkkMZYDWJkEj8/LXyenZz3T0Irx/WXSUQIYDB4F7XGGOjeU/eP0cHxgH70gtpxoS
         593wZnUVUiqgZqhmNZJBvdbDOEAjelVZNg7W3uJxmMeE2W2+4ryrLED4uLWr5d2on/1Y
         V+k0+LPGbknr9eHhBtS9n9cOKc/o9fFLWU4T/+6C9EhAuV3OtNNgAG8pjet6UXydTeg8
         /OlJ55P8StYowRupDWz7iqCrO55GZV8SHF0Qf78K+dPX1qyWPG1Pi5uUN5Re3N+8QgpF
         Opsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QuNLltsEiIW4LCbpFyTWl1p44IkTT3QJmbdClg97dn0=;
        b=FwkcQOliyiPYHDZFKZlGn4gH3lKuvx+fDmXVh3vDGDuH3PN+bmh1TE4Rf6qRP7A3ue
         jjpgJX4hYDj/bSrkt3e2nE0zm8cqDEiVAFKeGVrCiFfa7LKQDO/LQx/TJT2AkSjN7cHq
         q+AKvsRXws4eoFJWY0zNtF5FdKwHxzGxKJXGO5Fmt/p4h+vj7ELRour+sIde2u+/NYnB
         oX5s1L6e6C2tM3mGupNNF3MNraNACinrQO7HD1CI8w6DnWtFBv6uZ36/wiyDHlZ51t+K
         zljJ6A9r6tv6ZhMO1hUHUx9G7AbHc2p17gatJjh6gRv2BGDEhMW6UAcMolKmhO19BWLb
         7fnA==
X-Gm-Message-State: AOAM53086R2ERNN6mK3kHGWpyxT0dOEWmh46qs6++Bx7SChExPIQKmS4
        4ng7eZVjk66nX3FDL3R0c7jooxCLAe+CNW3l3yM2Sg==
X-Google-Smtp-Source: ABdhPJylvGTfdGwP02Q+D0hgvcDauwlOQni6HAn5s7aLot2eLwS2w0Wmn0FgXWKx98K2aaDsiVxs7F4QHZfQitRnsZs=
X-Received: by 2002:ab0:130a:: with SMTP id g10mr1522518uae.100.1599473277782;
 Mon, 07 Sep 2020 03:07:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200904164315.24618-1-krzk@kernel.org>
In-Reply-To: <20200904164315.24618-1-krzk@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 7 Sep 2020 12:07:21 +0200
Message-ID: <CAPDyKFrzDeNqvM4cc69iCdVW7QnF=O9C=v13+o5bGBSCSzZfWA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mmc: host: Drop unneeded MMC dependency in Kconfig
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Prabu Thangamuthu <prabu.t@synopsys.com>,
        Manjunath M B <manjumb@synopsys.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        linux-arm-kernel@axis.com,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 4 Sep 2020 at 18:43, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> All entries in Kconfig are already part of "if MMC", so there is no need
> for additional dependency on MMC.
>
> Suggested-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied for next, thanks!

Kind regards
Uffe


>
> ---
>
> Changes since v1:
> 1. New patch
> ---
>  drivers/mmc/host/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index b95f79f53395..eea01fde0591 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -422,7 +422,7 @@ config MMC_SDHCI_IPROC
>
>  config MMC_MESON_GX
>         tristate "Amlogic S905/GX*/AXG SD/MMC Host Controller support"
> -       depends on ARCH_MESON && MMC
> +       depends on ARCH_MESON
>         help
>           This selects support for the Amlogic SD/MMC Host Controller
>           found on the S905/GX*/AXG family of SoCs.  This controller is
> @@ -458,7 +458,7 @@ config MMC_MESON_MX_SDIO
>
>  config MMC_MOXART
>         tristate "MOXART SD/MMC Host Controller support"
> -       depends on ARCH_MOXART && MMC
> +       depends on ARCH_MOXART
>         help
>           This selects support for the MOXART SD/MMC Host Controller.
>           MOXA provides one multi-functional card reader which can
> --
> 2.17.1
>
