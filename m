Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99671C6FA99
	for <linux-mmc@archiver.kernel.org>; Sun, 12 Mar 2023 17:29:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjCLR3x (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 12 Mar 2023 13:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjCLR3w (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 12 Mar 2023 13:29:52 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539D03669E
        for <linux-mmc@vger.kernel.org>; Sun, 12 Mar 2023 10:29:50 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id x3so39827169edb.10
        for <linux-mmc@vger.kernel.org>; Sun, 12 Mar 2023 10:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678642189;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IxYyqt7C2nkBChfw7xRazh33TpU0YO4rKgpItaaFBK8=;
        b=K0w8cqhO1cKFYNFzU+/0Vr3R4cYQ4RAQN0/6zsxLjlIbTfB6ZJ7dmisxSteUToo8fY
         4wBitFWrzT+/N5Z8is240LXqFrA/QXhCmZfECaB91+PhIbTaKiP/Rp35OU96kHp/LLuF
         hyYNbIr0dmiiERgXBLooZnaE4pffxHmcIQxt7tvFivo6AhZg5YCG0Kryi9h/BKt+81+a
         Jh8f0xf4LBLHapc8482rhx3a97IqSkf54nLtoko0rCFZ+8sRGWYhvJ15mSbEo84jR/Ke
         /P1o0g9lZ9qXu/5VDad9jP8ym+CTCT80NthVDp/L+kxNp+CmCWD/TyLNgOnL1M28clCI
         XmpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678642189;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IxYyqt7C2nkBChfw7xRazh33TpU0YO4rKgpItaaFBK8=;
        b=oggItgAlIUYUdDaYV1oeuiPVB0psPero+ODw67Ezg55gPFuEja2UiYKqAYuQTtq2wk
         5GGt8WW7RWNrPR+5bGxXsjBUu0QR97988WugcpvdNro/JEMQinmoOZ9xYfVOhYb8+G4v
         /ts42P60vNJLLAmer4qZa564zW1YuNqt2LzZNd60WJAkB/7i4EVu9Sk7UbmCp7Yhwam6
         MsGyjiTEeBK9lxaG4O4ftG1zBYBamzyQSgg3rK+Wv3rzwQxtgsCFFBzJsG5aYFLqIoXc
         zI5OCEk+8Q+VvTi+ojHsElvHk38Usgh0qPTQJVIlVeHihLeYhGpRn1rqakAxtx5btQgn
         FsBw==
X-Gm-Message-State: AO0yUKUqKKRWWhtWGepc+F9LOWN/diJm/WZmn660Eugah+IcmIontP/u
        ch0EuI4JfWht6oz8/FnvkaG5JA==
X-Google-Smtp-Source: AK7set/8/0R7GalSBzGksp0r8lZEcqHwCIpaSotNVtlyPhysgmKmdXCCL1e3cm1oz4it6IEqgemeRA==
X-Received: by 2002:a17:906:4fd5:b0:927:8285:18a3 with SMTP id i21-20020a1709064fd500b00927828518a3mr2046753ejw.0.1678642188807;
        Sun, 12 Mar 2023 10:29:48 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d9f6:3e61:beeb:295a? ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id o11-20020a17090637cb00b00926f89e2213sm724617ejc.190.2023.03.12.10.29.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 10:29:48 -0700 (PDT)
Message-ID: <9f197b20-499a-7437-bff3-c5fbd39b5387@linaro.org>
Date:   Sun, 12 Mar 2023 18:29:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 1/2] dt-bindings: exynos-dw-mshc-common: add exynos78xx
 variants
Content-Language: en-US
To:     Sergey Lisov <sleirsgoevy@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Jaehoon Chung <jh80.chung@samsung.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <640e0b2d.c20a0220.63661.19a4@mx.google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <640e0b2d.c20a0220.63661.19a4@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 12/03/2023 18:26, Sergey Lisov wrote:
>> Thanks for letting me know.
>>
>> https://elixir.bootlin.com/linux/v6.1-rc1/source/Documentation/devicetree/bindings/writing-bindings.rst#L42
> 
> OK, at least its codified somewhere.

You got feedback from Devicetree maintainer. It should have been enough.

> Still, this results in the opposite
> effect: DTBs written for one SoC, using compatibles from other SoCs just
> because "they are the same anyway". And doing this properly, well, results
> in essentially duplicate compatibles.
> 
> And "fallback compatibles" won't solve this case anyway, as there is no
> common compatible that denotes "Exynos7 DW-MMC that has the bug".

Your explanation is not correct and we talked about this so many times.
No wildcards in compatibles. That's the rule. You cannot find any
argument good enough to break that rule.

Best regards,
Krzysztof

