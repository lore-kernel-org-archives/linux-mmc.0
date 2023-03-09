Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E65C6FD1F
	for <linux-mmc@archiver.kernel.org>; Thu,  9 Mar 2023 10:25:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjCIKZW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 9 Mar 2023 05:25:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjCIKZV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Mar 2023 05:25:21 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1B360428
        for <linux-mmc@vger.kernel.org>; Thu,  9 Mar 2023 02:25:19 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id cw28so4958000edb.5
        for <linux-mmc@vger.kernel.org>; Thu, 09 Mar 2023 02:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678357518;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f29pOc0OlEjB2aN049aESwB0+Wn2Q9ambfIlPJGk7zs=;
        b=SbTPgGcrbEdbPszGqq/zi10sHZQXTQqcG+ClKw7WU4IbfZjkneUyWgfDPLt5xBj5J3
         CU5kDHn7gerky8OEON/4iKKq8AHuIa+tANju7NpcUZY4EQSyjaDngypKTHPSnOuSHn6q
         drVI395AC9G+AdugQuLnYnLcTnZa2dZrKi72CLjgLVH+S7tfK3G8tzDiUm1cHI1A+n6W
         0irecpUGucGlhLHmiQizIB1Vb4b7zAycNtsAbs8Pl5GrvFEdXzpDn/WLSkzsHWQmoiYH
         fblOjN2o2VkidyihNb3YQw7mNnDTrTZxw371UhvG2ICPchyenI2lgY8Yi35fFXXt4hrY
         2WPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678357518;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f29pOc0OlEjB2aN049aESwB0+Wn2Q9ambfIlPJGk7zs=;
        b=bJgC/yMdO1j0eLbnXlYJmph6v4a3unoaZWAEi255nJvI9Uz04fVgnAakP6lLBa9Xlm
         5f65zzC2Y1S1+c7qmHvOURXS5b4H4FqUTc/MnaqdNsSwxF8z15ylUte8kWomaBxth3Mx
         VARGx0ifH4fySksCQVHq9WpIACUqM4nVIdpHsgXmjatfnoZvA5BpF1cNuEKZc1+yp9uz
         44KQPXiBSKo9sTRtvOx8YkeUJLe2/Z2Ust91MMZsxb/oULxI4SjmzPh2QPVMy+V8cX8x
         S1U/Y3Z2bx8iTetbPqziG7QzRj/+j0fuRK5fRL8jt/x1esEBIqMw4yOPl2JK2hFZt5uS
         jKGA==
X-Gm-Message-State: AO0yUKX3dt+GAU3T0Q6ifdxwM5SM5tdHfZmJ72YdZ8mHgap4sQGReDQh
        Vk6v+OdsUoouL9BXz4LT5UorNA==
X-Google-Smtp-Source: AK7set/3JwqwCep6Y6Cmt2nJXIoH3xw9e1mH3GOvuZj/ADtxV26fHn+UNk53xWREry/gIRBcphk0tA==
X-Received: by 2002:a17:906:858c:b0:88c:3502:56d4 with SMTP id v12-20020a170906858c00b0088c350256d4mr21037241ejx.46.1678357518370;
        Thu, 09 Mar 2023 02:25:18 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:7ee2:e73e:802e:45c1? ([2a02:810d:15c0:828:7ee2:e73e:802e:45c1])
        by smtp.gmail.com with ESMTPSA id ia27-20020a170907a07b00b008b1fc59a22esm8690065ejc.65.2023.03.09.02.25.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 02:25:17 -0800 (PST)
Message-ID: <b85c414d-6970-f1a1-a847-bd49f18edc22@linaro.org>
Date:   Thu, 9 Mar 2023 11:25:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH v2 1/7] dt-bindings: soc: qcom: Add schema for Inline
 Crypto Engine
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20230308155838.1094920-1-abel.vesa@linaro.org>
 <20230308155838.1094920-2-abel.vesa@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230308155838.1094920-2-abel.vesa@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 08/03/2023 16:58, Abel Vesa wrote:
> Add schema file for new Qualcomm Inline Crypto Engine driver.

Subject: drop second/last, redundant "schema for". The "dt-bindings"
prefix is already stating that these are bindings.

> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
> 
> This patch was not part of the v1.
> 
>  .../soc/qcom/qcom,inline-crypto-engine.yaml   | 42 +++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,inline-crypto-engine.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,inline-crypto-engine.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,inline-crypto-engine.yaml
> new file mode 100644
> index 000000000000..359f80dd97cb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,inline-crypto-engine.yaml

soc should not be placeholder for everything. Put it in crypto/

> @@ -0,0 +1,42 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/qcom/qcom,inline-crypto-engine.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Technologies, Inc. (QTI) Inline Crypto Engine
> +
> +maintainers:
> +  - Bjorn Andersson <andersson@kernel.org>
> +
> +description:
> +  Inline Crypto Engine

Please add useful description or drop.

> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,inline-crypto-engine

You need SoC specific compatible(s).

> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,gcc-sm8450.h>
> +
> +    ice: inline-crypto-engine@1d88000 {

Just: crypto

Also drop the label

Best regards,
Krzysztof

