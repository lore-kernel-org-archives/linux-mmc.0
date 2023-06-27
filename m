Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 788E7EB64D9
	for <linux-mmc@archiver.kernel.org>; Tue, 27 Jun 2023 13:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjF0NhQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 27 Jun 2023 09:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjF0NhP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Jun 2023 09:37:15 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40C02D59
        for <linux-mmc@vger.kernel.org>; Tue, 27 Jun 2023 06:37:13 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9891c73e0fbso818554966b.1
        for <linux-mmc@vger.kernel.org>; Tue, 27 Jun 2023 06:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687873032; x=1690465032;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zjn+m5IJNtwxVd6i0hgU1RQ6FBtfGTIs6fzcd38U4Jo=;
        b=fNEBITWaLLZCAFNoYkPQcaqn8qMhZVIH4tjFvICdPg7UH3NeqXNX09RHP19a29h8zL
         4oAQbPXWNPZNaKyMaBoMMpnr3blZrVLVT+DPEMnbhP/nYY630gZvlRFHQf5Dt9WK1Ivv
         w+F57Jh2DuPGYZUOe6//JFfeQ26Zj+R3yIJY0YEd4Y1GcNSEgJU4n81O8HhrCtmV7Au8
         Ng99JeM0diRKB11msr6h9cupKH9Ja0Cu00SxxaKQO+3RcJRSKiJf0hQp4SYummOo4zJD
         RiOuRzv6hTEdPBAq27Ayw2sN0TWu3A7VVbjCZovndTpye+j30JleNaSolsnjq9bXaDS7
         TBgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687873032; x=1690465032;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zjn+m5IJNtwxVd6i0hgU1RQ6FBtfGTIs6fzcd38U4Jo=;
        b=JTLw7+720kv44UkNVZvqAXQXDtPGd3ToTLbO40hJMR1YQf5TCDaJ+rbxzF6q2MtGOo
         oWyDFTLrlj/sIXPTInPioTlbH9KNKnva4ssBBDvPdQYtQHK9fd4qeJg2t8jJAiCaP4w4
         +67cGaLt472jo85vA6LV9gfIkW8Num41MHwb6Q/TloxfHDWyTJOPY6Wq0og7A8flRAAi
         ovGGBXKhSivEtIzSI2e58umROqseG0N8+DJbrBZfsaBLKPIs2Ai73ZO67Pj50fmkl/qY
         fy0DV7Km/W4FJDTj3gjDwdoYSazCuOhhh/KI67vUgp19TjF8L0piYKCnwknthdMsCOgw
         cB2Q==
X-Gm-Message-State: AC+VfDw7R06Go8DWO7fgzaQRHaPPwKa2qnI2Q95D0fSwx4hMw0kPcKHu
        /tQrE/Ij11iDhHqXecml/HtMhA==
X-Google-Smtp-Source: ACHHUZ5KPZiM0xwFFkDm9ASG5ZrHrep9NXMTXPqfYF8cYZacARH7VH8i601pygIFhMDQpdq/gxZYxg==
X-Received: by 2002:a17:907:2da6:b0:988:15f4:fdba with SMTP id gt38-20020a1709072da600b0098815f4fdbamr29369700ejc.14.1687873032258;
        Tue, 27 Jun 2023 06:37:12 -0700 (PDT)
Received: from [10.230.170.72] (46-253-189-43.dynamic.monzoon.net. [46.253.189.43])
        by smtp.gmail.com with ESMTPSA id i10-20020a170906250a00b0096a6be0b66dsm4573216ejb.208.2023.06.27.06.37.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 06:37:11 -0700 (PDT)
Message-ID: <b6ef76a8-95fc-aa76-d811-ed25ccb8ad8e@linaro.org>
Date:   Tue, 27 Jun 2023 15:37:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Aw: Re: [PATCH v1 1/2] dt-bindings: mmc: mtk-sd: update
 assigned-clocks/clock-parents for mt7986
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230625191151.7808-1-linux@fw-web.de>
 <20230625191151.7808-2-linux@fw-web.de>
 <91411797-18b4-f515-d6c0-ca0f8ff39696@linaro.org>
 <trinity-28cad1dc-f8e0-4f65-874f-a2392c2e878e-1687867773444@3c-app-gmx-bs07>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <trinity-28cad1dc-f8e0-4f65-874f-a2392c2e878e-1687867773444@3c-app-gmx-bs07>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 27/06/2023 14:09, Frank Wunderlich wrote:
>> Gesendet: Dienstag, 27. Juni 2023 um 12:44 Uhr
>> Von: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
>> Betreff: Re: [PATCH v1 1/2] dt-bindings: mmc: mtk-sd: update assigned-clocks/clock-parents for mt7986
>>
>> On 25/06/2023 21:11, Frank Wunderlich wrote:
>>> From: Frank Wunderlich <frank-w@public-files.de>
>>>
>>> MT7986 has 2 clock-parents so update the binding for it.
>>
>> You didn't test it, I think. If you do, then you will see errors from
>> other trees.
> 
> Hi,
> 
> i tested it of course...which errors do you see?

The top-level said it can be maximum 1, so raising it in allOf:if:then:
should not be enough

> 11
> this is basicly how i tested it (in case anything has changed):
> 
>         logfile=dtbs_arm64.log
>         exec 3> >(tee $logfile)
>         ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make DT_CHECKER_FLAGS=-m dt_binding_check 2>&3
>         if [[ $? -ne 0 ]];then echo "arm64 binding check failed!";cat $logfile;exit 1;fi
>         ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make defconfig #dtbs_check need kernel-config
>         ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make -j8 DT_CHECKER_FLAGS=-m dtbs_check 2>&3
>         if [[ $? -ne 0 ]];then echo "arm64 dtbs_check failed!";cat $logfile;exit 1;fi

A bit over-complicated... why not running dtbs_check against the schema
you changed?

> 
> and looked into the resulting logfile for keywords like mmc like mtk-sd
> 
> i tried running dtbs_check with passing the yaml-file, but of course all compatibles not matching this file were reported.
> 
> ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make -j6 DT_CHECKER_FLAGS=-m dtbs_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> 
> but this spits out many errors "failed to match any schema with compatible" because i defined only the changed one...
> 
> maybe there is another way to check only one yaml file against all dtbs without these unrelated errors.
> 
> pipeline in dt-bindings-patchwork is clean too
> https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230625191151.7808-2-linux@fw-web.de/

Maybe that binding just fails to apply to DTS because of missing or not
correct compatibles.

> 
>> Anyway, I don't understand why defining it in the first place. Just drop
>> the assigned-clock* from the binding.
> 
> as it was defined (not looked where it was used) i only used the soc-specific branch to update the MaxItems...just to not break anything. After that the message i got before was fixed
> 
> arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dtb: mmc@11230000: assigned-clocks: [[4, 35], [4, 34]] is too long
> arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dtb: mmc@11230000: assigned-clock-parents: [[5, 6], [4, 18]] is too long
> 
> but if the right way is to drop the MaxItems from generic (or the property itself - where is it taken from then?). The only
> include i see is Documentation/devicetree/bindings/mmc/mmc-controller.yaml and there the assigned-clock* is not defined. And the

The way is to entirely drop assigned-clocks. I don't think there are
much benefits of having them in the bindings. Maybe if specific rates
are required, then yes - device cannot work with other rates and you can
verify it with dtbs_check. But otherwise it is like adding values of
'reg' or 'interrupts'. Plus some board might require third item and then
what?

Best regards,
Krzysztof

