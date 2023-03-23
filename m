Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86135C6FD1D
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Mar 2023 12:15:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjCWMO6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 23 Mar 2023 08:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbjCWMOc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Mar 2023 08:14:32 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8AA62410D
        for <linux-mmc@vger.kernel.org>; Thu, 23 Mar 2023 05:14:05 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id j7so24492503ybg.4
        for <linux-mmc@vger.kernel.org>; Thu, 23 Mar 2023 05:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679573641;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CBcr6rGUQpq73pjYT7vRUWqGDW5Dr38jLB7HJdT5cIo=;
        b=voEb/826RcZ3kwUnJrKKb5X0HAbeEHDo9gxIa7fYVS2TgYVRFp8uQLGPf5rqZHl+hL
         Q/TNwsas90BLJQRUYzSmNUUVS1mlzjMMyIrkLWAYkIFqrjIX5nNAqZzEX6SwnOjt4tiz
         Lt3fG2Sx0aV86xTqdDs4TZZsEveXVz9psGjGoSLn3Uo4f2v0FRGNfLff+FeaGmdlHkiN
         fgA8epD3GnmWQDOPB9sJtcPHg2XvO/2/LrRw/UY9Pn0KdQZikvonson8U2c4q4ZFEqRk
         hbgu+3nxxqgPSw7s/Ajwzp/0lb9xvCHwZKVkXItCgf1MMGU6p8GmU6//bqu4XYYJVixI
         Bgpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679573641;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CBcr6rGUQpq73pjYT7vRUWqGDW5Dr38jLB7HJdT5cIo=;
        b=yN9ommBzvIfQkfQuwQQj6z5UYfc6jr2usH02Hjf4zszbGEznq5OwjmiSUaJVhXvOmn
         e3bYS7FHQG+4IEuZOnBwRC1PS4hinHewesnQtpj8RwqH/dfH6IjID7cEKexSU88yCAp8
         lNEozgnCe9mUf2+WMdXqAFTc/IzVaTjoR+5V3XWhrChdchE9sU2UxgOYxMTG/pjdZOwd
         /ujKdd5X8w8ryRHAUrVtUoh6AFrQ1JJJuaTuh2fs1PuZQJdcmmXL8/hH6kSeTas9fMix
         8jNDBx/q/tgjdhrgU+za83E9Z6kNuBBGEJq6K1OkBDGNlJ06UXvWcIrcgOQeHgb7LZ6M
         h4qA==
X-Gm-Message-State: AAQBX9es59QxEQTUJmap0ksGG94+nYyLgMNL4Oc1Kl0kWdNrIbWvgA8m
        ujQDCDzGL+MR7RplnmJKGBpN+bcBQUPUVPfHG9KIuQ==
X-Google-Smtp-Source: AKy350a5HqJ3Do5D8FQMtsU4FwpW2pRvPpCLBVv/YVEXdN/L2HtAIv5Arz6/7Km/jGditdZo9mvd1J5GFyhyQUTw4+I=
X-Received: by 2002:a05:6902:1689:b0:b75:8ac3:d5d9 with SMTP id
 bx9-20020a056902168900b00b758ac3d5d9mr948334ybb.3.1679573641152; Thu, 23 Mar
 2023 05:14:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230319164744.1707169-1-trix@redhat.com>
In-Reply-To: <20230319164744.1707169-1-trix@redhat.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 23 Mar 2023 13:13:25 +0100
Message-ID: <CAPDyKFqfdYKXwaCbT6_hBsX1ZxeVtNivZBQmh3gA8554F944hA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdricoh_cs: remove unused sdricoh_readw function
To:     Tom Rix <trix@redhat.com>
Cc:     saschasommer@freenet.de, nathan@kernel.org,
        ndesaulniers@google.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, 19 Mar 2023 at 17:47, Tom Rix <trix@redhat.com> wrote:
>
> clang with W=1 reports
> drivers/mmc/host/sdricoh_cs.c:104:28: error: unused function
>   'sdricoh_readw' [-Werror,-Wunused-function]
> static inline unsigned int sdricoh_readw(struct sdricoh_host *host,
>                            ^
> This function is not used, so remove it.
>
> Signed-off-by: Tom Rix <trix@redhat.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdricoh_cs.c | 8 --------
>  1 file changed, 8 deletions(-)
>
> diff --git a/drivers/mmc/host/sdricoh_cs.c b/drivers/mmc/host/sdricoh_cs.c
> index 76a8cd3a186f..57b8c1a96756 100644
> --- a/drivers/mmc/host/sdricoh_cs.c
> +++ b/drivers/mmc/host/sdricoh_cs.c
> @@ -101,14 +101,6 @@ static inline void sdricoh_writel(struct sdricoh_host *host, unsigned int reg,
>
>  }
>
> -static inline unsigned int sdricoh_readw(struct sdricoh_host *host,
> -                                        unsigned int reg)
> -{
> -       unsigned int value = readw(host->iobase + reg);
> -       dev_vdbg(host->dev, "rb %x 0x%x\n", reg, value);
> -       return value;
> -}
> -
>  static inline void sdricoh_writew(struct sdricoh_host *host, unsigned int reg,
>                                          unsigned short value)
>  {
> --
> 2.27.0
>
