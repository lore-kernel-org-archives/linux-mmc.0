Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95156C433FE
	for <linux-mmc@archiver.kernel.org>; Tue, 19 Oct 2021 11:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76E5C6138D
	for <linux-mmc@archiver.kernel.org>; Tue, 19 Oct 2021 11:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235335AbhJSLCT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 19 Oct 2021 07:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235434AbhJSLCE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Oct 2021 07:02:04 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DAB8C06176C
        for <linux-mmc@vger.kernel.org>; Tue, 19 Oct 2021 03:59:50 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id s19so5329386ljj.11
        for <linux-mmc@vger.kernel.org>; Tue, 19 Oct 2021 03:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yvpR/+LDc/4vIIRPGMLgKA8FJKUHtg12S0DrPQp+iCA=;
        b=ShER1y/hDIZPAQU1v1YNeGWehRkRxSpc08jn/rG7iGr+0+du6oAPScZBT57yeOVBcE
         MS2Z4Y0smUW0XWeN7JnbpmWjczvKIg8k9cEEcAeO7ZZofw4IiAI0y45+7E7p/1Zq4VuB
         o4S9JXVQSC+D5d/zEfZuN+g0Sia6I2eefLBvrGziO2tiqYSIh38KAHMJfuygRSXF5YIX
         IPyiNxQ6MiCt9OwO1snXJM7HYUyV36ELXQ2xO4GQIQ7YlB02hgVn0hENH8cbHEgWAIBH
         iy6EfpHjbIoun0qCkC7oYwmREc2djmQ5IBjhcVj2J5VBCqV9DX7M/ofj8I9TBorxQ/5N
         2rDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yvpR/+LDc/4vIIRPGMLgKA8FJKUHtg12S0DrPQp+iCA=;
        b=y8NAA66/MHOhs85whjcJvwoC7gpiZl89Sma9f9m+J2E30+1aGjhnuERShDIeyfMo6W
         AfghHzT9HlTwqGF6gH65bh3mIXv+C0MvtLZnyZw+0CcrlhMNYWaom+X540bhMA4hGXuS
         RVe60bcCaiFl2b2D2bdi+m4Cvvki5/DiGKORBMwZQQok9O06e7DnwHDhPYcQtqcvFLWh
         8pg0gJxBTGDLVIH0fBQgi/EUPdqC2Hhdgcosk3eToMZp0wXmNwO7GbLvK4Y9GV1IwfON
         PoTeqCNOlX+zSx8bZt6gIGwRNQ3dP/X53ef/Cl2aVO/Dbq21KKFPBTdxVC97qXuifLdS
         g+XA==
X-Gm-Message-State: AOAM531/IWawLfjBGcmuLhJstBwPAcUFsxJ4ee/WodviWorc1XZzsIpB
        UklIRSxyrU+HHziXAjcFwixB6/VrjOuS5FOlu0wIbQ==
X-Google-Smtp-Source: ABdhPJweCp01ZjPFICCqBQ55XvXqdFtPCUZr+w6qvIuEAd0a/tIavRkspbIkoBgN9dnt2TjEcaWQ2UBNJYvKKC1xVcI=
X-Received: by 2002:a2e:b550:: with SMTP id a16mr634976ljn.229.1634641188965;
 Tue, 19 Oct 2021 03:59:48 -0700 (PDT)
MIME-Version: 1.0
References: <20211017175949.23838-1-rdunlap@infradead.org>
In-Reply-To: <20211017175949.23838-1-rdunlap@infradead.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 19 Oct 2021 12:59:12 +0200
Message-ID: <CAPDyKFrhdkp2W6rPorw+0T_dZkcg6TXFcqB2vrWnnfvwdhpKzw@mail.gmail.com>
Subject: Re: [PATCH] mmc: winbond: don't build on M68K
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pierre Ossman <pierre@ossman.eu>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, 17 Oct 2021 at 19:59, Randy Dunlap <rdunlap@infradead.org> wrote:
>
> The Winbond MMC driver fails to build on ARCH=m68k so prevent
> that build config. Silences these build errors:
>
> ../drivers/mmc/host/wbsd.c: In function 'wbsd_request_end':
> ../drivers/mmc/host/wbsd.c:212:28: error: implicit declaration of function 'claim_dma_lock' [-Werror=implicit-function-declaration]
>   212 |                 dmaflags = claim_dma_lock();
> ../drivers/mmc/host/wbsd.c:215:17: error: implicit declaration of function 'release_dma_lock'; did you mean 'release_task'? [-Werror=implicit-function-declaration]
>   215 |                 release_dma_lock(dmaflags);
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Pierre Ossman <pierre@ossman.eu>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-mmc@vger.kernel.org
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: linux-m68k@lists.linux-m68k.org
> Cc: Arnd Bergmann <arnd@arndb.de>

Applied for fixes, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/host/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- linux-next-20211015.orig/drivers/mmc/host/Kconfig
> +++ linux-next-20211015/drivers/mmc/host/Kconfig
> @@ -508,7 +508,7 @@ config MMC_OMAP_HS
>
>  config MMC_WBSD
>         tristate "Winbond W83L51xD SD/MMC Card Interface support"
> -       depends on ISA_DMA_API
> +       depends on ISA_DMA_API && !M68K
>         help
>           This selects the Winbond(R) W83L51xD Secure digital and
>           Multimedia card Interface.
