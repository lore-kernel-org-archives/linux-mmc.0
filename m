Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD25C433FE
	for <linux-mmc@archiver.kernel.org>; Tue, 18 Oct 2022 18:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbiJRS3N (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 18 Oct 2022 14:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbiJRS3H (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Oct 2022 14:29:07 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED66792C2
        for <linux-mmc@vger.kernel.org>; Tue, 18 Oct 2022 11:29:06 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id x13so9215721qkg.11
        for <linux-mmc@vger.kernel.org>; Tue, 18 Oct 2022 11:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jf71w/kMAtLTuZpw+aeynxFbJonRYosXdM0sN0F9YJQ=;
        b=QyPtio5WxIjCn0zb+wjna2OySfw2zIuGY3eeBmkvLgsfLTvwctfMJVZB2v95/HPEjG
         W/LzBAjV7nX5q6D6mL2vXB9CwWc35oUIbragvzLNU2vBhPn0HQMAXTeIOPg9WKdKbcj0
         oRvf72Vpd6pIkGIsOe4Nk11/QqMfBFl5IRjl5qnV6xLDQ9WYhqCtAVO6YWTPfYa2gFcf
         wqFEzpDL89d8RZ/IjCHCC6fAnFN4xyxb7vQbY2vloC81sFeyAZWHHFq7g6wqOjHucsWJ
         JzBwV7nPLTdeMJVBK6GvWgsUOvghhC4kEYesz8jNDvMMMLvCLzsoU5S6HglApZ8IPcMB
         JP4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jf71w/kMAtLTuZpw+aeynxFbJonRYosXdM0sN0F9YJQ=;
        b=AFC4TzsW/AdwOnmXYK+zWwngOqZJlPHEYWKBTQcwU0o1j1WDlDzuRvwW4Y4SEX8R6O
         wb+gRk2Ez5P4kxTh7n+YqZiRFpoyqcHI6A+uUg3EnCQZjRx25PYiY2BJa3EAFkXjGa2u
         BHGv7CGmREYOCDxKNvsc+HmpFyO76YB2z1BexUT07LrdjPH8n5joqN1QHUHFrCQxh11a
         jZ6AyVzIj4K/WOQnmsLvWRs/X0fGN1wjkZwbev61OyeYg6L4Rbmaa7T6LFXK0RAruOdD
         5tzY8u2pJHWY5opi6cFECUtgRhJMBVyEvTjDcLkQX85t+W7BM2IYkxF5RBszMAVRhxxS
         rP8A==
X-Gm-Message-State: ACrzQf1ssq/BBk5o2DGorlgo9eQbQ9fUzbkPUWMm1EuuAQgWXdPJKKoD
        p7SZs+yTnTH6yYZKNoRKB8Swrw==
X-Google-Smtp-Source: AMsMyM6Ka5CO8JW+udIuW1pTo+oi3POKxDhOQ2etdGB19wypOpdxMZP7SqrspYTEsdDdzY/4x5HGTg==
X-Received: by 2002:a05:620a:1452:b0:6ec:3f82:522b with SMTP id i18-20020a05620a145200b006ec3f82522bmr2719440qkl.402.1666117745901;
        Tue, 18 Oct 2022 11:29:05 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id y4-20020a37e304000000b006b5cc25535fsm2699092qki.99.2022.10.18.11.29.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 11:29:04 -0700 (PDT)
Message-ID: <5d87f1c3-1c73-054b-dca1-9f52939e187d@linaro.org>
Date:   Tue, 18 Oct 2022 14:29:03 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 2/2] dt-bingdings: mmc: Mediatek: add ICE clock
Content-Language: en-US
To:     Mengqi Zhang <mengqi.zhang@mediatek.com>,
        chaotian.jing@mediatek.com, ulf.hansson@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, wenbin.mei@mediatek.com
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221017142007.5408-1-mengqi.zhang@mediatek.com>
 <20221017142007.5408-3-mengqi.zhang@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221017142007.5408-3-mengqi.zhang@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 17/10/2022 10:20, Mengqi Zhang wrote:
> Document the binding for crypto clock of the Inline Crypto Engine
> of Mediatek SoCs.

This does not match the patch contents at all.

> 
> Signed-off-by: Mengqi Zhang <mengqi.zhang@mediatek.com>
> ---
>  Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Best regards,
Krzysztof

