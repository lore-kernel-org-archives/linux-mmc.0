Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26FE0C433FE
	for <linux-mmc@archiver.kernel.org>; Sat,  1 Oct 2022 09:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiJAJ1J (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 1 Oct 2022 05:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiJAJ1J (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 1 Oct 2022 05:27:09 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A26185584
        for <linux-mmc@vger.kernel.org>; Sat,  1 Oct 2022 02:27:04 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id l12so7085722ljg.9
        for <linux-mmc@vger.kernel.org>; Sat, 01 Oct 2022 02:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=7Nj1lwdx9sTsA2nL+BGFiXFp2OoiBiYnOH4pA3qxzz8=;
        b=MrB0am7jgF3/5gQ9fYiq2wuaLx3JQS+FikIH61wLTAw0RQrQ/OOloBpnvYvbsMe2YK
         Cu1tqkYYeqTTOSmMw5VBTdfoBim1DKAOwNvirzKwW/SLUAzDlZDEII1Z+KuT0qx/T9Ry
         Jw+9bXrwYJHl33RVvG2Mqh5P0seZLkQSengF8QGPbLO+woWk2IbFUc/x68ruzGqmwwpa
         A+uMrTzvfdREX2BVjJ1LAly9QciNHw8L0gCHiPkYjNR0VBhziCYepqvMSsVgdlakJa4M
         5IU0byI9PgnY7NefxUO/bvRgsQutjSKxd1cafoRk/SURA0ZkiSDiumPuTs0oK4TJB7MD
         hG9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=7Nj1lwdx9sTsA2nL+BGFiXFp2OoiBiYnOH4pA3qxzz8=;
        b=bXD0v/BORxjpgvLjenbG+Q9DhMfKCF0l0SNt3iOpZ1RK9BdkXktYJivtNqRt9eJbEF
         Oe/HRK3JSEOdREbE/TeQu8vwUqKyKIzb1g09Mxksigf83BkVND9UtadH3INY0E0FVVre
         J3RgfWdWz8X9wvsJa81DZPb43akTqyzg16mdcAax+OXfOlJkJZ8m9OHQ4D2vtso6vSwS
         PI2rzucItELeAEy7+/mWF4WxPoJFCtg5EoTRErriwQt/acajpKkEUD3sonB1m0YA5Edy
         T1cmCmV4HchXFA2ejFGxjxptvkZhKz7jg2F7SnXpsbJZO7nCnTIxRkVJULRTr95CcJgo
         TH+g==
X-Gm-Message-State: ACrzQf1rthRMHvXk/mpDtODe52EqE60aQ5uB/COKl8e/qpYFfLT18vgt
        2mQ1e1QMsHWFM/Xp2x5IKnpJ7A==
X-Google-Smtp-Source: AMsMyM7fiEyigyTQCUnwDyA7VW4YRpy46nlRd4rKTZNxjTlygi4zBHFCbtiCgREMBzOLDIBxm9svmA==
X-Received: by 2002:a05:651c:119a:b0:26a:a1b3:e6f2 with SMTP id w26-20020a05651c119a00b0026aa1b3e6f2mr3967251ljo.190.1664616422716;
        Sat, 01 Oct 2022 02:27:02 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id k21-20020a05651210d500b00498ebd60c35sm701581lfg.165.2022.10.01.02.27.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Oct 2022 02:27:02 -0700 (PDT)
Message-ID: <d43c954a-8b3e-779c-85b1-07d46a5f7fb3@linaro.org>
Date:   Sat, 1 Oct 2022 11:27:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 3/5] dt-bindings: power: rpmpd: Add QDU1000/QRU1000 to
 rpmpd binding
Content-Language: en-US
To:     Melody Olvera <quic_molvera@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221001030641.29354-1-quic_molvera@quicinc.com>
 <20221001030641.29354-4-quic_molvera@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221001030641.29354-4-quic_molvera@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 01/10/2022 05:06, Melody Olvera wrote:
> Add compatible and constants for the power domains exposed by the RPMH
> in the Qualcomm QDU1000 and QRU1000 platforms.
> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  Documentation/devicetree/bindings/power/qcom,rpmpd.yaml | 2 ++
>  include/dt-bindings/power/qcom-rpmpd.h                  | 6 ++++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
> index 3934a2b44894..7343cfc91262 100644
> --- a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
> +++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
> @@ -44,6 +44,8 @@ properties:
>        - qcom,sm8250-rpmhpd
>        - qcom,sm8350-rpmhpd
>        - qcom,sm8450-rpmhpd
> +      - qcom,qdu1000-rpmhpd
> +      - qcom,qru1000-rpmhpd

Wrong order.


Best regards,
Krzysztof

