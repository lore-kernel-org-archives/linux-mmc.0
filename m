Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 451E7C433FE
	for <linux-mmc@archiver.kernel.org>; Tue,  7 Dec 2021 09:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233745AbhLGJoF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 7 Dec 2021 04:44:05 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:36946
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229677AbhLGJoE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Dec 2021 04:44:04 -0500
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 552FF3F1F7
        for <linux-mmc@vger.kernel.org>; Tue,  7 Dec 2021 09:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1638870033;
        bh=JOMD5NNt/xfvXy1MKrXFMrSWfmb2GWyO1lXjWYdJbus=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=mYMtLfECoJN/ZP0bqmodDZEsFXSydQ293lRL4+0s+IpN2oR3nNEK0NeUZLJ0jWjzR
         vJgxAeN19QhWoM6VtvwEwht++C70mx9RUUl/zG0GCoOvzmecSjqe94pU+qmq/WOe5T
         XMT8hIoIFy9bMERb+InRAr2gdcEFpl3/sF1+0/d8rsK2qlDQ7On19Pk9Sha7xZ521G
         3VHhm9Sa5V+Zt5wZBjNaaVfnJ1cjEL/TNTtIpg2seKHkzcbm2ZNaEHmNm7RZqrR4Ee
         ioghDoW1wf1uSc/uOtoenVpq+ly22Hkrov0YC78bNocYVXKqi66eteVA1dmQzU2FFf
         w2/g0ddofZytg==
Received: by mail-lf1-f71.google.com with SMTP id f15-20020a056512228f00b004037c0ab223so5102149lfu.16
        for <linux-mmc@vger.kernel.org>; Tue, 07 Dec 2021 01:40:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JOMD5NNt/xfvXy1MKrXFMrSWfmb2GWyO1lXjWYdJbus=;
        b=sFEAaJdonyMzLn6FE/kW97OSo+hV60UxojI92Cq11lwtCSv2nFkp+DcVnmNZ1L/I18
         XUq/zmHuTIKjzUXz8t5CW9qtVecbj1m/Mkc8bp+lGLSqIh3ji140Aad5IAtHKuEhFlPA
         iaeTLDqWBNK5RkXukn1fyJ9a1l6in7mX4vfpjalhShWZf3UEsbJtyqcMRyoLvZz1h7xU
         jaCexQYbBo2zC56Qon9WYHXUuj8k2sC97JolEiBpH8bulvMKpiT7/j+pnjEV+oVP7fwf
         sFfDhWy6cn5f3okCYPNaLQ3lZ4R4CSMmnWftUpWjt4tCD6i+zBPGZ9+8vxJeh9UvFQK0
         6YYQ==
X-Gm-Message-State: AOAM531CLCVSvlos6LIvnTbAU+46+5cislDsDer5u6FCoBC/4vDCXj8Q
        373I7gxnrDvgVyWBVPCAMY3Sj0I1/Z1ieosS+F29M3yzzDob1Euj7mRD8i2fhhXSw0xLg7a3+Jm
        3HYqndl/B7bFHtYfAJtvQxiTimlJP0QuaP67Ejg==
X-Received: by 2002:a05:6512:90c:: with SMTP id e12mr23777125lft.419.1638870032747;
        Tue, 07 Dec 2021 01:40:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwTQ2k0wWW/H+W08cFK0E4G1YScO3MV5cie2qRunh/w3gGjwnDm4UaCRWd67b0Qs0mfxg2tFQ==
X-Received: by 2002:a05:6512:90c:: with SMTP id e12mr23777113lft.419.1638870032568;
        Tue, 07 Dec 2021 01:40:32 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id f13sm1613936lfe.297.2021.12.07.01.40.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 01:40:32 -0800 (PST)
Message-ID: <5ba8fb6f-fc8b-cee4-6a10-38d64545af42@canonical.com>
Date:   Tue, 7 Dec 2021 10:40:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v2 1/4] dt-bindings: mmc: exynos-dw-mshc: Add support for
 ARTPEC-8
Content-Language: en-US
To:     =?UTF-8?Q?M=c3=a5rten_Lindahl?= <marten.lindahl@axis.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>
Cc:     Doug Anderson <dianders@google.com>, kernel@axis.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
References: <20211206142929.26729-1-marten.lindahl@axis.com>
 <20211206142929.26729-2-marten.lindahl@axis.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211206142929.26729-2-marten.lindahl@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 06/12/2021 15:29, Mårten Lindahl wrote:
> The ARTPEC-8 SoC has a DWMMC controller that is compatible with the
> Exynos 7 version v2.70a. The main differences from Exynos 7 is that it
> does not support HS400 and has extended data read timeout.
> 
> Add compatibility string "axis,artpec8-dw-mshc" for ARTPEC-8.
> 
> Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
> ---
> 
> v2:
>  - Change compatible string vendor prefix
> 
>  Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
> index 0419a63f73a0..753e9d7d8956 100644
> --- a/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
> +++ b/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
> @@ -22,6 +22,8 @@ Required Properties:
>  	  specific extensions.
>  	- "samsung,exynos7-dw-mshc-smu": for controllers with Samsung Exynos7
>  	  specific extensions having an SMU.
> +	- "axis,artpec8-dw-mshc": for controllers with ARTPEC-8 specific
> +	  extensions.
>  
>  * samsung,dw-mshc-ciu-div: Specifies the divider value for the card interface
>    unit (ciu) clock. This property is applicable only for Exynos5 SoC's and
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Best regards,
Krzysztof
