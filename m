Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5074C43460
	for <linux-mmc@archiver.kernel.org>; Thu, 15 Apr 2021 12:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70B9D613C0
	for <linux-mmc@archiver.kernel.org>; Thu, 15 Apr 2021 12:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232694AbhDOMDq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 15 Apr 2021 08:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232524AbhDOMDp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Apr 2021 08:03:45 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8367EC06175F
        for <linux-mmc@vger.kernel.org>; Thu, 15 Apr 2021 05:03:21 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id s184so1639201vss.5
        for <linux-mmc@vger.kernel.org>; Thu, 15 Apr 2021 05:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OUz3HXaBkVj8VSFrQQ9X5yODbbRw47llRPRWGnTEIRM=;
        b=BCbXhBQ+y5EXL6VEc3xYmNMhyLYVoqhZLtvDMJZ+Vhoatu8xnCZpCueqDnrkF+JU0T
         VLpNn4fefD43r5l613XegE+0bNV0J/tBn6X79BPjqehuF8WIwVvg3W0zaybYD1xbtFV1
         pq5nJKDayG711JKdZ1N13PiT6+JiUmDM/1GuBK6tL9DGye+Sgk/TNgSZPGMjbQZATB5i
         PjGLI/cnX3vSpfvycwIJn4VHG0LCmDemHv3AyqFfgLEftnVFnNstDdPEK8pxSEpyyL/Y
         M2EOmKDC0G7sZ7V3GTt0Dzm2nuAsuFvFzXKtKe3Xw8f4WUmR3uXbFI9Dbs4+FclvR14F
         CXLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OUz3HXaBkVj8VSFrQQ9X5yODbbRw47llRPRWGnTEIRM=;
        b=QHLCZZvgE0+TiqhnkKRxLa6B/bVWhSPqxLk4Q6eQqFezgx5zXJhUgDwxVmVYADcO/o
         SGwkG2Uei0doAvcziJaPkNplC6nlOoa+gW8WPDykE4D6Lh6og0RX256zqeY5/xa0Wh+t
         sLdnDArgp3mr5sSKK2NmgySdalfUuuKE0qmtD156RD5/+TqzH9gA7U7jWMglxm3t3ba1
         cnO6nhbL5a+exkYc6nYxhglmr4cnAm3avZFkOLz69eQVy9C7cUprt381fKqdn5hao3N6
         zjl8ijIRhB+yfb0vlFgu++yllRMNNXUNHoWkVQ5QTgSKu+b7Pn6CZ9Z+u2Oiycp5Xq6Y
         79lA==
X-Gm-Message-State: AOAM532I9meM5nqXG1cbOSUkqaZHff6KE1KwyMmO7WkolJayn1xA4N42
        sDLnx2zPuradltM5yP3MgzQO3sh8Wy/vapjy1hpe8w==
X-Google-Smtp-Source: ABdhPJzYrV95ZwIOxPy47s7byHeTNiu15hRx32Un8/nA7FoJkRZAcaROnIkGe4eFSoRGPNJOw/gzmosNAgxB2KAH/Vw=
X-Received: by 2002:a05:6102:21d1:: with SMTP id r17mr1484367vsg.19.1618488200756;
 Thu, 15 Apr 2021 05:03:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210415084412.51125-1-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20210415084412.51125-1-krzysztof.kozlowski@canonical.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 15 Apr 2021 14:02:43 +0200
Message-ID: <CAPDyKFqpLAie9kP1Z2WXCzAaZZv7xJuE62ObGL2nD+owOLzuxA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] mmc: sdhci-s3c: simplify getting of_device_id
 match data
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Ben Dooks <ben-linux@fluff.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 15 Apr 2021 at 10:44, Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> Use of_device_get_match_data() to make the code slightly smaller and to
> remove the of_device_id table forward declaration.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Applied for next, thanks!

Kind regards
Uffe


>
> ---
>
> Changes since v1:
> 1. Rewrite the commit msg as it is not a NULL pointer dereference.
> ---
>  drivers/mmc/host/sdhci-s3c.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index f48a788a9d3d..8e1dca625620 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -20,6 +20,7 @@
>  #include <linux/gpio.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/of_device.h>
>  #include <linux/of_gpio.h>
>  #include <linux/pm.h>
>  #include <linux/pm_runtime.h>
> @@ -461,19 +462,12 @@ static int sdhci_s3c_parse_dt(struct device *dev,
>  }
>  #endif
>
> -#ifdef CONFIG_OF
> -static const struct of_device_id sdhci_s3c_dt_match[];
> -#endif
> -
>  static inline struct sdhci_s3c_drv_data *sdhci_s3c_get_driver_data(
>                         struct platform_device *pdev)
>  {
>  #ifdef CONFIG_OF
> -       if (pdev->dev.of_node) {
> -               const struct of_device_id *match;
> -               match = of_match_node(sdhci_s3c_dt_match, pdev->dev.of_node);
> -               return (struct sdhci_s3c_drv_data *)match->data;
> -       }
> +       if (pdev->dev.of_node)
> +               return (struct sdhci_s3c_drv_data *)of_device_get_match_data(&pdev->dev);
>  #endif
>         return (struct sdhci_s3c_drv_data *)
>                         platform_get_device_id(pdev)->driver_data;
> --
> 2.25.1
>
