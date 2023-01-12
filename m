Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 743B2C63797
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Jan 2023 02:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjALCUd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 11 Jan 2023 21:20:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjALCUc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Jan 2023 21:20:32 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61204FCE9
        for <linux-mmc@vger.kernel.org>; Wed, 11 Jan 2023 18:20:31 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id b9-20020a17090a7ac900b00226ef160dcaso17537406pjl.2
        for <linux-mmc@vger.kernel.org>; Wed, 11 Jan 2023 18:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QtNHpk17/WAelzP5iDU+OWjsp90Q3TI4Nh3fBvnKWZc=;
        b=COglh8KfE6YRAz3TkaJ6GcKPxkf3vtCxD24y73jZRPfbJIdML2VQaO9ppH6tWvepH6
         Onz4CHdT2l7/xztcZzBAgBTCyxE8W/llzQ528nLPdVxKaHwg+nnGJHcmICZc636ERyAC
         u/XbSceAjmqFrqXdxG/ohPMTaNYEOw7aQt2Dg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QtNHpk17/WAelzP5iDU+OWjsp90Q3TI4Nh3fBvnKWZc=;
        b=v8wCY/81YTyrIvPXJUTie30bSgRb9Sb88hFplNo8PpxvhJBOHM9zGEH1QQ+fLj+3se
         rMzVhuQHLymoTbYpl48HsnoSzz9+OXTmPR/OFqGlvGJRaoLjH4eYLDzXmDi6T50t/klP
         1Hpy3Wpx8NHnWkalMJqFSSvJGNM9vj4dE9GAwaPquNr5HocXnGJWo+j9PWbR/AjtenEp
         dwNMyjvzn5R+3iN/JzOhy+9UWHDTijp7rQWNcEEu1/tIZsxOo7p33w20DIlNZ5lRdApx
         V/87s6eQM2W9DzEE5GfuSevphseaqLXdUUpAFYk1LlrxFxuOUs2MhKPhQ9268jxmLVIl
         JJuw==
X-Gm-Message-State: AFqh2koD8c7ZezJsz/KeCLK0Hpmi90l+JxbRaTUSx5yqloSv+4x2xpx2
        bwiwGnVBAScd/gWWCzwA1vnpuQ==
X-Google-Smtp-Source: AMrXdXsfS63/C8GtuviF59EFypoXeTZUdVIOkUDbGOaE0+6SCrvAvpggbblj9YACTzjXWnYL7vStkw==
X-Received: by 2002:a05:6a20:93a8:b0:b2:48e8:e3a9 with SMTP id x40-20020a056a2093a800b000b248e8e3a9mr6607235pzh.12.1673490030696;
        Wed, 11 Jan 2023 18:20:30 -0800 (PST)
Received: from [192.168.1.33] ([192.183.212.197])
        by smtp.googlemail.com with ESMTPSA id 5-20020a621505000000b005772d55df03sm10645136pfv.35.2023.01.11.18.20.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 18:20:29 -0800 (PST)
Message-ID: <fa3d8c7d-3216-2914-8d0d-b157d90cd8a2@schmorgal.com>
Date:   Wed, 11 Jan 2023 18:20:27 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20221229200411.295339-1-doug@schmorgal.com>
 <20221229200411.295339-9-doug@schmorgal.com>
 <1acd4e02-93db-88bc-2230-e230214fe591@intel.com>
From:   Doug Brown <doug@schmorgal.com>
Subject: Re: [PATCH v3 8/8] dt-bindings: mmc: sdhci-pxa: add pxav1
In-Reply-To: <1acd4e02-93db-88bc-2230-e230214fe591@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 1/11/2023 4:44 AM, Adrian Hunter wrote:
> On 29/12/22 22:04, Doug Brown wrote:
>> Add a compatible for the pxav1 controller in the PXA168, along with
>> optional pinctrl properties to use for an errata workaround.
>>
>> Signed-off-by: Doug Brown <doug@schmorgal.com>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Doesn't apply cleanly anymore


Sorry about that. Krzysztof beat me to the "bindings in title" removal
he asked me to do. Will send a v4 series rebased on the latest mmc/next.

> 
>> ---
>>   .../devicetree/bindings/mmc/sdhci-pxa.yaml    | 19 ++++++++++++++++++-
>>   1 file changed, 18 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml b/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml
>> index 1c87f4218e18..09455f9fa8de 100644
>> --- a/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml
>> +++ b/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml
>> @@ -4,7 +4,7 @@
>>   $id: http://devicetree.org/schemas/mmc/sdhci-pxa.yaml#
>>   $schema: http://devicetree.org/meta-schemas/core.yaml#
>>   
>> -title: Marvell PXA SDHCI v2/v3 bindings
>> +title: Marvell PXA SDHCI v1/v2/v3
>>   
>>   maintainers:
>>     - Ulf Hansson <ulf.hansson@linaro.org>
>> @@ -34,6 +34,7 @@ allOf:
>>   properties:
>>     compatible:
>>       enum:
>> +      - mrvl,pxav1-mmc
>>         - mrvl,pxav2-mmc
>>         - mrvl,pxav3-mmc
>>         - marvell,armada-380-sdhci
>> @@ -61,6 +62,22 @@ properties:
>>         - const: io
>>         - const: core
>>   
>> +  pinctrl-names:
>> +    description:
>> +      Optional for supporting PXA168 SDIO IRQ errata to switch CMD pin between
>> +      SDIO CMD and GPIO mode.
>> +    items:
>> +      - const: default
>> +      - const: state_cmd_gpio
>> +
>> +  pinctrl-0:
>> +    description:
>> +      Should contain default pinctrl.
>> +
>> +  pinctrl-1:
>> +    description:
>> +      Should switch CMD pin to GPIO mode as a high output.
>> +
>>     mrvl,clk-delay-cycles:
>>       description: Specify a number of cycles to delay for tuning.
>>       $ref: /schemas/types.yaml#/definitions/uint32
> 
