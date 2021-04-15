Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0449BC433ED
	for <linux-mmc@archiver.kernel.org>; Thu, 15 Apr 2021 12:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1C09613B6
	for <linux-mmc@archiver.kernel.org>; Thu, 15 Apr 2021 12:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbhDOMD4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 15 Apr 2021 08:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232739AbhDOMD4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Apr 2021 08:03:56 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15DFEC06175F
        for <linux-mmc@vger.kernel.org>; Thu, 15 Apr 2021 05:03:33 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id s2so7420540uap.1
        for <linux-mmc@vger.kernel.org>; Thu, 15 Apr 2021 05:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yP0jz0gWkwE8Z2s8JJsAXu8+mr7EF1nBBjJ+JwFWlP8=;
        b=uLpZrxzEdpeuw9cGVX7JzwCGHIlkkbMCfghz7I83e0yN87+IwyKf4Q5nclwCchMPyE
         tayKdLL4rXlZIG3q7KwuItxAaWaD1rQGb6TUi2iuLVwZQde4OvPUYGBC5IYuMBEfudiB
         dv4ZCxBDDP2zMlWvHlyaqouhqCvnNHL0DFe0oYMshWnyeGmxooU8bZn4HE17LS6z4Ws+
         jaBP5y6764Hz8TcUO7vhOBs2Wr+t1ZJFDbPSByc6GaLI6P1FeCO9TLEcvqK2Fhtg2PHT
         yXs/HwPjC5icGgpEtEjVoo89UE9WesoQCvlmXq67kuhzvAfERZBD2HfPIfzpgTerog90
         oySQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yP0jz0gWkwE8Z2s8JJsAXu8+mr7EF1nBBjJ+JwFWlP8=;
        b=j3r7OUb2gA8H+/+8sOMdNIqWxoIm2KMNDpjAI9ooTdX/ezUxjN1jvYa+6mXOetvFmI
         1VBos3DnUl/wSMIUwiPytQl5Hih35W+YO5wMLeZoFLwerZ44a/JhwfF6lL0TeN7kjLnD
         3n8GVZ3A3kC6OzGk34Du+mhbsD5SsXuenWoOEzkwnvVmKaW7sOJ569dHRhB+u+LWH4HB
         aQWoxZ9Y3tFo4ItwBIaa5406oDdvGzbPeUUBeExnMj/rhaVP0uuHMBYE7m/MpfzfPztb
         6fMtepkwU5tyHRNgOraWqVhliwUdP2nIQe6vNefoxtcAq0Ul8tj8zUAPeP5sOgIKZ0ZX
         SNBw==
X-Gm-Message-State: AOAM530t3tUHLYjHKKghwREXP3BizKxtmpwIXGskcO2Luw1FEU6a7Jzg
        75w3vPvSq/O5ws+zlAmQVM6HwM87dT/bHXVg1RDMzg==
X-Google-Smtp-Source: ABdhPJzVPPBgXqqGAHLGxvLYlWpW0KUEuaGUllP9CGqxUWae4Hpv3Y7hZ4LtsuEO2vPqMLHpuyRlWLYJskPJ65NAspA=
X-Received: by 2002:ab0:4322:: with SMTP id k31mr1351719uak.15.1618488207953;
 Thu, 15 Apr 2021 05:03:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210415084412.51125-1-krzysztof.kozlowski@canonical.com> <20210415084412.51125-2-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20210415084412.51125-2-krzysztof.kozlowski@canonical.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 15 Apr 2021 14:02:49 +0200
Message-ID: <CAPDyKFog3OA3YJVQ8D4mw4N5K0Mk53BWBqJEhp2+M2geueFL5w@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] mmc: sdhci-s3c: correct kerneldoc of sdhci_s3c_drv_data
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
> Correct the name of sdhci_s3c_drv_data structure in kerneldoc:
>
>   drivers/mmc/host/sdhci-s3c.c:143: warning:
>     expecting prototype for struct sdhci_s3c_driver_data. Prototype was for struct sdhci_s3c_drv_data instead
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
> Changes since v1:
> 1. None
> ---
>  drivers/mmc/host/sdhci-s3c.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index 8e1dca625620..a07a8f011741 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -130,7 +130,7 @@ struct sdhci_s3c {
>  };
>
>  /**
> - * struct sdhci_s3c_driver_data - S3C SDHCI platform specific driver data
> + * struct sdhci_s3c_drv_data - S3C SDHCI platform specific driver data
>   * @sdhci_quirks: sdhci host specific quirks.
>   * @no_divider: no or non-standard internal clock divider.
>   *
> --
> 2.25.1
>
