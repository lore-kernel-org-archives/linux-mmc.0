Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC1FEC433E0
	for <linux-mmc@archiver.kernel.org>; Thu, 11 Mar 2021 10:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A71B64E67
	for <linux-mmc@archiver.kernel.org>; Thu, 11 Mar 2021 10:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbhCKK6J (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 11 Mar 2021 05:58:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232544AbhCKK5k (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 11 Mar 2021 05:57:40 -0500
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3214C061574
        for <linux-mmc@vger.kernel.org>; Thu, 11 Mar 2021 02:57:39 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id g7so462892uab.12
        for <linux-mmc@vger.kernel.org>; Thu, 11 Mar 2021 02:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VhCbRq6AtdBjwnonZsJCwx9bYEGLYFxfv2gxi80ch5g=;
        b=A2FKRP/DcTnXGGgsgddrySXuzsbPZRlNQhQF3iwzKnBnE8ZwwbZxalj5RUy8f6s3Gf
         FL2z8W7tqUSj9r7w4514AUhGbgmXHASELTA21v72joswHcSvFbmagXJqL+IAAeCj9rh0
         fqCd6GB9IGngabrbDCNNJr4N/HAFTPqHIPRUqZrmZ8LZ0ZY16S+qLmltKC2CxbG43ad2
         0mPrPMDt9Z8XU+wpWaJmmRN+FBCBLpiN9JMHWOuOyJBykDgn1MeKgeavq6xm+185izn6
         sPI5FZB8voNHacbM9a67BsE6kE/HtnzOGzdhXiVA8CNHtbUKlDlXJJ+qY7s+AyIs2+j1
         1xMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VhCbRq6AtdBjwnonZsJCwx9bYEGLYFxfv2gxi80ch5g=;
        b=DrSNmoXudCVAm6dEZxIJHUeC+PveIwAX94DIeIKhxOiaouWxLsPjOFiAOPE7LF2cxm
         ot7dH58cX16HgVPgt7kSSPH9WMmf+fjuLtJjFzWwqErgKAcAI9PS0c7KVUDNKhOZG8Dl
         lH/uwmhETpt97lP2oXaJwah331QYCqBwG7qt/3NittHsFSaBbgVMicyjgf2H033D6oPt
         1vFSZNpWOyGNRreCw2rXi9wr5aGuHkWjYe1uESAQmPBpkEH1/jHOXAJgMy3V8Z2Tcw5W
         YmnA4Evw63nvHeLBy4dh+oPYESzun9hW/2Q9L3qJ3YezgupJx6qxUnxma1GMrxEYQ3Nh
         TnWg==
X-Gm-Message-State: AOAM533w49YkJpE9SSxE26w2ZkqGb4bKquHs3CHmfz4JIm3PDsBYZCLe
        qxB7TiGdXbwOEXOkS0qGyjwT1FsNU7S1tdeiZhcZnA==
X-Google-Smtp-Source: ABdhPJxl0wiLbT5XKYx2OeE/0A/5dFP0opQRgr3W0U++as0oWRsXChTpziQMmVfwKcM2e7/2scZBIf40nDgtrdIfhxw=
X-Received: by 2002:a9f:3546:: with SMTP id o64mr4683366uao.129.1615460259190;
 Thu, 11 Mar 2021 02:57:39 -0800 (PST)
MIME-Version: 1.0
References: <20210311174046.597d1951@xhacker.debian>
In-Reply-To: <20210311174046.597d1951@xhacker.debian>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 11 Mar 2021 11:57:03 +0100
Message-ID: <CAPDyKFpUM+Xpui3e8Ft2C1KpWEmR33QT-wERo33vmEJp0Grrbw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci: Use "mmc" directly rather than "host->mmc"
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 11 Mar 2021 at 10:40, Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:
>
> Clean up the code to use the "mmc" directly instead of "host->mmc".
> If the code sits in hot code path, this clean up also brings trvial
> performance improvement. Take the sdhci_post_req() for example:
>
> before the patch:
>      ...
>      8d0:       a9be7bfd        stp     x29, x30, [sp, #-32]!
>      8d4:       910003fd        mov     x29, sp
>      8d8:       f9000bf3        str     x19, [sp, #16]
>      8dc:       f9400833        ldr     x19, [x1, #16]
>      8e0:       b9404261        ldr     w1, [x19, #64]
>      8e4:       34000161        cbz     w1, 910 <sdhci_post_req+0x50>
>      8e8:       f9424400        ldr     x0, [x0, #1160]
>      8ec:       d2800004        mov     x4, #0x0                        // #0
>      8f0:       b9401a61        ldr     w1, [x19, #24]
>      8f4:       b9403262        ldr     w2, [x19, #48]
>      8f8:       f9400000        ldr     x0, [x0]
>      8fc:       f278003f        tst     x1, #0x100
>      900:       f9401e61        ldr     x1, [x19, #56]
>      904:       1a9f17e3        cset    w3, eq  // eq = none
>      908:       11000463        add     w3, w3, #0x1
>      90c:       94000000        bl      0 <dma_unmap_sg_attrs>
>      ...
>
> After the patch:
>      ...
>      8d0:       a9be7bfd        stp     x29, x30, [sp, #-32]!
>      8d4:       910003fd        mov     x29, sp
>      8d8:       f9000bf3        str     x19, [sp, #16]
>      8dc:       f9400833        ldr     x19, [x1, #16]
>      8e0:       b9404261        ldr     w1, [x19, #64]
>      8e4:       34000141        cbz     w1, 90c <sdhci_post_req+0x4c>
>      8e8:       b9401a61        ldr     w1, [x19, #24]
>      8ec:       d2800004        mov     x4, #0x0                        // #0
>      8f0:       b9403262        ldr     w2, [x19, #48]
>      8f4:       f9400000        ldr     x0, [x0]
>      8f8:       f278003f        tst     x1, #0x100
>      8fc:       f9401e61        ldr     x1, [x19, #56]
>      900:       1a9f17e3        cset    w3, eq  // eq = none
>      904:       11000463        add     w3, w3, #0x1
>      908:       94000000        bl      0 <dma_unmap_sg_attrs>
>      ...
>
> We saved one ldr instruction: "ldr     x0, [x0, #1160]"

Nice!

Even if I think the cleanup of code makes sense alone.

>
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>  drivers/mmc/host/sdhci.c | 33 ++++++++++++++++-----------------
>  1 file changed, 16 insertions(+), 17 deletions(-)
>

[...]

> @@ -2489,14 +2489,14 @@ void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable)
>         unsigned long flags;
>
>         if (enable)
> -               pm_runtime_get_noresume(host->mmc->parent);
> +               pm_runtime_get_noresume(mmc->parent);

Maybe use mmc_dev(mmc) instead? At least I think I would appreciate
consistency in the entire c-file, today it seems like both
"mmc->parent" and mmc_dev(mmc) are being used.

[...]

Kind regards
Uffe
