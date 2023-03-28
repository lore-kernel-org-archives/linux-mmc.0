Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B37C76196
	for <linux-mmc@archiver.kernel.org>; Tue, 28 Mar 2023 07:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjC1HOm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 28 Mar 2023 03:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjC1HOl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Mar 2023 03:14:41 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A86C3AB8
        for <linux-mmc@vger.kernel.org>; Tue, 28 Mar 2023 00:14:40 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id q16so14530437lfe.10
        for <linux-mmc@vger.kernel.org>; Tue, 28 Mar 2023 00:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679987678;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FWBhH9ILBM2tk6yi5ctxIjsW4GlgCAF1zIgHGzXnjFs=;
        b=T7yC8gSlUBnvB2LJYKAGKjRzLehQRSY8vW/FYMogmCQSVh3JSOadJqtI8IXxhCL4Ya
         tNdQRCoCUHf9P2Zz9SL+x47SzeLIMGZ+Z27nMfnDjl+ngCGipnaJVD0pkRz9LxKehRs/
         o7NPPLvXzcNe6IMkEVmXdpUlPYG8RPbEA/m3vqSi0hFZ4zuIOaM7Nw5SKRzC8UZnTuGQ
         nvl5z0wBQblq5kX4xwjzADjd2A7yZnVWMJbHB1Eal1VCOOsuOQGLcgKfoYzMkciCI39A
         HR3cHN0PPb+C4VS5WpMCsbx5XVpFho6sGO6Eq5PrRYHB55zJzvX0JGVCQyoHYiSQzpP8
         FtNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679987678;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FWBhH9ILBM2tk6yi5ctxIjsW4GlgCAF1zIgHGzXnjFs=;
        b=1hc9WMDhFQ83KGHsL7zBDSmlISyfiDqg1VN7Bbe/8IneMNkai1FZxl00h5kMwAgqfK
         Czroe7kUJOY5l5RdHYmDTZAoCh3qBINcMLqF1nAzL0sOySKqKfXMMKF6YmUIyRu6RURq
         C047xovNLNRKePWV+1dpvsS4MGf9M4D4Uu+M48iZaN1+eD2Vq6DQRjWLcmLc0mRv88tv
         QjpQlOmM6v1XaEpzPc5+gwH+QLC3TMe4pSDDsRUPACrxjzPVC8haYCK1eWM8Nyip98MH
         G1OEm5GFLgEYdXVW2RUoQIfzwcyMeQVsQ+VJyq8Xknp9bbOlZ0+EDyI6nBHlrmtu/b4G
         ny0A==
X-Gm-Message-State: AAQBX9cJ/Sb8pyYLOiWbjpsMThwfj8V+en/RWNNcSZQJvPv/x2MH3b2a
        Rpy2QKGSvyaIU8vJKWFcYPXPzA==
X-Google-Smtp-Source: AKy350Z77Fh+XOqxjbOgg3kmbKAPaExvIk4LSK4qoTm//2gkfvRWguD3omxMa9GSvXBRQ6PX37x0fw==
X-Received: by 2002:ac2:4c17:0:b0:4ea:f227:c1d6 with SMTP id t23-20020ac24c17000000b004eaf227c1d6mr4258365lfq.67.1679987678426;
        Tue, 28 Mar 2023 00:14:38 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:9e92:dca6:241d:71b6? ([2a02:810d:15c0:828:9e92:dca6:241d:71b6])
        by smtp.gmail.com with ESMTPSA id q27-20020ac25a1b000000b004dc4d26c30dsm4946301lfn.63.2023.03.28.00.14.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 00:14:38 -0700 (PDT)
Message-ID: <1f97dec8-d30c-ccc7-3026-713bf9a15850@linaro.org>
Date:   Tue, 28 Mar 2023 09:14:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/2] dt-bindings: mmc: arasan,sdci: Add Xilinx Versal Net
 compatible
Content-Language: en-US
To:     "Potthuri, Sai Krishna" <sai.krishna.potthuri@amd.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "saikrishna12468@gmail.com" <saikrishna12468@gmail.com>
References: <20230324073630.3194724-1-sai.krishna.potthuri@amd.com>
 <20230324073630.3194724-2-sai.krishna.potthuri@amd.com>
 <d646d109-d0a6-aedb-a8b2-ac954336e628@linaro.org>
 <BY5PR12MB425806889EE700C1FCC8A465DB8B9@BY5PR12MB4258.namprd12.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <BY5PR12MB425806889EE700C1FCC8A465DB8B9@BY5PR12MB4258.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 27/03/2023 11:58, Potthuri, Sai Krishna wrote:
> Hi Krzysztof,
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Sent: Friday, March 24, 2023 5:14 PM
>> To: Potthuri, Sai Krishna <sai.krishna.potthuri@amd.com>; Ulf Hansson
>> <ulf.hansson@linaro.org>; Rob Herring <robh+dt@kernel.org>; Krzysztof
>> Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Michal Simek
>> <michal.simek@xilinx.com>; Adrian Hunter <adrian.hunter@intel.com>
>> Cc: linux-mmc@vger.kernel.org; linux-kernel@vger.kernel.org;
>> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; git (AMD-
>> Xilinx) <git@amd.com>; saikrishna12468@gmail.com
>> Subject: Re: [PATCH 1/2] dt-bindings: mmc: arasan,sdci: Add Xilinx Versal Net
>> compatible
>>
>> On 24/03/2023 08:36, Sai Krishna Potthuri wrote:
>>> Add Xilinx Versal Net compatible to support eMMC 5.1 PHY.
>>>
>>> Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
>>> ---
>>>  Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
>>> b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
>>> index 8296c34cfa00..cf44a4b988a7 100644
>>> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
>>> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
>>> @@ -27,6 +27,7 @@ allOf:
>>>              enum:
>>>                - xlnx,zynqmp-8.9a
>>>                - xlnx,versal-8.9a
>>> +              - xlnx,versal-net-5.1-emmc
>>
>> v5.1 is eMMC standard or Versal block version? If the first, it's not suitable for
>> compatibles.
>>
>> Also, what's the difference from xlnx,versal-8.9a?
> V5.1 is an eMMC standard and this compatible is defined based on sdhci arasan
> eMMC5.1 Host Controller(arasan,sdhci-5.1), where as in Versal, it’s a different
> controller and it is based on 4.51 Host Controller(arasan,sdhci-8.9a).

Mixing IP block versions and eMMC spec versions in one binding is a
great way to confuse.

> Versal Net Compatible is defined it this way to make it inline with the other
> existing SoC compatibles like "intel,keembay-sdhci-5.1-emmc".
> Please suggest if the compatible need to be renamed to "xlnx,versal-net-emmc"?

Is Versal Net uniquely identifying your SoC or IP block?

> 
> Regards
> Sai Krishna
> 
>>
>>>      then:
>>>        properties:
>>>          clock-output-names:
>>> @@ -62,6 +63,11 @@ properties:
>>>          description:
>>>            For this device it is strongly suggested to include
>>>            clock-output-names and '#clock-cells'.
>>> +      - items:
>>> +          - const: xlnx,versal-net-5.1-emmc     # Versal Net eMMC PHY

You do not have items here, so move it to respective place at beginning,
just like others are defined.


Best regards,
Krzysztof

