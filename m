Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A392C7EE2E
	for <linux-mmc@archiver.kernel.org>; Fri,  9 Jun 2023 07:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbjFIHV2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 9 Jun 2023 03:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238390AbjFIHU6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Jun 2023 03:20:58 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B0C18D
        for <linux-mmc@vger.kernel.org>; Fri,  9 Jun 2023 00:20:57 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-30c4c1fd511so1386355f8f.1
        for <linux-mmc@vger.kernel.org>; Fri, 09 Jun 2023 00:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686295255; x=1688887255;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qbECCQojym0tki1fcePemFQzOMvKm7eIXy1UhdmS0Os=;
        b=Gq13LllHeyFxZyDi5RA7RqNbZzv4vO7xJUkHSwJazafpjxcY1xBqRcAi7a3bXIrDDy
         ql5iibzEcb1G/pULT95qZFLLn6YU95/u6pqIyeoCDtmIrXc2V75btPpSVVmfcn36+EP3
         U+rvCx/zT2Ww0Jo8sdJppPsU1DnIRANgA+XyjFvfRmkA72SAmHyyoyhzSAqDXT483T/9
         r7Hlpnr6k/pBISeuNsK3OaQY2dKy9TvWSky42iWMYk6ds43CbNprKMX/RmYVDuP4VFr4
         cave3t9HzMIN6YC6sfDPAhUQTWCz2UUrVKjXIMf1vKJNFg03wsH65mcjyeB2uz04BQPX
         zk0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686295255; x=1688887255;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qbECCQojym0tki1fcePemFQzOMvKm7eIXy1UhdmS0Os=;
        b=gah/Bj7ODlkFfJy0KKcV+c9CQQaqF/ifimAwr+RoPQzztXHRumxZbhC3g8y757yF0K
         mZduZcSbyFYQVSM/RizcZwJ+sXxMyRH9iwHFdXaLrRLgfU8PbdVP5Qn5BacgFeQF2Qs+
         rbbf3wyVowMQ3vaDxLdwz1W2klS6WQEyiSuM5CgGK0wEx1q/Do9FYhoJCldbmzf6fZ0T
         dH9X6PoEt8ymRmMzgIJpOsrZC0Kru7TKTGhJH6hI8QrCgXtTIq4XFXaNVpDGF+bis4lA
         p/nlBLrWcyKLqAPYuZXZ3kDID4y7270bfUSz5gVIBbJJAithYjj9oJb68ExZItaIZChD
         zF0g==
X-Gm-Message-State: AC+VfDxf4rEOvGXR10hUqwIieDKoVVZ5YJkxWNkJ8/AWOH3ryNq7Lf4r
        3d+ZI/2US+6/MhShSgrEW6xUYQ==
X-Google-Smtp-Source: ACHHUZ595w+56xOgrh/zB+ULRVC2q70uomUS/Elf7KYJVvyLy9TBLa3xWhmNv03xAjXVV/KvFGCIfA==
X-Received: by 2002:a05:6000:4cf:b0:30e:56d9:d7ad with SMTP id h15-20020a05600004cf00b0030e56d9d7admr363920wri.71.1686295255619;
        Fri, 09 Jun 2023 00:20:55 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:5c40:3a0f:b23:350f? ([2a01:e0a:982:cbb0:5c40:3a0f:b23:350f])
        by smtp.gmail.com with ESMTPSA id q7-20020adff947000000b0030af72bca98sm3583142wrr.103.2023.06.09.00.20.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 00:20:55 -0700 (PDT)
Message-ID: <c0d6c95a-e96c-a258-666d-f81a05a86db8@linaro.org>
Date:   Fri, 9 Jun 2023 09:20:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 02/12] mmc: meson-gx: fix deferred probing
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20230608194519.10665-1-s.shtylyov@omp.ru>
 <20230608194519.10665-3-s.shtylyov@omp.ru>
Organization: Linaro Developer Services
In-Reply-To: <20230608194519.10665-3-s.shtylyov@omp.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 08/06/2023 21:45, Sergey Shtylyov wrote:
> The driver overrides the error codes and IRQ0 returned by platform_get_irq()
> to -EINVAL, so if it returns -EPROBE_DEFER, the driver will fail the probe
> permanently instead of the deferred probing. Switch to propagating the error
> codes upstream.  IRQ0 is no longer returned by platform_get_irq(), so we now
> can safely ignore it...
> 
> Fixes: cbcaac6d7dd2 ("mmc: meson-gx-mmc: Fix platform_get_irq's error checking")
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> ---
> Changes in version 2:
> - updated the fix due to the surrounding code change;
> - refreshed the patch;
> - removed stray newline in the Fixes: tag;
> - slightly reformatted the patch description.
> 
>   drivers/mmc/host/meson-gx-mmc.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index b8514d9d5e73..75f97dce7ef3 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -1192,8 +1192,8 @@ static int meson_mmc_probe(struct platform_device *pdev)
>   		return PTR_ERR(host->regs);
>   
>   	host->irq = platform_get_irq(pdev, 0);
> -	if (host->irq <= 0)
> -		return -EINVAL;
> +	if (host->irq < 0)
> +		return host->irq;
>   
>   	cd_irq = platform_get_irq_optional(pdev, 1);
>   	mmc_gpio_set_cd_irq(mmc, cd_irq);

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
