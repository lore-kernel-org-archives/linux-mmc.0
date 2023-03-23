Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F06C6FD1C
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Mar 2023 12:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbjCWMNq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 23 Mar 2023 08:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbjCWMNl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Mar 2023 08:13:41 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CA61EBDC
        for <linux-mmc@vger.kernel.org>; Thu, 23 Mar 2023 05:13:32 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id x198so14795766ybe.9
        for <linux-mmc@vger.kernel.org>; Thu, 23 Mar 2023 05:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679573612;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DrtQ8CwDcwRA/DKiIVaGSBD/b1SSGaInqX/K7jpVRKA=;
        b=LXcwVizvFL7SjKCXKuCoQfWAYpHOQFMIsfvaBv9J6ZIhI6mlTEb/OoL/PGa2EYhDKy
         aQNsr29CKBreYNUaDvAFNZYVQ83GbRN6+wEcg1BKTCsqEoS/1dZnpd/FxTAtaw3BK4np
         4DXFFWefgVSPCWNzoguFllSpnuEEIA6kZ9WA7WFS602rAyB2UX8afTfhNXRd7SM6+Vat
         AC8vmciKYPSiQF5/PEGpA4+iRnjwHaRE2jhB9ZmD8pMwnJhXaPqu4/lz8sQaJVhujOXp
         rvoxT99I4g/pi0v5T8Djhfz9aSpX06eQNrsM42xMbbPr4pFvchLC7xsajuWVyc19ilWz
         aQPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679573612;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DrtQ8CwDcwRA/DKiIVaGSBD/b1SSGaInqX/K7jpVRKA=;
        b=TFPX9IX5Mvjv2nHo+Vi5+MpozuU000CvFrZtI2yciU993vEW+tdkhAgKA5D6EoOukC
         Y69cr7oR8lcIryUJXBDuTaeE9PHlrztR0Sm2j7hH0vs/FiO5l9ZLKA3VlyHLG9bby8Ef
         5crLLsDN6ogWXLkHtRRCM7LHXLbp9B6wHrkvrPyTUf68+W4pREliK/zrm121UjpgLpLi
         BjcKph2/uQdE4rfL6I+loHHRzY9zQK3KbFBNCOZ2YJsaOwQTlbhSaJ4iwbA+AeKyj3TI
         dWV8NrJZxlx15axT13IrgkmQyN3PmMCUTEbrV1SGd9leAQxIQswxcoXB1RGsJNQh5HqJ
         3kJw==
X-Gm-Message-State: AAQBX9f1vaEpkRj7c4Qe2kJg88MjdlG3IZL0kCJqHjlcZ7lu2+QT8EUP
        WP8mgk+DjK6SSryu3fZZozrg/8f9hkSTVetxVzd73A==
X-Google-Smtp-Source: AKy350Y6PAngVYMC5aIvNHmGoOD2wdu03PXzck6qzjHGv4u4r/rSe3V4PKht12FdYJJ+8QYKiBvoXSmOWogaFoo1tbA=
X-Received: by 2002:a05:6902:722:b0:b68:7a4a:5258 with SMTP id
 l2-20020a056902072200b00b687a4a5258mr2072334ybt.3.1679573611981; Thu, 23 Mar
 2023 05:13:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230315055023.61779-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20230315055023.61779-1-yang.lee@linux.alibaba.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 23 Mar 2023 13:12:56 +0100
Message-ID: <CAPDyKFrcATB2qxzpkHGKD=VGK21Vr83xmHYcaX708F0Qjek4xA@mail.gmail.com>
Subject: Re: [PATCH -next] mmc: sdhci-of-aspeed: Use devm_platform_get_and_ioremap_resource()
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     adrian.hunter@intel.com, andrew@aj.id.au, oel@jms.id.au,
        linux-mmc@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 15 Mar 2023 at 06:50, Yang Li <yang.lee@linux.alibaba.com> wrote:
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
>  drivers/mmc/host/sdhci-of-aspeed.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
> index ba6677bf7372..25b4073f698b 100644
> --- a/drivers/mmc/host/sdhci-of-aspeed.c
> +++ b/drivers/mmc/host/sdhci-of-aspeed.c
> @@ -547,8 +547,7 @@ static int aspeed_sdc_probe(struct platform_device *pdev)
>                 return ret;
>         }
>
> -       sdc->res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       sdc->regs = devm_ioremap_resource(&pdev->dev, sdc->res);
> +       sdc->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &sdc->res);
>         if (IS_ERR(sdc->regs)) {
>                 ret = PTR_ERR(sdc->regs);
>                 goto err_clk;
> --
> 2.20.1.7.g153144c
>
