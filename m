Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE411C636D6
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Feb 2023 13:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjBPNni (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 16 Feb 2023 08:43:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbjBPNnX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Feb 2023 08:43:23 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65AF155E4E
        for <linux-mmc@vger.kernel.org>; Thu, 16 Feb 2023 05:43:06 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id a10so2856576edu.9
        for <linux-mmc@vger.kernel.org>; Thu, 16 Feb 2023 05:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B5grLXxAB2C9edHtiWdcPQF4DNv/cRB6QAPzd9Oxh6M=;
        b=NQVwbo6Oc/igVtVnE5j9BA51kVTizAW4bXxHKVG4u+nusPCgy7miJHd5yn7E/y/vwE
         Lbs7+8Sr0blHOvDJhNvAZr7/ctXDElFMFdYLzKCICxnJc74z+IRIcXdToaV4DcHNepaB
         sHUNy2du4sdjpZZUwqHJ/IgvysSmtgm5avpBXsoBsvUXr4WwhYESareQBPmsNpkxigqm
         sLvfcnD0IqRS8czrjOh7oiIdJT8zJQz190ZtromTTjlV1Ve9RwuZpddtfThaWKj3nrQD
         Q6Srqfd9txDc1vL5Hddz2gerivCodr1PmQS7WYHJ+hCxy2B2YvYi6XKOqCuu8M5oZ0YX
         k1ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B5grLXxAB2C9edHtiWdcPQF4DNv/cRB6QAPzd9Oxh6M=;
        b=hF9TMOpmiKXnKITb2Lya+lbxMAgDL9Rj1uy62wRz/FhDjHt/HqnRN+Codl83Sr2XjZ
         N/vm6258RGfIjHZikUTs1dhr9edZWVDfN1ZrIHrVwyhTHhupV9JQdWsHK4ujejqqXPau
         12ldCC0/Ci+8lchn42Q3pLT0rKKckjfPug/9SaFXaUNiROb1ZDpdqCShC0PKabdMcmuk
         gcg0kTfDaFvttsTxHDdVq/vpvZf9NEg85uqhpmpYe3e/rSi6M0Jy2sYdTK+l5hg/tAtc
         EyJk7cM43PvUdD8iFy/s9A7rP0ZdgMVb++hKstbqAi5CUj/sifXpx+AyWP8ATNa9+mBN
         YZtA==
X-Gm-Message-State: AO0yUKW86itGJaXMVssHmfj76UMwZG5I3q1WawXlrAkrE41KpRu5cUvw
        aHAuyjetNr3JWu+XxTPsOfoCIQ==
X-Google-Smtp-Source: AK7set/TRdjG6xv8ct9rhgVcIRiyLMjQGkZkFuhAX6OpQzYrsPbm81px2CSsywNftx89T+9FNn5qpA==
X-Received: by 2002:a05:6402:909:b0:4ab:1715:2858 with SMTP id g9-20020a056402090900b004ab17152858mr2272896edz.11.1676554985181;
        Thu, 16 Feb 2023 05:43:05 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id n28-20020a5099dc000000b004aab66d34c7sm898722edb.7.2023.02.16.05.43.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 05:43:04 -0800 (PST)
Message-ID: <caed0029-57cf-cd95-661f-1657ef0a6d5e@linaro.org>
Date:   Thu, 16 Feb 2023 14:43:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] dt-bindings: mmc: meson-gx: fix interrupt binding
Content-Language: en-US
To:     neil.armstrong@linaro.org, Heiner Kallweit <hkallweit1@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <d5542f6e-920e-93cf-a453-b0601d03f48d@gmail.com>
 <21ae5f5f-2336-db5b-f98a-f83391e1becd@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <21ae5f5f-2336-db5b-f98a-f83391e1becd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 16/02/2023 13:52, Neil Armstrong wrote:
>>     interrupts:
>> +    minItems: 1
>>       maxItems: 2
>> +    description:
>> +      mmc controller instance interrupt
>> +      optional card detect interrupt
> 
> I would instead write:
> 
> interrupts:
>    minItems: 1
>    items:
>      - description: mmc controller instance
>      - description: card detect
> 
> and drop maxItems.

+1

Best regards,
Krzysztof

