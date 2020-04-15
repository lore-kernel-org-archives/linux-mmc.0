Return-Path: <SRS0=Q6+y=57=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F71FC2BA19
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Apr 2020 10:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D92520737
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Apr 2020 10:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I1dbtE9s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896534AbgDOKoI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 15 Apr 2020 06:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2896468AbgDOKW4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Apr 2020 06:22:56 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700C6C061A41
        for <linux-mmc@vger.kernel.org>; Wed, 15 Apr 2020 03:22:24 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id 184so1889949vsu.3
        for <linux-mmc@vger.kernel.org>; Wed, 15 Apr 2020 03:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LzzdfLUwUBzFYRmKpHR/vr/78mFa7TyklDw5HVocAjI=;
        b=I1dbtE9seuOpci5uQnbnkHGkhrAmN7qweG/vSXEJ+2myJ/NjuLIUlEfkNHUjh4c506
         zro/TedmPpqbKelc/XCRAl09Wa8x+VaDI0YYGZVY//z91gFTicnWaWts+nl51WTgi/+g
         r71FKwUhBsACCxTvdrB0i6mFkQ3wN725EOPkf2QLLNsMx41xy5t88cY35K1hVQMmM47o
         gWnoEZ0hkPslJw8N4RHFLRHvkhQfQd7Hy/62YzyrlMTgk8djWbsqjYJjoV3oQCLc5rVJ
         eu2ofYdKv9gfotYwHAKdkfxcF5FGrl7n/ZSU6rm26UeH6CHXsDsKMinqTZcFXfTOtjZX
         I/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LzzdfLUwUBzFYRmKpHR/vr/78mFa7TyklDw5HVocAjI=;
        b=gOiwHilgsutjEDS9wU3MSKpc3nXsmsLIPAyGI4uzoFGeES9uUIOgaNtc/jvsqfOSLP
         XnH/BO/DwoNpf/GvbTME62rQmjGxFGxFXeYrxbZRJeOQisuIu5ZS/LsZE/oUc09O1kPl
         uWHnbd/eSwqU+hdyLcvAYgpJBUAYA5D0M/QWQx6MjKy3zVLvPxUhgcDfCJ6tibxNGhgU
         zPjBYUrUoPWh1tz2M9ZagVub/3P3YTYDJU0I8ZE13Z7GUFWxnoZ8qA5AvBExg/VOtSPQ
         YupfwM23vt05ZbbakAhPHhc4jCi3QaHqSBchSQVV1u/dIHHLHScwOlAwPHz8BsG0zXnK
         f/GA==
X-Gm-Message-State: AGi0Pua9QJLzAADU92sLO+3Zx6x6kadamMxZoK2Xz51TF0+s6PtI8fiZ
        FYqiS0j9vhesPgrDhctI0vTfG/BeJCyu+VWoDdcDvg==
X-Google-Smtp-Source: APiQypKN37l7EKhD4x9xU2qvhkdIXUITkcuPG/U10KjhSNKj8LctO0ixQTgpDqbrESAV0BJVwQJ2C2CFXWsYVjybbzI=
X-Received: by 2002:a67:8b09:: with SMTP id n9mr3621500vsd.191.1586946143715;
 Wed, 15 Apr 2020 03:22:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200408072105.422-1-yamada.masahiro@socionext.com>
In-Reply-To: <20200408072105.422-1-yamada.masahiro@socionext.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 15 Apr 2020 12:21:47 +0200
Message-ID: <CAPDyKFrQkyBk2Xizu8_e-aHj=EzmFbg5TSaYvs66VDaE3hY_fA@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: sdhci: move SDHCI_CAPABILITIES_1 to a more
 suitable place
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        masahiroy@kernel.org, Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 8 Apr 2020 at 09:21, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> In the SDHCI specification, the Capabilities Register (Offset 0x40h)
> is the 64-bit width register, but in Linux, it is represented as two
> registers, SDHCI_CAPABILITIES and SDHCI_CAPABILITIES_1 so that drivers
> can use 32-bit register accessors.
>
> The upper 32-bit field is associated with SDHCI_CAPABILITIES_1.
>
> Move the definition of SDHCI_CAPABILITIES_1 to the correct place.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
>  drivers/mmc/host/sdhci.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 79dffbb731d3..b786b68e0302 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -220,6 +220,7 @@
>  #define  SDHCI_CAN_64BIT_V4    0x08000000
>  #define  SDHCI_CAN_64BIT       0x10000000
>
> +#define SDHCI_CAPABILITIES_1   0x44
>  #define  SDHCI_SUPPORT_SDR50   0x00000001
>  #define  SDHCI_SUPPORT_SDR104  0x00000002
>  #define  SDHCI_SUPPORT_DDR50   0x00000004
> @@ -236,8 +237,6 @@
>  #define  SDHCI_CAN_DO_ADMA3    0x08000000
>  #define  SDHCI_SUPPORT_HS400   0x80000000 /* Non-standard */
>
> -#define SDHCI_CAPABILITIES_1   0x44
> -
>  #define SDHCI_MAX_CURRENT              0x48
>  #define  SDHCI_MAX_CURRENT_LIMIT       0xFF
>  #define  SDHCI_MAX_CURRENT_330_MASK    0x0000FF
> --
> 2.17.1
>
