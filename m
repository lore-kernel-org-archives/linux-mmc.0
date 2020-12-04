Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81328C4361A
	for <linux-mmc@archiver.kernel.org>; Fri,  4 Dec 2020 14:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4440F22B3A
	for <linux-mmc@archiver.kernel.org>; Fri,  4 Dec 2020 14:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgLDOjR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 4 Dec 2020 09:39:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729548AbgLDOjR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Dec 2020 09:39:17 -0500
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1338EC061A4F
        for <linux-mmc@vger.kernel.org>; Fri,  4 Dec 2020 06:38:37 -0800 (PST)
Received: by mail-vs1-xe44.google.com with SMTP id s85so3362081vsc.3
        for <linux-mmc@vger.kernel.org>; Fri, 04 Dec 2020 06:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s+k/mSBFJsFZ7HojuNLekbONO81rNKh6OE3AXV7Cz3s=;
        b=diyIsFMce4Kl/wHn0z8OHL9U5VmCbU223rL9b+pJu84J01GZsHzwmVwe19I8bzqU9/
         YQJqwejUUk3PGWksHEkIS2DHaO3/VrQDEFDv9O1jnEgeRqQwpFOiWz70892/likQOuxS
         JXPGdY8pPzqXQ4qhrP/6U/xRs9g248bIC9/EeCf91YuFwhsz7JOCJgw44bOSQtGWOMWg
         zgrDrV+0YWB9/wwHoSOiO65jasNG40gYkUDGveHaf0NSyse8aZ9wKyQ+u9X5cHgHq6ZS
         QmjaoBBXn6iU4dB8zBO7CnEViUSmR77KX0YhZQhfeL5SEcb7kCrH8hD66jazsaHKflBC
         Vt1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s+k/mSBFJsFZ7HojuNLekbONO81rNKh6OE3AXV7Cz3s=;
        b=KJKavuULptgXKzrbs6Q9XQqlRiFYBTgtvqslT6cmKZNvx4DdkL5I1kOm9O2t7AOY2c
         +IY6zjJ/mlRR5DmzMOz5awgsQDFAuNkmHFbQkvdU1bHT1fqEaY6zp36+5LZn/lF+3LL3
         BkQWVtgDSsSLbROJncWSQ7h8zO6sYKBV+2lwbHdDdtQQ7A/Da9igpHsO8DSMaztQ/9tL
         tqt9Z9se2sgX6KQ1H25A84f/FdxyCJL7VgqtpVsksnKG+6ud+dmwgwELg9PtVf1RUOf/
         emNFjrjH5MHMj7OvGwbg5JujT+1ueOp/CNRFWWkiXRGWs5MLGtGeavSLBVdvv6JpLaI7
         YNhg==
X-Gm-Message-State: AOAM5319AjLtfRAU9ysWhSQ3en1VKgFYXMhCuuq1G56bjmTpdWCih6xt
        FtxxpbcCaOJCupP6kVcmRQV8PK1KFLKbs74HNh+GvKZBWuQUmQ==
X-Google-Smtp-Source: ABdhPJxI1UmekGI0M6WigcT4Jc3tSkI5Vwd0Ihg7DLTcTKdoqPWhiDKv+o83pwBX12J10QuGp4Oio8uDnyZNZvrOVd8=
X-Received: by 2002:a05:6102:2127:: with SMTP id f7mr3961164vsg.48.1607092715668;
 Fri, 04 Dec 2020 06:38:35 -0800 (PST)
MIME-Version: 1.0
References: <20201125014718.153563-1-jingxiangfeng@huawei.com>
In-Reply-To: <20201125014718.153563-1-jingxiangfeng@huawei.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 4 Dec 2020 15:37:58 +0100
Message-ID: <CAPDyKFqJY5ezi=74RgMAMF+AmuH1R+ZQngvg24jWH0-dRsPspA@mail.gmail.com>
Subject: Re: [PATCH] memstick: r592: Fix error return in r592_probe()
To:     Jing Xiangfeng <jingxiangfeng@huawei.com>
Cc:     Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 25 Nov 2020 at 02:43, Jing Xiangfeng <jingxiangfeng@huawei.com> wrote:
>
> Fix to return a error code from the error handling case instead of 0.
>
> Fixes: 926341250102 ("memstick: add driver for Ricoh R5C592 card reader")
> Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/memstick/host/r592.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/memstick/host/r592.c b/drivers/memstick/host/r592.c
> index dd3a1f3dcc19..d2ef46337191 100644
> --- a/drivers/memstick/host/r592.c
> +++ b/drivers/memstick/host/r592.c
> @@ -759,8 +759,10 @@ static int r592_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>                 goto error3;
>
>         dev->mmio = pci_ioremap_bar(pdev, 0);
> -       if (!dev->mmio)
> +       if (!dev->mmio) {
> +               error = -ENOMEM;
>                 goto error4;
> +       }
>
>         dev->irq = pdev->irq;
>         spin_lock_init(&dev->irq_lock);
> @@ -786,12 +788,14 @@ static int r592_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>                 &dev->dummy_dma_page_physical_address, GFP_KERNEL);
>         r592_stop_dma(dev , 0);
>
> -       if (request_irq(dev->irq, &r592_irq, IRQF_SHARED,
> -                         DRV_NAME, dev))
> +       error = request_irq(dev->irq, &r592_irq, IRQF_SHARED,
> +                         DRV_NAME, dev);
> +       if (error)
>                 goto error6;
>
>         r592_update_card_detect(dev);
> -       if (memstick_add_host(host))
> +       error = memstick_add_host(host);
> +       if (error)
>                 goto error7;
>
>         message("driver successfully loaded");
> --
> 2.22.0
>
