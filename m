Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8622C61DA4
	for <linux-mmc@archiver.kernel.org>; Fri,  3 Feb 2023 09:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbjBCJbK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 3 Feb 2023 04:31:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbjBCJbH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Feb 2023 04:31:07 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1144320041
        for <linux-mmc@vger.kernel.org>; Fri,  3 Feb 2023 01:31:01 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id bt17so1033881wrb.8
        for <linux-mmc@vger.kernel.org>; Fri, 03 Feb 2023 01:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RsIvhlNhsuqxFf9ZP6UUldQV5rhEIuniVcY9EEdflHQ=;
        b=dS9U7K4hx5+UHNLv0nbXOEx175H0lar03m9RgJtrk67LYO8KhBbp6DLmDIht4HFRou
         i+HddtcrDo1LT2wjnJ8Az4t1RBPKk3f18ghM+k1jPJ5BHJ4Wlz56SufdXNRd/mSbDX3I
         WQrwRs67You+4kPoYchd4zUH59vbnYAjqBqoir45C+7D3cPpbNy+eEyH4s3URfxc5soX
         p3NlVS7Bnj40hO02bZzwvlc6DFF3vyywR/blHFdfKQxOdO4UrrUunYD8ozM2PB7mmyaZ
         tRQNH8hLYWc0M9r0VNcwmxF3q5D6CmmQRSALwuWVnidB1wEuvtQGQcvgBK38a67OR2C/
         pACA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RsIvhlNhsuqxFf9ZP6UUldQV5rhEIuniVcY9EEdflHQ=;
        b=II9/JLOshevd/Dwh0MWrhQ4mfRf5GzuFsHMIGaEwFeeuGJO3bU7FiRFrJrD0TvsdhN
         DkuSd4wnld8xaNwki//lYvY0ZcwIRNv0l2K4euT3hNEa8UunwXgzk3LxqgPpsfeKAA1X
         yIVW4D4zP6LfEdxxADQVCd1Lc7vbKuCtYfZPapAbQbslTUdx/5h86kxoqldUtgm7+xkm
         sRShGCj22v13H/oWVdA+P7Sk87GBgEsHqjdQBRggtspLIsIrSkmFQYMGPm181V2mLcaw
         iXefzAA60+qAGs6yfcmwSuWw1376aYqYfcJDoFfBHYCJOKopZsPDSDnbq6oh+MJTYF10
         SawQ==
X-Gm-Message-State: AO0yUKWvxbA+/jWEIGCKAq0TlgvpGubzIc9AQukNWCyLCgeLaV7vls/S
        iN0TZ7VvkxuKcga4XR9b/bflxm+31jjKzo+o
X-Google-Smtp-Source: AK7set9mhThVU4ZMUNjEG8Lt9BDIM9Z02zk0GC4q6tDH4m3bgoRblmm6ZN9SDVH1XSK5Yz/djY/Wfw==
X-Received: by 2002:adf:f705:0:b0:2bf:bb0a:e486 with SMTP id r5-20020adff705000000b002bfbb0ae486mr8457821wrp.30.1675416659339;
        Fri, 03 Feb 2023 01:30:59 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id n3-20020a5d6b83000000b002366553eca7sm1508672wrx.83.2023.02.03.01.30.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Feb 2023 01:30:58 -0800 (PST)
Message-ID: <ab9a4a7f-a8fa-fa29-95e9-941096359de1@linaro.org>
Date:   Fri, 3 Feb 2023 10:30:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 3/3] riscv: dts: starfive: Add mmc node
Content-Language: en-US
To:     William Qiu <william.qiu@starfivetech.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20230203081913.81968-1-william.qiu@starfivetech.com>
 <20230203081913.81968-4-william.qiu@starfivetech.com>
 <3c5bda9f-08b9-f2ba-6951-9fc614d4debc@linaro.org>
 <afe28108-9b85-982c-90ee-8cd58c9b6fb2@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <afe28108-9b85-982c-90ee-8cd58c9b6fb2@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 03/02/2023 10:23, William Qiu wrote:
> 
> 
> On 2023/2/3 17:02, Krzysztof Kozlowski wrote:
>> On 03/02/2023 09:19, William Qiu wrote:
>>> This adds the mmc node for the StarFive JH7110 SoC.
>>
>> Do not use "This xxx". Use imperative mode.
>> https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95
>>
>>> Set mmco node to emmc and set mmc1 node to sd.
>>>
>>> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
>>
>>
>>> +
>>>  &gmac0_rmii_refin {
>>>  	clock-frequency = <50000000>;
>>>  };
>>> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
>>> index 64d260ea1f29..ae1a664e7af5 100644
>>> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
>>> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
>>> @@ -370,6 +370,11 @@ syscrg: clock-controller@13020000 {
>>>  			#reset-cells = <1>;
>>>  		};
>>>  
>>> +		sysreg: syscon@13030000 {
>>> +			compatible = "starfive,sysreg", "syscon";
>>
>> No:
>> 1. Undocumented.
>> 2. A bit too generic. You should have here SoC specific compatible as
>> well (either as second or third compatible, if all your SoCs share
>> register layout).
>>
> 
> Hi Krzysztof,
> 
> As for the compatible, I will change it to "starfive,jh7110-sysreg"
> in next version,but for undocumented, I don't get it, can you
> clarify that.
> Thank you anyway.

You need bindings for it. I don't see it in linux-next, cover letter
dependencies nor here.

Best regards,
Krzysztof

