Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01D6C46467
	for <linux-mmc@archiver.kernel.org>; Sat,  7 Jan 2023 14:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbjAGOJf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 7 Jan 2023 09:09:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232807AbjAGOJ3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 7 Jan 2023 09:09:29 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D16644C
        for <linux-mmc@vger.kernel.org>; Sat,  7 Jan 2023 06:09:27 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id bi26-20020a05600c3d9a00b003d3404a89faso4854892wmb.1
        for <linux-mmc@vger.kernel.org>; Sat, 07 Jan 2023 06:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hTkxCHIheyNTVL7VydMOU8yLlFfEZgD4uztibkHROUs=;
        b=pPCDkW/wC3N3XkRh44F/mw4FVFibhSDoyP3GvliH4+QEb45EU9nZWmHa2Br/icn8sz
         eQi7UKn5aO1sP3wKFUhz5oP+jZhHFPZ8SEtLAjlYWm9tHVKUFH5R2Yd07coSodK4Ix12
         yjazvQ/KHxR277XPrswnjJUJPqdP1Q3MNRARalP4MCoBvyWH0laPV1jvda11Jvw7llLX
         //4o9lGM3RJA5HDDAuUrswNdO/Y2tSwQE2pJRSCt06sHs7ack1rcpQIORFNWN+B1rFCk
         nWkplHDqBOmfEeoAaoP/rOyYyZm/pR2mbq3XJnCTE8RK4Ur4Fjd/41N9doNycm7QjuiH
         jnQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hTkxCHIheyNTVL7VydMOU8yLlFfEZgD4uztibkHROUs=;
        b=MUCeugvYYsWTnielnKRql4hDwrHOctCodNU5f5sWsbo4G3GqjYplq1w0pU4fJKsrg6
         snw7NviA3eKYrqBjXJUQ0Mm1G3MwxTkdiP/6BEfJA4m0G/UXncK6x320Du9JsA6i2f+h
         /aQ2kf9SHyOqqJ9QM8ucrRWHC7PrNdRUptEgARDZQYM5x+ysm83cmSGG01Rlkb7aPr0P
         0ekr9XxsAiUi7guDe8telFgiIuFGOAS3Y49OCOdz8gKCAJt8aJvA3reK+khgc2Yqcf9i
         eVLh8Qt93Ndt615DLR4Os38Zo7aWSL/PYIWBIyLCdm9I9AHmzwdkW3uP/+zxOdOVTqON
         Dykw==
X-Gm-Message-State: AFqh2krJOAnSGuOCJJdrbbHqClV1ypXrFEhCTe/BNU1RfrpcNErm3D04
        5dsciaFc3yKzFhe8y9hx5mfviQ==
X-Google-Smtp-Source: AMrXdXtgyk1FFYnTGg0G6YSmSgCxjvtllGOOCra9Efk6HYqQMQ/5QPxNnQqaERO+Ep7bL0Vg7uITQQ==
X-Received: by 2002:a05:600c:1d1d:b0:3cf:81af:8b73 with SMTP id l29-20020a05600c1d1d00b003cf81af8b73mr41729069wms.23.1673100566549;
        Sat, 07 Jan 2023 06:09:26 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id ay13-20020a05600c1e0d00b003d34faca949sm5419825wmb.39.2023.01.07.06.09.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Jan 2023 06:09:26 -0800 (PST)
Message-ID: <0ab84fb8-6173-54e0-abad-a0e0e4ba82e7@linaro.org>
Date:   Sat, 7 Jan 2023 15:09:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] dt-bindings: mmc: fsl-imx-esdhc: allow more compatible
 combinations
Content-Language: en-US
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     ulf.hansson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230105213856.1828360-1-andreas@kemnade.info>
 <d7c407dc-0a6c-97d5-a06f-b432a923d74d@linaro.org>
 <20230106203358.14878660@aktux>
 <967cc7b7-f0bb-de37-52b9-7bfab05eadd7@linaro.org>
 <20230107144336.2ecff4f9@aktux>
 <123d1a56-8134-dc75-8b2a-b3836e727d4a@linaro.org>
 <20230107150740.0ba34aa1@aktux>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230107150740.0ba34aa1@aktux>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 07/01/2023 15:07, Andreas Kemnade wrote:
> On Sat, 7 Jan 2023 15:00:56 +0100
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
> [...]
>>>> I asked to remove half-compatible. Not to enforce.
>>>>  
> so you are saying that allowing
> compatible = "A", "B" 
> is not ok, if B is not fully compatible. I agree with that
> one.

I did not say that. It's not related to this problem.

Again - you cannot have device which is and is not compatible with
something else. It's not a Schroedinger's cat to be in two states,
unless you explicitly document the cases (there are exception). If this
is such exception, it requires it's own documentation.

Best regards,
Krzysztof

