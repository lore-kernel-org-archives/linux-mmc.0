Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7126AC433B4
	for <linux-mmc@archiver.kernel.org>; Wed, 14 Apr 2021 15:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54697611B0
	for <linux-mmc@archiver.kernel.org>; Wed, 14 Apr 2021 15:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352044AbhDNPZt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 14 Apr 2021 11:25:49 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41629 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352037AbhDNPZt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Apr 2021 11:25:49 -0400
Received: from mail-ej1-f72.google.com ([209.85.218.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lWhOR-0003Hm-6x
        for linux-mmc@vger.kernel.org; Wed, 14 Apr 2021 15:25:27 +0000
Received: by mail-ej1-f72.google.com with SMTP id di5so552130ejc.1
        for <linux-mmc@vger.kernel.org>; Wed, 14 Apr 2021 08:25:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1gNdMZIY7k9qgwfrohIjWBJglr1iMiMfvSgX5G9T2aM=;
        b=aleMlgh9JZzSwOB3gezsrKG1BWbkLNdxmAgFf00Dx7m+UADZExbkljQfbGLGJ17JxF
         ZYvYauWxa025ImKrrpdQc6iVyokrvMajLXG3jivY1bxKH7cslAuhbpNEyUBSzOsCIyjC
         Is3zAkJajLjfj+5lvOl8quzd8PzO+T6Z0ztmgY7JudOUV1RVTiY+1o91p+1HI1fiLwsw
         VTONn3oYyflLztylrbyPBuqmWY8yAixus2NFOU7sO/CVe5/PM/lYe1n2nhtfc9BWRa3d
         ++Bcwu6v5C8l1Sj2SZPLe3H5ZKXFZ3d7L12xnDhieBMZA0WJ1afKq7sSplcED2Uu9Sfa
         AUZA==
X-Gm-Message-State: AOAM533ie9L9y0r+W0qIr60zyxYj64Lyl4ku1X7EUT9ZGxlW1UfqoA8V
        dB9CKj3Uy97lEGxhaRVsmMksdkKeK2B7gqUojezZQ7j/c++5xGN45hXymwkY6HwtlieElAY+tKN
        xoVScS8VlS10Du++EtMu3Bp+sDbKCC/F8UZVc2w==
X-Received: by 2002:aa7:d14a:: with SMTP id r10mr31775578edo.385.1618413926563;
        Wed, 14 Apr 2021 08:25:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw1JCAj/r+e3/uIOKJ2XZglO0McMtQzQ8diU5aN0gEjel2Jj0k1vvDuRlTIenHIoA7tdTyV1A==
X-Received: by 2002:aa7:d14a:: with SMTP id r10mr31775562edo.385.1618413926402;
        Wed, 14 Apr 2021 08:25:26 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id n14sm6781032ejy.90.2021.04.14.08.25.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Apr 2021 08:25:25 -0700 (PDT)
Subject: Re: [PATCH 1/3] mmc: sdhci-s3c: fix possible NULL pointer dereference
 when probed via platform
To:     Ben Dooks <ben-linux@fluff.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
References: <20210414151242.102313-1-krzysztof.kozlowski@canonical.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <a0ac5d21-acc1-825a-1585-f8d897902b14@canonical.com>
Date:   Wed, 14 Apr 2021 17:25:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210414151242.102313-1-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 14/04/2021 17:12, Krzysztof Kozlowski wrote:
> The driver can be matched by legacy platform way or OF-device matching.
> In the first case, of_match_node() can return NULL, which immediately
> would be dereferenced to get the match data.
> 
> Addresses-Coverity: Dereference null return value
> Fixes: cd1b00eb24b0 ("mmc: sdhci-s3c: Add device tree support")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
> 
> Not tested on HW, but the code should be equivalent (plus safer).
> 
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
>  			struct platform_device *pdev)
>  {
>  #ifdef CONFIG_OF
> -	if (pdev->dev.of_node) {
> -		const struct of_device_id *match;
> -		match = of_match_node(sdhci_s3c_dt_match, pdev->dev.of_node);

Now I have second thoughts whether NULL pointer can actually happen.  If
device is matched via platform/board files, maybe the pdev->dev.of_node
will be NULL thus skipping this branch?

Could there be a case where device is matched via platform_device_id()
(which has different name than compatible!) and (pdev->dev.of_node) is
still assigned? Maybe in case of out of tree DTS?

Anyway, the patch makes the code simpler/smaller, so I still think it is
reasonable. Just the severity of issue is questionable...

Best regards,
Krzysztof
