Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91EBC636D4
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Feb 2023 08:47:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjBQIr6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 17 Feb 2023 03:47:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjBQIr4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Feb 2023 03:47:56 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0E24485
        for <linux-mmc@vger.kernel.org>; Fri, 17 Feb 2023 00:47:54 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id dn12so9291488edb.5
        for <linux-mmc@vger.kernel.org>; Fri, 17 Feb 2023 00:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6mCPUncoNNGQDkBH1K4Qwr2txnBpLQ2xqpC1PN44nIo=;
        b=zMOgIsHj6qxMkglPlIGwHPtY65joY5FCUCHW41i1STnDb9VvgcgzUZZh3zCuj7WAtZ
         hCP7+xRs0HlbLdfpWze78Iq4IdVNmlM3KLY6QC66gFDQZ/Fx+N57yeDOTHIQJ4uK3q7l
         R1yG2LZBj0iqb6wVnsQF1yusZT/z8wy1Z2s2+Fb7mnDdSo5NiCn+kAHS6ZHq6BCBFzds
         3aHQAavQHhPeB2EeMjpIh3J/J4dY4ASe3ZqaaljUn5HDCSqtDcxSMHD9L37ooqzBsBE3
         AKFreSM6PdOXsILNgz/BjMR9maQiQOVcoN2SjBddVvzXAHnj2IiRxb9g4aU7TOi2UapT
         JmTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6mCPUncoNNGQDkBH1K4Qwr2txnBpLQ2xqpC1PN44nIo=;
        b=nRVwFNRf26xTEbt1rA36Tmh9I1aSGIDMPFPBjoCGQCOkb3X8lJGNLBrmY/U1JktKHH
         UmwpypBS1aGrzwHZgt4tTCk76mccwscUzie8BiywqMSkG/wHCzux86+NO5stBgZy7Rto
         9NNsnuoMPHRXVsajvSkjrqlISZuoti7cVtl10/+poYIlnESNTUnU0i/w4ga6YVR336Hu
         z8dBFdJk9k4rGBrcZUVLNnUDgF/uP7MW3dqR8C0+xKoSC3TUVk7PSn48hFP18DU80t1V
         iowjwiJjRLCS2G1XXEQJ6c/fIY+Muxu+bzEB5fepPRE8OTlqIAbI77SV6073TVtS6/Kt
         wXQA==
X-Gm-Message-State: AO0yUKXmE8J2u4+k0euUJ4+//dZkt4mjWzXgRf3AlsJ2bULTrrbu2e0j
        PDNXGcyB9MxsAqIC5gkLcWkyfQ==
X-Google-Smtp-Source: AK7set+bc046PiYwSDnVyB86S6c9jja8hnHbQX0stMjnEgo8oKt4A8NuJK9HWepfuMYEn0SaZNEmQw==
X-Received: by 2002:a05:6402:445:b0:4ac:c720:9255 with SMTP id p5-20020a056402044500b004acc7209255mr580406edw.34.1676623673490;
        Fri, 17 Feb 2023 00:47:53 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id f29-20020a50a6dd000000b004ad6e3e4a26sm1532945edc.84.2023.02.17.00.47.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 00:47:53 -0800 (PST)
Message-ID: <86945f01-351b-9843-0ba8-08377f12dd4d@linaro.org>
Date:   Fri, 17 Feb 2023 09:47:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2] dt-bindings: mmc: meson-gx: fix interrupt binding
Content-Language: en-US
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <c1437eb6-0c01-809f-422b-cb1109489355@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <c1437eb6-0c01-809f-422b-cb1109489355@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 16/02/2023 20:50, Heiner Kallweit wrote:
> Reflect in the binding that the cd interrupt is optional,
> and add a description of the interrupts.
> 
> Fixes: 09b31a610328 ("dt-bindings: mmc: meson-gx: support specifying cd interrupt")
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

