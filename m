Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EB9C433E9
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jan 2021 11:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79D87233EA
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jan 2021 11:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbhAML1I (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 13 Jan 2021 06:27:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbhAML1H (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Jan 2021 06:27:07 -0500
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA39C0617BF
        for <linux-mmc@vger.kernel.org>; Wed, 13 Jan 2021 03:26:04 -0800 (PST)
Received: by mail-ua1-x931.google.com with SMTP id j59so572179uad.5
        for <linux-mmc@vger.kernel.org>; Wed, 13 Jan 2021 03:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G9uUX9S3OVX4rZ6wYRdgXrk3nCogppGF0MA8GEuY/Eo=;
        b=bU6xDgHDA03VljnUMmlniVSQL+0j8c8khXIY8SYSejm5jZmEf0DMR8cvviAekgjnpg
         8nsfnWMQcbaMrUs6k6GasTAoOuia5YOZ1iyDVWb20Cqi5YaaoCAdB7Q7lXZqdISTwRGh
         +yAr/OYyF0dQrcO6WmmvQIoSz8GX20sRUEmAqiudqFDuZ+p/kdb4XooeioD69ncGaCXK
         AGr8JTbslgrkhZikNO1rwt+OwdITR9V+it/fgPMUZhQ6Oen58zOiI4eGiAJQ/XaIlgZ0
         YHPQcCMcTH++qBKGkUpd1PYsOE9NdlPGM4QKgWk2VEWIGvkqkcnki/Xd6QQohcTIZ2fI
         fQ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G9uUX9S3OVX4rZ6wYRdgXrk3nCogppGF0MA8GEuY/Eo=;
        b=N4VaT3gyflzsyVS3U0eUubl8Hx+sxCvwGlNY+sQTbMqs8yYG8HinMKzQd3Lffu1GlZ
         sG/NHqnbJel48JwOY/zXiHX7+7kmQHGLZy8tgeglFS8Q3oYMv8PgDhWYHEd7ahiQSv0f
         FksavVFy0oTCJ9d7WnCPqDin+0AydYA+OPwIFEHZf2Qvpo3LLb/p3UYBcRnj+1FWNQoQ
         YRlMfu7T8jhj+IsatpIbMRklafQQ016k2KDS7LXYtAhw+1HzafiHX16ROyG/QZ6Qg5o1
         oWq3Te/TrnzQPiYsAnF44ul84iJCGuc36oGAw5yKC/MFwML1lGUn3dE6cPo1rKKKujvP
         7jcg==
X-Gm-Message-State: AOAM53311RXZW13r68IxV9BCy6KMG3TN6MZ6ksMMl6VIxBzKkzqnJBpH
        qLcDTVKza4JUipGBAD7ALRxN/7S6H0zJeX9/H5P/kg==
X-Google-Smtp-Source: ABdhPJzuX/Dmv6UrnVgDqjPg9laCYydPT3+Ow26Mww6AgWCZnluKMLLz+2aCvtQkShl3qtjiA+tyznGcQJytP8JGG+o=
X-Received: by 2002:ab0:4597:: with SMTP id u23mr1353390uau.100.1610537163831;
 Wed, 13 Jan 2021 03:26:03 -0800 (PST)
MIME-Version: 1.0
References: <20210107221509.6597-1-alcooperx@gmail.com>
In-Reply-To: <20210107221509.6597-1-alcooperx@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 13 Jan 2021 12:25:27 +0100
Message-ID: <CAPDyKFqK-b7B6jfhfFAwey0rs3uP=W2P9Gwt-yc0820UmypwPA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-brcmstb: Fix mmc timeout errors on S5 suspend
To:     Al Cooper <alcooperx@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 7 Jan 2021 at 23:15, Al Cooper <alcooperx@gmail.com> wrote:
>
> Commit e7b5d63a82fe ("mmc: sdhci-brcmstb: Add shutdown callback")
> that added a shutdown callback to the diver, is causing "mmc timeout"
> errors on S5 suspend. The problem was that the "remove" was queuing
> additional MMC commands after the "shutdown" and these caused
> timeouts as the MMC queues were cleaned up for "remove". The
> shutdown callback will be changed to calling sdhci-pltfm_suspend
> which should get better power savings because the clocks will be
> shutdown.
>
> Fixes: e7b5d63a82fe ("mmc: sdhci-brcmstb: Add shutdown callback")
> Signed-off-by: Al Cooper <alcooperx@gmail.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-brcmstb.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
> index bbf3496f4495..f9780c65ebe9 100644
> --- a/drivers/mmc/host/sdhci-brcmstb.c
> +++ b/drivers/mmc/host/sdhci-brcmstb.c
> @@ -314,11 +314,7 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
>
>  static void sdhci_brcmstb_shutdown(struct platform_device *pdev)
>  {
> -       int ret;
> -
> -       ret = sdhci_pltfm_unregister(pdev);
> -       if (ret)
> -               dev_err(&pdev->dev, "failed to shutdown\n");
> +       sdhci_pltfm_suspend(&pdev->dev);
>  }
>
>  MODULE_DEVICE_TABLE(of, sdhci_brcm_of_match);
> --
> 2.17.1
>
