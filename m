Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C68DDC7619A
	for <linux-mmc@archiver.kernel.org>; Sun, 16 Apr 2023 09:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjDPJF7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 16 Apr 2023 05:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjDPJF6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 16 Apr 2023 05:05:58 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B45D1
        for <linux-mmc@vger.kernel.org>; Sun, 16 Apr 2023 02:05:57 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id u3so4586122ejj.12
        for <linux-mmc@vger.kernel.org>; Sun, 16 Apr 2023 02:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681635955; x=1684227955;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KlGz8JKELgg3r8mMiki5eECoDbZv+x5gc1ofLrVcTyg=;
        b=cOgPSIoFkdBBtroB7HJ8Jy5YxHfHM+s7oz+bS15lmhrLaQv7kDAJryXB+eWSTdFnCq
         KJe5Y6hXhpZ9g6Dmrc5P+qOCFrE3Bx2c47+KA38UAZlSmq8M1c2+K2vWV0J5K3jw5Ww5
         QXtZ8Zg17Q/p9uGZ6jnuUdssnXYE2+oc2fCeJkvEHO3OFfMrCVVPTpYLM0LaJhdKIJhp
         UGbCaMEczEp71Q2lHkkvurXNkkHULzbwbdlRU7/NoUch2q7Os4vfOjUYwWiNam+RzGwu
         cW0thOZCWngq/3yRUpDCwkZF6udLdqTeHGz0jy29p034FLxvU+NZwoJS8SrMKNQiHLKo
         HNxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681635955; x=1684227955;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KlGz8JKELgg3r8mMiki5eECoDbZv+x5gc1ofLrVcTyg=;
        b=bO3aOMrW/S/vV9zbpr5FDRr0cwtFWO5UuuYKR1KE60cG3jrYGTw9mFYUdMlfQcLhlF
         1FK2VzwIjjyeTli3zAcnYkYMyFMSXX8l5bS1NFkpgx73MqAghzZg/lJSJN3r9EadPQqt
         6cqSTjpAazUUx5MmF7y38s4JmCRfE0t4y+RJcOtAXmbYRPyTBx/evVT9okHPRptIR3qC
         rlCkq8MMY6yr0DkJE3bEIuADCCywbRSVFOy3G1KHYgMXivvLaNzwJJbB48xKEKx8hfGO
         hQKwxMK9D8RN8J+rK/rRTn6LXTK/Qix5u3k7/Q1SS+hASviS3w4PjnpvrNFdHWhoOFH7
         l7Ww==
X-Gm-Message-State: AAQBX9eVp4/JUlPxYEb4fVuQz50tDqmz2+Cq3lhCRi3zzI9MMweTpQ1g
        cNGgWS0W+zSzBzMsRcksDddwig==
X-Google-Smtp-Source: AKy350YtxFNxax7Pbq26Km+VElE38/PHPK+bNeopmDM55nPrGadnmeGvHZepVxj8+9iGRvAW89qqwQ==
X-Received: by 2002:a17:906:1014:b0:948:eed:b4e0 with SMTP id 20-20020a170906101400b009480eedb4e0mr4192321ejm.61.1681635955504;
        Sun, 16 Apr 2023 02:05:55 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:29dd:ded4:3ccc:83db? ([2a02:810d:15c0:828:29dd:ded4:3ccc:83db])
        by smtp.gmail.com with ESMTPSA id n20-20020a1709065db400b0094a90d3e385sm4807165ejv.30.2023.04.16.02.05.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 02:05:55 -0700 (PDT)
Message-ID: <4b3ce97d-a134-290d-e762-46d6a91caee1@linaro.org>
Date:   Sun, 16 Apr 2023 11:05:53 +0200
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
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> index 785b969..350f9f6 100644
> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> @@ -30,6 +30,7 @@ description: |
>          apq8084
>          apq8096
>          ipq4018
> +        ipq5018
>          ipq5332
>          ipq6018
>          ipq8074
> @@ -95,6 +96,7 @@ description: |
>          hk10-c2
>          idp
>          liquid
> +        rdp432-c1

Keep proper order, not random.

>          mtp
>          qrd
>          ride


Best regards,
Krzysztof

