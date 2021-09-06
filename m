Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53415C433F5
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Sep 2021 16:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3567761039
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Sep 2021 16:36:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243509AbhIFQho (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 6 Sep 2021 12:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbhIFQhm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Sep 2021 12:37:42 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B95CC061757
        for <linux-mmc@vger.kernel.org>; Mon,  6 Sep 2021 09:36:37 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id f2so12213215ljn.1
        for <linux-mmc@vger.kernel.org>; Mon, 06 Sep 2021 09:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cgr6Jz+lrB7D42Igr6LQ2k0LOWT6QRl6Zo2ea56U1/0=;
        b=qFue/ctcVup2ZBYh+V2vDeXGYUQlqSSTr0F0rtwg3ihQG1N3E0nkPHz7F4S1cPA36X
         XX6ajt0l5e6WRc1OnNJ88Rpm6B8Pvq4fIq15S2eNWK19rSp8lbBhRTGNaOs+d/6T9JNg
         KMMQ66achlkth81CmiYymoqErBfB5qgnbMzMsGnIUh7ybdTBdGBNFO0xsZrShGCerYp5
         NjEQZn2gTzmLOrPHL/UKB5lXjoC3v6bB936WCcMPL/Jb2F7yiCALaOj5JiWVREyTtXV4
         QA6oo/C8cZj+rIGHtw7QNIHz/16i4xnpriV+1DjH0V88DESYATAWCmLrhb84m+Z0mohL
         hgFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cgr6Jz+lrB7D42Igr6LQ2k0LOWT6QRl6Zo2ea56U1/0=;
        b=fYl7o90cVsBa1YQF9DTQOUYof3hcDlPEvFd0aIL8ZKjQ7pxIq7l/RDk4mpCCgjDQA5
         nr0onxL8kwBb0bZ7p+u/i98KcOAm4NIkSwugbzsYKv6BESq4Ymw7yT/3fw3rLEXZW8h1
         kInleMg6n1cz5USiXUpJY7xibMj6QUh4dcJi2+KPw47CTGpNJ1vRf8tfa5R8XzQihr0k
         zfAz2yWD9P2XwHS7hD6uwawMxHpTgHsl66k5vxojvcXPBbXrKWzLxroD/0nqAY4gPr6e
         vbkr6Ti6xR/F1aRAA1031521PUUTpT7SJ5VsOx235EC5T5iaW6UXx3r0GqOSN3lPvHdY
         qx6A==
X-Gm-Message-State: AOAM532a1hmBBMEwaSqHpIlUcjLzpdcqWTLwwoFU6NbUIoMljx8gySFh
        18tG0v5ulCKNsxXqS3nLXIGK8vNbz7Np90fqxRjaiQ==
X-Google-Smtp-Source: ABdhPJzT5LiGUegKEZsMvc5nNqo2qWbWBytqyjX8rsodVuGLIyP1vHsR6WA8ikEELHPTINM6V/ky1ojVSaj1bOIzF8M=
X-Received: by 2002:a2e:960c:: with SMTP id v12mr12032538ljh.300.1630946195528;
 Mon, 06 Sep 2021 09:36:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210828085446.1878-1-caihuoqing@baidu.com>
In-Reply-To: <20210828085446.1878-1-caihuoqing@baidu.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 6 Sep 2021 18:35:58 +0200
Message-ID: <CAPDyKFqz-Go=gCYpzsN6Np3SnfKm_iCWnhORidj1PTHm_ftx7w@mail.gmail.com>
Subject: Re: [PATCH] mmc: omap_hsmmc: Make use of the helper macro SET_RUNTIME_PM_OPS()
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Doug Anderson <dianders@chromium.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, 28 Aug 2021 at 10:55, Cai Huoqing <caihuoqing@baidu.com> wrote:
>
> Use the helper macro SET_RUNTIME_PM_OPS() instead of the verbose
> operators ".runtime_suspend/.runtime_resume", because the
> SET_RUNTIME_PM_OPS() is a nice helper macro that could be brought
> in to make code a little clearer, a little more concise.

That makes sense to me.

>
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---
>  drivers/mmc/host/omap_hsmmc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 2f8038d69f67..748303e14841 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -2156,8 +2156,7 @@ static int omap_hsmmc_runtime_resume(struct device *dev)
>
>  static const struct dev_pm_ops omap_hsmmc_dev_pm_ops = {
>         SET_SYSTEM_SLEEP_PM_OPS(omap_hsmmc_suspend, omap_hsmmc_resume)
> -       .runtime_suspend = omap_hsmmc_runtime_suspend,
> -       .runtime_resume = omap_hsmmc_runtime_resume,
> +       SET_RUNTIME_PM_OPS(omap_hsmmc_runtime_suspend, omap_hsmmc_runtime_resume, NULL)
>  };

When building this driver with CONFIG_PM being unset, the compiler
will complain about unused functions. Please add "#ifdef CONFIG_PM"
around the implementation of omap_hsmmc_runtime_suspend|resume() to
address that.

>
>  static struct platform_driver omap_hsmmc_driver = {
> --
> 2.25.1
>

Kind regards
Uffe
