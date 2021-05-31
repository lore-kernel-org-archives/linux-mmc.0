Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2087C47080
	for <linux-mmc@archiver.kernel.org>; Mon, 31 May 2021 10:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2E67611CA
	for <linux-mmc@archiver.kernel.org>; Mon, 31 May 2021 10:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbhEaKSq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 31 May 2021 06:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbhEaKSn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 31 May 2021 06:18:43 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29750C061761
        for <linux-mmc@vger.kernel.org>; Mon, 31 May 2021 03:17:03 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id i29so5750866vsr.11
        for <linux-mmc@vger.kernel.org>; Mon, 31 May 2021 03:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uwvxx69c5I2Xyj4W+OI1HkZT6qMIIrqbfX9qTV0ZMOM=;
        b=q3Wa8TXl84khkBvB8WkMOfD5LRTmVWOQtmPAWbrduQZSWm6cQ+fFdnMoZzeJF7FvQr
         BIJgXU4FpgzRYM2CGu22W0S0LGR6EeErrH0OD1akpD9woevYKz6aPJrFmw76G81dLVe+
         2pIGG6CcpV0eFE3p9iZ+AgP6TVQQF9WGI8eeLYOFSlKG8Dv/b4QIoDDFdHZVKzsJxfEG
         FZQbf8PdbqwIDRc7p8kTgm1P6x+6su+uxdM0KP8l1dOFq5tkc6Zr8o0EYv+UThcD/CUJ
         sRuKagi5ZWKefNWnaQwnuYMOd6B24LmS1KZ9jYsk368by680eMUtzv2iDI6tOgicGsS6
         PJTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uwvxx69c5I2Xyj4W+OI1HkZT6qMIIrqbfX9qTV0ZMOM=;
        b=mmCowG6nBUIOtWH2ediaNlcnSD7BmjJmwYiaXrzAcrxHdLRIrRfoBDXh1zar1cuvj4
         m4EkUTUqAhsrPmARGt67rW3tuVRgibgETTMSbvsjIhRzpsFwEaYCOcIr4EZltCrDvF0/
         YfzNaWalinPH9FCcJ6Y74ByD8BX9DzEwd4VhWWMeV9ZExJ5JoFOO0XuY3R1sNQWYefg0
         7HWzVI49G8+vw1OsUPFvTWYG/08WVffje6HuB8QmgAwq87LZm2fG5aI4b53S5SKQornw
         Xb1/jFZn2tGTVhDV2++tzbOFq6jcmJ93zKf8IQRAduFOidNI++WXg2IEdXbggPWxM2Jt
         PgQg==
X-Gm-Message-State: AOAM531qjgkdWHOHx6zphS35KJWH6WnvwZ8K8iVx0aFBnBcJOw34coPe
        +6bJPC+zt9Imfg9jVBLeETqYEfamSqov6W/GvdGcAQ==
X-Google-Smtp-Source: ABdhPJwIGI5VbRGX8PTwoO3Df5my/ZNCNNhiHEbA+RW80GxhxeEpq1hkdwtpCmIGG0fSsFuOuYzUaVBiPCw1QlU5dws=
X-Received: by 2002:a05:6102:74d:: with SMTP id v13mr869097vsg.55.1622456222315;
 Mon, 31 May 2021 03:17:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210527194226.1705607-1-geert@linux-m68k.org>
In-Reply-To: <20210527194226.1705607-1-geert@linux-m68k.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 31 May 2021 12:16:25 +0200
Message-ID: <CAPDyKFrpyXVpFpDvor5C3B-39m2-jE_f_xz6dGW4-KRbE7bBvg@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc-pltfm: Remove unused <linux/clk.h>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Addy Ke <addy.ke@rock-chips.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 27 May 2021 at 21:42, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> As of commit 4cdc2ec1da322776 ("mmc: dw_mmc: move rockchip related code
> to a separate file"), dw_mmc-pltfm.c no longer uses the clock API.
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/dw_mmc-pltfm.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
> index 73731cd3ba2315e3..9901208be7973f67 100644
> --- a/drivers/mmc/host/dw_mmc-pltfm.c
> +++ b/drivers/mmc/host/dw_mmc-pltfm.c
> @@ -17,7 +17,6 @@
>  #include <linux/mmc/host.h>
>  #include <linux/mmc/mmc.h>
>  #include <linux/of.h>
> -#include <linux/clk.h>
>
>  #include "dw_mmc.h"
>  #include "dw_mmc-pltfm.h"
> --
> 2.25.1
>
