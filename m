Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CECC6FA99
	for <linux-mmc@archiver.kernel.org>; Sun, 12 Mar 2023 17:09:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjCLRJQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 12 Mar 2023 13:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCLRJP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 12 Mar 2023 13:09:15 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC14206BD
        for <linux-mmc@vger.kernel.org>; Sun, 12 Mar 2023 10:09:12 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id y4so10320864edo.2
        for <linux-mmc@vger.kernel.org>; Sun, 12 Mar 2023 10:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678640951;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ur0YRak4azgO8ER8v9X1Sisyj3A0UjrzNilpdcu+HRk=;
        b=IIumIHOspITOgjriMp5ESfe4mr+ULnDvPBgJipm3w8unQT74U3jSJ0ZYxyJ3yA7l1w
         wzQzBmdo48JSDwrmGI5NNHrj6qB4LwBjNcm+y4kD7txoNzXnlv6W3m54HK8X+qOL5YA0
         IY6cyOAQZmZuL9WqiPPaoGuXb3wqfwCMSmzUPXNTQBiq1ErNXeA5UtcMRXcnh0xzlDK6
         87eT+bj19kVx2bzZiI8RHt/APiSIdokGzw/U5ZgKxoJrWKwXnQFPWFgHdszEeIHUE9RR
         w+1cESbv7K+k5D0KDdqDm0NdHJzG8kigScImY2DdcrNQeGzwaQwMCyLrse+TD39Ykv78
         /P2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678640951;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ur0YRak4azgO8ER8v9X1Sisyj3A0UjrzNilpdcu+HRk=;
        b=NwMqRcoD1iKCrkcO7FGbcbfkWVvT8Llvg9szTJM7WhF1uxwdjgaaCbTWSsph4gEmNC
         4eONxZYB5CEr/JZN5R9wiS82Zl9pUR8zgVZqn578vhIAgjBLBG2u/TdoFIZf8/Hp5x/z
         5NSKKTX6v1bFkThr8iParYNFA6uSesmM8qQfTXaNGjU9PNEgXx2RQ5MBHKvv1x6CiSHa
         IxAZeLVw/sOjw7G1KIORU3navVNflkyMOf/QQNcCNK/4i/3WooaJxTV3G3f2U4QTS7D7
         +i6jqvR6gq1UfDRDvYhlEuHVoqT42jb/vs57kBFRlCV9JzB3+HwYbm/o9cIdPq9qYPC6
         w4ZQ==
X-Gm-Message-State: AO0yUKW6VdLWGkXQHx9mHbLOxYWAN29far9c6GztVB1CvxXge//6reSv
        CsIV8gQtsjhnvLq9Zcfl/lFR9w==
X-Google-Smtp-Source: AK7set+9rjs/pkVy7AWNiNv0a34Mg1Vn463+p/9TwJdBU4BL6GlFQorb6rS66Q1i0nTHMIp1JktUoQ==
X-Received: by 2002:a17:906:3b48:b0:921:da99:f39c with SMTP id h8-20020a1709063b4800b00921da99f39cmr5463449ejf.12.1678640951442;
        Sun, 12 Mar 2023 10:09:11 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d9f6:3e61:beeb:295a? ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id i5-20020a170906850500b0091e1878bc59sm2425726ejx.68.2023.03.12.10.09.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 10:09:11 -0700 (PDT)
Message-ID: <f34ba6e5-4a8d-0812-c334-ea47de7b1d21@linaro.org>
Date:   Sun, 12 Mar 2023 18:09:10 +0100
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
References: <640e0136.c20a0220.2d5bf.1959@mx.google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <640e0136.c20a0220.2d5bf.1959@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 12/03/2023 17:43, Sergey Lisov wrote:
>> Bindings and DTS (and driver) are always separate.
> 
> Okay, will split the patch.
> 
>> Compatibles must be specific.
> 
> No, this way you'd have tons of identical compatibles that only differ in
> the exynosXXXX digits, and are functionally equivalent.

Thanks for letting me know.

https://elixir.bootlin.com/linux/v6.1-rc1/source/Documentation/devicetree/bindings/writing-bindings.rst#L42

>> That's non-bisectable change (also breaking other users of DTS), so you
>> need to explain in commit msg rationale - devices were never compatible
>> and using exynos7 does not work in certain cases.

BTW, this rationale was only example - you need to come with something real.

Best regards,
Krzysztof

