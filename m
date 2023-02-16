Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D39C636CC
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Feb 2023 09:30:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjBPJaD (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 16 Feb 2023 04:30:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjBPJaC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Feb 2023 04:30:02 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78BD6EF;
        Thu, 16 Feb 2023 01:30:01 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id v13so1839712eda.11;
        Thu, 16 Feb 2023 01:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rsPY97Yb49Y5FgSF3U74uFpbs2etiGuSLqzypFzafCw=;
        b=g8AHuQPOL0KbtLgNuQ3OlO2X1hOBflAHNSLWULqA0A4oZoC4vcFPCvaHiOm3nKowlG
         NPNN3ClJykznTJ14yuyCFW3Q0Hp88LVZYi/6q67H/GtxcanaKQPTqCF228Tu53MZ+vWX
         fcLDe3lwxdwD3V9aozeqfpC7sWgEh14YtWd8+NDWJW+5AhWcScDXnLJyx69p0gKrEa47
         pssYFIQ88X9XsdHYB/duGe7d0dYkxVaFyrk1ZnsXFYAwBl68/I95F8uIYhxjEYQVkRce
         lUPOsU+3MdE/aEQb7/hJzmfVskS859VLnr2V2SVdsqiNSfLdDQdLAtt5x+6AQfWQfAuQ
         ir+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rsPY97Yb49Y5FgSF3U74uFpbs2etiGuSLqzypFzafCw=;
        b=WVQvlAhJvNETfjonpGlgkeUJVFinliVDPZUC3sfyPRwIpg8p8R+28UANltNq5LCcng
         f9WAxI1uilzoth1SnKyj3ZcNsGve8Zxo6VASpftrnaaoSFMOoZW3t/aoI97KQC8okM5m
         c8XRKoS8jVPkJzq/frcV9+KVnDej3hbpaONw836rRjH76wC/ROCG4ioQVWao8cpSm//m
         KKqGheVsDjn7qj2hagGlvRwBJw/nyRjdHEfRa7N8A/LCpsByNIIAkX0H1/PA9Hg30oLg
         /wFgK819chI3CVk/baTN9zpGFFvODo9wx3ieWepeYhA8HEJSFHHT9emKKHvFUge3LDhb
         6MAg==
X-Gm-Message-State: AO0yUKU/UFPcfhTdFauG+Yzren7sK7xZsndE5XXphH5rw6lriP1uezHD
        q+YNpSs5qkG3U5wnoMv5MVo=
X-Google-Smtp-Source: AK7set/As+S00Pk3E9sDFYTcqiBB9PX1GCdND6YbLhUo+BAQk/u4DugqNJ0Qj0Y47EFSy8ZbyNd4rg==
X-Received: by 2002:a05:6402:180f:b0:4ac:be53:1789 with SMTP id g15-20020a056402180f00b004acbe531789mr5027357edy.40.1676539799932;
        Thu, 16 Feb 2023 01:29:59 -0800 (PST)
Received: from ?IPV6:2a01:c23:c4f6:7c00:a103:b0a3:f168:e08f? (dynamic-2a01-0c23-c4f6-7c00-a103-b0a3-f168-e08f.c23.pool.telefonica.de. [2a01:c23:c4f6:7c00:a103:b0a3:f168:e08f])
        by smtp.googlemail.com with ESMTPSA id y23-20020a50ce17000000b004acc1374849sm548575edi.82.2023.02.16.01.29.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 01:29:59 -0800 (PST)
Message-ID: <723119a3-7c7f-6447-254e-bc340a1fe2de@gmail.com>
Date:   Thu, 16 Feb 2023 10:29:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v2 2/3] dt-bindings: mmc: meson-gx: support specifying cd
 interrupt
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
Content-Language: en-US
From:   Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <b87003f6-02a8-64fc-80fb-b90ca6bec37c@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 16.02.2023 10:18, Krzysztof Kozlowski wrote:
> On 14/02/2023 22:42, Heiner Kallweit wrote:
>> Support passing a second interrupt as card detect interrupt.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>>  Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml
>> index 46e235bf2..c8c30300d 100644
>> --- a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml
>> +++ b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml
>> @@ -28,7 +28,7 @@ properties:
>>      maxItems: 1
>>  
>>    interrupts:
>> -    maxItems: 1
>> +    maxItems: 2
> 
> Wait, you now *require* (not support) cd interrupt, so this looks like
> ABI break.
> 
The second interrupt is optional. If not provided MMC core falls back to
cd polling.

> Second, you must describe the items.
> 
OK, this will be added.

> Best regards,
> Krzysztof
> 

