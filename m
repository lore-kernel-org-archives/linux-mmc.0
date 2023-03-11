Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DAC5C61DA4
	for <linux-mmc@archiver.kernel.org>; Sat, 11 Mar 2023 17:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjCKR5X (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 11 Mar 2023 12:57:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjCKR5W (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 11 Mar 2023 12:57:22 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D554F15160
        for <linux-mmc@vger.kernel.org>; Sat, 11 Mar 2023 09:57:20 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id j11so33170424edq.4
        for <linux-mmc@vger.kernel.org>; Sat, 11 Mar 2023 09:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678557439;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6ZzQFADWQjYXc6+XH0LPEMabA+seTwz6QtTtf51Ujcc=;
        b=VIcpHFImgRhlLPDoAAMSYk1JItJrJb2/5qlI512iy4Ll+JGtg0KN3SokgrHV+HHxH1
         cIgv29IiPHvP1U8Lya7ABerW7uoYjqoqWKU8ddgDPt4KFcOH9+xmnPn97Uq+IjHt5OqD
         r5X8FEvzzXmS2QOwIJ4i84D+kftk75y+C7w5F/MxD2qoV3sTLXS+TsulF6mBgM8IbTFk
         78zgOBEuoFmrPrmwZa3cF47If6Kl4NBC3Zoy7O8W/fYf2G5a6LIKEzQJHz46l5HJb/1M
         x0xl9O6R6qiYTDQpycOY08QrL11HgQBM6Qe8qoT4mkSKNIO4mS4Qg7UiJs+jaElbBj2s
         c0Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678557439;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6ZzQFADWQjYXc6+XH0LPEMabA+seTwz6QtTtf51Ujcc=;
        b=ENb6mdb4etSq/8HRKndi/GD9WvGqmpStsXpfCsp1fXidzYjykvxFgu8JRUSRXNG9kQ
         R9Y1Iad6ENC3FE8wnD/u/bwE4hFmYkL88bVoGAZIw0QAKPJhGw9btcectkjQtLxVOxDL
         HD4vpaczTj6u4tJUWpwBCJx6UFwByCKgPbrIndWp6UiZk2cxvXSw6fEe3Xjn4XR8GEGZ
         X53HITUX+8YquB06SdNVVNcRdQvuqc635XOmh2CohDg0YQsvqLOd2Ug6qshkZr4/2gjH
         kKlgiLIihLjV74kHRK9ytiSUUp9eO2FTDmIQSHFgpk2rX2EkfgrGyoyNi6kPWZASMauE
         kWng==
X-Gm-Message-State: AO0yUKVgOPPPkRLMLKjl5lqJhs+GsF0xwvv1ZCNqlJZ6tLQTY/Ik8HJR
        v0HzJj7LKlW2ia87rt9UmtNn3w==
X-Google-Smtp-Source: AK7set+aVOQ4IW3YvNK0hGqeruski1GhpuLa88OUPQx0N+Cxu+PYrmbclVVWvTknUtwz4HOeXe+RIg==
X-Received: by 2002:a17:906:66cd:b0:8e8:602f:847a with SMTP id k13-20020a17090666cd00b008e8602f847amr27819882ejp.24.1678557439406;
        Sat, 11 Mar 2023 09:57:19 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:6927:e94d:fc63:9d6e? ([2a02:810d:15c0:828:6927:e94d:fc63:9d6e])
        by smtp.gmail.com with ESMTPSA id ji16-20020a170907981000b008dea022f5e6sm1317076ejc.24.2023.03.11.09.57.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Mar 2023 09:57:19 -0800 (PST)
Message-ID: <4de11c0b-8e09-c3ef-4180-585662386859@linaro.org>
Date:   Sat, 11 Mar 2023 18:57:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: broken subject?
Content-Language: en-US
To:     Sergey Lisov <sleirsgoevy@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <c13993bc-9d12-f20e-de27-fa0b8a58ed33-1-sleirsgoevy@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <c13993bc-9d12-f20e-de27-fa0b8a58ed33-1-sleirsgoevy@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 11/03/2023 18:40, Sergey Lisov wrote:
>>> ---
>>>  .../devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml    | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>

Why did you remove the subject? Please keep the mailing process matching
mailing lists. It messes with mailboxes, filters and reading process.

>>> diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml
>>> index 8dfad89c7..2bc5ac528 100644
>>> --- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml
>>> +++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml
>>> @@ -57,6 +57,12 @@ properties:
>>>        force fifo watermark setting accordingly.
>>>      $ref: /schemas/types.yaml#/definitions/flag
>>>  
>>> +  fifo-access-32bit:
>>
>> Missing type boolean.
> 
> Thanks, will add the same $ref as for the entry above.
> 
>>> +    description:
>>> +      Specifies that this device requires accesses to its 64-bit registers
>>> +      to be done as pairs of 32-bit accesses, even on architectures where
>>> +      readq is available.
>>
>> And why the device would require this? If it has 64-bit registers in the
>> first place, they can be accessed in 64-bit. Otherwise these are not
>> 64-bit registers, but just lower/upper 32-bit, right?
>>
>> Also, why this cannot be implied from compatible? Why different boards
>> with same SoC should have different FIFO access?
> 
> It probably can be implied, but I am not exactly sure on which boards it
> affects, so I decided to go for a new devicetree option. Anyway, the same
> argument applies to the "data-addr" property, which is already in the
> spec, so I supposed that adding such knobs is fine.

Yeah, Rob acked it so I will let him to judge this. To me it looks like
unnecessary fragmentation - this looks like compatible specific, not
board. Anyway you need to resend to fix all the mailing mess.

Best regards,
Krzysztof

