Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE9DBC0015E
	for <linux-mmc@archiver.kernel.org>; Thu, 15 Jun 2023 12:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244497AbjFOM4E (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 15 Jun 2023 08:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240673AbjFOMzz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Jun 2023 08:55:55 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0E4213B
        for <linux-mmc@vger.kernel.org>; Thu, 15 Jun 2023 05:55:53 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f7deee339dso1660227e87.0
        for <linux-mmc@vger.kernel.org>; Thu, 15 Jun 2023 05:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686833751; x=1689425751;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hr+C4HV3ypYhMAH5p+tz4TJXh2rByBSODsfmyqqfM3o=;
        b=Ix+HXY8lKizE+F/v9G5aOrSdAwCUUPO3rC5F22k4R8aUIph0mG19vve1xPug+9DdRb
         EhVfImlBBTz3KHcBCs/FVDcF4s18euAZMEXNNGWJaZdTYVPo7GAwKezYf000qbO4P5IJ
         /nIpu0ZHAqYiqYbsKwbtR1R3OpX8r0Hth+2c2RSA/sepTHT+LABrrk3FFL44W/CEquEs
         nZTyeZSTdy9PoWlYB5PUWppt0pgx/iXJvPhOW4+8eqBEcjjCHqX4++5PsCFOo3G2FxLp
         PamKcUhhjm8AhIUuMqpr+gyCFZlqkl3SmIQr2lI2eG5mEH4oqpnltkTtHCuyStR4sRVU
         A7+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686833751; x=1689425751;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hr+C4HV3ypYhMAH5p+tz4TJXh2rByBSODsfmyqqfM3o=;
        b=O/oBKPRJLddlCEQxatlif6ilCbZGf01E8XRdVAOdEw6cDSwIR5AJCZ+MXl7spKUV8h
         MbBanlHuvVWJ+cgSx1LURzycYjV0BexO2MocCmKJZWXeMy5esX/akMfoyQgpQEZ5oRyP
         LDdVTjCyxehP7U59y4rUMayKxT6iQH5Zc5Gi4LOGI9U1+3O3yz4SIieZ8VLkEyeqSnMf
         p/a+/i+LdpWzx1vk6M+w/14zLT5Z//g3jX1mKnONdrorYwUBXJdZG1onCJAa2VIFhQ2I
         2pwIe3TfkQtU+Hz2IJQLWBvBaFgFE2+ZXjMW1Q4ulfiyY8ddOuWgN8TZyG3kCp2k/5te
         ZO1A==
X-Gm-Message-State: AC+VfDyk+7nDPuPqy567egE70R/I9JGaqqd5lYQ2n9c44XOI8w/tNXLp
        lbN4wPUNJJLwigpVvIl+3lq8Hkae96Tu/73q6fk=
X-Google-Smtp-Source: ACHHUZ5r5g0/EdaBgh3ItbXCv7EHaR9YYHxAHfFr/UG529fhS2cSFA7JJ0Qe09gXlXkN1fN/RsAUhg==
X-Received: by 2002:a19:da12:0:b0:4f7:669f:7da8 with SMTP id r18-20020a19da12000000b004f7669f7da8mr3474493lfg.7.1686833751155;
        Thu, 15 Jun 2023 05:55:51 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id c26-20020a19761a000000b004f14ea05895sm2550319lff.213.2023.06.15.05.55.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 05:55:50 -0700 (PDT)
Message-ID: <1d1756c6-b79f-7f8f-2f00-6fcb3657295a@linaro.org>
Date:   Thu, 15 Jun 2023 14:55:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [v10 2/6] clk: qcom: Add Global Clock controller (GCC) driver for
 IPQ5018
Content-Language: en-US
To:     Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, ulf.hansson@linaro.org, linus.walleij@linaro.org,
        catalin.marinas@arm.com, will@kernel.org, p.zabel@pengutronix.de,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        robimarko@gmail.com, krzysztof.kozlowski@linaro.org,
        andy.shevchenko@gmail.com
References: <20230615090638.1771245-1-quic_srichara@quicinc.com>
 <20230615090638.1771245-3-quic_srichara@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230615090638.1771245-3-quic_srichara@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 15.06.2023 11:06, Sricharan Ramabadhran wrote:
> Add support for the global clock controller found on IPQ5018
> based devices.
> 
> Co-developed-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> Co-developed-by: Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>
> Signed-off-by: Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> ---

> +
> +static const struct freq_tbl ftbl_apss_axi_clk_src[] = {
> +	F(400000000, P_GPLL0, 2, 0, 0),
> +	{ }
> +};
This is weirdly far away from its use.

With that fixed:

Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
