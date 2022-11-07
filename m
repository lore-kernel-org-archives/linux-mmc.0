Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9860C43219
	for <linux-mmc@archiver.kernel.org>; Mon,  7 Nov 2022 18:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbiKGSKl (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 7 Nov 2022 13:10:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232632AbiKGSKX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Nov 2022 13:10:23 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C539E102B
        for <linux-mmc@vger.kernel.org>; Mon,  7 Nov 2022 10:07:53 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id d20so17510102ljc.12
        for <linux-mmc@vger.kernel.org>; Mon, 07 Nov 2022 10:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xGzbPcp3W+tJwRD4VsrTgzgj+M76xrWtKtvZNseJPN8=;
        b=tMMQX/EhEI104xOjR7D40/vjZerzqkE7YOM/NNgNo/nOX8DL0BEnIfJl8zcECj+NkE
         cadU64L/sgpu0wY5ZV96Yb+mkw7ywnJnDe3Ea1hbryuUD0cda2pSZH8DUBYpePhtNQLE
         P/PBIPCicYFLHAk0r9K9gBwMbq33LLtmNqzH+u+GmHtL5q5Jz6+H2LzOHoXOT84j/Dex
         CbPy1DuQn+BRFo8C2DK3QwzcsHrm5SG+IGF2PbYJLd8o3AZxPA5pLKoJosrvNh8WdTlo
         d1IO2cs3FnKgjAT48ArkvYMDoL+gOMDIdeKt0izwaeQPvYut7JBuIwVk/cgorl99m4Qn
         rfXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xGzbPcp3W+tJwRD4VsrTgzgj+M76xrWtKtvZNseJPN8=;
        b=Rn0P8EFJpzc6Hyby51rQmZyFAdhOraUnovNZv5NHaeVXa1v714R/O3zoTH2OH5cjAz
         p7w/Wm2frsmoJccFnWrBG6D30411JqlEthuSY4PYA9syNHy+ccEp3H0LFMw4a+xOBwLb
         /Z9Bzl0mOg8la1Ke6gs5gwS1GXBfCiJlhVdd/ticiXhkIrs0ojrDueG2cdUPl5+/Hoo8
         bp1kdeK5MeVvq2/0nwNEeU/OxXRrJ36aJHUu2dQeKxDsvCjSxqWaPCnAr23SWKtLbhIZ
         UF88QIavmXpCvwJ2gwp1FtafBZSg3rhOxj06dCMQt+S636cWqDY7eEsPz+cMtrX7z1oN
         GjLA==
X-Gm-Message-State: ACrzQf3ltJSHMAs9p9Kpt/ZFzYIu6IT3vh+oQDoWURFFIW2rr38gHDRE
        ABNQ09pkVlg1l8EZeB0uewd9kA==
X-Google-Smtp-Source: AMsMyM4colD8URbCBCk00gHoMXuiVYuBgD10XMX2nAPdi4CJlhl6C+S4xQpxwkfOU66wmdNcOqemvw==
X-Received: by 2002:a2e:7303:0:b0:277:c7c:9c61 with SMTP id o3-20020a2e7303000000b002770c7c9c61mr18768509ljc.274.1667844472153;
        Mon, 07 Nov 2022 10:07:52 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id g13-20020a0565123b8d00b004afac783b5esm1354123lfv.238.2022.11.07.10.07.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 10:07:51 -0800 (PST)
Message-ID: <ea5d34cd-61eb-b811-5bc1-9846a642a738@linaro.org>
Date:   Mon, 7 Nov 2022 19:07:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCHv2 1/1] dt-bindings: mmc: sdhci-of-dwcmhsc: Add reset
 support
Content-Language: en-US
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Jisheng Zhang <jszhang@kernel.org>, linux-mmc@vger.kernel.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        kernel@collabora.com
References: <20221107173310.60503-1-sebastian.reichel@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221107173310.60503-1-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 07/11/2022 18:33, Sebastian Reichel wrote:
> Properly describe reset related properties in the binding.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

