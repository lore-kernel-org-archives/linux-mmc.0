Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0023AC61DA4
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Feb 2023 09:34:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjBPJex (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 16 Feb 2023 04:34:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjBPJev (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Feb 2023 04:34:51 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C9D30B35
        for <linux-mmc@vger.kernel.org>; Thu, 16 Feb 2023 01:34:50 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id d40so1900590eda.8
        for <linux-mmc@vger.kernel.org>; Thu, 16 Feb 2023 01:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=svWlMyI6wlXGD9pTyPzUoADIQ1sfpe0Mys0Y7wrsKnM=;
        b=rwf8EHFvW0kW3XMm2w0YFkmx4JAKlvc3viohkBszIsyDH4rHJxkgGQTMTYzPHB8CdA
         SB0OZaT0FjMRCP+17vXbb48oXVrHgcz8y61IbSU8kEvafFm6e/Tb5C3WQeFoUxKucYLY
         /FAqAabTRqkWk3mrC4u0qVUJ87mNykTjEaj7d/F1OlHYSxTnjKOQ5BfLKDAS6Bk+K+uh
         Jb31CjnwLO/PwkTnhZ1gyoBEU39tZJh2w3tBlZmOzEfBcw9WkUCJ39gmQB0tjEBSwxEL
         smyUnLonCeuB/bQULncq6F9uy7cCB1T1YDT52+jZGwRL8na7S/svLNFfjLxf/cttW6Wd
         tivw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=svWlMyI6wlXGD9pTyPzUoADIQ1sfpe0Mys0Y7wrsKnM=;
        b=gsaRV4y3d98PzsGD/a42NDKpO8Y09H9UpLH2sXFKUuSY5IJLQ2p47r/CBkITSO48eO
         uSAjvL4DPBL7ga0NJkb5UEjBHV3FMS/uhM2lAPZd8Z5qPQYJx0vJIlocPEVeO1yWA1ba
         +dT+sNKcCOHMDPlcdpwVmFGcNhls2fZf2x+uS5Cfi9mBwgVRbp2XENWvhpyc6cUCtYUj
         g4yl4jzMxEYreL2ERPo4fvBCtO/daRKAfY3DWQslPyEkfJ94J8ZJYh9DybKef1nBrQiu
         IRnZIQEMT/i/NX3jIDDui0+QL71OOgw0EKC3bZBdaTnd7G20mMXgZIoUdCJad3pDgRnz
         dj6Q==
X-Gm-Message-State: AO0yUKUFCUNUvjMe/9E3d0pnq2Prmm3ydA5d99G7j38J9Am+G20xb1EM
        jLii/ERIaLwtkbn3RlNoA0GjyA==
X-Google-Smtp-Source: AK7set/DywjlEvfAgh0u8LhyD8kSk6ewjjo4pcqO5hdesVF5obdc6Q7Zjlx6CvKJGOFdN4SGcYriag==
X-Received: by 2002:a05:6402:885:b0:4aa:a248:a153 with SMTP id e5-20020a056402088500b004aaa248a153mr5000114edy.3.1676540089178;
        Thu, 16 Feb 2023 01:34:49 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id r11-20020a170906c28b00b008b1347773ccsm577463ejz.144.2023.02.16.01.34.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 01:34:46 -0800 (PST)
Message-ID: <8e9d4c8a-40e0-65ef-ba72-ee8d1114ce97@linaro.org>
Date:   Thu, 16 Feb 2023 10:34:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 2/3] dt-bindings: mmc: meson-gx: support specifying cd
 interrupt
Content-Language: en-US
To:     Heiner Kallweit <hkallweit1@gmail.com>,
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <723119a3-7c7f-6447-254e-bc340a1fe2de@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 16/02/2023 10:29, Heiner Kallweit wrote:
> On 16.02.2023 10:18, Krzysztof Kozlowski wrote:
>> On 14/02/2023 22:42, Heiner Kallweit wrote:
>>> Support passing a second interrupt as card detect interrupt.
>>>
>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>>> ---
>>>  Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml
>>> index 46e235bf2..c8c30300d 100644
>>> --- a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml
>>> +++ b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml
>>> @@ -28,7 +28,7 @@ properties:
>>>      maxItems: 1
>>>  
>>>    interrupts:
>>> -    maxItems: 1
>>> +    maxItems: 2
>>
>> Wait, you now *require* (not support) cd interrupt, so this looks like
>> ABI break.
>>
> The second interrupt is optional. If not provided MMC core falls back to
> cd polling.

It is not. Your binding requires it. Did you test it on DTS without the
second interrupt?

> 
>> Second, you must describe the items.
>>
> OK, this will be added.


Best regards,
Krzysztof

