Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A09B6C6FA99
	for <linux-mmc@archiver.kernel.org>; Sun, 12 Mar 2023 11:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjCLLNO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 12 Mar 2023 07:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjCLLNL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 12 Mar 2023 07:13:11 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D6418149
        for <linux-mmc@vger.kernel.org>; Sun, 12 Mar 2023 04:13:09 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id r15so10703035edq.11
        for <linux-mmc@vger.kernel.org>; Sun, 12 Mar 2023 04:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678619588;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vyFi1sUYUGVsSq5enTkckNqp58U1GRDhcQmFLdZmZuY=;
        b=hTv94TyLwSRiH9FdPFRgkbiDejMWY/cvPGK5+iLsHLXBmoGFo8Z2UrCrqsmoJ+Ghoa
         mcdoMw2h1Kumncp2lP9n3ZSkb0CY0CudBM5xWL9WfOrl5bR1LYbBduj3Dd69nrNQy3G7
         K0F+MjebZasbGQQrFtTNzluOwbs0h6mD9PZaE3kAClQZiCYWSSTbDD5bWUPYNmQI3j7A
         7ua9aSPjUNSJunlvWld8LxtBLOxcKtOBrLZ6FoCELUjBy/G86XZIL3V0LfV9Bz4u2Rqi
         sU1P04otUAonbQ1ZbcLCl0im2gH+UuhdSQhloXuXZOrsLJxSqknvOPaLAVFmXFoIxRND
         rOTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678619588;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vyFi1sUYUGVsSq5enTkckNqp58U1GRDhcQmFLdZmZuY=;
        b=BS3OAJEX3yeNxftT5zsDMthxMgNJ8hK6mqXC7cBA3g3sqBB+7/t9qS5CjWoLf3c04o
         auQD3/2txbd6mxEEZCDVG8pLiJbG1QskY50/B6a6H+uW+a3bJ3QMXQlkWdmuRgylbLjR
         rrXZ52gXLrVp7lEwmeoezr7a45hr5cY6BNnONpYgAVjWIp8o1TRcT6y65PuXYx1wVyPl
         3YE1EYhEQUtSjxSUWggUjBRC+YCv/UnaT8A+ezkuVOEG350k8oyFMGtXLevu+5UzkF17
         HGvq4F8lwer7OZD6kW5oEoPVrLXjNHl1CXPqh3ei6brh6nsPMgHikrM+btNOgFCsndvM
         3SMg==
X-Gm-Message-State: AO0yUKVhpI52c6EASURbETfRhe6+tOHD8limketovR9j45sIpaLQp6bR
        16RCe828Dya556iO31tYELhUoQ==
X-Google-Smtp-Source: AK7set97ixmFG1mMz1RXatDkVLPgMEqnY1RW4cHJ9uR9aCkCHjJacnv6EOl24AiBthGjGhiiipoQhA==
X-Received: by 2002:a17:906:6dd3:b0:878:8249:bef6 with SMTP id j19-20020a1709066dd300b008788249bef6mr30820146ejt.59.1678619588233;
        Sun, 12 Mar 2023 04:13:08 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d9f6:3e61:beeb:295a? ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id m20-20020a170906581400b008e1509dde19sm2105200ejq.205.2023.03.12.04.13.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 04:13:07 -0700 (PDT)
Message-ID: <98f28de3-20b6-dd57-0c95-69c31f8bb76c@linaro.org>
Date:   Sun, 12 Mar 2023 12:13:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 1/2] dt-bindings: synopsys-dw-mshc-common: add
 "fifo-access-32bit" property
Content-Language: en-US
To:     Sergey Lisov <sleirsgoevy@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <640db0e7.c20a0220.babe.16cb@mx.google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <640db0e7.c20a0220.babe.16cb@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 12/03/2023 12:00, Sergey Lisov wrote:
>> On 12/03/2023 11:49, Sergey Lisov wrote:
>>>>
>>>> Anyway, I said last time this looks compatible-specific, so I don't
>>>> think we need another property.
>>>>
>>>> Best regards,
>>>> Krzysztof
>>>
>>> I agree, but I'm afraid of introducing regressions by enabling this
>>> workaround on systems that don't actually need it.
>>
>> I don't understand why would you enable it for systems which do not need it?
> 
> OK, then how do I find out which boards have the bug? My only idea is
> "search for samsung,exynos7-dw-mshc through all devicetrees, find vendor
> kernels for each of those boards, and check if they have the workaround".
> Is it really that better than enabling it selectively only for
> known-affected boards?

There is no way this is board specific. This is SoC specific. I
mentioned it last time.

Best regards,
Krzysztof

