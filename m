Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1535C2B9F8
	for <linux-mmc@archiver.kernel.org>; Mon, 24 May 2021 14:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81323610CE
	for <linux-mmc@archiver.kernel.org>; Mon, 24 May 2021 14:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbhEXONX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 24 May 2021 10:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233068AbhEXONK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 24 May 2021 10:13:10 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DCCDC061344
        for <linux-mmc@vger.kernel.org>; Mon, 24 May 2021 07:11:38 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id w33so32919132lfu.7
        for <linux-mmc@vger.kernel.org>; Mon, 24 May 2021 07:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2XYL8Bw8Ui8YkIQlQTJti/dfc11C12H26WrALkHSRnk=;
        b=kWENuBc8oPZ53edo17M+ZVof9HHcIEWVKvnCiXHth2S9UHktJzHyZKHLxXtyRo3WCx
         Cqghvv2YS98jkjNt+Vt3mAdX17jmrim46fBq6DReBVkjEl67gKpkuYcSvPpvAuTLlE+z
         nHOkcFWNwzQEsc30a0krrllHQ/FVSntXWwQmWXO9fZEnrwK4Y+xvUZptb93q1fQXLuPm
         8U4xWFUMBTxzLrZ8ppMUqG5fem8Vk2R0D3Dm1OGT4N5Xu/SYJerwMnOQVNPaR7XaFCUw
         4OROTwamAmqugpqfIX3UIuvZ4or4Gs4cQy3CNuIYkFghXt39uABaJpk99IQjKhl4OXaG
         B4IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2XYL8Bw8Ui8YkIQlQTJti/dfc11C12H26WrALkHSRnk=;
        b=LgiDw5cd3LSq36EU2Muclybg596fQt5X4r4amFv9QqJ/yRgcWNW9wMMyRwYZnHkx2y
         YrdvWggp+9jBW8JPpBf6O0zM3ngP4kddsbZ0bQ7NsysRBUdbxc7kwLQrf5uMR1/4YmPq
         HBCUYJRu2lzPV4Yj/RJEziQFGXc4xxXP/FbYEAkpNclRrBQi27279+ziX/nv7ULxDXp1
         IH9xF8yhrgh2zDGTFhA1t/m9p7AzYukBLFEklWTnsFZHwhIuOfWSxO1P76QxUM48zZw+
         JTfaHY0gpmMn++PTS50IE6OnQ+yuKFv1Kwt4PrWGHbjoI8PeiWskLp9CvQ3XRAU7SblO
         GqkA==
X-Gm-Message-State: AOAM533rV9rPiGXAb+eNghYwvtID4VyHIjTBU072C2Xenz7uQnbXaa/S
        0bDZk0gniH3AOqM9s4rJvTziSMinkuKsDvgOi87jUtpyw4gnXw==
X-Google-Smtp-Source: ABdhPJxrkPyvodEQM2Koiqen+FWoeN/4o0wqkp6rZVF4idauvZzMjLFIzXWJRrFuNvh/SStEjCN65FxO7pYk/wP9Jr8=
X-Received: by 2002:ac2:592a:: with SMTP id v10mr10704278lfi.400.1621865496563;
 Mon, 24 May 2021 07:11:36 -0700 (PDT)
MIME-Version: 1.0
References: <1621558965-34077-1-git-send-email-tiantao6@hisilicon.com>
In-Reply-To: <1621558965-34077-1-git-send-email-tiantao6@hisilicon.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 24 May 2021 16:10:57 +0200
Message-ID: <CAPDyKFq9_em1+3LBQp7TMJwzZk07sX9WSsbvhxVaR2eA0LoakQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-omap: Use pm_runtime_resume_and_get() to
 replace open coding
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     Kishon <kishon@ti.com>, Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 21 May 2021 at 03:02, Tian Tao <tiantao6@hisilicon.com> wrote:
>
> use pm_runtime_resume_and_get() to replace pm_runtime_get_sync and
> pm_runtime_put_noidle. this change is just to simplify the code, no
> actual functional changes.
>
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-omap.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
> index 7893fd3..8f4d1f0 100644
> --- a/drivers/mmc/host/sdhci-omap.c
> +++ b/drivers/mmc/host/sdhci-omap.c
> @@ -1173,10 +1173,9 @@ static int sdhci_omap_probe(struct platform_device *pdev)
>          * as part of pm_runtime_get_sync.
>          */
>         pm_runtime_enable(dev);
> -       ret = pm_runtime_get_sync(dev);
> -       if (ret < 0) {
> +       ret = pm_runtime_resume_and_get(dev);
> +       if (ret) {
>                 dev_err(dev, "pm_runtime_get_sync failed\n");
> -               pm_runtime_put_noidle(dev);
>                 goto err_rpm_disable;
>         }
>
> --
> 2.7.4
>
