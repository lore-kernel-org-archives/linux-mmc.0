Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B25EB64DC
	for <linux-mmc@archiver.kernel.org>; Thu, 20 Jul 2023 08:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjGTI5m (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 20 Jul 2023 04:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbjGTIp3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 20 Jul 2023 04:45:29 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5FA26AE
        for <linux-mmc@vger.kernel.org>; Thu, 20 Jul 2023 01:45:27 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-992f6d7c7fbso97331866b.3
        for <linux-mmc@vger.kernel.org>; Thu, 20 Jul 2023 01:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689842725; x=1692434725;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tSoVxWSE1cyumuS4GrQ83guaORjhmkGXCHW2lWl3ILk=;
        b=nbv30qoPhEh2h9MZjLI6Dnw8e3nzuRNXK/oGEM4BNKmw/+pnzTuEyrf3JhtyZ0bilF
         aDpKMcgP1LIp8uAvX6C+W7fTvUU0i6Sx7cimzXj1Q32LVvZzXGTXNVxKNx4fD5dI2RL+
         47tFslQTfjNS66oAaoefLUCzJXNmkNY1aDgtClMa2QRnudc1CWYz/irz7podoQV8u5ro
         ZLsVpwP0hgdo6bxkICHiAAxmMF8/rnM0/CU6A4aqP4YY2S4mIvDkgWn4ROozwSnX52Yq
         T3ssXP/9yMo8pOaMwAxBefmw7dmlBaoTUOF9yCiTFc7a45vr5PPj7YKRjFXIEJUe4URt
         47jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689842725; x=1692434725;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tSoVxWSE1cyumuS4GrQ83guaORjhmkGXCHW2lWl3ILk=;
        b=XBPtQwNYH5ha4JfshF6A44pctz6Inh5OubYupIOwwgZGRFTnHpxO1lXKcOJxJvt1OE
         jyNQ6XWMMu+OLjNqKgi77ecCF4jChXBpkWdUbPWhFb32dcZRXZz7JRyy9ZvWBrYRCQwR
         VZFwDflGXO7XMRqwJKB6sMgX7rle3nc9uGlXABg6V/hzNqdjBJtemQP+JggPzJEMGFG5
         00ggjQ5iO6JVXd2Ocb2ksC/+HlxJlKSXGYDrRTrXl6+QLj69PDOM3sYvLKaqjGMy3Rht
         IO271WkOAmcvWHlPICxsq3RxxWiMpfc5Vug7QHqadFlHwDEhaxOaWxeEWS0gr+njMM/p
         pZ1A==
X-Gm-Message-State: ABy/qLaWet6km6kCKgU+4B9mlep9c3ubDpFpUH2G67pl+OiEqTK0dpzZ
        bVap7tvHG2AVx65MYwme+IfKbQ==
X-Google-Smtp-Source: APBJJlF1GBIlxZpXyWvbwbFsR4lNV73jiLrstNTcD/bQex9Wl20n1MUIMq54n3qCMqEs87+A1Awr5A==
X-Received: by 2002:a17:906:106:b0:997:aee1:74ee with SMTP id 6-20020a170906010600b00997aee174eemr4345447eje.14.1689842725596;
        Thu, 20 Jul 2023 01:45:25 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id lo19-20020a170906fa1300b00992665694f7sm363528ejb.107.2023.07.20.01.45.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 01:45:25 -0700 (PDT)
Message-ID: <419d4a09-84aa-7029-cd0f-556945ba0046@linaro.org>
Date:   Thu, 20 Jul 2023 10:45:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [v11 1/6] dt-bindings: arm64: Add IPQ5018 clock and reset
Content-Language: en-US
To:     Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, ulf.hansson@linaro.org,
        linus.walleij@linaro.org, catalin.marinas@arm.com, will@kernel.org,
        p.zabel@pengutronix.de, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robimarko@gmail.com,
        andy.shevchenko@gmail.com
References: <20230616101749.2083974-1-quic_srichara@quicinc.com>
 <20230616101749.2083974-2-quic_srichara@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230616101749.2083974-2-quic_srichara@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 16/06/2023 12:17, Sricharan Ramabadhran wrote:
> This patch adds support for the global clock controller found on
> the IPQ5018 based devices.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Co-developed-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>

Please use subject prefixes matching the subsystem. You can get them for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching.

Best regards,
Krzysztof

