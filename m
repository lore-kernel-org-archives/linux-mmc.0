Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0669FC636CC
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Feb 2023 19:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjBPTo6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 16 Feb 2023 14:44:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBPTo4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Feb 2023 14:44:56 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609C84E5C7;
        Thu, 16 Feb 2023 11:44:55 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id eq11so7033555edb.6;
        Thu, 16 Feb 2023 11:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X2TGP6B+IxbGPuvRSkNm+2wsr3WKYYRSuuWyBPcPIYA=;
        b=a+4Kk1je213yxbfmrjyyha9AtYMFDoIL4SK0XgUTfaia+t0Y1Xm5WgR3veSJI6sp0l
         aS5P6XGGFyhkLN+Z82ctnGUJ0apDpTvA4nIMzcpTaKDiAREsxRvFr9Y6Bf4dujioerZt
         VF5qlzAjoJrZo0MRBRzF+U4khIoGCsjGmAtwtICnVRU/wethTuKbYgxx1jfTXQkeRGtb
         H21cv/mSkxk12N+k7jiRO92NCfb9tWv1LbDS7+uhqFj6X6CLVdtTiutE199kFrFg5Q6T
         TEaoG0Rg2HKNNqjQndCjkCtiRM6KjDPqC3A2M9QjHVoKnNRGBIgvQvgq+yrBVPLXDcgs
         ezCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X2TGP6B+IxbGPuvRSkNm+2wsr3WKYYRSuuWyBPcPIYA=;
        b=LSmsonBeDtV9yKo6SonCjlcM+xnxi8iN+0UFod0vOsLNMN5XsFBGM1Jigzf1ax80Kj
         MwapDd8e/PK+srhhZE5oiexcRlfTC4Dl3RUot/0WYSoLk1wMyAsoSjMSgPnvRhuKlmyL
         l7jOkfmhauCh0qBRGudu12hHIrA2M2GeuYu3OK8lQUAQ/vzEMkxQSOs85CLTvHJDISs0
         LxZOTlzzdx/se7PpOE6tk3N8DaYA9C9jspb1psJBRz/+YY9+IAetD9MiHxU39gH+4A7X
         pgMEn8KZ+zBUf7ji6HmOIGWiLuvZVHcGEodvJHTrW0vBmoQHmfe1gwLu5c0dxVcRVh44
         9kUw==
X-Gm-Message-State: AO0yUKXqWfKLIUmb3zIaLk7Bp1msK73HdODM5sIMgJiuVa7/wDLW6h0O
        jBG05hf2fUyMeDpIzXMxG2w=
X-Google-Smtp-Source: AK7set+GOmNvxidy4aSiFfWjv0DKYhrvVBpSkAum+m/SU2QKrWYPb2rsd/xwToJUw+4+K92uaoo/Xw==
X-Received: by 2002:a17:906:84b:b0:8b1:800b:d2e9 with SMTP id f11-20020a170906084b00b008b1800bd2e9mr355562ejd.56.1676576693818;
        Thu, 16 Feb 2023 11:44:53 -0800 (PST)
Received: from ?IPV6:2a01:c23:c4f6:7c00:a039:5cde:fa47:7ceb? (dynamic-2a01-0c23-c4f6-7c00-a039-5cde-fa47-7ceb.c23.pool.telefonica.de. [2a01:c23:c4f6:7c00:a039:5cde:fa47:7ceb])
        by smtp.googlemail.com with ESMTPSA id n2-20020a170906118200b008b1426fd60dsm1182681eja.176.2023.02.16.11.44.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 11:44:53 -0800 (PST)
Message-ID: <3ac1eb14-e39e-066a-8066-a92572d0ba45@gmail.com>
Date:   Thu, 16 Feb 2023 20:44:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH] dt-bindings: mmc: meson-gx: fix interrupt binding
Content-Language: en-US
To:     neil.armstrong@linaro.org, Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <d5542f6e-920e-93cf-a453-b0601d03f48d@gmail.com>
 <21ae5f5f-2336-db5b-f98a-f83391e1becd@linaro.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <21ae5f5f-2336-db5b-f98a-f83391e1becd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 16.02.2023 13:52, Neil Armstrong wrote:
> On 16/02/2023 12:49, Heiner Kallweit wrote:
>> Reflect in the binding that the cd interrupt is optional,
>> and add a description of the interrupts.
>>
>> Fixes: 09b31a610328 ("dt-bindings: mmc: meson-gx: support specifying cd interrupt")
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>>   .../devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml         | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml
>> index c8c30300d..cd3f75821 100644
>> --- a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml
>> +++ b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml
>> @@ -28,7 +28,11 @@ properties:
>>       maxItems: 1
>>       interrupts:
>> +    minItems: 1
>>       maxItems: 2
>> +    description:
>> +      mmc controller instance interrupt
>> +      optional card detect interrupt
> 
> I would instead write:
> 
> interrupts:
>   minItems: 1
>   items:
>     - description: mmc controller instance
>     - description: card detect
> 
> and drop maxItems.
> 
Thanks for the hint! Bindings isn't really my area of expertise (yet).

> Neil
>>       clocks:
>>       maxItems: 3
> 

