Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD78C43334
	for <linux-mmc@archiver.kernel.org>; Thu, 21 Jul 2022 16:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233813AbiGUQOb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 21 Jul 2022 12:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233850AbiGUQON (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Jul 2022 12:14:13 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6258875B
        for <linux-mmc@vger.kernel.org>; Thu, 21 Jul 2022 09:14:05 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id o7so3528448lfq.9
        for <linux-mmc@vger.kernel.org>; Thu, 21 Jul 2022 09:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RZ5vmU+ClA/fu/M7hswkmZ+GixSqlSovrkD7A2cfILw=;
        b=pIw6YvxKmhA7tGWpEMrpP1adj8vabPF45HxLLLgecSNQRfwMTgIc6d2n95G0yxUdnJ
         W02M7Mgxijqsp3n9cdnXs8POohwRgO/iNAVjGk/2CJts6vGGs+xRLi8tihpLKx/4Hi0C
         kc/b+c7QsUqlY+1VLpa3Th6+Dy0yRMrCaS2o10cpXCmZ1kUNZ81RsZro0owLJP6OrQZG
         RX7gUHTBzBEAKsKaG9w8aa78A7AQFD2fg+uuOqL+g7eoI980xGm1MmAl4uhc4yLOp3B5
         ZaVW8dICdQ1PIDeSNdx7IVNHHgZdDxdEq+zoSub8QW4KxDVMmWfYYbZxEvy9JE0arREj
         Plhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RZ5vmU+ClA/fu/M7hswkmZ+GixSqlSovrkD7A2cfILw=;
        b=RXQ9AjY5LxTznLQwj5mM9bc5uk2encR+otSyWMW7Hfn0/90TZfAsRH6mmfd+MeqF0B
         C5PReZjp+lUPhPm7NZQnof5YlhcJe75dECvbjM04gC3Xaf1VEFQS7RBzYneqLnjd5NS2
         Rvp2vDa2rq67LCiy7T01MEleH99ojv/sO3yWzwL5wf8z0ZJv0D/NLiFUngdCl+4A/G/s
         9+rDX7fsv9NtKBIZ+bwZMAwIp354eRfXWxAwnsC019DvRgpb7/kdR7uKWC8CL7+xXMqV
         vze+9M0iOnhbDEgFK61hTVLjeEzdfAKhTQ3giden4NY3k9urER/RD592LRtnXn17/NLj
         59YA==
X-Gm-Message-State: AJIora8jjBENvb/89sa5Pi1mcgJuTUj3cJ4amFX7b0hHkdIOnIwsJzZe
        4LN2YuEbxgRL1t8iC8fA5Js0XQuvrnHlnb47iTcyAUFtOcA=
X-Google-Smtp-Source: AGRyM1sp1aVatdZz9Hjnaiec6x634lPmgLObvQEfCUeta2YG/iuw+ZRIYM1Xi1UKptCrn2a7YfmHUv0kQON2c5E/pXg=
X-Received: by 2002:a05:6512:c0a:b0:489:cf39:d750 with SMTP id
 z10-20020a0565120c0a00b00489cf39d750mr24597555lfu.233.1658420024680; Thu, 21
 Jul 2022 09:13:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220719095216.1241601-1-windhl@126.com>
In-Reply-To: <20220719095216.1241601-1-windhl@126.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 21 Jul 2022 18:13:08 +0200
Message-ID: <CAPDyKFrtqc_JB3GSVpxP0vKQRUmRUS+rU3R0u+SR91g2-bSHTA@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: cavium-octeon: Add of_node_put() when breaking
 out of loop
To:     Liang He <windhl@126.com>
Cc:     rric@kernel.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 19 Jul 2022 at 11:52, Liang He <windhl@126.com> wrote:
>
> In octeon_mmc_probe(), we should call of_node_put() when breaking
> out of for_each_child_of_node() which has increased and decreased
> the refcount during each iteration.
>
> Fixes: 01d95843335c ("mmc: cavium: Add MMC support for Octeon SOCs.")
> Signed-off-by: Liang He <windhl@126.com>

Applied for next, thanks!

Kind regards

Ulf Hansson

> ---
>  drivers/mmc/host/cavium-octeon.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/cavium-octeon.c b/drivers/mmc/host/cavium-octeon.c
> index 2c4b2df52adb..12dca91a8ef6 100644
> --- a/drivers/mmc/host/cavium-octeon.c
> +++ b/drivers/mmc/host/cavium-octeon.c
> @@ -277,6 +277,7 @@ static int octeon_mmc_probe(struct platform_device *pdev)
>                 if (ret) {
>                         dev_err(&pdev->dev, "Error populating slots\n");
>                         octeon_mmc_set_shared_power(host, 0);
> +                       of_node_put(cn);
>                         goto error;
>                 }
>                 i++;
> --
> 2.25.1
>
