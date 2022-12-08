Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7CFFC4332F
	for <linux-mmc@archiver.kernel.org>; Thu,  8 Dec 2022 09:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiLHJCB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 8 Dec 2022 04:02:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiLHJBo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Dec 2022 04:01:44 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D5E67238
        for <linux-mmc@vger.kernel.org>; Thu,  8 Dec 2022 01:01:33 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id cf42so1069534lfb.1
        for <linux-mmc@vger.kernel.org>; Thu, 08 Dec 2022 01:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oupZ+kN7BsmQiiMOTzuSss+gc5CnRM8obTkN6ZAEyQ0=;
        b=PH5NstiDSUw9FjLTglzjiCMRNWEfR/Ko199Og1ANGhVysFgUBMD2jQ/p99HQ7F6jsq
         8RGfl9JBzqxJtHbEDJbQ9pCzBpEducsP8v9+4wzUxBdeFXCl1z4xXDXKbU+RA6hOxx7I
         6jMhHTgD91b3aSSaXEHrdovZZic5prvhy8bIvKipf3n4gLGEG/F5YDUFlF7z5J7hkMgo
         OLJs+TW2thjTm4F1HieLXWKJJ/V6+2QmcW0QyvdFY8m1aBd6mlAk55nQt/KBbzymCckG
         dtWYbvW0Sk7GlcDvSZNGxr3ltJj0S5GadjItC/u2mVMedd7546hIF7mWoiaij7p5+w8U
         x64A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oupZ+kN7BsmQiiMOTzuSss+gc5CnRM8obTkN6ZAEyQ0=;
        b=dgE7ekaaTHcDhUp9NnyvE5sB/So4iLkHgzvNJGjYgSlujf7PYUG9BtD7StzT2v0RU0
         u6s3sy6IxbTehWARkXJdOA0NxKFrl1iAMRwH5Bhx/5o7Qx5ZXIQ4b33VELMeiNyiH5nI
         RzOhRfxeOgnF8pDxjeuTD/e3qRt8tVCw9VblOeXYdNAbvUUcfETXmDkCd5VGYH3y7OhH
         AMgMfwJFbFIzQcsXR/ud6JA8vlAl77N++5xh8XZdWM+LS150aqz7FrkPs7HvJqm+mzC/
         WYCcUlfK+KkYdqQ21cUAweeyVLmFUZ5lk+UgudBaHJjFPMDEwBFcqmP84Vv9oacItw5+
         edkg==
X-Gm-Message-State: ANoB5plkPVTd0ab3eEKLCpV9OQNwNvzxkJmsU9E7M9PsbbwJ/4oTMUJu
        NLTfxgddtE2pv89+J2tKdMb81g==
X-Google-Smtp-Source: AA0mqf6Eagz9JgMi7kX/o8j2qajknHJ6NB91uNWrWH/4O1j4aIvU5N4Qo529XhOn4AFPQskDqCwoHg==
X-Received: by 2002:a05:6512:3b88:b0:4a3:9533:f4c9 with SMTP id g8-20020a0565123b8800b004a39533f4c9mr27019503lfv.615.1670490092121;
        Thu, 08 Dec 2022 01:01:32 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id o11-20020ac25e2b000000b004b55c1b5c66sm2196831lfg.157.2022.12.08.01.01.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 01:01:31 -0800 (PST)
Message-ID: <d9e92880-6efe-a528-efa8-2c49483d8530@linaro.org>
Date:   Thu, 8 Dec 2022 10:01:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v1 1/3] dt-bindings: mmc: Add bindings for StarFive
Content-Language: en-US
To:     William Qiu <william.qiu@starfivetech.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20221207131731.1291517-1-william.qiu@starfivetech.com>
 <20221207131731.1291517-2-william.qiu@starfivetech.com>
 <d7ecbbbf-5d6b-3254-b645-dbea369447ae@linaro.org>
 <b0dfc269-e06e-4f4d-7695-55c8522d6137@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <b0dfc269-e06e-4f4d-7695-55c8522d6137@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 08/12/2022 09:44, William Qiu wrote:
> 
>>> +
>>> +  clock-names:
>>> +    minItems: 1
>>> +    items:
>>> +      - const: biu
>>> +      - const: ciu
>>> +
>>> +  interrupts:
>>> +    maxItems: 1
>>> +
>>> +  starfive,sys-syscon:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>>> +    description:
>>> +      The desired number of times that the host execute tuning when needed.
>>
>> That's not matching the property name. Missing number of items... this
>> is anyway confusing. Why number of tuning tries is a property of DT?
>>
> 
> Will update the description.

I propose first to explain what is it. Because it is not about
description only, but also type. Your driver uses this as syscon, so
this cannot be uint32-array but phandle-array...

Best regards,
Krzysztof

