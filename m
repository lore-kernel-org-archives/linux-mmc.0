Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96403C77B75
	for <linux-mmc@archiver.kernel.org>; Tue, 16 May 2023 01:08:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245743AbjEPBI3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 15 May 2023 21:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245368AbjEPBI2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 15 May 2023 21:08:28 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8918D59E5
        for <linux-mmc@vger.kernel.org>; Mon, 15 May 2023 18:08:23 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2ad819ab8a9so112891401fa.0
        for <linux-mmc@vger.kernel.org>; Mon, 15 May 2023 18:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684199302; x=1686791302;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lyzlb1knfLNloYB6AlxNxhOYp8O4rjeCw8TEVU/6wrs=;
        b=K+xV7UkWFhHrH+cyZjQLTvXQRg8U+IYM2T2Ap2WI+gjyfg/BUTTzMHFYJ+9h4GZgHJ
         0Z+bbAhqqeJNocTsBdAVJXVjBxevp1xRjF95LYKnHUoii0QqVrwPbKfxzK93ID1SfUSx
         NdGZPaBPUyS40nCUOlD6u0vMsvI3ZFVfTzKqhD3e5Hwbeu11I0imt6AxpseuRC5VMVXm
         nlbjvHP5h28Rkzo/bzg4UL+I95OnJ1G5iFVUB0IVqFUDQ73q1QvOq3Jt0al2cWxEoVAZ
         0IuHA9+aSCWoZ2bYj2l6X1ae61CfKaswE68J8GNuarGO12ZO3e+q99iSFvNX7kau4Sde
         gqrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684199302; x=1686791302;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lyzlb1knfLNloYB6AlxNxhOYp8O4rjeCw8TEVU/6wrs=;
        b=lC8p8NTDc9q0OEBKgolUlvCllenMBbK8biOltCyB2yXrw8jkiN2AEqU/Mi3JBWYDKL
         032hE5GDYtFkOHuowJ3smvJFmgaGoU+fYE1BJ3y+WQkeJt0TGxCnR2FCRt2kh67G9RJJ
         V+lbLkKv1cBD+6nIEih8DjDeyNvUw2HkotTknFTUohS/zEnVS5E/Co3ma40/AcDtolAh
         kRtPHeMKznKPRdbvqwFSP1fX1Gbb3NWbBz1cG3R8k5I6RVVtDsHEcptm9/XvbwLmDPog
         su654xBKaabbry0WsNxGhVogIAc0gPioxklOis0r8WsolHu52lM8kEspLZKvGJHHw/3m
         B+Tg==
X-Gm-Message-State: AC+VfDxfvbyEvtIl8FV+UJJ4vpoVKIECmlQRDO7NWn6UI5zgefF16rS0
        SFgkQ5lBbdZ5P1JUBg47R5OqwQ==
X-Google-Smtp-Source: ACHHUZ7Vbb5JZKPQUWR7eE/rFp0x8+WxhI3f0tbA8gkCNyc76Q2iwI2ZhTdlT/f0YKuX7mr9lQRPJw==
X-Received: by 2002:a2e:9f47:0:b0:2ac:90db:2a3d with SMTP id v7-20020a2e9f47000000b002ac90db2a3dmr7807292ljk.8.1684199301811;
        Mon, 15 May 2023 18:08:21 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id x15-20020a05651c104f00b002ada919a09asm2577682ljm.73.2023.05.15.18.08.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 18:08:21 -0700 (PDT)
Message-ID: <8a5d13e2-b06a-417e-5d8b-1db749efb0cd@linaro.org>
Date:   Tue, 16 May 2023 03:08:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 6/6] dt-bindings: thermal: tsens: Add QCM2290
Content-Language: en-US
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-pm@vger.kernel.org
References: <20230314-topic-2290_compats-v1-0-47e26c3c0365@linaro.org>
 <20230314-topic-2290_compats-v1-6-47e26c3c0365@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230314-topic-2290_compats-v1-6-47e26c3c0365@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



On 14.03.2023 13:53, Konrad Dybcio wrote:
> Add the TSENS v2.x controller found on QCM2290.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
<bump>
This one got lost!

Konrad
>  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> index 926e9c51c93c..1a6ffbf11bcc 100644
> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> @@ -48,6 +48,7 @@ properties:
>                - qcom,msm8953-tsens
>                - qcom,msm8996-tsens
>                - qcom,msm8998-tsens
> +              - qcom,qcm2290-tsens
>                - qcom,sc7180-tsens
>                - qcom,sc7280-tsens
>                - qcom,sc8180x-tsens
> 
