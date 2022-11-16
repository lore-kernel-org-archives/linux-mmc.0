Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B61C43217
	for <linux-mmc@archiver.kernel.org>; Wed, 16 Nov 2022 08:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238861AbiKPIXu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 16 Nov 2022 03:23:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238810AbiKPIXT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Nov 2022 03:23:19 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CC62B1A2
        for <linux-mmc@vger.kernel.org>; Wed, 16 Nov 2022 00:21:35 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id a15so20822044ljb.7
        for <linux-mmc@vger.kernel.org>; Wed, 16 Nov 2022 00:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hOhON3c92uOQG/q5cu0aF5WgWtMVsl/yA7D31IBRUvA=;
        b=v3xeJRqsQ25HIf13rxAwKE+/6/K6rqVfZRhQyECOPVLQ7icsDHkVtYjpCaFYlBRba+
         NnfDliMvRv8EowYlm8UwXF9AIhq8ryISGJdbQenYBhP6zVJtE0p+U4akJ5FyAwrVvi7r
         55VMwNJQKFbqLHdk7qLf7DSYhxiny765h7f/AVAYyeLz7eQ4wT0uUBXajTaiLoQi/2IX
         bhUnvVgWKY9wzj4ijwOxGT+VGTI9msc9yehCwaf5tJArF+DEerMe+OtlIyXDwqItc81r
         OyU0W+2HuIm03oNHNP07ue7gC/NBDMUE/Tjj4xxMFKKsFBuNZlrTpwIia4lUGEVlYQdQ
         6q9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hOhON3c92uOQG/q5cu0aF5WgWtMVsl/yA7D31IBRUvA=;
        b=3sHT1Qu1+I4LR+/QmcHGsnvhsiypKaGq+pbidmJL1wN1jfU9DpIibt/hcUANgi+oU2
         j55EdMGWjqqJhrJXI5HduEV2MP3xNM2mQ5HV7jcmpDyQ7P9qryJ0IFiLOCnbR7zCXqVi
         ryAJAGh8r9A/Qd3ZecjJ0SESE4jzMVsoDbzw6Cb46xObxT1DUcIxeZ/ULzaTDwja4Sx4
         9ytyC0/6V1ErDRIoZ3X1ftQW6e79w5dvqTlvBiCl4gqFfUzrMVuiAY2ZE8n6wucszO2r
         uBI4ObVAizPCOPEQUw35erwSTBTrJZUoJ4PztkoOj05g7KZlobm1RYOj0jMDpzPRkYxM
         rwlg==
X-Gm-Message-State: ANoB5plIWaLiplY9f+EuwwPfqwWZ+XgiPOY+cTxqItmaVp+B4V74d8rI
        APoRNF1wimPAvAuJGYiktYDPew==
X-Google-Smtp-Source: AA0mqf7D9jtRcm31IK4h9nEOJcLgzidioIPjn0kKfE18WRLFBDH5aYRGy0EDuLZaRrezjI86pj58Ig==
X-Received: by 2002:a2e:94cb:0:b0:277:3df:90d0 with SMTP id r11-20020a2e94cb000000b0027703df90d0mr7184219ljh.234.1668586893685;
        Wed, 16 Nov 2022 00:21:33 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id e5-20020ac25465000000b00492dbf809e8sm2485379lfn.118.2022.11.16.00.21.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 00:21:33 -0800 (PST)
Message-ID: <a7dac56d-0fb0-b45f-a722-4cac8d1f777e@linaro.org>
Date:   Wed, 16 Nov 2022 09:21:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/4] dt-bindings: mmc: sdhci-msm: Document SM8350 SDHCI
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     patches@linaro.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221115172828.14372-1-konrad.dybcio@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221115172828.14372-1-konrad.dybcio@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 15/11/2022 18:28, Konrad Dybcio wrote:
> Document the SDHCI on SM8350.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

