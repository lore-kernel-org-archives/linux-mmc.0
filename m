Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308F7C4332F
	for <linux-mmc@archiver.kernel.org>; Mon, 21 Nov 2022 10:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiKUKeZ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 21 Nov 2022 05:34:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiKUKeY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Nov 2022 05:34:24 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7DE27CD5
        for <linux-mmc@vger.kernel.org>; Mon, 21 Nov 2022 02:34:23 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id j16so18124365lfe.12
        for <linux-mmc@vger.kernel.org>; Mon, 21 Nov 2022 02:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g01rBdqiiTuvoRvPxYyakM/ID62S4Z8P8ecgqOpG6Fk=;
        b=wFH18v//BO+mSjYvq4+pAXmZBg4PjE0BeTd3kAFFjcC6xH8XmxyFZOr0GV27y7gg22
         JMgpn7rDNTfrWd4H+zZCg0gOxri+c/wXE/KRmkO0U1V4URhgTQD3JzgBD0GfssH+VgTB
         2GuW7sPQV2g+V1W0vbSDFQZPH9qYer/gQIcA/6OeKSl9C7gSG//OQf2+aXROMwGrSze+
         qIJY1ezr9wzU5UG6xK3+zNjphPIipzAH7Asjz/sA3axJPnNtyUxtoFoEtYGElVgnNbnG
         W6jUsODTfsclAmANjGIH8ASeQIKhjlIVWpStromLdg9memHEK7xNVemBBjXsCuPQ1xOC
         rvYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g01rBdqiiTuvoRvPxYyakM/ID62S4Z8P8ecgqOpG6Fk=;
        b=uokoB71ZzMhHXSb08zOCx2S2dTGzWePbJ6bDyNjrx2EKSMwQ+ay1xTh237ggpKrMiI
         wwWtIHAieepYVUvEfogp7pb04Y9CaKy6WUKvYXFdC3Uubijh899iTPDJZ+2tODJyABW2
         OgsKhB5fXZeVppFoghQUw7AQDQ5vS3fN9c2uQb3y1ua/Kv2qXlPwKgVJYabAeRL4FrLo
         dtGNalgFyQYqB3hXQ5bd5tF9rKAbdf0d70wCFaqWIAKNb0w42puf39b+hXJBSb0GOEJu
         S6NKsOD7LSSyOwtQ2oATFrhS+CiVUqYW8xTBT2U0yaIDhvpA8hz4pHcOm3ntkfrWhi8C
         2w6Q==
X-Gm-Message-State: ANoB5pkGeSBignT+EdLSUAc7t9GWuN8RZXi3bhZ1XuX1Y0ahAItsrKHW
        0BMan9Dp1UC4NyocKAmX0hDTKw==
X-Google-Smtp-Source: AA0mqf6nYP6HjyYkv6L/aAK9yRawGjQhM899BPw2v0roscvBxNE129EPtnmzz2ueMEh8xr9bZNcfsQ==
X-Received: by 2002:ac2:4346:0:b0:4b4:a5c8:cc0f with SMTP id o6-20020ac24346000000b004b4a5c8cc0fmr6388397lfl.138.1669026861877;
        Mon, 21 Nov 2022 02:34:21 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id i16-20020a198c50000000b0048afb8b8e53sm1978969lfj.80.2022.11.21.02.34.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 02:34:21 -0800 (PST)
Message-ID: <86ead5ed-b236-ce2f-d965-1eea72f58857@linaro.org>
Date:   Mon, 21 Nov 2022 11:34:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v12 1/2] dt-binding: mmc: Add mmc yaml file for Sunplus
 SP7021
Content-Language: en-US
To:     Tony Huang <tonyhuang.sunplus@gmail.com>, lhjeff911@gmail.com,
        ulf.hansson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, wells.lu@sunplus.com
References: <cover.1669023361.git.tonyhuang.sunplus@gmail.com>
 <8c8fbc29524819d8ab45a4fe75311b3b7b567650.1669023361.git.tonyhuang.sunplus@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <8c8fbc29524819d8ab45a4fe75311b3b7b567650.1669023361.git.tonyhuang.sunplus@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 21/11/2022 11:06, Tony Huang wrote:
> Add MMC YAML file for Sunplus SP7021.

> +++ b/Documentation/devicetree/bindings/mmc/sunplus,mmc.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) Sunplus Ltd. Co. 2021
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/sunplus,mmc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sunplus MMC Controller
> +
> +maintainers:
> +  - Tony Huang <tonyhuang.sunplus@gmail.com>
> +  - Li-hao Kuo <lhjeff911@gmail.com>
> +
> +allOf:
> +  - $ref: "mmc-controller.yaml"

If there is going to be resend, drop the quotes (and keep my Reviewed-by
tag).

Best regards,
Krzysztof

