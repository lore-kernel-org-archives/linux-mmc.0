Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78088C54E94
	for <linux-mmc@archiver.kernel.org>; Wed, 25 Jan 2023 16:21:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236046AbjAYQVY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 25 Jan 2023 11:21:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236003AbjAYQVF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Jan 2023 11:21:05 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC535A81A
        for <linux-mmc@vger.kernel.org>; Wed, 25 Jan 2023 08:20:40 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id b7so17607485wrt.3
        for <linux-mmc@vger.kernel.org>; Wed, 25 Jan 2023 08:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=slnyAV6MaHfo5cGXPJA+Cna3TI+4G6tWc0UbnmcgEDE=;
        b=k7ENkjp7CZQlib2dPzrpRmyMLk2gfukicdyDvoQkkc+q1l7jNEDMn/1hrTulY/mGuL
         rmn/nbCMhDb/1gRZ0hq7CjBuNiBDkqrqYHfBFAUJ0nK40NcvED+n0AuXvhUBOcx63/4N
         51U2sTdBFF3wO/OwGpjDEHZ3cfIPsEJccfBOdTIcsu1YXWO/Yt3c+H1zfOaXnfrK2JD4
         Pb2Bc83boGx592EkWRKK7EfwMsmGXOXUIXSnoOiF3IGHrfYwfz70IKyyftDrl0ABbm27
         KHhcVRwrGZzFbxL3oWULpRu75PA4WQzCiukeuIU5wJjF1vrVx76ocAwZtCU6kea00GFM
         bp4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=slnyAV6MaHfo5cGXPJA+Cna3TI+4G6tWc0UbnmcgEDE=;
        b=ODLM/clUgskRUUz5vViuiKkaGQ8my779ngAsJFiq28p9TnXiJQ2AwK1zakgi+T23P3
         ki75sENfKt9fcnsLD/JiKuBw93fuqsjcTCFwC5A5/xScehya4b6i17RzdCWaV2eYLZiF
         P1Bd9uMnHKqUaXVtC/VwZKCdeE+XVN2O8OJtLcrQz4CSCHxgd5nUgBuSJv+UA37SrVhT
         mz6ibwziOh4uubT4aoPykL6RuiXAFBVNDc0/egPGqYzjeWcUEORaChDE/xvW+5KN9kfY
         K6thCUReMgXA7rtkt3DAAdAN5AKt2jCVcV3Nm61ibaREleloC1g+w/nfQW9aHDxrfUO9
         McKw==
X-Gm-Message-State: AFqh2kpPswVo+PehqStyTBKafWY4m6Ag05PL+zgDXeXuLuWYT+hfyfOb
        pLGWh+cSxWjoO7hWzLiLRcOFFw==
X-Google-Smtp-Source: AMrXdXsErnmK+EAjDOryVC5A8CCD05H7UGeqMzi84c5REP0WfWlAHqqLMR+3jCLqqnJd+b6QMKPNPA==
X-Received: by 2002:a05:6000:5c2:b0:2bb:eb3d:8d20 with SMTP id bh2-20020a05600005c200b002bbeb3d8d20mr27126612wrb.43.1674663636289;
        Wed, 25 Jan 2023 08:20:36 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id n21-20020adf8b15000000b0028965dc7c6bsm4729019wra.73.2023.01.25.08.20.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 08:20:35 -0800 (PST)
Message-ID: <d6512673-a232-c8e5-45f7-e903fc1a01a7@linaro.org>
Date:   Wed, 25 Jan 2023 17:20:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 01/10] dt-bindings: pinctrl: qcom: add IPQ5332 pinctrl
To:     Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, ulf.hansson@linaro.org,
        linus.walleij@linaro.org, catalin.marinas@arm.com, will@kernel.org,
        shawnguo@kernel.org, arnd@arndb.de, marcel.ziswiler@toradex.com,
        dmitry.baryshkov@linaro.org, nfraprado@collabora.com,
        broonie@kernel.org, robimarko@gmail.com, quic_gurus@quicinc.com,
        bhupesh.sharma@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230125104520.89684-1-quic_kathirav@quicinc.com>
 <20230125104520.89684-2-quic_kathirav@quicinc.com>
 <50ec54ba-3468-3448-3fab-f28e97549ad2@linaro.org>
 <0b28f4a3-c445-7473-501b-39cbcfdb9889@quicinc.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <0b28f4a3-c445-7473-501b-39cbcfdb9889@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 25/01/2023 16:49, Kathiravan Thirumoorthy wrote:
>>
>>> @@ -0,0 +1,134 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/pinctrl/qcom,ipq5332-pinctrl.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Qualcomm IPQ5332 TLMM pin controller
>>> +
>>> +maintainers:
>>> +  - Bjorn Andersson <andersson@kernel.org>
>>> +  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> +
>>> +description: |
>>> +  Top Level Mode Multiplexer pin controller in Qualcomm IPQ5332 SoC.
>>> +
>>> +allOf:
>>> +  - $ref: /schemas/pinctrl/qcom,tlmm-common.yaml#
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: qcom,ipq5332-tlmm
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  interrupts: true
>> missing maxItems
>>
>> Rebase your patches on latest next and use the latest bindings and
>> drivers as starting point.
> 
> 
> Changes are based on v6.2-rc1.  I see the maxItems changes in 
> linux-next. Will update this in V2.

Your patches cannot be based on v6.2-rc1. They won't even apply. You
miss entire development of last month.
> 
> 
>>> +  interrupt-controller: true
>>> +  "#interrupt-cells": true
>>> +  gpio-controller: true
>>> +  "#gpio-cells": true
>>> +  gpio-ranges: true
>>> +  wakeup-parent: true
>>> +
>>> +  gpio-reserved-ranges:
>>> +    minItems: 1
>>> +    maxItems: 27
>>> +
>>> +  gpio-line-names:
>>> +    maxItems: 53
>> You have 54 GPIOs.
> 
> 
> Sorry, GPIO ranges are from 0-52, will update it in all places in V2.

Ah, then the gpio pattern needs a fix.


Best regards,
Krzysztof

