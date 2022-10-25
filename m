Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3762BECDFA1
	for <linux-mmc@archiver.kernel.org>; Tue, 25 Oct 2022 12:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiJYMVl (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 25 Oct 2022 08:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbiJYMVj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Oct 2022 08:21:39 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07180CAE6D
        for <linux-mmc@vger.kernel.org>; Tue, 25 Oct 2022 05:21:35 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id h10so8392890qvq.7
        for <linux-mmc@vger.kernel.org>; Tue, 25 Oct 2022 05:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yrilAhGGJreK8L4jo0y+OfIubyvYYXmcpdYjjv0NBzw=;
        b=vFP823FJZuCoQ/qSOuYtkMQd2VmdCUrulmNtzL1ZXynQCiDNoSwdCXGbDO/vsXvXOB
         GLEh/COj6kV401Ni86hUKFde73N9Nnysrv5Wdma5U4q/VDRlKmnT0UUog66EV4CPz9VE
         ZG4KL/5K04wupgRJp7o8WLu4PyvCpolUKv0xzxSIDDc6VQHlcGVI3Xm4yIpsaSGc1yWl
         kSJlMKbuqk6uCSbX3SmBh7DG/VZBfyxSReCuOoo5jXf/WtEBaX1DBKhLtuHlRQfwqZ/R
         u994/N/ApSm4zlTiYLwUxFDQ5q2NJEXcKfHd5eBvQERIzpeLQgfqB9qivAqRoBC9zyTq
         NK8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yrilAhGGJreK8L4jo0y+OfIubyvYYXmcpdYjjv0NBzw=;
        b=vdwwCHr5McwWN1j44XRWD35rpFoXW5rbtxLQvFSsiUX32lbgGV6VXrq1fLZM0Xx6rY
         opMAdKuro+0Y7lMqEzgc76JRq5qqK9qGkGREWogbxp50A58V1u7z/YYpo2UJ1aRXkelx
         wBsJrllImLtN1Mlxqd6FMlikiVREHzTClYB7RJf058csedR2mgmXf+SatX+aJXvq8dm/
         YrdC8zJQkkhJPKPrmglJI/Rk1Y2mqxb2sskm97WY5AU+661rR6EDsoufinj6bOeg0gn2
         7/9+yRHjVjyIg34jFWaazkWopYyCE9rxsH9Vcn+yiS27kMr9gFLGS5p/xbwE5TLXcj5A
         cOQA==
X-Gm-Message-State: ACrzQf1g6u7CTyo9E7RJiLAqTwsHplov8GwvMgyPXqoNOC3kEOpZWm+l
        sLov01kQHbcK2jWo3vJWpGwBOQ==
X-Google-Smtp-Source: AMsMyM4s0N1Fal+yR+QTBJMIob7ci46MXCs+VOue61R+M/I9AAZ+z1gY8tW13hXFvcnKIx6Wvt0hNg==
X-Received: by 2002:ad4:5ae5:0:b0:4b7:1bdb:d79e with SMTP id c5-20020ad45ae5000000b004b71bdbd79emr26229025qvh.25.1666700494159;
        Tue, 25 Oct 2022 05:21:34 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id dt27-20020a05620a479b00b006cdd0939ffbsm1911886qkb.86.2022.10.25.05.21.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 05:21:33 -0700 (PDT)
Message-ID: <857f6769-3618-0958-472b-bff57a23f763@linaro.org>
Date:   Tue, 25 Oct 2022 08:21:31 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v4 2/6] dt-bindings: mmc: Add support for Mediatek MT7986
Content-Language: en-US
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sam Shih <Sam.Shih@mediatek.com>
References: <20221025074238.18136-1-linux@fw-web.de>
 <20221025074238.18136-3-linux@fw-web.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221025074238.18136-3-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 25/10/2022 03:42, Frank Wunderlich wrote:
> From: Sam Shih <sam.shih@mediatek.com>
> 
> This commit adds dt-binding documentation of mmc for Mediatek MT7986 SoC

> +          items:
> +            - description: source clock
> +            - description: HCLK which used for host
> +            - description: independent source clock gate
> +            - description: bus clock used for internal register access (required for MSDC0/3).
> +            - description: msdc subsys clock gate
> +        clock-names:
> +          minItems: 3
> +          items:
> +            - const: source
> +            - const: hclk
> +            - const: "source_cg"
> +            - const: "bus_clk"
> +            - const: "sys_cg"

Drop quotes.

Best regards,
Krzysztof

