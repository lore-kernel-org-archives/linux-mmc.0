Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA76C6FA90
	for <linux-mmc@archiver.kernel.org>; Tue, 20 Sep 2022 15:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbiITPUN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 20 Sep 2022 11:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbiITPUG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Sep 2022 11:20:06 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3619F5B071
        for <linux-mmc@vger.kernel.org>; Tue, 20 Sep 2022 08:19:58 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id a14so3394501ljj.8
        for <linux-mmc@vger.kernel.org>; Tue, 20 Sep 2022 08:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=rD2Iu80dHLJWJ4+vD+KGwraRNgomTCbTDLJpR3Q5Kx8=;
        b=W6mbAyLFmXXQcpHH6yLbyJbjO1iHcvldBNOpIAvTGtBbRqvtfM7Wy8glBUrHVjUCbj
         mSIP6Q9xya0Ea0l73qkbdzeTAJcPdmz7msICv+rrTSeEOvk0yb9S065y3cp0BTZbWmRG
         OlGxH7KpZxOuxwtaVptMi6jCEn0iGvP59zWToiYyrpdROzHJSLieciJohNIBjMqSb7eb
         y27aOcr4EyTGXwJTmutAS9EkARj8zxvH1AmAb3FiwwBRbiiofnq17wVCrwB9ZlhrjUqV
         ke2m5RwdZfW6wwqG0j4zbDe099fTHjsNsFqf436TX036RBIaSucaBm/aEOJ1kIi6g4DF
         vL0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=rD2Iu80dHLJWJ4+vD+KGwraRNgomTCbTDLJpR3Q5Kx8=;
        b=yVL+R3LV1nfRl0AVNmsXBqWdVZZg3ZCnkwopTddxECGMusXVMRpCojizfRcCjaPbPz
         yFnxG8YYxNuJss12EGy0bUGYlL/3TEiv9z/3N/rJwbX8TitgacrOXI/PzdIEtUppD0Wv
         tToA1VxRcGyL2rEBYwn0SDOpMhvVy6xAG/tPUdPfSzJwZ5nTXzRhJhGHpXu0iixTiR1g
         +elPpBI0RM/d0bqTsC+3k5BG3dXxJk0zquM8bA3Di2fB0Pe04903bruDIIOygC2LaXeZ
         yjc9Sk7Ep2Y/Xr9O0c3CUTIa6zWGSSdXbfQfeGvMgFshuKVo65nszCnxX5tdvu2loFei
         xcVA==
X-Gm-Message-State: ACrzQf3Ec3VZXjen/WArpu9MnJQM6Rh67VLOelkXJLgrpL6lH0WhECg+
        JzyiSyT+P/zlImNcKCzILVBnMg==
X-Google-Smtp-Source: AMsMyM6Qc/9g0u+WpXt8XCZR3c2BKTCrGSK+rk+9Ww3VlAYIpUy1zJXBTirkcBLxQ4bycaYYCQLv6g==
X-Received: by 2002:a2e:844e:0:b0:26b:f5ee:b2bb with SMTP id u14-20020a2e844e000000b0026bf5eeb2bbmr7381800ljh.403.1663687196496;
        Tue, 20 Sep 2022 08:19:56 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id bx11-20020a05651c198b00b0026c15d60ad1sm37998ljb.132.2022.09.20.08.19.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 08:19:56 -0700 (PDT)
Message-ID: <07c118cb-4daf-8e82-2969-1cff072ec52a@linaro.org>
Date:   Tue, 20 Sep 2022 17:19:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 2/2] mmc: dw_mmc-pltfm: socfpga: add method to configure
 clk-phase
Content-Language: en-US
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     jh80.chung@samsung.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220919181309.286611-1-dinguyen@kernel.org>
 <20220919181309.286611-2-dinguyen@kernel.org>
 <CAPDyKFoB7Z6kDOBd9rVLXU5yRQK7d5A-ut5CRroepbAfQpuByw@mail.gmail.com>
 <50c7d35b-f395-6421-1422-56e30a580318@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <50c7d35b-f395-6421-1422-56e30a580318@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 20/09/2022 15:24, Dinh Nguyen wrote:
> 
> Hi Ulf,
> 
> Thanks for the review!
> 
> On 9/20/22 07:17, Ulf Hansson wrote:
>> On Mon, 19 Sept 2022 at 20:13, Dinh Nguyen <dinguyen@kernel.org> wrote:
>>>
>>> The clock-phase settings for the SDMMC controller in the SoCFPGA
>>> Strarix10/Agilex/N5X platforms reside in a register in the System
>>> Manager. Add a method to access that register through the syscon
>>> interface.
>>>
>>> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
>>> ---
>>>   drivers/mmc/host/dw_mmc-pltfm.c | 68 ++++++++++++++++++++++++++++++++-
>>>   1 file changed, 67 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
>>> index 9901208be797..9e3237c18a9d 100644
>>> --- a/drivers/mmc/host/dw_mmc-pltfm.c
>>> +++ b/drivers/mmc/host/dw_mmc-pltfm.c
>>> @@ -17,10 +17,15 @@
>>>   #include <linux/mmc/host.h>
>>>   #include <linux/mmc/mmc.h>
>>>   #include <linux/of.h>
>>> +#include <linux/mfd/altera-sysmgr.h>
>>> +#include <linux/regmap.h>
>>>
>>>   #include "dw_mmc.h"
>>>   #include "dw_mmc-pltfm.h"
>>>
>>> +#define SYSMGR_SDMMC_CTRL_SET(smplsel, drvsel) \
>>> +       ((((smplsel) & 0x7) << 4) | (((drvsel) & 0x7) << 0))
>>> +
>>>   int dw_mci_pltfm_register(struct platform_device *pdev,
>>>                            const struct dw_mci_drv_data *drv_data)
>>>   {
>>> @@ -62,9 +67,70 @@ const struct dev_pm_ops dw_mci_pltfm_pmops = {
>>>   };
>>>   EXPORT_SYMBOL_GPL(dw_mci_pltfm_pmops);
>>>
>>> +static int dw_mci_socfpga_priv_init(struct dw_mci *host)
>>> +{
>>> +       struct device_node *np = host->dev->of_node;
>>> +       struct regmap *sys_mgr_base_addr;
>>> +       u32 clk_phase[2] = {0}, reg_offset;
>>> +       int i, rc, hs_timing;
>>> +
>>> +       rc = of_property_read_variable_u32_array(np, "clk-phase-sd-hs", &clk_phase[0], 2, 0);
>>
>> This needs to be documented through updated DT bindings.
> 
> Ok, but it looks like clk-phase-sd-hs is already documented in 
> Documentation/devicetree/bindings/mmc/mmc-controller.yaml

Not in next-20220919.

> 
> Should I create a specific documentation just for
> "altr,socfpga-dw-mshc" and document "clk-phase-sd-hs"?

All properties must be documented.

> 
>>
>>> +       if (rc) {
>>> +               sys_mgr_base_addr =
>>> +                       altr_sysmgr_regmap_lookup_by_phandle(np, "altr,sysmgr-syscon");
>>
>> DT bindings?
> 
> "altr,sysmgr-syscon" has already been documented in
> Documentation/devicetree/bindings/net/socfpga-dwmac.txt

This is not documentation of nodes you are changing here and in patch 1.

You linked altr,socfpga-stmmac and here you have altr,socfpga-dw-mshc...

Best regards,
Krzysztof
