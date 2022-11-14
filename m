Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89B7C43217
	for <linux-mmc@archiver.kernel.org>; Mon, 14 Nov 2022 08:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236654AbiKNI7X (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 14 Nov 2022 03:59:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236651AbiKNI7Q (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Nov 2022 03:59:16 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A431CB35
        for <linux-mmc@vger.kernel.org>; Mon, 14 Nov 2022 00:59:14 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id u11so12230031ljk.6
        for <linux-mmc@vger.kernel.org>; Mon, 14 Nov 2022 00:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aEB4+pHuB87kKFxU9sS7xN56uZZ17ZCmfmqV3IDAJwA=;
        b=GUpuQJsqj7d9hVV6WvL0eu3Sa4Zu0WoScwnrjp+Sb/R6VBoodh7gnJrBG64mqhWy0Y
         eP/R02YYf4gIauUMYOHNGjGdV/CGjBX0c0sktWLGSc6gdfeOwq9NnCar3s6pRhG2z0On
         hthJ+8yzUj6OFqThEpdFhV29ZqRt0OpMe8EbEj7wrj06Oc3KiHUwGFoE/5+2G10MCBoM
         TffGZHc4dZ+ec4a+dEgAr8lFZCvCD48B99Hl24gzbVknKfCqXzpyi2MhXGM7Ovvk8i6p
         LKziMMc9thyTZw+EpvhonoG9JBrL4k8AL5ZAZph3gNWSh0Px69gU5yt00d3Qh3J86eLh
         mSYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aEB4+pHuB87kKFxU9sS7xN56uZZ17ZCmfmqV3IDAJwA=;
        b=RamuftUEKuanznS2i2rNEvpdOFgxHU0H0ARRZaGr4f6kfXbEdHSZDyrpxoOLFvGwUU
         YQe17TKKwz1ziKgEAoJDJGIMrgMy0Bl2d6dsSLa3/DU5Tq6Yyfsbt0T7huW3xCh2oL+U
         xF4lmgXRmPTxZLU6MejsPyxfSH5UkRo8ODYu2ZjP32iX2XUBK2YB/N9UxfdZqDqufoGX
         7k8iw6fsCkchA2qMvrqJCekAIu2TZkhQhai0X8OPwi8htQ4ihTmEGBZlwy4+DAfB+zwV
         BFtAugFPhVksFEe0lv+PEDf8D7mwm9d6jC7Fa9jLOKU9forHslKJvxsBH+1GhFK2EqmK
         irjg==
X-Gm-Message-State: ANoB5pkVv2jhr3k8qk7STj5SbPA/Emr+0DKpTDbSxMV8pXUvGNkIOSWv
        4ltUjmBiTOuMWICwjLMzhNlT+Q==
X-Google-Smtp-Source: AA0mqf68fg/tIqJjNfZ90yjoIk4FX4jbfttTDsgKec1B2mUTB3NymIkjIX4vOuJCTH9yfdOZ645fxA==
X-Received: by 2002:a05:651c:1029:b0:277:5c7e:b128 with SMTP id w9-20020a05651c102900b002775c7eb128mr4245801ljm.237.1668416353026;
        Mon, 14 Nov 2022 00:59:13 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id c8-20020a056512324800b0049a5a59aa68sm1756324lfr.10.2022.11.14.00.59.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 00:59:12 -0800 (PST)
Message-ID: <9eb8e2d8-bda1-169a-5e26-5a3b127758c7@linaro.org>
Date:   Mon, 14 Nov 2022 09:59:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 1/6] dt-bindings: mmc: Convert sdhci-fujitsu to JSON
 schema
Content-Language: en-US
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Jassi Brar <jaswinder.singh@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221111081033.3813-1-hayashi.kunihiko@socionext.com>
 <20221111081033.3813-2-hayashi.kunihiko@socionext.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221111081033.3813-2-hayashi.kunihiko@socionext.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 11/11/2022 09:10, Kunihiko Hayashi wrote:
> Convert the Fujitsu SDHCI controller IP binding to DT schema format,
> and add resets property as optional to support reset control.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof

