Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B91FC6FD1D
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Mar 2023 12:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbjCWMNs (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 23 Mar 2023 08:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbjCWMNm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Mar 2023 08:13:42 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9FE234ED
        for <linux-mmc@vger.kernel.org>; Thu, 23 Mar 2023 05:13:35 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id b18so5453676ybp.1
        for <linux-mmc@vger.kernel.org>; Thu, 23 Mar 2023 05:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679573615;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QHbs0rnNZeieI4I/+z7njBcl6R6MpIcd0316GA7EDq8=;
        b=DPlkjAbo4Yl5mr6xKESFph0Zi3CIqqAuq13v8w89o9AGuE7Z3fAuMErAfPzSd5IJc6
         OmkVcToFh+y3TBHkUI+FQUPepXEwa8wzvHVjlX7+hqXYehySbcSNKYpWysAYtVpaaMfF
         JpwTbY/HOQkyiU7BdTBoxlQnRfHxadYvKU8qsFUt5RzcYtI4E7tfVwL4mrKiJJKy+6Kt
         KZEV8uc59LuvSYNILXuYumYFsbw+epMpGyhQLR/PjdEggzG2Mf1roScTsA4an1xSzFbs
         OGfCBW2r4ZbqLt8abAaeaJHwff3VjWsfk0NFR3LeZtzQeNCP5TQBati9DwkrLAjXZ602
         rBOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679573615;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QHbs0rnNZeieI4I/+z7njBcl6R6MpIcd0316GA7EDq8=;
        b=x1w/7h/tjJxXcy5gEU+6sJlGb7xDqf5bAGfcKFqLLaDiMtPORyQKuPcmSEaGbs97TN
         gxwAfSgaCiJJ307T0mUX2Spr+InHRiMMe8cvGvkziXJE5OyH+QE6HL69mhXwi9yapE5E
         MVLj6eH0LUiB5YNpUNx7G638/c8kWjtojLr74+RJQohDGsXGXm2gFqreYOtKl+lka7Md
         //VEri8PGgqTb+RCIzTPWjG6QHHm5p43q0y6XVAMJ4gIxUkMpCyW1hoO2L1V2sE7SWlL
         g30tj4lc3dbKlLZQyB4gT60HT9X+jcPr3c8VgfjrcLzGloOT1tpj7ZSi6b/5gu0REvc9
         XDLA==
X-Gm-Message-State: AAQBX9cvMxYnH3gGYYRvoOtJoPn3YZzp2slS+eEWKH8fIWxo+Iox/IGx
        c6EqRCN4ZnDickGfYxPMB4XM41KsGptLG9dmsN/ih4ccazA5mDmx
X-Google-Smtp-Source: AKy350a/EpBi14YjETGVL/MH7zuDiC8Odp9sDpzFsFQTi2EtyeR/Gz8t6w4wvGvyniowTsWkM+nSOfh9XfMpKSJf9Ow=
X-Received: by 2002:a05:6902:1689:b0:b75:8ac3:d5d9 with SMTP id
 bx9-20020a056902168900b00b758ac3d5d9mr947479ybb.3.1679573615378; Thu, 23 Mar
 2023 05:13:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230315054113.48898-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20230315054113.48898-1-yang.lee@linux.alibaba.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 23 Mar 2023 13:12:59 +0100
Message-ID: <CAPDyKFphyqEDRvmFOPdyx1uy4i7nfaoJN4usDmNf+uXuqn7Z3A@mail.gmail.com>
Subject: Re: [PATCH -next] mmc: owl-mmc: Use devm_platform_get_and_ioremap_resource()
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     afaerber@suse.de, mani@kernel.org, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 15 Mar 2023 at 06:41, Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> According to commit 890cc39a8799 ("drivers: provide
> devm_platform_get_and_ioremap_resource()"), convert
> platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/owl-mmc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/owl-mmc.c b/drivers/mmc/host/owl-mmc.c
> index 3dc143b03939..6f9d31a886ba 100644
> --- a/drivers/mmc/host/owl-mmc.c
> +++ b/drivers/mmc/host/owl-mmc.c
> @@ -578,8 +578,7 @@ static int owl_mmc_probe(struct platform_device *pdev)
>         owl_host->mmc = mmc;
>         spin_lock_init(&owl_host->lock);
>
> -       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       owl_host->base = devm_ioremap_resource(&pdev->dev, res);
> +       owl_host->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
>         if (IS_ERR(owl_host->base)) {
>                 ret = PTR_ERR(owl_host->base);
>                 goto err_free_host;
> --
> 2.20.1.7.g153144c
>
