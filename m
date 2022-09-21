Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 630AAC6FA8E
	for <linux-mmc@archiver.kernel.org>; Wed, 21 Sep 2022 11:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiIULNg (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 21 Sep 2022 07:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiIULNc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Sep 2022 07:13:32 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0538B2E2
        for <linux-mmc@vger.kernel.org>; Wed, 21 Sep 2022 04:13:30 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id j24so6048042lja.4
        for <linux-mmc@vger.kernel.org>; Wed, 21 Sep 2022 04:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=lfPaDvZl0fHH6rn8puMVcoMiT+eeT0X1tsZ/B7VR2+Y=;
        b=G2+xdwC9HD2+kvdQGyPDiSqAq0a5ql/RG4RhF64ckQhU1iswOGuKQJlXFRlkhbgwPn
         g26rB73GOqzN+HTCOFRhXfbUl4Vhc04oLQ1DdTwxEIVfyG0vB/aZ9DAb+9fJTp8CdzgX
         fynLnGBNGODUtSo+2FA45rGELhmHidrkr6HDWPhCX6hO6bkz+K1/cMOkqK2/+80+TMKe
         tqrZ5UplpDMshglktJZ8nKVIOv8ahj5zw4bWMq7WLEc0iMoV4On8gBmtipsSY7vFa3CJ
         l0pbURYWfgEXX+OEOcUrknTyIPqkPQs9AFyLFswyuQenWnAL9oTeEAADyRzfjTYH7a+4
         6lgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=lfPaDvZl0fHH6rn8puMVcoMiT+eeT0X1tsZ/B7VR2+Y=;
        b=t3PpVBxT95fb0xeGtWAx798TCiBM+Rkzno1Y2DjxOwqyMcOVIduprl82UUCJZolbfl
         AD7jKKj3VJEPrXhXB7CNpOCufCLs3y/p/rThToysVD+bJssZp6cR9HYbhxRgg8P3KJyg
         bMMe3oPKEPo4AJIhTo2BgBBH3ygCOWlX24OSXwO5l7dKNR93S/XYq58hVIP4V92gAjoK
         p/UfR2HRFMKvzTiPjNfa6RkNu4QPsuug12pU5i9OgE7uD5dgFKEtZeMDcVNROuaXkjQZ
         6KS5MXlYey2v3BB9pvu0+L3+Nm2kIQCQR3jhoDwbkNeLTcBOSPtp0Go/blV0+F2ZCUY8
         jbEQ==
X-Gm-Message-State: ACrzQf2n+/gryjfVoJKWt0em3JEkdsJXUZiM+jEfKVOvFFGhOmT7otrs
        jXqJk46AcWttlrtJB9qZ8arNNw==
X-Google-Smtp-Source: AMsMyM6919xzTTe6YBgZrcwGlc/Z99NkHRzObKYS0ULfa5sASVNawEef9+XwoL8PP257YyWbRC8gJA==
X-Received: by 2002:a2e:7314:0:b0:26a:ca18:60eb with SMTP id o20-20020a2e7314000000b0026aca1860ebmr8008812ljc.69.1663758808438;
        Wed, 21 Sep 2022 04:13:28 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id s16-20020a056512215000b0049493c14b17sm381439lfr.181.2022.09.21.04.13.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 04:13:27 -0700 (PDT)
Message-ID: <74c9c011-b0db-c838-e9bb-d732361ff799@linaro.org>
Date:   Wed, 21 Sep 2022 13:13:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 2/2] mmc: dw_mmc-pltfm: socfpga: add method to configure
 clk-phase
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Dinh Nguyen <dinguyen@kernel.org>
Cc:     jh80.chung@samsung.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220919181309.286611-1-dinguyen@kernel.org>
 <20220919181309.286611-2-dinguyen@kernel.org>
 <CAPDyKFoB7Z6kDOBd9rVLXU5yRQK7d5A-ut5CRroepbAfQpuByw@mail.gmail.com>
 <50c7d35b-f395-6421-1422-56e30a580318@kernel.org>
 <07c118cb-4daf-8e82-2969-1cff072ec52a@linaro.org>
 <CAPDyKFoQJsf4EAoQRO9hoKWug+QTX2Hw1ukFqhr0sNQCCwR8Bg@mail.gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAPDyKFoQJsf4EAoQRO9hoKWug+QTX2Hw1ukFqhr0sNQCCwR8Bg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 21/09/2022 12:31, Ulf Hansson wrote:
>> Not in next-20220919.
> 
> Dinh is right!
> 
> It seems like both me and Krzysztof missed the already documented
> binding. Probably because the property is named like below and that I
> did "git grep clk-phase-sd" :-)
> 
> "^clk-phase-(legacy|sd-hs|mmc-(hs|hs[24]00|ddr52)|uhs-(sdr(12|25|50|104)|ddr50))$":

Too much trust in git grep. Thanks for finding it.

> 
>>
>>>
>>> Should I create a specific documentation just for
>>> "altr,socfpga-dw-mshc" and document "clk-phase-sd-hs"?
>>
>> All properties must be documented.
> 
> Yes, but as stated above, we should be okay in this case.
> 
>>
>>>
>>>>
>>>>> +       if (rc) {
>>>>> +               sys_mgr_base_addr =
>>>>> +                       altr_sysmgr_regmap_lookup_by_phandle(np, "altr,sysmgr-syscon");
>>>>
>>>> DT bindings?
>>>
>>> "altr,sysmgr-syscon" has already been documented in
>>> Documentation/devicetree/bindings/net/socfpga-dwmac.txt
>>
>> This is not documentation of nodes you are changing here and in patch 1.
>>
>> You linked altr,socfpga-stmmac and here you have altr,socfpga-dw-mshc...
> 
> Right.
> 
> I guess an option is to convert
> Documentation/devicetree/bindings/net/socfpga-dwmac.txt into the yaml
> based format and then reference that binding from
> synopsys-dw-mshc-common.yaml?

I did not look much inside, but isn't them entirely different devices
(net vs mmc)? If they are different, then such vendor-custom property
needs to appear in each bindings. The same as we have for other
syscon-like properties.

Best regards,
Krzysztof

