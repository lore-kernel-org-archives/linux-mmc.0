Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 977C4C433EF
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Sep 2021 18:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 831D761211
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Sep 2021 18:50:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242807AbhIWSv4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 23 Sep 2021 14:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242758AbhIWSvz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Sep 2021 14:51:55 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A140C06175F
        for <linux-mmc@vger.kernel.org>; Thu, 23 Sep 2021 11:50:23 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id x27so29953564lfu.5
        for <linux-mmc@vger.kernel.org>; Thu, 23 Sep 2021 11:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EC54pajHK/jhlrdoN2LrjDzAGYxPUaeJq5OMKjryfSg=;
        b=vW/lzrxVF8zErmZtVvjvbsNDCl4vWGKYJu7yJFDL+qpobc/I9BCxGyrJ2EdjukmD2I
         Wbzy9Fk+OBRM64GbmcRarOBVHwRNWNrQ2f0aTRvO+S6GiOB86XnWUpbcbyfCox71u8Ug
         jUoN8DKTlDCWcvCldOCEEB8p/iEwO/4dEawwJaW+zMQZtldMUHXdEh2PHFNMoA+ACsig
         yJ4fclxJ04gN5vx9W1aVh9XwKDYR/356xE5FYlvG3d/bAl0VGIxmCvHb+3Z0rS+negcV
         58nccCEDPF0qQBZyJGyfd8EUxaFWUMIjsDNePgiZooIjzz7lwvjsGRVJLuETn/VvWrKG
         LReQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EC54pajHK/jhlrdoN2LrjDzAGYxPUaeJq5OMKjryfSg=;
        b=Zw41hL9/6ly++zsYR/hb6SggNfqPx4AEfqSkNU3JJNSkIMSo2D/5fxDgwCoRPya9RQ
         gZvDWJrWKuSwVhFKxFo86Fjb3NaAY5ANuEKg83EjYJnMFAFv8fx/XJrfzTQRS66JDjhz
         wOuDgJQ8/TLpDHtn2YIYSF+ZLee7uhuNolCP6LvtzegDzMHGurxoM9+ZMmkXTJj/PvRC
         6/Vx1Of3BaNuL/aJ+uCs5Y89yN8AzDzUOaU0X0jCuEd4sD/oemTLbtloKVS9ZDXKi7oG
         xiFS96sDEF0kN6gbFvyLINDtisHdCXptIgKyQFpTHpLFEwICYYpjAFdc8styZbv12iAO
         guPA==
X-Gm-Message-State: AOAM531mdC/dCE2WiY0xKAALvZrrtw8IqS6fPFBP0nKSG4fnHAkisXr1
        D+GIlZk1f4MGsy60yU28vfMYyZ7LZs8xPL2u0xMW4Q==
X-Google-Smtp-Source: ABdhPJwaj51XOX0RgW7c4TANOs4O5F+IlhNZ0UP2bQGbrs3huRUXqsBMlwEubsE+h6f5RWfZMxc9G94gPkY6z0XV8go=
X-Received: by 2002:a05:6512:3f9f:: with SMTP id x31mr5891075lfa.233.1632423021793;
 Thu, 23 Sep 2021 11:50:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210916170511.137915-1-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20210916170511.137915-1-krzysztof.kozlowski@canonical.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 23 Sep 2021 20:49:45 +0200
Message-ID: <CAPDyKFqPfznPznCBaxK8iK+no4rtNOQOxtUFci5grQB2Qx6N0Q@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-s3c: drop unneeded MODULE_ALIAS
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Dooks <ben-linux@fluff.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 16 Sept 2021 at 19:05, Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> The MODULE_DEVICE_TABLE already creates proper alias for platform
> driver.  Having another MODULE_ALIAS causes the alias to be duplicated.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-s3c.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index 862f033d235d..9085f3932443 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -791,4 +791,3 @@ module_platform_driver(sdhci_s3c_driver);
>  MODULE_DESCRIPTION("Samsung SDHCI (HSMMC) glue");
>  MODULE_AUTHOR("Ben Dooks, <ben@simtec.co.uk>");
>  MODULE_LICENSE("GPL v2");
> -MODULE_ALIAS("platform:s3c-sdhci");
> --
> 2.30.2
>
