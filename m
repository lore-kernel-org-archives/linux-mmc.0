Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC12FC4332F
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Nov 2022 18:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234720AbiKHSJj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 8 Nov 2022 13:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbiKHSJi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Nov 2022 13:09:38 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A2C1408B
        for <linux-mmc@vger.kernel.org>; Tue,  8 Nov 2022 10:09:37 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id u11so22315532ljk.6
        for <linux-mmc@vger.kernel.org>; Tue, 08 Nov 2022 10:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iNCXKrMAkXs2BI3AZ7/yGd4vcUJUTzN3Vd6P6Ds6uzQ=;
        b=yJMFCyD4siO4pgW5hcXM3+TeI1/HP2PR9lxzr8ZtrieeouwlJ+EzmyjrhABEaNCJw8
         7cEVxbnJdpgxpRiOSgjqOjsMMYWjc4x9PbWafIGl0KREngAN5d9UZpG7E07S/swf0HzR
         4JFoILUxV6b63XYf5Nau0sRMmmHkialf2sA0s/luWQJmZQ33KE6CUbf6yhx+sqh/JtL4
         M+iCog5MVyiKbvz40/TQBIEW3ad2TuZzBWdWkEjnrP/9eknsZ0V46FfxJIMaQULyOMCZ
         dxwor2ndjkssEANari81+gbT/JqaRFw/h3RJdYyvwIAstwbK1SlnGZnnisb0oZmVAf/1
         pADQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iNCXKrMAkXs2BI3AZ7/yGd4vcUJUTzN3Vd6P6Ds6uzQ=;
        b=gBE7aRIga84SDIUhxufhIYrDsmD5mxLu0QrxtfzUkwm4B7MEP5yAQYslsKDUcymHvh
         3u/VcFx5wVwHYNGA7Y914NV6Z+VwXFbLdhnXBNLhPTGO7il5Sl/uQE/BWBmGUeOAFJVP
         LMHN+imvgYkpUAf9fkN6T0ryNr5jlLKsMB28t/FdTwHKunbFl1ml9ykoaDiZ8EFcEz07
         q2KWUI+uxgUqtVFz9zPqumW4/doWug57nspfJEEmkjAnCsWXnEqtnwcvEnOxE75MpgHo
         /EXuIIlF2aGTYXwWDwHGf9+xHR28b5R51y5H9JMYsrzav72OZfMQmnq7BiNPtsXMux3k
         uUmg==
X-Gm-Message-State: ACrzQf0DcOwMvJHo0Bt3FmrikqMI/X7CDkm+KfcACGmuEmwhtMKFLdJs
        B3hXG/+1/ug0EnNTQ8tNscI/uw==
X-Google-Smtp-Source: AMsMyM5RorrExuMeriCEuLO1zVGFWCDPXI1TU14nSAWzhhyrFcpwZiVom1Hruz0t5OAfxkXEzGyLtQ==
X-Received: by 2002:a05:651c:506:b0:277:6da2:da7a with SMTP id o6-20020a05651c050600b002776da2da7amr12845719ljp.93.1667930976342;
        Tue, 08 Nov 2022 10:09:36 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id q10-20020a056512210a00b004a478c2f4desm1867700lfr.163.2022.11.08.10.09.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 10:09:35 -0800 (PST)
Message-ID: <a3a4f449-534b-f17f-6ff0-353a14f86700@linaro.org>
Date:   Tue, 8 Nov 2022 19:09:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v7 02/10] dt-bindings: mmc: rockchip-dw-mshc: Add
 power-domains property
Content-Language: en-US
To:     Jagan Teki <jagan@edgeble.ai>, Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        Johan Jonker <jbx6244@gmail.com>, linux-mmc@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
References: <20221108041400.157052-1-jagan@edgeble.ai>
 <20221108041400.157052-3-jagan@edgeble.ai>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221108041400.157052-3-jagan@edgeble.ai>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 08/11/2022 05:13, Jagan Teki wrote:
> Document power-domains property in rockchip dw controller.
> 
> RV1126 is using eMMC and SDIO power domains but SDMMC is not.
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

