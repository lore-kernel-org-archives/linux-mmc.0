Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4024CC7619A
	for <linux-mmc@archiver.kernel.org>; Sun, 16 Apr 2023 09:12:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjDPJM3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 16 Apr 2023 05:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjDPJM2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 16 Apr 2023 05:12:28 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6621992
        for <linux-mmc@vger.kernel.org>; Sun, 16 Apr 2023 02:12:27 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a5so70543ejb.6
        for <linux-mmc@vger.kernel.org>; Sun, 16 Apr 2023 02:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681636345; x=1684228345;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rwM8RzXXHOEUyCag2xnFM/XLXIGexTVEtmhJCwM3MOw=;
        b=prlpI3x/8BglFmW6LK06SM1lwdhkXve3v2C/KEl+jyvTdBMH3reXhut5a5z3FDIwNK
         IYQjYbXLjddkb/tXaDLEMKNIuRE29TTCJtEg7kM5dDvkFpp8dbTLr1QmyZ0EieU28SAu
         dNmIozVlBKx/cUsF6jydzZaMjWDCpHNbW5x0GtFwTSCg1On+Kd2wjKlJLHxK3mxxUGY9
         9CgXRZ6tZOxLy9NdcePT9Q9T5aNWQjb560tMhXKKQlfQPF8A64/F1TBjXJYPk1e7Uoon
         r+DVGiOvWTmxEQTJfOib9uvTEkOTK5XpDsmEoIj58Ds04rQ3vqCiFYCgdjD97a7V000F
         RI9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681636345; x=1684228345;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rwM8RzXXHOEUyCag2xnFM/XLXIGexTVEtmhJCwM3MOw=;
        b=OXok9o1m/F4ygqsCXDWeVVtRkQcqcsudOGEfmbVhxk/GripsS8WItPNmqeLBSIeRKc
         r2IgFCBdNRZ4KL4wgYt4OHb9oD6HW983nQ4LybwmuZabSVSo5j7CZUAX+KJkRuQ3PiFd
         +/q7jitIpBfApGEn7JB7E/YHDZL6tnnPGzThkkDC0ebr/5N1OVI6WsjC+gGygDX8rpU1
         peUPAZnkP0ZDfQO1ooqayoZZDWtXFADMjXdYEHh/FZyn4MP8BggdvTew7QuG21yGtO4B
         RYySYioOMxq2gHVf7ZE38cKJbo0TqKmYGAZ9OA4m6ZLLF7P0iFtpNwAm/0dRX1iKv2OM
         XEXQ==
X-Gm-Message-State: AAQBX9feGuEmYDrh4J6GMtGHJvbs/Ye1fRF66I5Y3dHHI6aOjxR9amY4
        ap81Fa5o5SPYR7DQInjv3xgLLQ==
X-Google-Smtp-Source: AKy350aAz4/lvUhtDCrVLib6n1uhBytZ37hkMSVT8CnMGYL5w01Yk/CuFGoNLxTvxM6PZ8iKqheCiw==
X-Received: by 2002:a17:906:6992:b0:930:6c71:64eb with SMTP id i18-20020a170906699200b009306c7164ebmr4048092ejr.29.1681636345690;
        Sun, 16 Apr 2023 02:12:25 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:29dd:ded4:3ccc:83db? ([2a02:810d:15c0:828:29dd:ded4:3ccc:83db])
        by smtp.gmail.com with ESMTPSA id ud7-20020a170907c60700b0094ee700d8e4sm3208048ejc.44.2023.04.16.02.12.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 02:12:25 -0700 (PDT)
Message-ID: <ce9c90e4-47a1-e5c7-0b71-56ffa7cdd1f7@linaro.org>
Date:   Sun, 16 Apr 2023 11:12:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V3 5/9] dt-bindings: qcom: Add ipq5018 bindings
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
 <1681468167-11689-6-git-send-email-quic_srichara@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1681468167-11689-6-git-send-email-quic_srichara@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 14/04/2023 12:29, Sricharan Ramabadhran wrote:
> Document the new ipq5018 SOC/board device tree bindings.
> 
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> ---
>  [v3] Fixed board name
> 
>  Documentation/devicetree/bindings/arm/qcom.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)

Does not look like you tested the bindings. Please run `make
dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).


Best regards,
Krzysztof

