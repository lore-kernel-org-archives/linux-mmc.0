Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B57C433EF
	for <linux-mmc@archiver.kernel.org>; Mon, 11 Jul 2022 11:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbiGKL0x (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 11 Jul 2022 07:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiGKL0M (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Jul 2022 07:26:12 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B473DF05
        for <linux-mmc@vger.kernel.org>; Mon, 11 Jul 2022 04:02:35 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id bf9so8025962lfb.13
        for <linux-mmc@vger.kernel.org>; Mon, 11 Jul 2022 04:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=MeyCZN/nvsiRNNCAAR15uWNXyKxL+fyysaeRMmXtoJA=;
        b=D4OVU2SdZDl1a2Jmvol1Su2acwSKKhbqYZKZn6/Qc8eT2iND/KO9t9DapzIOJtxYXe
         Me3ljHAhTzWcyA62SHeecPkZ9BDGif3nIQh/4L6wxXSsOfYRKcaerfZkctH+lPcPcaXR
         9nwslGSNuJR55nrpcs0QsF89vgcW8SmISLwf7h2vLLq4lkAVjwTUIVYO0/uBy/LsND6c
         fUnyCOa9fgewXhbnW8EdRaMnWofxJvAWbnpmaDz4VV5KTLCEbsVuj6MgdDHsj0ja4Cm4
         7iMTtMjKPL9Xg15Ww0kzLHvpVQi9YC6P0O0itH4F7zJK4x/PaxvCYROPFLopO6UyHl1u
         Htcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MeyCZN/nvsiRNNCAAR15uWNXyKxL+fyysaeRMmXtoJA=;
        b=HcQfxTERIszXl3tsWVz/OcEj6ukVpV1/AY+xlXqPQqMFhQENKImL5nzbRHWxr0damL
         DUp5i0qISL8Dyc5mD8FZ5cvwHJXeFgCCpHnH/q3ZCZhGzQiH/IkZAyxRZwzIq3tkCMfv
         UtNa7WNIS+/roGfq8hdfFq4mIUB1Pg3eJb30NxDW0+8c3uLOVkOYkvvW+jBWTCvvDByC
         Dz+r36EHzXO50YMBWA3njtQFqmep+GeHwzwf+eMRcPz5+ZugXY4mxhEYaOvVzSKpsdIm
         hk/UfocBaPawwLraGkrUYu3U2o1ndDhL8eG2gw6vSBC8+X1vDOt8vfwjkiBSBBaAS6s9
         VTqA==
X-Gm-Message-State: AJIora/c5EveK6eN0HuQyH8AUXILrtl3QaYW8GAKEOp0YyIskPCEyFTu
        uLvLSQcaAmECvsrs9DnTbNYAqA==
X-Google-Smtp-Source: AGRyM1vhnNj6aFdiTr/noru4YDiDuSvAcJcPUSJPfEwIMQ9AAASbaicPsvFT+S0lPieRGdaNAEiPLw==
X-Received: by 2002:a05:6512:3b20:b0:47f:8ca1:bd7 with SMTP id f32-20020a0565123b2000b0047f8ca10bd7mr10686215lfv.105.1657537353492;
        Mon, 11 Jul 2022 04:02:33 -0700 (PDT)
Received: from [10.0.0.8] (fwa5cab-55.bb.online.no. [88.92.171.55])
        by smtp.gmail.com with ESMTPSA id u10-20020ac258ca000000b00478a311d399sm1489609lfo.0.2022.07.11.04.02.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 04:02:32 -0700 (PDT)
Message-ID: <c8f8f5f4-173e-797d-e060-e5eaac7ca822@linaro.org>
Date:   Mon, 11 Jul 2022 13:02:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] dt-bindings: mmc: Add compatible for MediaTek MT8188
Content-Language: en-US
To:     Johnson Wang <johnson.wang@mediatek.com>, ulf.hansson@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220707054710.1396-1-johnson.wang@mediatek.com>
 <41e17a56-5cb0-8e90-c7ae-a7a56de986d0@linaro.org>
 <3216ec92952c7d722feaeb76986e0a6a54340646.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <3216ec92952c7d722feaeb76986e0a6a54340646.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 07/07/2022 09:30, Johnson Wang wrote:
> On Thu, 2022-07-07 at 08:46 +0200, Krzysztof Kozlowski wrote:
>> On 07/07/2022 07:47, Johnson Wang wrote:
>>> This commit adds dt-binding documentation of mmc for MediaTek
>>> MT8188 SoC
>>> platform.
>>>
>>> Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
>>> ---
>>>  Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
>>> b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
>>> index 2a2e9fa8c188..3fbf33ad4f7c 100644
>>> --- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
>>> +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
>>> @@ -32,6 +32,9 @@ properties:
>>>        - items:
>>>            - const: mediatek,mt8186-mmc
>>>            - const: mediatek,mt8183-mmc
>>> +      - items:
>>> +          - const: mediatek,mt8188-mmc
>>
>> You duplicate quite a lot. Use enum.
>>
>> Best regards,
>> Krzysztof
> 
> Hi Krzysztof,
> 
> Thanks for you suggestion.
> 
> I will use 'enum' to place this compatible strings.
> 
> Just like this:
> - items:
>     - enum:
>         - mediatek,mt8186-mmc
>         - mediatek,mt8188-mmc
>         - mediatek,mt8192-mmc
>         - mediatek,mt8195-mmc
>     - const: mediatek,mt8183-mmc
> 
> Moreover, it seems that missing an "items:" between oneOf and enum in
> the compatible property.
> Is my understanding wrong?

I did not propose to remove items, so where are they missing? Not sure
what you are asking about...

Best regards,
Krzysztof
