Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F903C04A95
	for <linux-mmc@archiver.kernel.org>; Thu, 29 Sep 2022 06:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234918AbiI2Gt7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 29 Sep 2022 02:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233899AbiI2Gt6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Sep 2022 02:49:58 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188FE4F65C
        for <linux-mmc@vger.kernel.org>; Wed, 28 Sep 2022 23:49:54 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id a10so530002ljq.0
        for <linux-mmc@vger.kernel.org>; Wed, 28 Sep 2022 23:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=9riNZVJHHiGAu2Pt8+qgKwtbpAbtFPq/WEzep1qznjk=;
        b=GFmvseWTnKL9Z9WgWeMRvQvhAoDiC5Lyhwr7cz9K0gAzBAeDsFp/EhpuesebdJ+Nhn
         x8L4Pf2vSAkcuWbARrlA/ZL2RYZdr/mhTtf4rZCPHTlFWnCI10P/aIldX3ZRk0jVQ9Xn
         4zdT0F0R6S9vXhxy0bjwTPJgkPqasWrLCQNZAoD74sFQY3pwy7ODiaIJf5yZfuEamrtr
         SUilrWMZSGK14TKcRNp6a1Gf8rAY0+qUpWDZnrAFXyT6x//fdJULZSyTDNxVfDv2dgNg
         dc2vaZF/BeRvBk6rDazFkrJWCejzjVbSK6J6eDfzQVHMZ02BzJweCxq9f6PHpxLtfvXq
         OOJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=9riNZVJHHiGAu2Pt8+qgKwtbpAbtFPq/WEzep1qznjk=;
        b=FpxDNhhWypiceaHEivEBLdoJGXoV6ZtCCqshb/99jJzxuxc9OSmmV9+e04W+glm6Ky
         SbgI1ZUty1RD4gBrIOXaO3U+3RkCQEtyhtjsG918VbstxVvtn+pLokkQJDkbN/yepbt9
         HmE/fJsLN3csAVehlxM+wzS2ZS/eWYMSUAXfPzGeHAKQDhhZPbbvm0NeYqhPNTRJCo2r
         mtsHiR8LaggKQ7il6iSfl3nITMzwd5u5L3SNUw7+RafhyF5/U40izXSMBCQ0skVisel7
         FFLSqwJNw1KhGCMv6vUFEgoq2bhcgaxSmFFgNRTt8acSV0inj5R5SXm20TZfZmvhgNGi
         GHdA==
X-Gm-Message-State: ACrzQf3MhDDrSaSy8y3k9RPu8Wjcab4MarfBfD4ktvcXVpksxM7X6VGZ
        2PBWR5RzSExONre78DGuaV/Uog==
X-Google-Smtp-Source: AMsMyM6HQoJ5UNKRyCHBISkOOH4HujGYWPOKkoE98SUL/UFadadDiHyVoD70LSpaqusQ1YF5KVmSjQ==
X-Received: by 2002:a05:651c:1504:b0:26c:6331:3463 with SMTP id e4-20020a05651c150400b0026c63313463mr607382ljf.30.1664434192564;
        Wed, 28 Sep 2022 23:49:52 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id j14-20020a05651231ce00b0048af9576d30sm695743lfe.83.2022.09.28.23.49.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 23:49:52 -0700 (PDT)
Message-ID: <dd887ce0-df72-2818-ecaf-1fcdcc0dfb42@linaro.org>
Date:   Thu, 29 Sep 2022 08:49:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCHv4 1/3] dt-bindings: mmc: synopsys-dw-mshc: document
 "altr,sysmgr-syscon"
To:     Dinh Nguyen <dinguyen@kernel.org>, jh80.chung@samsung.com
Cc:     ulf.hansson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220928165420.1212284-1-dinguyen@kernel.org>
 <ef396764-af53-8e5a-5203-f3e103bbb7a3@linaro.org>
 <02967018-8a04-bd82-49e6-1ee475916ebb@kernel.org>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <02967018-8a04-bd82-49e6-1ee475916ebb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 28/09/2022 20:37, Dinh Nguyen wrote:
> Hi,
> 
> On 9/28/22 12:15, Krzysztof Kozlowski wrote:
>> On 28/09/2022 18:54, Dinh Nguyen wrote:
>>> Document the optional "altr,sysmgr-syscon" binding that is used to
>>> access the System Manager register that controls the SDMMC clock
>>> phase.
>>>
>>> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
>>> ---
>>
>> Thank you for your patch. There is something to discuss/improve.
>>
>>> +
>>> +allOf:
>>> +  - $ref: "synopsys-dw-mshc-common.yaml#"
>>> +
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            const:
>>> +              - altr,socfpga-dw-mshc
>>
>> It still should not be an array, even if there is no warning.
>>
> 
> I apologize, but I'm confused with the message. Do you mean it should 
> not be a "const"?

No, it should not be a const. Open any other schema and check how const
is done there.

Best regards,
Krzysztof

