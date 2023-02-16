Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18BF1C61DA4
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Feb 2023 09:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjBPJth (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 16 Feb 2023 04:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjBPJtg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Feb 2023 04:49:36 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F01CA36;
        Thu, 16 Feb 2023 01:49:35 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id f21so3730735ejq.8;
        Thu, 16 Feb 2023 01:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oW7oxsmghjRgR/cEvtjdj9saOc+kRxMn/Fex28SetPc=;
        b=dcbybFIFYOy3iMs8HnGAgDdGjQ32Pb/ch7AJenbUPn7vWRTK5AUUwxSq17fynnD5FS
         cr2QPcPFKw5Untn7PdDOk2/fRS6W1Qcdyg/WjiOgSKYvE46XX8vPkDt731pVgGFl/mWy
         u9wtOR/GEkqV7Am0CXOLFpyzHcJijHW9rttFROm1zQBg6XM7vR76bTJLx5qh5yjT40pD
         GLMheivSESZ+rZfhXh1Fu48r9reL9FziDY+NMOm96JR1ZIZGJF6nMY/Vc/RDwkEoGI2q
         gO+Oo/XPyOZGf82agnXKKurfAUcbrvaem4jPU7sYts1z/u8eHk/D8NR/YNa9QakILJJ4
         3DdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oW7oxsmghjRgR/cEvtjdj9saOc+kRxMn/Fex28SetPc=;
        b=AQ8wqcJHttjpdOJ65XJK06tNeebjzboYrDiGFsrBJBoCc0kpuY667plHi/7OS9fIs9
         pE6GEwDAYUE0R4VKX4Bz7FZ+IT1iSX8ZAAuBK+iDUfDiawhRBATBc8ibUE5EdCLDbTbN
         WVipCyXPPJgmsVhqa6DleYTHmqFd7FBtxKCTWXazoj93ZYbPca2mFCMOXYdw8M24MQW5
         kL2c8g88ztB7PUvaOXTs+tHDT5QmEhz/moMPSjn77jABwKi26m9/umWEnQqvDVvM9/d9
         bvdSrY49ytPwsASosP7Vu3XAGXdxnryOc2dEUjL6C2sYOXTAvYNyOWioIlsWCCVUOp87
         3ZEw==
X-Gm-Message-State: AO0yUKUwoL8TYcFJGaQOTGNSEdJzgLP4LLdEv7Vl8i8MZCM3iX8s/hrf
        F8meMeDy9hZlEJXE+x3kngo=
X-Google-Smtp-Source: AK7set8LaL2eQT8EV7iN1nX0qmp+S7YV4SUpTc9cLS0GsA+mCh4hU2NC8s1uLRwM+LDKyrMrGsY5DA==
X-Received: by 2002:a17:906:1d07:b0:8aa:c143:ffe1 with SMTP id n7-20020a1709061d0700b008aac143ffe1mr6016272ejh.48.1676540973842;
        Thu, 16 Feb 2023 01:49:33 -0800 (PST)
Received: from ?IPV6:2a01:c23:c4f6:7c00:a103:b0a3:f168:e08f? (dynamic-2a01-0c23-c4f6-7c00-a103-b0a3-f168-e08f.c23.pool.telefonica.de. [2a01:c23:c4f6:7c00:a103:b0a3:f168:e08f])
        by smtp.googlemail.com with ESMTPSA id kq16-20020a170906abd000b00889a77458dbsm589492ejb.21.2023.02.16.01.49.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 01:49:33 -0800 (PST)
Message-ID: <bcd24667-731d-8a6c-82aa-4763d033741a@gmail.com>
Date:   Thu, 16 Feb 2023 10:49:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v2 2/3] dt-bindings: mmc: meson-gx: support specifying cd
 interrupt
Content-Language: en-US
From:   Heiner Kallweit <hkallweit1@gmail.com>
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
 <eef6172c-6d74-16e2-bde2-324227ca174c@gmail.com>
In-Reply-To: <eef6172c-6d74-16e2-bde2-324227ca174c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 16.02.2023 10:41, Heiner Kallweit wrote:
> On 16.02.2023 10:34, Krzysztof Kozlowski wrote:
>> On 16/02/2023 10:29, Heiner Kallweit wrote:
>>> On 16.02.2023 10:18, Krzysztof Kozlowski wrote:
>>>> On 14/02/2023 22:42, Heiner Kallweit wrote:
>>>>> Support passing a second interrupt as card detect interrupt.
>>>>>
>>>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>>>>> ---
>>>>>  Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml | 2 +-
>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml
>>>>> index 46e235bf2..c8c30300d 100644
>>>>> --- a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml
>>>>> +++ b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml
>>>>> @@ -28,7 +28,7 @@ properties:
>>>>>      maxItems: 1
>>>>>  
>>>>>    interrupts:
>>>>> -    maxItems: 1
>>>>> +    maxItems: 2
>>>>
>>>> Wait, you now *require* (not support) cd interrupt, so this looks like
>>>> ABI break.
>>>>
>>> The second interrupt is optional. If not provided MMC core falls back to
>>> cd polling.
>>
>> It is not. Your binding requires it. Did you test it on DTS without the
>> second interrupt?
>>
> You're right, the binding misses a minItems 1. I'll add that and the
> interrupt description.
> 
Ulf,
do you require an add-on patch that fixes the binding issue or a
replacement patch?

>>>
>>>> Second, you must describe the items.
>>>>
>>> OK, this will be added.
>>
>>
>> Best regards,
>> Krzysztof
>>
> 

