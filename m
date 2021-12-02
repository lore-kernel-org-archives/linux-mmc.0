Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0003AC4332F
	for <linux-mmc@archiver.kernel.org>; Thu,  2 Dec 2021 08:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356276AbhLBIov (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 2 Dec 2021 03:44:51 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:47960
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1356269AbhLBIob (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 2 Dec 2021 03:44:31 -0500
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com [209.85.208.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A2B924003C
        for <linux-mmc@vger.kernel.org>; Thu,  2 Dec 2021 08:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1638434467;
        bh=FIwRIWabElMuSh13dNs8xwk0guQGLGLYUJ8I7QxS5UA=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=SumPOPsmyhEdvmd/bWWtffs0kQIDv4VD6P1/ao6wC7LrzuBRiZeVosav+SjoBrNzR
         nmGo3Sgolrhx0xFIzY8fP+KTXpqeCxlckP/QL6ljCrxUTyoHdTDyvvZOf1j2LIecfS
         FBbB+PWtI5W2AixwVXu28wXeuxPIg6pY9v3GJVceajTQMrTWHWMRLJVzCEI4PE6xQx
         PBBLpxBCLpOTlC+bZTRVg1seXsiAEKCqAk1PmlJFGo4mLZbcK6ltVj3L4Ox4wsHZn7
         ENW91J3ROE5i49x3Rod0IHnBUQv0w+7pImcaamqUS6Sl76UxUvtmpmdmJxdq7F5NQW
         8x7iBCnFdsiXw==
Received: by mail-lj1-f200.google.com with SMTP id s16-20020a2ea710000000b0021b674e9347so9332323lje.8
        for <linux-mmc@vger.kernel.org>; Thu, 02 Dec 2021 00:41:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FIwRIWabElMuSh13dNs8xwk0guQGLGLYUJ8I7QxS5UA=;
        b=bSQEcnppXF968Ysb6OalP+Ms66wtKJBc2M9Bpst+7MCF2X2HOL36r51+xdePtj6t2f
         t0QxcuhkkRmNdxf9iGziw2l23B3gj3li4ZwlgY9oF5PcJU35uGuwJsadojr8oeHG16ej
         NU+GSNcs2+qe4puc0w1eynjCZc3O5RH7x7rWCNkFoi5Jlti9RimWMmgP44nivFPrx2CP
         Er1S9l4QyVltLfwfdQvVY11qmSMRatju7GcYspXQ7dISaysQPijQ2Q1jtZlhKIglTQOk
         xgP0NYD6Y1XuwHTruGikUa53fMcUmIXhKGWHTrKdyf5Z5wO153OV8GHdKeyZfhSLLDHk
         ZOcg==
X-Gm-Message-State: AOAM530BRSUCbgw8Tt1trgzUC0E1eVM/J7hWSuuZ6ZVT2kzOCmSLrSPA
        t1hwq9mLZ75+8Lsoc48b2LM8NM3HtiJM6Ku4puDb7BFEYZn8b3UErD/B7TtXja/tCmFBMcH1LXy
        MzE4g/WDX9BABq/2EaH8dCTkKSqHH6vEJnu+7VA==
X-Received: by 2002:a2e:8691:: with SMTP id l17mr10288230lji.119.1638434467077;
        Thu, 02 Dec 2021 00:41:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwOzAYA0rXNf6qxmuG4HJayRcLcb2MW0+iM9hyKq55/nQxtJmM0dNWEAgdHZ4YJPVsPd578gA==
X-Received: by 2002:a2e:8691:: with SMTP id l17mr10288212lji.119.1638434466896;
        Thu, 02 Dec 2021 00:41:06 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id cf34sm260062lfb.222.2021.12.02.00.41.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Dec 2021 00:41:06 -0800 (PST)
Message-ID: <c6a44fd1-ad48-06cc-4a96-818ca124afca@canonical.com>
Date:   Thu, 2 Dec 2021 09:41:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 1/4] dt-bindings: mmc: exynos-dw-mshc: Add support for
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
References: <20211201153804.27655-1-marten.lindahl@axis.com>
 <20211201153804.27655-2-marten.lindahl@axis.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211201153804.27655-2-marten.lindahl@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 01/12/2021 16:38, Mårten Lindahl wrote:
> The ARTPEC-8 SoC has a DWMMC controller that is compatible with the
> Exynos 7 version v2.70a. The main differences from Exynos 7 is that it
> does not support HS400 and has extended data read timeout.
> 
> Add compatibility string "samsung,artpec8-dw-mshc" for ARTPEC-8.
> 
> Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
> ---
>  Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
> index 0419a63f73a0..161be451a1f0 100644
> --- a/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
> +++ b/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
> @@ -22,6 +22,8 @@ Required Properties:
>  	  specific extensions.
>  	- "samsung,exynos7-dw-mshc-smu": for controllers with Samsung Exynos7
>  	  specific extensions having an SMU.
> +	- "samsung,artpec8-dw-mshc": for controllers with ARTPEC-8 specific
> +	  extensions.

Artpec8 does not look like Samsung, so vendor prefix does not match.

Best regards,
Krzysztof
