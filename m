Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC72C77B61
	for <linux-mmc@archiver.kernel.org>; Sun, 16 Apr 2023 11:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjDPLRM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 16 Apr 2023 07:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjDPLRL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 16 Apr 2023 07:17:11 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7D12716
        for <linux-mmc@vger.kernel.org>; Sun, 16 Apr 2023 04:17:08 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id fy21so14027365ejb.9
        for <linux-mmc@vger.kernel.org>; Sun, 16 Apr 2023 04:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681643827; x=1684235827;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ghy1vBrrOopi9da9RaVmh1imZTAoDfQaq0rl9RiH25Y=;
        b=y9YlHJpe/YX4wp7vcZrsKZBoVJSGKCK29B/Zbvl9+dp04+scETF793YiUGa5AszuId
         MW6QXkqSxwfkzPxqqZzh+2SuPAddkf40bPvtBAZan0AHk7vuGE+Yke5m/z1d0rZVvB/O
         X+wfgWcyufFVZD58pUkURLe3WbJOHEwThWqGDZasYcpnewwSDJMRWcFfyqdUFg3LjJiQ
         YBAmL2zvFzlApO30+KrYCkN6MdOEvwabgeJLVJoszaseR/rQPvgsII8Xx4HyiDDVWedV
         6AYSJMulOY5+BQYTnn4bsBJuULpkctFOI7fVt3nuoT+1t4U1gkMea1ITPHYxjjTsOmmd
         Evjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681643827; x=1684235827;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ghy1vBrrOopi9da9RaVmh1imZTAoDfQaq0rl9RiH25Y=;
        b=BhtDcZG28ppid8jSh4wwTcIRZlxlfGvEXtXycjFOjRAFSrDo+sq+dZrFs135PQJsov
         hypwx1N7hidw1rWeq38SCCIoAPZmqqUglOynvbBNSANeBKEfe3R7RutT1yyDuK2Gmcdk
         7rQfCJCZ+CVls2FqbxGkbGFMA7nybFNzhLT0AK7rYkJQAxPGLIYfdWJUOSLJzP5MjJVs
         7dJU8UmZmIOkwQDRz3niwfw6blQGiS9c05l1mCEhf8fCZilu0gg41dLJPErJMlDIlklW
         c/90kOaconW/UZBVIlM71NqgbIp7uZEoiI0a3UyRaqZg5zOW9ERd/HugyXvd3bU6vTHt
         cLmA==
X-Gm-Message-State: AAQBX9et4EAABMR5jJrdZM89Dju67dguSrJiAUQ55YM2XGob8eNx1nCc
        1+D1U/eznYuxY0lDiJL1hpfGcw==
X-Google-Smtp-Source: AKy350YveBF6sakE3Jo3HZxABjt/Jvg0DDaSL6crvK8r3ou+E+gcURkLQxWBbdbPuTRK+kEZ4JnLdA==
X-Received: by 2002:a17:906:5610:b0:94e:ff98:44a7 with SMTP id f16-20020a170906561000b0094eff9844a7mr4579441ejq.72.1681643827424;
        Sun, 16 Apr 2023 04:17:07 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:29dd:ded4:3ccc:83db? ([2a02:810d:15c0:828:29dd:ded4:3ccc:83db])
        by smtp.gmail.com with ESMTPSA id p7-20020a170906784700b00947740a4373sm4927755ejm.81.2023.04.16.04.17.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 04:17:07 -0700 (PDT)
Message-ID: <1ff86f70-8e8d-5689-13f5-8f04a72cb600@linaro.org>
Date:   Sun, 16 Apr 2023 13:17:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH RFC v4 3/4] dt-binding: mmc: hi3798cv200-dw-mshc: convert
 to YAML and rename to histb-dw-mshc
Content-Language: en-US
To:     forbidden405@outlook.com, Ulf Hansson <ulf.hansson@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     tianshuliang <tianshuliang@hisilicon.com>,
        Jiancheng Xue <xuejiancheng@hisilicon.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        David Yang <mmyangfl@gmail.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230415-mmc-hi3798mv200-v4-0-44096e187f53@outlook.com>
 <20230415-mmc-hi3798mv200-v4-3-44096e187f53@outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230415-mmc-hi3798mv200-v4-3-44096e187f53@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 16/04/2023 11:19, Yang Xiwen via B4 Relay wrote:
> From: Yang Xiwen <forbidden405@outlook.com>
> 
> The renaming is due to the fact that it is now supporting SoCs other
> than Hi3798CV200.
> 
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>



This is an automated instruction, just in case, because many review tags
are being ignored. If you do not know the process, here is a short
explanation:

Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions, under or above your Signed-off-by tag. Tools like b4 can help
here. However, there's no need to repost patches *only* to add the tags.
The upstream maintainer will do that for acks received on the version
they apply.

https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540

Best regards,
Krzysztof

