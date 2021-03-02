Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B70EAC43331
	for <linux-mmc@archiver.kernel.org>; Wed,  3 Mar 2021 01:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F3F264E60
	for <linux-mmc@archiver.kernel.org>; Wed,  3 Mar 2021 01:51:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237640AbhCCBoF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 2 Mar 2021 20:44:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239099AbhCBKkN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Mar 2021 05:40:13 -0500
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8132C0617A9
        for <linux-mmc@vger.kernel.org>; Tue,  2 Mar 2021 02:39:22 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id 101so143694uag.1
        for <linux-mmc@vger.kernel.org>; Tue, 02 Mar 2021 02:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Umhvl4bq+upwhpgsDahvWiFLVfJYEzzIi8Pp8HB1UCU=;
        b=OQG3lH5wODLrZdv+wguq1ZV0/ouPrqhe3yjBzS5zIDZ9Z3IP+ASIFxVf+INdGRUEKQ
         2/twk8qhoUJem5qqPWeeh5b74/yj2selF5wiJ4HmR9mo8H0T50wrgDxAqWRrGVgfcvUV
         VngPYDvdzNKKI71OQE1LDYEt9UQyRTASDZTYp6vXooGlDnbSU4rNy9sHsEX4eORftUHY
         YnCyFFsI1E+85nKfV4oehVPQEgcBTOfUJzuXn+8QpCKNsJVsgjL+wAmq9XmN8LVmZQdq
         Ke/iqI6p0/62buAnjIu5ZAAFafN8r/gikx0YnzlmndlYxofqONVdOr86VCFm4G998eQi
         g2Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Umhvl4bq+upwhpgsDahvWiFLVfJYEzzIi8Pp8HB1UCU=;
        b=SKll6NORtfKuNxuYxuGLXHi1Ijiwnj2p6ZzBK/WadxJqqIXVovd0QhqFES1k6BFkPv
         02Krt6ms06PMugTW6BKq9EtzN0SgUOWzeQXjGrsYGm78SXIXaKF2UrjVfaCd0FaFH+px
         g7MnYDm/AEX236uYuNR/10fejSus5ldytGrU+3PNV5vr1tu5H32gUEtqFDF4ye8TYg8N
         wZ0daE9e9ZJakQHxNEZvXfGECHC1LtIUAOblbMK0jr/i4dexS8tn9lAKtph67LOHH9ml
         8NwXmzzmlkLBTPhnNp0gy9BXj28E9Qe5bzpWz9qbrtNTJKQhgm7aZUuFRTxKcSOkAd3w
         oRYw==
X-Gm-Message-State: AOAM531i8MtuCGrWDZuk7kTCmZxW2DTSguB9P6OgJZFPKQop9UIGvvb4
        0A2Rc2UnVFQI4UyggfzswN2XCH5j7zbvtLpkj+bGDQ==
X-Google-Smtp-Source: ABdhPJzEyACksmZlApWoBwwWgL7AzKp9cesm9Vy9z6W3q1lFtagYm5gc2fmXlNs/auwZp9RnR9QdnP8r6zx/hInmD3k=
X-Received: by 2002:ab0:6045:: with SMTP id o5mr10027474ual.100.1614681562074;
 Tue, 02 Mar 2021 02:39:22 -0800 (PST)
MIME-Version: 1.0
References: <20210215015116.1355-1-zbestahu@gmail.com>
In-Reply-To: <20210215015116.1355-1-zbestahu@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 2 Mar 2021 11:38:44 +0100
Message-ID: <CAPDyKFrNBPUdU772EFhcodbu6Mnhv+KmfV6E1oNau1xOooNf8A@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Reduce code duplication to mmc_spi_send_{csd|cid}
To:     Yue Hu <zbestahu@gmail.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yue Hu <huyue2@yulong.com>, zhangwen@yulong.com,
        zbestahu@163.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 15 Feb 2021 at 02:51, Yue Hu <zbestahu@gmail.com> wrote:
>
> From: Yue Hu <huyue2@yulong.com>
>
> mmc_spi_send_{csd|cid} have similar function body. Let's remove the
> duplicated part to simplify the code, just add opcode to distinguish
> them in changed mmc_spi_send_cxd().
>
> Signed-off-by: Yue Hu <huyue2@yulong.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/mmc_ops.c | 39 +++++++++------------------------------
>  1 file changed, 9 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index 265d95e..f413474 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -296,61 +296,40 @@ int mmc_set_relative_addr(struct mmc_card *card)
>         return 0;
>  }
>
> -static int mmc_spi_send_csd(struct mmc_host *host, u32 *csd)
> +static int mmc_spi_send_cxd(struct mmc_host *host, u32 *cxd, u32 opcode)
>  {
>         int ret, i;
> -       __be32 *csd_tmp;
> +       __be32 *cxd_tmp;
>
> -       csd_tmp = kzalloc(16, GFP_KERNEL);
> -       if (!csd_tmp)
> +       cxd_tmp = kzalloc(16, GFP_KERNEL);
> +       if (!cxd_tmp)
>                 return -ENOMEM;
>
> -       ret = mmc_send_cxd_data(NULL, host, MMC_SEND_CSD, csd_tmp, 16);
> +       ret = mmc_send_cxd_data(NULL, host, opcode, cxd_tmp, 16);
>         if (ret)
>                 goto err;
>
>         for (i = 0; i < 4; i++)
> -               csd[i] = be32_to_cpu(csd_tmp[i]);
> +               cxd[i] = be32_to_cpu(cxd_tmp[i]);
>
>  err:
> -       kfree(csd_tmp);
> +       kfree(cxd_tmp);
>         return ret;
>  }
>
>  int mmc_send_csd(struct mmc_card *card, u32 *csd)
>  {
>         if (mmc_host_is_spi(card->host))
> -               return mmc_spi_send_csd(card->host, csd);
> +               return mmc_spi_send_cxd(card->host, csd, MMC_SEND_CSD);
>
>         return mmc_send_cxd_native(card->host, card->rca << 16, csd,
>                                 MMC_SEND_CSD);
>  }
>
> -static int mmc_spi_send_cid(struct mmc_host *host, u32 *cid)
> -{
> -       int ret, i;
> -       __be32 *cid_tmp;
> -
> -       cid_tmp = kzalloc(16, GFP_KERNEL);
> -       if (!cid_tmp)
> -               return -ENOMEM;
> -
> -       ret = mmc_send_cxd_data(NULL, host, MMC_SEND_CID, cid_tmp, 16);
> -       if (ret)
> -               goto err;
> -
> -       for (i = 0; i < 4; i++)
> -               cid[i] = be32_to_cpu(cid_tmp[i]);
> -
> -err:
> -       kfree(cid_tmp);
> -       return ret;
> -}
> -
>  int mmc_send_cid(struct mmc_host *host, u32 *cid)
>  {
>         if (mmc_host_is_spi(host))
> -               return mmc_spi_send_cid(host, cid);
> +               return mmc_spi_send_cxd(host, cid, MMC_SEND_CID);
>
>         return mmc_send_cxd_native(host, 0, cid, MMC_ALL_SEND_CID);
>  }
> --
> 1.9.1
>
