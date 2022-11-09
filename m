Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77540C4321E
	for <linux-mmc@archiver.kernel.org>; Wed,  9 Nov 2022 12:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiKIMfG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 9 Nov 2022 07:35:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiKIMfF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Nov 2022 07:35:05 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D42415A37
        for <linux-mmc@vger.kernel.org>; Wed,  9 Nov 2022 04:35:05 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id d13-20020a17090a3b0d00b00213519dfe4aso1758313pjc.2
        for <linux-mmc@vger.kernel.org>; Wed, 09 Nov 2022 04:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Kb8Oj1LHOXAmgTYP/qGGqJomjIqyXn9NNEyd61ZH96M=;
        b=Xt5yC4ScfaA4fDd1L82V9Jg8nnwXJRhVjVapCK4ybqx7Q4ULsnA1OYMSlm06UWYBsn
         OUQe1d5W9RSMv5hkjd/1VmxqAVFXbrXYrXiBAJ5Lzj2WpVxiSVAGT5VJC2gayGJp489M
         rYB/CQSYC+LTglDjTEaamiGQxAE4uhFA5c0Rq/C9AbphZakxwcmZp3wri3guOaQT/env
         cVjRWdROOa2B689Fub7MFgucTZ+Z6p7zuIPJOosj4A7phEE95SaNWGGL5CmZsSES+VQO
         /iopBc+YXLWTbVtY//edso2fPY11TzkHYmiDrAC/vCcoguRq/5pPLRjdyHXJA9lo8H/I
         ORNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kb8Oj1LHOXAmgTYP/qGGqJomjIqyXn9NNEyd61ZH96M=;
        b=I8ApMP0698dnzsu8OP9FBasUWiksw8ST0lgQjE2WipHSLrp5LWXLq9oVcDT5sKyK1F
         ItBWGoRvuZkdnXx/JKEwth56BJUg0kdIOGdRAut9uJdOfXI8txVQrD95fimLrID4HOmD
         Qi/mZSSYABACFZBAak3ycGxhj+cOw59zgINjNt0u4YcDnUIRmm0TOCYX7rFVVswcpYzb
         /kgZ2tdsmiwfg0ANAdpj2RDzgSCHZxmp/hVqzpapnDTwylD/ULdeyNWWGg4nslL6JivO
         D/atIJvj/6yfW8GPFakcpJwZBvCTINA9aGwTghHzxxTnhPYNCq6tvTpDupiBapacCfgg
         HDuQ==
X-Gm-Message-State: ACrzQf28U5ADCHzwvNcVCWNlttqRWjhyNVaNRIKvKUrBhRNeysEf2vcj
        4v4VqABisC+tJITs6pqZDp+N/glz0AQmn1k38r2hyWLZLUo=
X-Google-Smtp-Source: AMsMyM7zr1QD/3hy5ni6Z48xsKcG8RBTSUZ6gUTP37xO7SgcVHADdL3iT15YXyKYyu8Yx5QolcIJuCDDWBUvHD1Vq1c=
X-Received: by 2002:a17:903:100c:b0:186:63a1:3b5d with SMTP id
 a12-20020a170903100c00b0018663a13b5dmr61929526plb.148.1667997304558; Wed, 09
 Nov 2022 04:35:04 -0800 (PST)
MIME-Version: 1.0
References: <20221108130949.1067699-1-yangyingliang@huawei.com>
In-Reply-To: <20221108130949.1067699-1-yangyingliang@huawei.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 9 Nov 2022 13:34:28 +0100
Message-ID: <CAPDyKFqy4A5EtdkB0YdVGrpNB8xVvmBAOnmfM2KntJ_fiE8WfA@mail.gmail.com>
Subject: Re: [PATCH] mmc: via-sdmmc: fix return value check of mmc_add_host()
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-mmc@vger.kernel.org, brucechang@via.com.tw,
        HaraldWelte@viatech.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 8 Nov 2022 at 14:11, Yang Yingliang <yangyingliang@huawei.com> wrote:
>
> mmc_add_host() may return error, if we ignore its return value,
> it will lead two issues:
> 1. The memory that allocated in mmc_alloc_host() is leaked.
> 2. In the remove() path, mmc_remove_host() will be called to
>    delete device, but it's not added yet, it will lead a kernel
>    crash because of null-ptr-deref in device_del().
>
> Fix this by checking the return value and goto error path which
> will call mmc_free_host().
>
> Fixes: f0bf7f61b840 ("mmc: Add new via-sdmmc host controller driver")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/via-sdmmc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/via-sdmmc.c b/drivers/mmc/host/via-sdmmc.c
> index 88662a90ed96..a2b0d9461665 100644
> --- a/drivers/mmc/host/via-sdmmc.c
> +++ b/drivers/mmc/host/via-sdmmc.c
> @@ -1151,7 +1151,9 @@ static int via_sd_probe(struct pci_dev *pcidev,
>             pcidev->subsystem_device == 0x3891)
>                 sdhost->quirks = VIA_CRDR_QUIRK_300MS_PWRDELAY;
>
> -       mmc_add_host(mmc);
> +       ret = mmc_add_host(mmc);
> +       if (ret)
> +               goto unmap;
>
>         return 0;
>
> --
> 2.25.1
>
