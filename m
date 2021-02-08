Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C343AC433DB
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Feb 2021 12:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82C7F64E27
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Feb 2021 12:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbhBHMKi (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 8 Feb 2021 07:10:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233567AbhBHMIj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Feb 2021 07:08:39 -0500
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2361C061797
        for <linux-mmc@vger.kernel.org>; Mon,  8 Feb 2021 04:07:33 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id f10so1406747uaa.8
        for <linux-mmc@vger.kernel.org>; Mon, 08 Feb 2021 04:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fnWP5XVMnr/gaD9t7Bquau7AE4TzVEi+aJ7kL2wNzyE=;
        b=d87iCQfD/721FS7yUDY6GMFelkMdsrjVU3C1dvsQ7eL9rNN/Z+VtlXsbD5T6hjZZ95
         30svbw3VkZTHxg9fk7Vq2B4no41+UyYARuwV5pkPBn8qevxMND7Dj+IZFZcZyOOCX7Kr
         8I0/wbqhRz/pgd3IF/vg0MM868xPUNyV2uaH5MoXjxacOnhVUMeAK8BvmijrmVCsYpcF
         HlCLX3AuC6kIUnZMMh8Q4rRaS2kK+TyqNw+j4hAmhvIx6nLbWneklQu9BXuSUsBO1siV
         1KU336KL6TgAGczhyzaomH2zSgnQZzB45bqxK/OXhinQc+vTdLBx2604PzDDUGY4wFWG
         65yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fnWP5XVMnr/gaD9t7Bquau7AE4TzVEi+aJ7kL2wNzyE=;
        b=iWZcWJNamLqZF0BopMtH0geIBz2QrkxMn0PglljNUNqLo+xMri2E862so9xljIAP8A
         mItoSwyoXaZHRYTUbFagyPAL0LYKeMS1sBSq+/DQm1Ev76Uv8rgwA7n0FINk62HBWoMV
         zKLZ9hwAKjjAwLQBRJV7x5y/rbOG5PkRL/RLPngAaDw7W1yfj5XcLRgElO0gallMbvyO
         oF9KSJLJ6dy9SJB1pT1yvspSf2xtytdHFCEI78McNhEJ7muj+r9iur+KUyOfNV39s3OD
         4Yq8RtvyZ6UYuuPUfzKqcybZP8m04Wo9YU2VaFR/BRwg3C8CedUtFO1xhOb3qd8URsRa
         IIJA==
X-Gm-Message-State: AOAM5303PYRt17gEheSwBhVNhzPgTgJSaErMXRv6w21UF3MfpLNj4CUB
        TnBYIYfTDRNrCYI35EATT1MM1eNpUH9+g7QIXOaLwg==
X-Google-Smtp-Source: ABdhPJzUIgW4GliFuC/xzGpbGIv9yT3FBDhE3PrPHgTY5ajw6dmBq4oL6Y6tpVHfx6azRNRRclNqU7IqVevpWWzfu+E=
X-Received: by 2002:ab0:2e8d:: with SMTP id f13mr9564324uaa.15.1612786053154;
 Mon, 08 Feb 2021 04:07:33 -0800 (PST)
MIME-Version: 1.0
References: <1612422438-32525-1-git-send-email-tanxiaofei@huawei.com>
In-Reply-To: <1612422438-32525-1-git-send-email-tanxiaofei@huawei.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 8 Feb 2021 13:06:57 +0100
Message-ID: <CAPDyKFpUSKJObVk49WSqDMkrcBp6s3bRpQR4kwntO0cFXue-Bw@mail.gmail.com>
Subject: Re: [PATCH] mmc: cavium: Replace spin_lock_irqsave with spin_lock in
 hard IRQ
To:     Xiaofei Tan <tanxiaofei@huawei.com>
Cc:     rric@kernel.org, Rui Miguel Silva <rmfrfs@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxarm@openeuler.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 4 Feb 2021 at 08:09, Xiaofei Tan <tanxiaofei@huawei.com> wrote:
>
> It is redundant to do irqsave and irqrestore in hardIRQ context, where
> it has been in a irq-disabled context.
>
> Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/cavium.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/cavium.c b/drivers/mmc/host/cavium.c
> index c5da3aa..4bb8f28 100644
> --- a/drivers/mmc/host/cavium.c
> +++ b/drivers/mmc/host/cavium.c
> @@ -436,12 +436,11 @@ irqreturn_t cvm_mmc_interrupt(int irq, void *dev_id)
>  {
>         struct cvm_mmc_host *host = dev_id;
>         struct mmc_request *req;
> -       unsigned long flags = 0;
>         u64 emm_int, rsp_sts;
>         bool host_done;
>
>         if (host->need_irq_handler_lock)
> -               spin_lock_irqsave(&host->irq_handler_lock, flags);
> +               spin_lock(&host->irq_handler_lock);
>         else
>                 __acquire(&host->irq_handler_lock);
>
> @@ -504,7 +503,7 @@ irqreturn_t cvm_mmc_interrupt(int irq, void *dev_id)
>                 host->release_bus(host);
>  out:
>         if (host->need_irq_handler_lock)
> -               spin_unlock_irqrestore(&host->irq_handler_lock, flags);
> +               spin_unlock(&host->irq_handler_lock);
>         else
>                 __release(&host->irq_handler_lock);
>         return IRQ_RETVAL(emm_int != 0);
> --
> 2.8.1
>
