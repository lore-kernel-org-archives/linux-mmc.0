Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D77FC433B4
	for <linux-mmc@archiver.kernel.org>; Thu, 15 Apr 2021 08:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 662DA6023C
	for <linux-mmc@archiver.kernel.org>; Thu, 15 Apr 2021 08:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbhDOImJ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 15 Apr 2021 04:42:09 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38341 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbhDOImJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Apr 2021 04:42:09 -0400
Received: from mail-ed1-f70.google.com ([209.85.208.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lWxZK-0000B6-5d
        for linux-mmc@vger.kernel.org; Thu, 15 Apr 2021 08:41:46 +0000
Received: by mail-ed1-f70.google.com with SMTP id z3-20020a05640240c3b029037fb0c2bd3bso4828242edb.23
        for <linux-mmc@vger.kernel.org>; Thu, 15 Apr 2021 01:41:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bi9RAwPaSe5m0kq6sTRon9limNuBDI5Ubk2v5g6X0T8=;
        b=CBsJFjbtPe9m45afrRAjKiMD/YLYzsspb0LCJC9vJY18xrjAw2Frlu28IIDumIUAon
         LuEL2AjElq7onY3XZA+6GTTcdw0JaWjSgkaZ6PbFxPmCfUulCsPJslzRG/z/7343MTOK
         pSrTh4EbclMPR6YZ3t9fE1yCnGUjqmG7PXzJFksqk8XcoZGKnphHZ2X7APJmNmpL+wrc
         NIkEc7SeTNKCJwfbOlNHGjnMvcTT6ssNHGA0rBV3JjZ3MHQgujoMShggwPT5qm/FnGOa
         3vXun4q5Y5YA7POvLMPv+TBZKM9vhzpYVzSJYdGfht3yPI07VgZRVkZigP3FnEvSvNFS
         Oxvw==
X-Gm-Message-State: AOAM531eZmF5+nXT+cCNcvQy8Vvo8HfQzscfIlC5KsLTp+gMP7WwbwDH
        Gyol8AK7eDGog77yfiz8yMAdrr54AKsmbTMoaRr4sNGizUwAqZqPmkK3pvraB06BN1DkS1+9Ktd
        JAJgwoIkhsyHB4Nxy2OLe6JQRPQnEdi0Q2yESWQ==
X-Received: by 2002:a50:ec93:: with SMTP id e19mr2825515edr.50.1618476105956;
        Thu, 15 Apr 2021 01:41:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJymXAkMKWmdA2rywHv5eaow+dB7GK6Y4X4sednUAUsDZq1L6GupvMkgFX7rHbqiQqb8XW0RLQ==
X-Received: by 2002:a50:ec93:: with SMTP id e19mr2825500edr.50.1618476105796;
        Thu, 15 Apr 2021 01:41:45 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id a17sm1423391ejx.13.2021.04.15.01.41.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Apr 2021 01:41:45 -0700 (PDT)
Subject: Re: [PATCH 1/3] mmc: sdhci-s3c: fix possible NULL pointer dereference
 when probed via platform
To:     Sylwester Nawrocki <snawrocki@kernel.org>,
        Ben Dooks <ben-linux@fluff.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>
References: <20210414151242.102313-1-krzysztof.kozlowski@canonical.com>
 <a0ac5d21-acc1-825a-1585-f8d897902b14@canonical.com>
 <74059494-3610-c24e-7d09-b89106c0a396@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <f66d3d81-d824-18e9-18e2-098b1f85f664@canonical.com>
Date:   Thu, 15 Apr 2021 10:41:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <74059494-3610-c24e-7d09-b89106c0a396@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 14/04/2021 18:49, Sylwester Nawrocki wrote:
> On 14.04.2021 17:25, Krzysztof Kozlowski wrote:
>> On 14/04/2021 17:12, Krzysztof Kozlowski wrote:
>>> The driver can be matched by legacy platform way or OF-device matching.
>>> In the first case, of_match_node() can return NULL, which immediately
>>> would be dereferenced to get the match data.
>>>
>>> Addresses-Coverity: Dereference null return value
>>> Fixes: cd1b00eb24b0 ("mmc: sdhci-s3c: Add device tree support")
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> 
>>> -#ifdef CONFIG_OF
>>> -static const struct of_device_id sdhci_s3c_dt_match[];
>>> -#endif
>>> -
>>>   static inline struct sdhci_s3c_drv_data *sdhci_s3c_get_driver_data(
>>>   			struct platform_device *pdev)
>>>   {
>>>   #ifdef CONFIG_OF
>>> -	if (pdev->dev.of_node) {
>>> -		const struct of_device_id *match;
>>> -		match = of_match_node(sdhci_s3c_dt_match, pdev->dev.of_node);
>>
>> Now I have second thoughts whether NULL pointer can actually happen.  If
>> device is matched via platform/board files, maybe the pdev->dev.of_node
>> will be NULL thus skipping this branch?
>>
>> Could there be a case where device is matched via platform_device_id()
>> (which has different name than compatible!) and (pdev->dev.of_node) is
>> still assigned? Maybe in case of out of tree DTS?
> 
> That seems unlikely, the platform device would need to be initialized
> via board file and then its of_node assigned somehow. It doesn't make
> much sense to me. We either use board file or dtb to instantiate devices.
> 
>> Anyway, the patch makes the code simpler/smaller, so I still think it is
>> reasonable. Just the severity of issue is questionable...
> 
> Yes, the patch looks good. Similar cleanups are already done in most of
> the s3c/s5p/exynos drivers.

Thanks Sylwester, I'll resend with different description.


Best regards,
Krzysztof
