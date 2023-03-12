Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD29C6FA99
	for <linux-mmc@archiver.kernel.org>; Sun, 12 Mar 2023 10:18:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjCLKS5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 12 Mar 2023 06:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjCLKS4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 12 Mar 2023 06:18:56 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99DA426C1A
        for <linux-mmc@vger.kernel.org>; Sun, 12 Mar 2023 03:18:45 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id r15so10443646edq.11
        for <linux-mmc@vger.kernel.org>; Sun, 12 Mar 2023 03:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678616324;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o7Gs6qDlaESvs11l+kYvPQbwbdk54JOWluW/Ld0/AVo=;
        b=X4i1RRxNEXh1IpcHIyp8QXs6/zfvD+9wXUOm5PeRaSk/XW4TlQCCE32ds5WsVtCB8t
         covIhjuwKdTQ2hE+8km2s8tR/PQ+vlyNwvfks2ewQVfxfo9NekKT+1I2f9R/fqQs1bBM
         06k2IfcmJHNq0YBmlCpZ7t6KE9KDHvb5yyZHHoI5mDzDK3PLmv0gTSArKFPySrO3XLbp
         3PlzsSUql4Slax6ScVChw6dgD6iPjDq8KvaGB5sHOTC8nBkNo2Ls3/C77GcqsvftLLcU
         7pP1mWFxU0jLKHL0CcKaq2z2xdHKwdbyaSK9weqVPKiJu1J/NMEfiDIHTc6TW6WGBD8T
         4vrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678616324;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o7Gs6qDlaESvs11l+kYvPQbwbdk54JOWluW/Ld0/AVo=;
        b=DhldXZfifj6Ul2Nk0c7HYLy19j+6g8BEv7Z9i552hYxwsCFL9yCTqJ7mjZ7z7d+FIv
         sAOwrfezP+LIhwFL9Esi3tsHWOlItXIFS9MGJPEntPpkmHC7I1OwfeHiL4X4FT3iRxx2
         N3m2KGhnR7qQ5t8qBFh49lwnzlQX2gW3qKNQchwkKma7PLZfj6uXFlU2iSLnyBJ6vGM9
         gMXM9RIwx/rmGgCKXrn6/GSPxiIZq3QaMh3COYTAJOXV0UBcCy8G7ZHzxOUUnlj5zrcb
         s2xN3DhDjS5RVsxkfdcUEWEb96WxtdzPBKOias8lA4V7pCzgeS/OApAZw19n6q+bnndb
         +A3A==
X-Gm-Message-State: AO0yUKUMYoRGL7Xd0KmKQy23SyCURtXAd+RnPcbeX0Fcw45QYknOWSmN
        fjctRiJIWsiCk+srScarF2+oHpaQG8BEjbMCGQM=
X-Google-Smtp-Source: AK7set9qrR9MMWaTv62j4SHAm8Oc3AdfWSUL1ixA9pQL14hL5A5Hr8N8FDJgu5Tf1eE9p94f3pdW0A==
X-Received: by 2002:a17:907:980b:b0:88c:4f0d:85af with SMTP id ji11-20020a170907980b00b0088c4f0d85afmr39414596ejc.75.1678616324127;
        Sun, 12 Mar 2023 03:18:44 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d9f6:3e61:beeb:295a? ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id v12-20020a50a44c000000b004ac54d4da22sm2042218edb.71.2023.03.12.03.18.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 03:18:43 -0700 (PDT)
Message-ID: <2edea81f-9ea1-5ede-8539-6aac88621670@linaro.org>
Date:   Sun, 12 Mar 2023 11:18:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 1/2] dt-bindings: synopsys-dw-mshc-common: add
 "fifo-access-32bit" property
Content-Language: en-US
To:     Sergey Lisov <sleirsgoevy@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1678558770.495747-1-sleirsgoevy@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1678558770.495747-1-sleirsgoevy@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 11/03/2023 19:15, Sergey Lisov wrote:
> Some Samsung Exynos boards using the arm64 architecture have DW MMC
> controllers configured for a 32-bit data bus but a 64-bit FIFO. On these
> systems the 64-bit FIFO registers must be accessed in two 32-bit halves.
> ---
>  .../devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml   | 7 +++++++
>  1 file changed, 7 insertions(+)

Missing changelog (I did not get cover letter, so no changelog there
either).

> diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml
> index 8dfad89c7..d025b38ca 100644
> --- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml
> +++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml
> @@ -57,6 +57,13 @@ properties:
>        force fifo watermark setting accordingly.
>      $ref: /schemas/types.yaml#/definitions/flag
>  
> +  fifo-access-32bit:
> +    description:
> +      Specifies that this device requires accesses to its 64-bit registers
> +      to be done as pairs of 32-bit accesses, even on architectures where
> +      readq is available.
> +    $ref: /schemas/types.yaml#/definitions/flag

Anyway, I said last time this looks compatible-specific, so I don't
think we need another property.

Best regards,
Krzysztof

