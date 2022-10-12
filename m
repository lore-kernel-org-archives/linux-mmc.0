Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC710C4332F
	for <linux-mmc@archiver.kernel.org>; Wed, 12 Oct 2022 13:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiJLNK1 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 12 Oct 2022 09:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJLNK1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Oct 2022 09:10:27 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EAC365805
        for <linux-mmc@vger.kernel.org>; Wed, 12 Oct 2022 06:10:24 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id hh9so10083858qtb.13
        for <linux-mmc@vger.kernel.org>; Wed, 12 Oct 2022 06:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cv+WkwwC9Q0rUd3KdbkW+Es/Dy75mEne3jS3rjr0plE=;
        b=vv6UwqkTm3ssp2T9OjzWs8ykNT7Pb7xgl0CPvoASxiRNNv2IkwlYCjFFmJ/WHYqrs2
         TH37PozUmEqvR7q5aIJORtdLwb+/t7YosA6zcVup4pkQIe/hLhVXwr/fwkZquYS/6WlO
         lXGWMOllhS38DFp8S41pDnuRG//w8j0GHCul/rQ954MmDuAj4a29gwYWyLELPti4fbGA
         YnsNMafU3yxUSwQw4toSe/LPasM1JpbzZOONln/Pu0ifXS7WKmqqshkRt0pGJvhRfGjo
         8UJU1WFpBPjhu/8zv1xibiyg31HpzUum8lvvB+Wa528xDXYfiZ1uKf7ls642JlnBnUyr
         G7fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cv+WkwwC9Q0rUd3KdbkW+Es/Dy75mEne3jS3rjr0plE=;
        b=0RHHtfgnsMW6nwZvor/Pjw+X5k248cvgdNjyQQ4d1JXBlvQdHMdXN744eAuMINSmZ8
         uLRHXPS9vC4mOXYv+NvZFC5qHj4AwB7GZ3YEb16Gq4Prn4YY3eYXgrk4GI8Q4yrdkrfr
         ctezNpLfvc+TBs0YENevwc2EmA2Xwl5YJsST4FrqYDGnoJHW+M/hDquTsnqG9A5W7/vC
         XGUz7VC+hSXOdOeam3eczSl86+MAxsiTGJ7J//YS3Bg3d6cwEmc12KtprZwHnMCSFEoR
         ov/sTVM2IQN4ZRvJJwpUd7tthLqVut5U892N8DeQEwXa8WlHc/0gxOrwAYcn1iNUjfQ0
         DQbg==
X-Gm-Message-State: ACrzQf3ajpCOzbel9CVUGtGAUzoAjaKJyUT1FoqR90UK72AGmjL+cFcK
        Di81pMcjSPxC/FW23dmiTcV7ig==
X-Google-Smtp-Source: AMsMyM70tl1NXSP4OYyHdhsG/89SAURilo8PxrhbTi4sUtwOI/patRYN/idHVw98qSnxx0dPcxrkEA==
X-Received: by 2002:ac8:7e8f:0:b0:39a:e70:421 with SMTP id w15-20020ac87e8f000000b0039a0e700421mr12845661qtj.592.1665580223519;
        Wed, 12 Oct 2022 06:10:23 -0700 (PDT)
Received: from [192.168.1.57] (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id j1-20020a05620a410100b006cfaee39ccesm16026643qko.114.2022.10.12.06.10.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 06:10:22 -0700 (PDT)
Message-ID: <4e349b3f-c0f6-91ab-15d5-3e9e873820b0@linaro.org>
Date:   Wed, 12 Oct 2022 09:08:11 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH] dt-bindings: mmc: renesas,sdhi: Document R-Car V4H
 support
Content-Language: en-US
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
References: <7ee7fdb6a46fc9f0e50c2b803ede6b4b2fdfa450.1665558324.git.geert+renesas@glider.be>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <7ee7fdb6a46fc9f0e50c2b803ede6b4b2fdfa450.1665558324.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 12/10/2022 03:05, Geert Uytterhoeven wrote:
> Document support for the SD Card/MMC Interface on the Renesas R-Car V4H
> (R8A779G0) SoC.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml | 1 +


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

