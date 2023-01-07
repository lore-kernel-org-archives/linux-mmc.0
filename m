Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0571EC54EBD
	for <linux-mmc@archiver.kernel.org>; Sat,  7 Jan 2023 13:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbjAGNZL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 7 Jan 2023 08:25:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbjAGNZJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 7 Jan 2023 08:25:09 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A20D58334
        for <linux-mmc@vger.kernel.org>; Sat,  7 Jan 2023 05:25:08 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id r2so3626215wrv.7
        for <linux-mmc@vger.kernel.org>; Sat, 07 Jan 2023 05:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VUIOJzfR4gjCubzJSweWARYQ7jO/K6ZEKw9R7MAtXPo=;
        b=onkbVc1rbEvGZygqbjpv2XpS5zkxuHUDgg44EIw1OuUNmXjWAcTAmvpHRZRll8WJQp
         G0jg7xCmF+cTL38qYRcUHPoQt1bhC3SfRvp85mk1zCw+RPZiXbb77M6v3a2Wjm+Phe3r
         /Gh9/tAp8hnGMaWMywn1kZVl7sBXbyon3U1ThTX2GoNqSE6KepUQCmsOXy6wMkjckXQq
         EqSJ/fiwiuypfW17kSxD8ZW9Hpu+YfFbuRkpe1Qjlz0p3/7RjoqrfvLJmfjxsAg0X0Aj
         v93NJ9nbfYV6WP2nBzBOsuw5SEegbQS4LZwJxBc2RITKHZLMMXc9Cqn7vhMyT5iX8Kbp
         hPqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VUIOJzfR4gjCubzJSweWARYQ7jO/K6ZEKw9R7MAtXPo=;
        b=Hy7siZ1WJbeeQnZCAm2QnY1+qRvW/sMmXGYqI6Ks9p1/ePEubnH7j4SBKUzehSFBHu
         zY4YNTK2l7uHF0HKv50tEBk1PvyL+nsQPntq8rpW/z9njB0SIjJ+1Nu7OQU9C5uvAvxu
         FnEF6tdGoycqoY+Ln3nBUfz77Pavn4Kdy65vBVeQ+0vtNXCdyIdQr0FigbJe6OCDi/MP
         iTsk0cwgJHQ4EoJaRRk4Qkd59VmCko2JBMsiMY44hkKJpW6q7UJ2z4sVRdZkHYOhB/I/
         +/rKmx36oL9IDydixkNUeEFLeja68gZADV+6TdFGt+Tuopv3RsI2y5OXKkU+KAWbY/th
         U6Zg==
X-Gm-Message-State: AFqh2krcCsKPSF7vV17tLolGSdXg1N7vZCLWMGNBCDtU7jKS+cSsTam6
        P9hiDsHUomqkkdl+N+QIstZMWw==
X-Google-Smtp-Source: AMrXdXsd4OlFrcapKoOIiiaSo59QJSOXueVuWMfL/ztMFbpKKDNEQLKruccFGDwsD/RBiTen9q8fqA==
X-Received: by 2002:adf:ef49:0:b0:28b:a241:9870 with SMTP id c9-20020adfef49000000b0028ba2419870mr19927855wrp.47.1673097907042;
        Sat, 07 Jan 2023 05:25:07 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id s2-20020adff802000000b00241bd7a7165sm3818637wrp.82.2023.01.07.05.25.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Jan 2023 05:25:06 -0800 (PST)
Message-ID: <f9d4c883-4b76-c95e-c6dc-a659b4410bf2@linaro.org>
Date:   Sat, 7 Jan 2023 14:25:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 3/5] dt-bindings: mmc: sdhci-cadence: SD6 support
Content-Language: en-US
To:     Piyush Malgujar <pmalgujar@marvell.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        adrian.hunter@intel.com, ulf.hansson@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        yamada.masahiro@socionext.com, devicetree@vger.kernel.org,
        jannadurai@marvell.com, cchavva@marvell.com
References: <20221219142418.27949-1-pmalgujar@marvell.com>
 <20221219142418.27949-4-pmalgujar@marvell.com>
 <5fc29d3c-e3da-3dc4-bce5-2158b81daa43@linaro.org>
 <20230106164812.GA14720@Dell2s-9>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230106164812.GA14720@Dell2s-9>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 06/01/2023 17:48, Piyush Malgujar wrote:
> Hi Krzysztof,
> 
> Thank you the review comments.
> 
> On Mon, Dec 19, 2022 at 04:40:35PM +0100, Krzysztof Kozlowski wrote:
>> On 19/12/2022 15:24, Piyush Malgujar wrote:
>>> From: Jayanthi Annadurai <jannadurai@marvell.com>
>>>
>>
>> Subject: use final prefix matching the file, so "cdns,sdhci:"
>>
>>> Add support for SD6 controller support
>>
>> Full stop.
>>
>>>
>>> Signed-off-by: Jayanthi Annadurai <jannadurai@marvell.com>
>>> Signed-off-by: Piyush Malgujar <pmalgujar@marvell.com>
>>> ---
>>>  .../devicetree/bindings/mmc/cdns,sdhci.yaml   | 33 +++++++++++++++++--
>>>  1 file changed, 31 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
>>> index 8b1a0fdcb5e3e2e8b87d8d7678e37f3dad447fc1..2043e78ccd5f708a01e87fd96ec410418fcd539f 100644
>>> --- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
>>> +++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
>>> @@ -4,7 +4,7 @@
>>>  $id: http://devicetree.org/schemas/mmc/cdns,sdhci.yaml#
>>>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>>>  
>>> -title: Cadence SD/SDIO/eMMC Host Controller (SD4HC)
>>> +title: Cadence SD/SDIO/eMMC Host Controller (SD4HC, SD6HC)
>>>  
>>>  maintainers:
>>>    - Masahiro Yamada <yamada.masahiro@socionext.com>
>>> @@ -19,6 +19,7 @@ properties:
>>>            - microchip,mpfs-sd4hc
>>>            - socionext,uniphier-sd4hc
>>>        - const: cdns,sd4hc
>>> +      - const: cdns,sd6hc
>>
>> Does not look like you tested the DTS against bindings. Please run `make
>> dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
>> for instructions).
>>
>> ... because it does not really make sense. Why do you require SD6HC as
>> fallback? I think you meant enum.
>>
> 
> Yes, that's correct. I will change it to enum.
> 
>>>  
>>>    reg:
>>>      maxItems: 1
>>> @@ -111,6 +112,34 @@ properties:
>>>      minimum: 0
>>>      maximum: 0x7f
>>>  
>>> +  cdns,iocell_input_delay:
>>
>> No underscores. Use proper units in name suffix:
>> https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/property-units.yaml
>>
>>
>>> +    description: Delay in ps across the input IO cells
>>> +    $ref: "/schemas/types.yaml#/definitions/uint32"
>>
>> Ditto... and so on - all of the fields.
>>
>>> +
>>> +  cdns,iocell_output_delay:
>>> +    description: Delay in ps across the output IO cells
>>> +    $ref: "/schemas/types.yaml#/definitions/uint32"
>>> +
>>> +  cdns,delay_element:
>>> +    description: Delay element in ps used for calculating phy timings
>>> +    $ref: "/schemas/types.yaml#/definitions/uint32"
>>> +
>>> +  cdns,read_dqs_cmd_delay:
>>> +    description: Command delay used in HS200 tuning
>>> +    $ref: "/schemas/types.yaml#/definitions/uint32"
>>> +
>>> +  cdns,tune_val_start:
>>> +    description: Staring value of data delay used in HS200 tuning
>>> +    $ref: "/schemas/types.yaml#/definitions/uint32"
>>> +
>>> +  cdns,tune_val_step:
>>> +    description: Incremental value of data delay used in HS200 tuning
>>> +    $ref: "/schemas/types.yaml#/definitions/uint32"
>>> +
>>> +  cdns,max_tune_iter:
>>> +    description: Maximum number of iterations to complete the HS200 tuning process
>>> +    $ref: "/schemas/types.yaml#/definitions/uint32"
>>
>> Why these three are properties of DT?
>>
> 
> These tuning parameters are added here so to make them custom configurable for different
> boards.

I understand why do you wanted to add them, but I am asking why these
are suitable for DT? DT  describes hardware, so what is here specific to
hardware which requires DT property?


Best regards,
Krzysztof

