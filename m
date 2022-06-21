Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C21CAC433EF
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Jun 2022 07:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346460AbiFUHAn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 21 Jun 2022 03:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346465AbiFUHAm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Jun 2022 03:00:42 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C364F205CE
        for <linux-mmc@vger.kernel.org>; Tue, 21 Jun 2022 00:00:39 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id ej4so14082249edb.7
        for <linux-mmc@vger.kernel.org>; Tue, 21 Jun 2022 00:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Umi7gvI0e0YKpUxgohz3zUuvtGBqyHu5yi8Lq1Zp0LE=;
        b=hRCfT6S086KX/lHoBEMeJk2FY72O/NtB3hnANPsIQqtuqSvu8r65BMOub4XNwzisgR
         R6lK5U1f2eaHLf4mRj6G2D8RdFA3lyN+L347egVZyhh4h0Gx4dIEUDa4G19Av44ke/Qy
         1Bf1E70RN41FxtW2PSk7qHT9PiiEV4E9d2qD85jFJe6rfNxRnYLtwt1awQnVKiasRtrg
         WhUTHXWduf/XLduolQ9wjEaTQsnLVVv8mFhSh06RT7X2757xEzvOSYe1Fge+s2ApJ5QW
         Bzuq5Id/zctN5O+qTkb9Vrkf2pMgZZG2Tx/dNqYVgaW24uxhoPnq9yN/ok7Ywr0lXemC
         XDMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Umi7gvI0e0YKpUxgohz3zUuvtGBqyHu5yi8Lq1Zp0LE=;
        b=NsyTaVUmnPR63KgE6sU8jRIyeLAaJkxODxbrCmFZXm6lwA3JrxarsZMnmUgnx/2qfB
         GsgEFV2LzBsIuKpFMhz7Mm8cBmbNk7ICJmzdTp/XtwyVMcaSSHcDPZODq4kEhA+Ejrt7
         baEkkUfcHwjpA55Tt5Y1Aa0KYNJ07gdm4c/lXh0nkqfU8f/QX+3Jp2ShiJO38+htLgAn
         RchvaMky7IJHc7z1u3I7BzDZT3YQJS1hiL+i/tTI6bQe449Wh8kSlnk99GtKPDqyhP67
         +XgmCKbbyWKAV2q1cSyfqf9b3u8+56iJCcl52ubcupLE0dcZway5F2IhNTA8ByC45aMQ
         bzMw==
X-Gm-Message-State: AJIora94vUUHhBn7JpVcQyD4Wjy3I+MRMjAVpxyLvx65lK44k+XJeeVT
        2LdeC6IlkenxM2gIMPUz3tABNg==
X-Google-Smtp-Source: AGRyM1tHLVkz4w72JZUmumPtAfYpFoylwgNqZyM99ydtgpk1yP+I24yDUI9ZxhMnRxx5HDmxb9FVww==
X-Received: by 2002:a05:6402:5ce:b0:435:65f3:38c2 with SMTP id n14-20020a05640205ce00b0043565f338c2mr23087899edx.347.1655794838254;
        Tue, 21 Jun 2022 00:00:38 -0700 (PDT)
Received: from [192.168.0.216] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id q17-20020a17090676d100b006fea59ef3a5sm7115446ejn.32.2022.06.21.00.00.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 00:00:37 -0700 (PDT)
Message-ID: <4ff85493-665a-ee58-07d3-80178c49223b@linaro.org>
Date:   Tue, 21 Jun 2022 09:00:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v5 04/15] dt-bindings: spi: dw: Add AMD Pensando Elba SoC
 SPI Controller bindings
Content-Language: en-US
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Brad Larson <brad@pensando.io>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, adrian.hunter@intel.com,
        alcooperx@gmail.com, andy.shevchenko@gmail.com, arnd@arndb.de,
        blarson@amd.com, brijeshkumar.singh@amd.com,
        catalin.marinas@arm.com, gsomlo@gmail.com, gerg@linux-m68k.org,
        krzysztof.kozlowski+dt@linaro.org, lee.jones@linaro.org,
        broonie@kernel.org, yamada.masahiro@socionext.com,
        p.zabel@pengutronix.de, piotrs@cadence.com, p.yadav@ti.com,
        rdunlap@infradead.org, robh+dt@kernel.org, samuel@sholland.org,
        suravee.suthikulpanit@amd.com, thomas.lendacky@amd.com,
        ulf.hansson@linaro.org, will@kernel.org, devicetree@vger.kernel.org
References: <20220613195658.5607-1-brad@pensando.io>
 <20220613195658.5607-5-brad@pensando.io>
 <20220620193044.ihxfn6kddif7j5la@mobilestation>
 <0a68aa72-df85-cf78-dcca-2d75038234c6@kernel.org>
 <20220620200445.yew3vo3pnjhos7rs@mobilestation>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220620200445.yew3vo3pnjhos7rs@mobilestation>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 20/06/2022 22:04, Serge Semin wrote:
> On Mon, Jun 20, 2022 at 09:46:25PM +0200, Krzysztof Kozlowski wrote:
>> On 20/06/2022 21:30, Serge Semin wrote:
>>> On Mon, Jun 13, 2022 at 12:56:47PM -0700, Brad Larson wrote:
>>>> From: Brad Larson <blarson@amd.com>
>>>>
>>>> The AMD Pensando Elba SoC has integrated the DW APB SPI Controller
>>>>
>>>> Signed-off-by: Brad Larson <blarson@amd.com>
>>>> ---
>>>>  Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml | 2 ++
>>>>  1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
>>>> index e25d44c218f2..2a55b947cffc 100644
>>>> --- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
>>>> +++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
>>>> @@ -73,6 +73,8 @@ properties:
>>>>                - renesas,r9a06g032-spi # RZ/N1D
>>>>                - renesas,r9a06g033-spi # RZ/N1S
>>>>            - const: renesas,rzn1-spi   # RZ/N1
>>>
>>>> +      - description: AMD Pensando Elba SoC SPI Controller
>>>> +        const: amd,pensando-elba-spi
>>>
>>> Not enough. The driver requires to have a phandle reference to the
>>> Pensando System Controller. So the property like
>>> "amd,pensando-elba-syscon" is also needed to be added to the DT schema
>>> otherwise should the dt-schema tool correctly handle the
>>> "unevaluatedProperties: false" setting (Rob says it isn't fully
>>> supported at the moment), the dtbs_check procedure will fail on your
>>> dts evaluation.
>>
> 
>> The property was here before, now removed, so I assume it was also
>> removed from the driver and DTS. Isn't that the case?
> 
> Ah, the property has been indeed removed. The driver now searches for
> the system controller by the next compatible string:
> "amd,pensando-elba-syscon" using the
> syscon_regmap_lookup_by_compatible() method. My mistake. Sorry for the
> noise.
> 
> * Though personally I'd prefer to have a property with the phandle
> reference in order to signify the connection between the system controller
> and the SPI-controller. Otherwise the implicit DT bindings like having
> the "amd,pensando-elba-syscon"-compatible syscon gets to be
> hidden behind the DT scene. But seeing we have already got the Microsemi
> platform with such semantic, I can't insist on fixing this.

I agree entirely, this should be explicit syscon-type property. Looking
up for compatibles:
 - creates hidden (not expressed via bindings) dependency between nodes,
 - is not portable and several people struggled with it later and needed
backward-compatible code (many examples, let's just give recent one: [1])


[1]
https://lore.kernel.org/all/20220619151225.209029-10-tmaimon77@gmail.com/


Best regards,
Krzysztof
