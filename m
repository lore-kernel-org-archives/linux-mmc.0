Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D28C38142
	for <linux-mmc@archiver.kernel.org>; Wed,  1 Feb 2023 09:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbjBAJ5Z (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 1 Feb 2023 04:57:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbjBAJ5Y (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Feb 2023 04:57:24 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02FF54B4B4
        for <linux-mmc@vger.kernel.org>; Wed,  1 Feb 2023 01:57:21 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id iv8-20020a05600c548800b003db04a0a46bso2266654wmb.0
        for <linux-mmc@vger.kernel.org>; Wed, 01 Feb 2023 01:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ePSrTzkMMNng2khdgheQOIcDWatP1PEI00zqDrWQnks=;
        b=oYP1aL6QJH56IKmeEBcKnbjMi6/NvzJeVrQZ9Klxdvk8dvINMrXZJ/J+7/ggXz7gZA
         U24dj5BIRXwrHxhzfDMapYDhJaRTSHqy8SN2dB4wu4iYUtsmoaAIdTTXC0ONo815UkoS
         DAzFUmL4WbuVX4yjnFjuJds4m7XqW8bOuUxWsAn+rud6vhx+IPGhltGll2KchHDW239J
         LeZfGKto7niCkyb+oaif2uVsuDhXvL6x71Va2XYNYT74/EvHagmrP4tpSd45iSehLB3l
         86FC5XanFGhfmQzHmZY1gafBkm5qvzYYA+2TLxeYGl0sG2hLJTwqS/dVCidwoAYoSCcr
         NGIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ePSrTzkMMNng2khdgheQOIcDWatP1PEI00zqDrWQnks=;
        b=mEgt2z66vXU7pRnZRZAowHQ1gXsESae6xwBZ5Oq2Nwa7iYiQTdDc9pOx5f4CExlC0q
         SncIzSm183ETYCJjEBO+6SkQt6HwzfX19tuFLIVc1C6mTeOllYL9lzquSldd4vWSvIiE
         6udDwfQ7GFFkls0d3QK6S29XHMDVsDvSrqlYmg3sAgVvVMaC7Ot9h9HiAQwcH3h/lDT+
         GmJOwgEHheV5GNld/42/lrE8q0s3Rx1QnEjp66y7C7aJoiVapYJJ3VVu1CzcY8mZ5E9f
         RQ+IThSCxTUgVB/JRB/E5ttI0raxwHXPSkvPuYQAA8QqhAqSO4E7d3SLMgMjMcGUm5fu
         hJgA==
X-Gm-Message-State: AO0yUKUwy5lzjsou0T2vubkeCrEqtrpD1eYz0azZKLwrVDWkGcSOyHzS
        ASZSJL1RYZBmKzLnPUl05DWEYw==
X-Google-Smtp-Source: AK7set+Zr918sBtF0rKPtTPU2ScDCggLyV4vVqb7ZJqK6OseqgAP8hHBEGS8nh3iKyB8TlpBXtxFiQ==
X-Received: by 2002:a05:600c:b88:b0:3dc:5965:2c35 with SMTP id fl8-20020a05600c0b8800b003dc59652c35mr1313977wmb.24.1675245439466;
        Wed, 01 Feb 2023 01:57:19 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id h14-20020a05600c314e00b003db0b0cc2afsm1312914wmo.30.2023.02.01.01.57.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Feb 2023 01:57:19 -0800 (PST)
Message-ID: <039986bb-a3e0-2482-9853-30532df10ff8@linaro.org>
Date:   Wed, 1 Feb 2023 10:57:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v8 06/17] dt-bindings: mfd: amd,pensando-elbasr: Add AMD
 Pensando Elba System Resource chip
Content-Language: en-US
To:     Brad Larson <blarson@amd.com>, robh@kernel.org
Cc:     adrian.hunter@intel.com, alcooperx@gmail.com,
        andy.shevchenko@gmail.com, arnd@arndb.de, brad@pensando.io,
        brijeshkumar.singh@amd.com, broonie@kernel.org,
        catalin.marinas@arm.com, devicetree@vger.kernel.org,
        fancer.lancer@gmail.com, gerg@linux-m68k.org, gsomlo@gmail.com,
        krzk@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee.jones@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        p.yadav@ti.com, p.zabel@pengutronix.de, piotrs@cadence.com,
        rdunlap@infradead.org, samuel@sholland.org,
        suravee.suthikulpanit@amd.com, thomas.lendacky@amd.com,
        ulf.hansson@linaro.org, will@kernel.org,
        yamada.masahiro@socionext.com
References: <20221116223045.GA1130586-robh@kernel.org>
 <20230130191248.1933-1-blarson@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230130191248.1933-1-blarson@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 30/01/2023 20:12, Brad Larson wrote:
> Hi Rob,
> 
> On Wednesday, November 16, 2022 2:30 PM, Rob Herring wrote:
>> On Wed, Nov 16, 2022 at 11:39:40AM -0800, Brad Larson wrote:
>>> Add support for the AMD Pensando Elba SoC System Resource chip
>>> using the SPI interface.
>>
>> Please resend the whole series properly threaded.
> 
> Series sent as v9
> 
>>> +description: |
>>> +  AMD Pensando Elba SoC Resource Controller functions are
>>> +  accessed with four chip-selects.  Reset control is on CS0.
>>
>> One device with 4 chip-selects? Then I'd expect 'reg = <0 1 2 3>;'
>>
>> Hard to say more because I don't have the whole thread nor remember what 
>> exactly we discussed before. That was 100s of bindings ago...
> 
> This has been changed to one device and four chip selects. This binding error
> is occuring for snps,dw-apb-ssi.yaml using reg for the chip selects.  Any
> guidance on how to fix? 
> 
> $ make ARCH=arm64 dtbs_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
>   LINT    Documentation/devicetree/bindings
>   CHKDT   Documentation/devicetree/bindings/processed-schema.json
>   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
>   DTC_CHK arch/arm64/boot/dts/amd/elba-asic.dtb
> /home/brad/linux.v10/arch/arm64/boot/dts/amd/elba-asic.dtb: spi@2800: system-controller@0:reg: [[0], [1], [2], [3]] is too long
> 	From schema: /home/brad/linux.v10/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml

Maybe this would work in snps,dw-apb-ssi for children:

reg:
  items:
    minimum: 0
    maximum: 3

Best regards,
Krzysztof

