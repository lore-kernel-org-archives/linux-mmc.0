Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9640C77B76
	for <linux-mmc@archiver.kernel.org>; Sun, 16 Apr 2023 09:07:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjDPJHY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 16 Apr 2023 05:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjDPJHW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 16 Apr 2023 05:07:22 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B271710
        for <linux-mmc@vger.kernel.org>; Sun, 16 Apr 2023 02:07:21 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id dm2so56701541ejc.8
        for <linux-mmc@vger.kernel.org>; Sun, 16 Apr 2023 02:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681636039; x=1684228039;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PB42luZzV2IXeVwjiAd/OfF8RsMIHF3lJTteNUnRK24=;
        b=o7vzzAt6G/1yLLL3MNGsA+klhQsZBmqn1s/rq9fN3EwJVYulTFQbzYnxKAvJKcPSwY
         sdp/eNYl/4/Papdnj3Pt8kVaRkj3lDu87icvE6qqeqYDrVeAUH7RsnwdBdXM6eEUyKpJ
         M+FLz5DQTb//uQpChH/JtZwldlHrOxFVTtZejYfCgv8pGpA5mEQb/c39SdK45dwzSpXn
         K8BoXfAOamto02ybpS3o0kqqK4Qea2DsBSefpfvcIhkSatqAjktdAtIt83/fz6GDSIun
         mkCk4Hc0pu1AJB9u/W9P3r3fSWqtIHoS19BvOkM0OFmZFrELAgXgHpz+veQH2DGEd7sH
         ZB0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681636039; x=1684228039;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PB42luZzV2IXeVwjiAd/OfF8RsMIHF3lJTteNUnRK24=;
        b=csgBQOP+/e6A9mOPTJ5vI+yeXtJUJOYGF2ecomwlLJl94/MJQ5TDhFdsC7OuwDDlYL
         t4qSI8WNIvu8kgh/76Cfi/JQ2EvM13uNepNkD/BVWoFuLjtbbE1+zCK0ZCqhh1TnLvgF
         l80+3nlpgxV6omfokIAso8K+PFqEa14+JNuBzGrSTMCnrnUf19GaRW7m4qhTYjc4o531
         +h8gWTSQ3sQWYv1ncYeqBoxryye0mHgyoO2eYhvkysLkPsaVjpU+InxNj6Hdjdqy9IpJ
         l0aZ0bhm7vT1lX07ZhsMwteOz7AlNbrzteuFimZ6MejdEP2RAsjFpRpuzTY6BnyQyUKH
         RY6Q==
X-Gm-Message-State: AAQBX9cWUgnIGa9Ofz2JB1Fzb7pafO10seQXXkOyNJdz9kfiwHfmg9ZA
        ulxkTlVE1TKfDRr09309PLRlYw==
X-Google-Smtp-Source: AKy350ZPaY00AacKzTMsCtP2nfiu5vG4ZvtLjAiXVFYffCad8MS+dbqmdW3L3DkGJhcjVFVrPl0QmQ==
X-Received: by 2002:a17:907:1111:b0:932:7f5c:4bb2 with SMTP id qu17-20020a170907111100b009327f5c4bb2mr4087865ejb.75.1681636039548;
        Sun, 16 Apr 2023 02:07:19 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:29dd:ded4:3ccc:83db? ([2a02:810d:15c0:828:29dd:ded4:3ccc:83db])
        by smtp.gmail.com with ESMTPSA id qb33-20020a1709077ea100b0094f680d36f3sm193446ejc.79.2023.04.16.02.07.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 02:07:19 -0700 (PDT)
Message-ID: <de891705-bce9-7610-340d-b4bc284dfaca@linaro.org>
Date:   Sun, 16 Apr 2023 11:07:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V3 0/9] Add minimal boot support for IPQ5018
Content-Language: en-US
To:     Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, ulf.hansson@linaro.org,
        linus.walleij@linaro.org, catalin.marinas@arm.com, will@kernel.org,
        p.zabel@pengutronix.de, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <1681468167-11689-1-git-send-email-quic_srichara@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1681468167-11689-1-git-send-email-quic_srichara@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 14/04/2023 12:29, Sricharan Ramabadhran wrote:
> The IPQ5018 is Qualcomm's 802.11ax SoC for Routers,
> Gateways and Access Points.
> 
> This series adds minimal board boot support for ipq5018-mp03.1-c2 board.
> 
> [v3]
> 	Fixed all comments for clocks, schema fixes
>         Picked up Reviewed-by from Bjorn for pinctrl driver

Didn't you just ignore all the tags you got? I was already acking and
reviewing a lot of these...

Best regards,
Krzysztof

