Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59815C43460
	for <linux-mmc@archiver.kernel.org>; Mon, 12 Apr 2021 07:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29E546135A
	for <linux-mmc@archiver.kernel.org>; Mon, 12 Apr 2021 07:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236924AbhDLHva (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 12 Apr 2021 03:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237016AbhDLHva (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Apr 2021 03:51:30 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1855CC061574
        for <linux-mmc@vger.kernel.org>; Mon, 12 Apr 2021 00:51:13 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id p206so135968vkd.4
        for <linux-mmc@vger.kernel.org>; Mon, 12 Apr 2021 00:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7VlEZih3TNHRE4EX69f5SnmwvHXFSkzmU3fsR1Oq2H4=;
        b=VLCuOb9vjJqQTWud7Qqxj1YzpwrEkGn9Vf1XTrpZUnGKyTVt4ntTXcI3Q2nsMoASNq
         VN6t6WUAnaQ7Kgxb0quCO39eFYEH/R4k12cO0viJfY3NG37Y/e2Yvzekck7Cp0AgPkhT
         aTN6jryKF4R35dBO+xOBSFRJDTM29FPGUlw1ilRRmvw0pQy8z9R2uPOn5M2cSMtlYytN
         5XRBCiHyV2jP6QpV2L/asp8B6z1qxVfr906zJf37wcPRdBgpLW9h1n/x/yvrXyRbkJhK
         UcZ6KKFsulDoikEJnSg/4jPWTc7j3UV8M4K2mzFxucvvN0Ny+m6j5O4K7K6ksHkdm+2Z
         bURg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7VlEZih3TNHRE4EX69f5SnmwvHXFSkzmU3fsR1Oq2H4=;
        b=uoBA2Hopyd7ozcmts3Ttjkc0mCTW5WHl2Ccyk9mY1R3ev39P6Su5a7YVqMRkqO+UuH
         X5Ad9M1+V04t+EuscVvwsN2nSVKz61l19i4Fl77y8vWq18XQKJbXdgk61deMuVGsFM3z
         Abd6h8jPTgkx4ZbGLe1xHf7p9OayGaX4oH7Ewb6+Z984YgpBbv/oTdHT6+hv4+LrXltw
         Npe9asxAgbE0NNz7JvyHjofwKIRgJhGYAQU5kb3fGHkEQkywoYAnHJcbevlKFdkJTgYk
         Pg6Kre71jHgKgXs654UbvzETI9VJvqGALXgIiuBMGSwXVZJnSyTOfES5t9nRhLpsw3EU
         ea/g==
X-Gm-Message-State: AOAM531L4R1pDrMC7VPNW7SSvvxDkhC9Vd+0dUvbEhjerbxL/4oCcWhZ
        V9i0Bg6nQbUwGi11VLjpa159DRdZtJZNriBq6vaeaA==
X-Google-Smtp-Source: ABdhPJysdSMbc522pPCJRjMHm0Pi4KOSvK5atjDKh5wHXXyuDpV0gRb6rsEHg7nE5IJQfpeW1zkMnkOkpdkmMkCEMfY=
X-Received: by 2002:a1f:2c58:: with SMTP id s85mr18468984vks.15.1618213872233;
 Mon, 12 Apr 2021 00:51:12 -0700 (PDT)
MIME-Version: 1.0
References: <1617765339-28946-1-git-send-email-tiantao6@hisilicon.com>
In-Reply-To: <1617765339-28946-1-git-send-email-tiantao6@hisilicon.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 12 Apr 2021 09:50:36 +0200
Message-ID: <CAPDyKFo4L4d0URRyBBj8wFnbJpaMkGrMzNQaGKFSv_PaHcz2aQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: s3cmci: move to use request_irq by IRQF_NO_AUTOEN flag
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 7 Apr 2021 at 05:15, Tian Tao <tiantao6@hisilicon.com> wrote:
>
> disable_irq() after request_irq() still has a time gap in which
> interrupts can come. request_irq() with IRQF_NO_AUTOEN flag will
> disable IRQ auto-enable because of requesting.
>
> this patch is made base on "add IRQF_NO_AUTOEN for request_irq" which
> is being merged: https://lore.kernel.org/patchwork/patch/1388765/
>
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>

FYI, I will have to wait to apply the $subject patch until the above
change (which is commit cbe16f35bee6 in linux-next) is available in an
rc.

Kind regards
Uffe


> ---
>  drivers/mmc/host/s3cmci.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
> index 0ca6f6d..8d5929a 100644
> --- a/drivers/mmc/host/s3cmci.c
> +++ b/drivers/mmc/host/s3cmci.c
> @@ -1578,17 +1578,12 @@ static int s3cmci_probe(struct platform_device *pdev)
>                 goto probe_iounmap;
>         }
>
> -       if (request_irq(host->irq, s3cmci_irq, 0, DRIVER_NAME, host)) {
> +       if (request_irq(host->irq, s3cmci_irq, IRQF_NO_AUTOEN, DRIVER_NAME, host)) {
>                 dev_err(&pdev->dev, "failed to request mci interrupt.\n");
>                 ret = -ENOENT;
>                 goto probe_iounmap;
>         }
>
> -       /* We get spurious interrupts even when we have set the IMSK
> -        * register to ignore everything, so use disable_irq() to make
> -        * ensure we don't lock the system with un-serviceable requests. */
> -
> -       disable_irq(host->irq);
>         host->irq_state = false;
>
>         /* Depending on the dma state, get a DMA channel to use. */
> --
> 2.7.4
>
