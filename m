Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E290BC54EAA
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Jan 2023 07:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjAXHXA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Jan 2023 02:23:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjAXHW7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Jan 2023 02:22:59 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1684C1204C
        for <linux-mmc@vger.kernel.org>; Mon, 23 Jan 2023 23:22:57 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id z5so12934199wrt.6
        for <linux-mmc@vger.kernel.org>; Mon, 23 Jan 2023 23:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hOqIhKWmcWZHOP0TZmwFeKFhIjE5xH+rrbYLVFlCH54=;
        b=HlnNsx1iPxPtbfpnVdPKdWVG8suPrAviFixXmIx4fqt1mo3cs95gRsDFo1LkAyACg9
         +Gjf59A/1JloygRmOugHZHlqSx5zy3E2w4OyJPZK7sArtb6QlinASrtFhTX7Z4+sMepg
         6W18cLx0YrHJtGMFWmbchimC1aSIGdhQclufRAVX0bogB4NF4zB35EURROHjYbdSNF5m
         LGIol1qNNgUgMJA0dSGTFX5zB3ikCfmej1JNz9dxL+YzXBxQw8h74hZzjtZEAnRCGGda
         qIiazs6A21ZBVXLX/WP4WnZ2l6AwbCobHjOsZBZqKkkQjMfDoifB1edlkbUKpwb1SltP
         45kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hOqIhKWmcWZHOP0TZmwFeKFhIjE5xH+rrbYLVFlCH54=;
        b=5jzpJnb4WiESHe/NFzNdrnkDLMjDhhbu2Jv9dJ/n6wKvMreizKS7tw34H6199VInzR
         dfdl7iuAlQjEGtKbeIQAYS2wyprwXwzX/ivNYXjpVcbwlxNDrm4U9J7u9+nuEQEGfaFQ
         +Cd/pAgLqTQoMNBam+1xe2eFnI534M2pdjd+mQYkt2YMkgyVWYIazNc5T9Cd9xEVjpm8
         kkpcT+pUPMFYVWW/LvMdvJFeB/sG8VaoVKYuEmd05ksyeQPHX7/zCM8piD9mI3R/qRGJ
         fg+wJ7+WRupHIpgeWlLpZd0T1ECeLmtjup7TI/NF5Df3Ent10DTw8WzV9avctJHThPZw
         Hzcw==
X-Gm-Message-State: AFqh2koxrsjh7FGFTTLWrJkSsTg0zSu3QIPgFz0iMVvWKaVBdIpZu4HF
        6/MqQO244/LwduF9vhWjW9HW4g==
X-Google-Smtp-Source: AMrXdXvmvg2tOjBvWsrSICSJ6SCvBHlj8KhJwTP4+sjwYqWpPuD963rZLRunfa+RjjRE3GpeDKF4Vg==
X-Received: by 2002:a05:6000:603:b0:26b:e7e1:ad03 with SMTP id bn3-20020a056000060300b0026be7e1ad03mr26799070wrb.55.1674544975569;
        Mon, 23 Jan 2023 23:22:55 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id w14-20020a5d608e000000b002bc84c55758sm1407059wrt.63.2023.01.23.23.22.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 23:22:55 -0800 (PST)
Message-ID: <84233b60-2468-4be9-7aa7-bdd296fd96e8@linaro.org>
Date:   Tue, 24 Jan 2023 08:22:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v9 04/15] dt-bindings: spi: dw: Add AMD Pensando Elba SoC
 SPI Controller bindings
To:     Brad Larson <blarson@amd.com>
Cc:     adrian.hunter@intel.com, alcooperx@gmail.com,
        andy.shevchenko@gmail.com, arnd@arndb.de, brad@pensando.io,
        brendan.higgins@linux.dev, briannorris@chromium.org,
        brijeshkumar.singh@amd.com, broonie@kernel.org,
        catalin.marinas@arm.com, davidgow@google.com,
        devicetree@vger.kernel.org, fancer.lancer@gmail.com,
        gerg@linux-m68k.org, gsomlo@gmail.com, krzk@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee.jones@linaro.org,
        lee@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-spi@vger.kernel.org, p.yadav@ti.com, p.zabel@pengutronix.de,
        piotrs@cadence.com, rdunlap@infradead.org, robh+dt@kernel.org,
        samuel@sholland.org, skhan@linuxfoundation.org,
        suravee.suthikulpanit@amd.com, thomas.lendacky@amd.com,
        tonyhuang.sunplus@gmail.com, ulf.hansson@linaro.org,
        vaishnav.a@ti.com, will@kernel.org, yamada.masahiro@socionext.com
References: <322383a5-5c2b-a1e0-d14c-6c038085301d@linaro.org>
 <20230124015721.2285-1-blarson@amd.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230124015721.2285-1-blarson@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 24/01/2023 02:57, Brad Larson wrote:
> On 19/01/2023 7:55 UTC, Krzysztof Kozlowski wrote:
>> On 19/01/2023 04:51, Brad Larson wrote:
>>> The AMD Pensando Elba SoC has integrated the DW APB SPI Controller
>>>
> ...
>>>  .../devicetree/bindings/spi/snps,dw-apb-ssi.yaml   | 14 ++++++++++++++
>>>  1 file changed, 14 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
>>> index d33b72fabc5d..96b072835de0 100644
>>> --- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
>>> +++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
>>> @@ -37,6 +37,18 @@ allOf:
>>>      else:
>>>        required:
>>>          - interrupts
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            const: amd,pensando-elba-spi
>>> +    then:
>>> +      properties:
>>> +        amd,pensando-elba-syscon:
>>> +          $ref: /schemas/types.yaml#/definitions/phandle-array
>>> +          description: AMD Pensando Elba SoC system controller
>>
>> And nothing here - neither in commit msg nor here - explains why do you
>> need it and what is it for.
> 
> Adding property amd,pensando-elba-syscon was a result of this thread:
> https://lore.kernel.org/lkml/20220621101159.stvan53rvr6qugna@mobilestation/
> 

But it is not in the code. The code should tell what the property does,
what is its purpose, how it is used etc. Your property description
basically copies the name without giving any new information.

Best regards,
Krzysztof

