Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3982C636D6
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Feb 2023 09:42:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjBPJme (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 16 Feb 2023 04:42:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjBPJmS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Feb 2023 04:42:18 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55047233C3;
        Thu, 16 Feb 2023 01:41:27 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id w3so1969347edc.2;
        Thu, 16 Feb 2023 01:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=quXyRkYVg6+mx+DMzdhBfayREmrzmAme5kuDUedg1kc=;
        b=SK8ihzgHkYOlKVe+I3WOjjwygNzbWa/CmSxn/zp/g1EHFhf0gqN3iUxqB+FnTetiiG
         n8+YYMHNm6WGjU7pwGBuSW7vmfxo3waI3++8SIy8nmMv72fmMx77cfIuYiLeCAapjZto
         ux+hMrc4/AIiwf0EZKaQ3kfFbRs2JGGpnMbLKq0edtordKzg++bIYpL4Cm/8IXXqEpM/
         K5rzI7gpLRA3U+6AMFARiaBXPiawTe9ZE3D7IapFDgrK3RdoKrHqE9U5ZxnDZIuNkmWJ
         cMJ2FH9q2X/xgiS5RY7Ni744PTaDx0TG8MbctGssCI01Sc14ewpilXrLWc8aoY4xtUhJ
         oMsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=quXyRkYVg6+mx+DMzdhBfayREmrzmAme5kuDUedg1kc=;
        b=Wn67W8zEcFgINMUcd8Vq8ee+q3K7vnAG9M2NevpOTsOoXtrgX4VZWFACN1UWv14Etr
         7FoyXqQ5iOfS5OBiN7o+QxtNKI4nDG6VSoLx788aJhTjAefByW8d/y7PfwxM+0T84dgQ
         27RYgGCUTn6ACUFvEL1gXlSyLVzItcKAVNksbzr9Uyl1DckWO163UviIsxBhM+GeO8+A
         DDW6fsczKi4mmk2fTn4h8+naAP2ytqUg1nM9URqb8Hsolj1Xno+3b1uzkJpUWdHP9GZt
         Ezbw4Wej5f0yNs1WhZ6byGm78LxvYT4ck7JcT2gDcqjpqQKoSyVoWVoVbO7zOTI/pmqE
         z9lQ==
X-Gm-Message-State: AO0yUKUkZ23iVrKZkjoK8p2Qqcm24zsXDvuRZAM7oi4QLb4Hm/DxZtO/
        0lY0MRnK+EK6lu7fSBPF3wg=
X-Google-Smtp-Source: AK7set9FD5gRjpvzIYNiDnade74qEPNtL0IkKV2yThzFTaeU2C7AjKii9DXNA59jARj5ihclamD8Ig==
X-Received: by 2002:aa7:d686:0:b0:499:4130:fae with SMTP id d6-20020aa7d686000000b0049941300faemr5402410edr.10.1676540481373;
        Thu, 16 Feb 2023 01:41:21 -0800 (PST)
Received: from ?IPV6:2a01:c23:c4f6:7c00:a103:b0a3:f168:e08f? (dynamic-2a01-0c23-c4f6-7c00-a103-b0a3-f168-e08f.c23.pool.telefonica.de. [2a01:c23:c4f6:7c00:a103:b0a3:f168:e08f])
        by smtp.googlemail.com with ESMTPSA id y42-20020a50bb2d000000b004ab1f97ca2csm575997ede.60.2023.02.16.01.41.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 01:41:21 -0800 (PST)
Message-ID: <eef6172c-6d74-16e2-bde2-324227ca174c@gmail.com>
Date:   Thu, 16 Feb 2023 10:41:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v2 2/3] dt-bindings: mmc: meson-gx: support specifying cd
 interrupt
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <15df9ef0-9b73-ca5a-d3cf-0585cd135bc5@gmail.com>
 <1c5996a5-491f-39d6-b120-bbef86473729@gmail.com>
 <b87003f6-02a8-64fc-80fb-b90ca6bec37c@linaro.org>
 <723119a3-7c7f-6447-254e-bc340a1fe2de@gmail.com>
 <8e9d4c8a-40e0-65ef-ba72-ee8d1114ce97@linaro.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <8e9d4c8a-40e0-65ef-ba72-ee8d1114ce97@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 16.02.2023 10:34, Krzysztof Kozlowski wrote:
> On 16/02/2023 10:29, Heiner Kallweit wrote:
>> On 16.02.2023 10:18, Krzysztof Kozlowski wrote:
>>> On 14/02/2023 22:42, Heiner Kallweit wrote:
>>>> Support passing a second interrupt as card detect interrupt.
>>>>
>>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>>>> ---
>>>>  Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml
>>>> index 46e235bf2..c8c30300d 100644
>>>> --- a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml
>>>> +++ b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml
>>>> @@ -28,7 +28,7 @@ properties:
>>>>      maxItems: 1
>>>>  
>>>>    interrupts:
>>>> -    maxItems: 1
>>>> +    maxItems: 2
>>>
>>> Wait, you now *require* (not support) cd interrupt, so this looks like
>>> ABI break.
>>>
>> The second interrupt is optional. If not provided MMC core falls back to
>> cd polling.
> 
> It is not. Your binding requires it. Did you test it on DTS without the
> second interrupt?
> 
You're right, the binding misses a minItems 1. I'll add that and the
interrupt description.

>>
>>> Second, you must describe the items.
>>>
>> OK, this will be added.
> 
> 
> Best regards,
> Krzysztof
> 

