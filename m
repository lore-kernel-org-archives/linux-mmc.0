Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96552C76195
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Mar 2023 12:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbjCWMOc (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 23 Mar 2023 08:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbjCWMOE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Mar 2023 08:14:04 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40524231E6
        for <linux-mmc@vger.kernel.org>; Thu, 23 Mar 2023 05:13:47 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id r187so403637ybr.6
        for <linux-mmc@vger.kernel.org>; Thu, 23 Mar 2023 05:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679573626;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=piZ+PkFV5WvYTk12pZZbvmVa0DMKTZ0dY4RGfTiFlGE=;
        b=qChmhFMYb7uAmDl3c9o+/OEyiiJWrsLk9qH+fBrZelNVKUCYekFJExMGimfH9+++64
         UyOU0iHMtTi/9NJwDGZPeLR/fJwh4KRVGFrZDfxzaLxMdZLv+vkB3aPB+azsXDcr2+AB
         XaXp0/B5GOuzWC0stmEOFztjxGZLzZjnP71BwF0LYyIJ1mgjXPGUX8QhsZlfgpsm+AU5
         UJjl1b3COQw3wyB1FqX1o5OStmXkpNaF6UnrvUbiE1RPCmg5/OSuxMDmnuZCkWSoonL4
         znpcCkjRS44hkWcqprqvV7PLqGKjJEQWMBkDhU9V8RcAHl5SXZcDhjZfTAQ931ku3L3M
         NzCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679573626;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=piZ+PkFV5WvYTk12pZZbvmVa0DMKTZ0dY4RGfTiFlGE=;
        b=L1eO23G6p5HdiLuWeoFc2pdkC5BhuTnck8Qc7p7AeOKrcy1gYRMNBqZaFbRrOfQyeJ
         IeYfIV3+wK1bahn/htgjBKJVniXgMFpERzQ0h17uTp6jyVvFQKqAaXjCAU2OSI9lfZG8
         bhPTe5FjiD6TjwEIqAD+JsTuH9vke83LAloUIa7pBknelsDEgYOMzB80zOOXlX2Zkysl
         IGIkPv6GwE4IaIUg2MVU2pgdmxKjoNDa23q87ZfuNBIJvPc6GFwSQzdGjn8AHFSMv/wg
         hc4Slb03rA7SqinoI88H5GAErqDZTw8/AA8as+C/kxfxNeNfvy2px7Q7uDeDaz3jp/RE
         3hDg==
X-Gm-Message-State: AAQBX9ewbNwm9LEUWnQFgqM5s+Q8sdz7+iGizv9rQkBKOoFN0Kmvg/bp
        6U61llrtRLuWFF7FVxdlGH8l0EbM+nT0njPhntcOHQ==
X-Google-Smtp-Source: AKy350b/FzYTw51HnTYwc0uSjq0ZvicnZs9K3NgIj/elTpYm4gPt7nbklyB5sQoODjeWSl0pEldwGAuyF3GQvkpN0ws=
X-Received: by 2002:a05:6902:1705:b0:b75:8ac3:d5d8 with SMTP id
 by5-20020a056902170500b00b758ac3d5d8mr942368ybb.3.1679573626037; Thu, 23 Mar
 2023 05:13:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230315053127.33855-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20230315053127.33855-1-yang.lee@linux.alibaba.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 23 Mar 2023 13:13:10 +0100
Message-ID: <CAPDyKFooj9uqAJZvcG-QYDRPoMngXsBC_6cu_0=9WnB=Y1xqLA@mail.gmail.com>
Subject: Re: [PATCH -next] mmc: jz4740: Use devm_platform_get_and_ioremap_resource()
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     paul@crapouillou.net, linux-mips@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 15 Mar 2023 at 06:31, Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> According to commit 890cc39a8799 ("drivers: provide
> devm_platform_get_and_ioremap_resource()"), convert
> platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/jz4740_mmc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
> index 698450afa7bb..1846a05210e3 100644
> --- a/drivers/mmc/host/jz4740_mmc.c
> +++ b/drivers/mmc/host/jz4740_mmc.c
> @@ -1079,8 +1079,7 @@ static int jz4740_mmc_probe(struct platform_device* pdev)
>                 goto err_free_host;
>         }
>
> -       host->mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       host->base = devm_ioremap_resource(&pdev->dev, host->mem_res);
> +       host->base = devm_platform_get_and_ioremap_resource(pdev, 0, &host->mem_res);
>         if (IS_ERR(host->base)) {
>                 ret = PTR_ERR(host->base);
>                 goto err_free_host;
> --
> 2.20.1.7.g153144c
>
