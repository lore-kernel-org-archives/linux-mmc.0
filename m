Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 424DBC43470
	for <linux-mmc@archiver.kernel.org>; Mon, 12 Apr 2021 07:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 197B261356
	for <linux-mmc@archiver.kernel.org>; Mon, 12 Apr 2021 07:53:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237039AbhDLHxR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 12 Apr 2021 03:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237074AbhDLHxR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Apr 2021 03:53:17 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC34C06138E
        for <linux-mmc@vger.kernel.org>; Mon, 12 Apr 2021 00:52:59 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id o17so2666586vko.8
        for <linux-mmc@vger.kernel.org>; Mon, 12 Apr 2021 00:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hcFlLUBMWxQKE3B4SECGAUhtA2wbG5MqwDkyb7fTUn0=;
        b=u9xumO9kleHHfj6tSe/0iqldeck9GJ6YXUX9u+OOybOasvmwDhemSKlk53mJdYzPqB
         6dMLHAf3fMpPCUYrVubGmBMvmoE4HeL33jFcs8md4Zu0XkXPWEUdm6Qm8HV4gc41ofXz
         sdjtU6pJz0XbmPnY+N+fDRx894+MzWurtJQlEp7ASGW/YjOxWPTwsBUkbt4e41o9qoYj
         p51k2Cex81UlMae7jVc6wJvUzhZU28h3A1XO3Ltod0NqCL4QatsWmcXTwhRr2yJDVU1Z
         QCpTYgc2UGbHeXxwEgIoK0enOe9dG/YEYTpfD7XRY1h4rBZmqk4WPbAi3zTT92SXfKz3
         yDFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hcFlLUBMWxQKE3B4SECGAUhtA2wbG5MqwDkyb7fTUn0=;
        b=kQOF0UaXOyceEZ1qtQc0xuumDhC4hzKxUmVKcD9XMmR5lfOSz+cqdYvf52o16yCpvI
         JFmQsVRgmG7COfJBoSGKB2X2P+lYLYUg45xvvcbQe9bezqSVXlTf3iIDaufHAUdLb9Ln
         /PFd5EB9NKEVHf9wVHiQ3kccO9iXAuzfhwooc4UwUW8YJXXss1GtF2xCmSo95yXyH0p/
         AbkBqwabfWUmXxTsM+EqkyYrBkkQZEWucZBzvC+OpKIAdtlnjK7zxyXlxxZ5R3eTgfm6
         3fjIQ0qizqPlMWnM3IkMgmNzVo3l2dAQ0+gpiASRe6LRj84c6Vk6Vm8MlVh/NGwXEqBn
         ZSow==
X-Gm-Message-State: AOAM531RyMdanCyihEXs8VIXVd9jCQog7mHpXrHGN2ui8seobOjFVjYd
        8zvAsKNzLck1NnA/St9j6eNh7T4tj8MOvwVhfwbj3A==
X-Google-Smtp-Source: ABdhPJyaO4Xd3hVmOLdeg8TevfbirfrXrX5rlO/3ixxXssURkNOxuNhiJ30d/DBpHuoz9T9c3tLdXhKljdhEVV/BYk4=
X-Received: by 2002:a1f:5504:: with SMTP id j4mr18551153vkb.7.1618213978935;
 Mon, 12 Apr 2021 00:52:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210409023349.3325907-1-qiulaibin@huawei.com>
In-Reply-To: <20210409023349.3325907-1-qiulaibin@huawei.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 12 Apr 2021 09:52:22 +0200
Message-ID: <CAPDyKFrwp6tbaHt6nctnTgppG5PsS2Hcb-BPhBT6N0-fmcpAWA@mail.gmail.com>
Subject: Re: [PATCH -next] mmc: owl-mmc: Remove unnecessary error log
To:     Laibin Qiu <qiulaibin@huawei.com>
Cc:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        YueHaibing <yuehaibing@huawei.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-actions@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 9 Apr 2021 at 04:24, Laibin Qiu <qiulaibin@huawei.com> wrote:
>
> devm_ioremap_resource() has recorded error log, so it's
> unnecessary to record log again.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Laibin Qiu <qiulaibin@huawei.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/owl-mmc.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/mmc/host/owl-mmc.c b/drivers/mmc/host/owl-mmc.c
> index 5490962dc8e5..3dc143b03939 100644
> --- a/drivers/mmc/host/owl-mmc.c
> +++ b/drivers/mmc/host/owl-mmc.c
> @@ -581,7 +581,6 @@ static int owl_mmc_probe(struct platform_device *pdev)
>         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>         owl_host->base = devm_ioremap_resource(&pdev->dev, res);
>         if (IS_ERR(owl_host->base)) {
> -               dev_err(&pdev->dev, "Failed to remap registers\n");
>                 ret = PTR_ERR(owl_host->base);
>                 goto err_free_host;
>         }
> --
> 2.25.1
>
