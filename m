Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22613C433EF
	for <linux-mmc@archiver.kernel.org>; Wed, 30 Mar 2022 16:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349096AbiC3Q6t (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 30 Mar 2022 12:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343794AbiC3Q6t (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Mar 2022 12:58:49 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E245642A3E
        for <linux-mmc@vger.kernel.org>; Wed, 30 Mar 2022 09:57:03 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id h1so25196442edj.1
        for <linux-mmc@vger.kernel.org>; Wed, 30 Mar 2022 09:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fEzld4oIJa86hl09sRy64K2e8LGIGCRfWuc+U0PWYOs=;
        b=pz8Axq5e3iFbz7Jw0eIdKg+hWyV0eg5X/OrzwVODe4qALsVNW5P6XCIffz7jZBls1S
         Ay8G4ifJkD57k5cn7sKOqZqcX8jZz7AiV0A+xfY0usJu+I228VzlXlRNwtFfpvWDYChT
         tCTa4NX0jot2hZU9MZto6acQS6j1L5ezvPVFwjTq5mozRXGJ/05EDtzB/X0fdtun30yf
         E7wrNN00iG4bycxxZuXuO6Zu97SotlzoyB98sU++D3zFCPA3T7stPpKNzWvbRrSL+Hzq
         CLmsL7H9fVbfmMMXR72/C2K+zdLRiND4Sk71buZAy/vXVdCalN6MK04NuIfO07hJu1FF
         XYsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fEzld4oIJa86hl09sRy64K2e8LGIGCRfWuc+U0PWYOs=;
        b=eUQIBit0AQuenhLEMiQ61wUlKXUmnr/YRVekFtgFZdjbhFidNSD/R6uXK0PcAj22h/
         dY6NC5uEnytEfuPc4Oc8MbkaFTOlLAuTZa2Jc9ZCDQ4lP64bVvHvHDqkrF2otLZY902N
         FYhNpY0UxClpobDEHozNwEPBBHRVUCPChnjuxCmV+pRtlV1efYLef4YwDB7yi4GfmUkg
         +mRTvCNS5WKqhuiTCJstBdIHKcaTQVl5F20Y5sx7kq7XlO1Ct0PSzepcEH6iXINWHAw/
         xeZ0fk0kPt8ONn8YAVvlJcUbpNdVkLn2V0rntkRtL/3Uvc94rJU7dcJaw/8JWTJAHlpd
         07Qw==
X-Gm-Message-State: AOAM5327AHNNg/GWBY8ks1RDkFSVqibp1yEaKn9cb7N2uojMg0pWN1ZM
        nmS/caKCQNw6vPmekeXBBxoozg==
X-Google-Smtp-Source: ABdhPJyCpxyw7R6T+pFO1zsX01vbrvk5lvAApJ9RbFPs/LdEa4c5G+bltActTe6FNicQwS1ouiR2cg==
X-Received: by 2002:a05:6402:d67:b0:419:48b:a762 with SMTP id ec39-20020a0564020d6700b00419048ba762mr11695300edb.291.1648659422507;
        Wed, 30 Mar 2022 09:57:02 -0700 (PDT)
Received: from [192.168.0.164] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id q15-20020a1709060e4f00b006cdf4535cf2sm8394201eji.67.2022.03.30.09.57.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 09:57:01 -0700 (PDT)
Message-ID: <e13ceaad-d5f7-3c50-774e-28cabb2e1fe6@linaro.org>
Date:   Wed, 30 Mar 2022 18:57:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] dt-bindings: Fix incomplete if/then/else schemas
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Dmitry Osipenko <digetx@gmail.com>, linux-iio@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-mmc@vger.kernel.org,
        linux-tegra@vger.kernel.org, netdev@vger.kernel.org,
        linux-phy@lists.infradead.org
References: <20220330145741.3044896-1-robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220330145741.3044896-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 30/03/2022 16:57, Rob Herring wrote:
> A recent review highlighted that the json-schema meta-schema allows any
> combination of if/then/else schema keywords even though if, then or else
> by themselves makes little sense. With an added meta-schema to only
> allow valid combinations, there's a handful of schemas found which need
> fixing in a variety of ways. Incorrect indentation is the most common
> issue.
> 
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Michael Hennerich <Michael.Hennerich@analog.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Olivier Moysan <olivier.moysan@foss.st.com>
> Cc: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Georgi Djakov <djakov@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> Cc: Grygorii Strashko <grygorii.strashko@ti.com>
> Cc: Dmitry Osipenko <digetx@gmail.com>
> Cc: linux-iio@vger.kernel.org
> Cc: alsa-devel@alsa-project.org
> Cc: linux-mmc@vger.kernel.org
> Cc: linux-tegra@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: linux-phy@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/iio/adc/adi,ad7476.yaml          |  1 +
>  .../bindings/iio/adc/st,stm32-dfsdm-adc.yaml  |  8 +-
>  .../bindings/iio/dac/adi,ad5360.yaml          |  6 +-
>  .../bindings/interconnect/qcom,rpm.yaml       | 84 +++++++++----------
>  .../bindings/mmc/nvidia,tegra20-sdhci.yaml    |  2 +
>  .../bindings/net/ti,davinci-mdio.yaml         |  1 +
>  .../bindings/phy/nvidia,tegra20-usb-phy.yaml  | 20 ++---
>  .../bindings/phy/qcom,usb-hs-phy.yaml         | 36 ++++----
>  .../bindings/regulator/fixed-regulator.yaml   | 34 ++++----
>  .../bindings/sound/st,stm32-sai.yaml          |  6 +-
>  .../devicetree/bindings/sram/sram.yaml        | 16 ++--
>  11 files changed, 108 insertions(+), 106 deletions(-)

Looks good:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof
