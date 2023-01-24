Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B03E0C38142
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Jan 2023 15:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbjAXPQu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Jan 2023 10:16:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235029AbjAXPO4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Jan 2023 10:14:56 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBCD946D61
        for <linux-mmc@vger.kernel.org>; Tue, 24 Jan 2023 07:14:53 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id e3so14180359wru.13
        for <linux-mmc@vger.kernel.org>; Tue, 24 Jan 2023 07:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fa3NonT7uFixEjw+mFXts/QRHz1QGTzg+aYFZ1DSamI=;
        b=ZDwoRWXjszEA2Uri4ulJorf3U8qeYpMCzR9w95It/1gUBf49Qp2To8luIc8kDHdrxW
         FO9g8eIkGybfAuaMkAa7qWlRjQKZia6gZzzuEMba/PBpQbZj1vsW7IiTtxk2BaCH6u2g
         WuY8nWWaaQZesAhD1Hp/CkPGxt+c73uqhP8N9iH4sqYsfkhAcz+YH4CYpjPbr6j9NPtv
         JxdnlmhmAEJupOZdHv/cSBJi772XxQ1gunch/yWVVhkzzd27ePiVcvcS1ch7I6bM+mbN
         3Vp0oCwj6XDip/JpghvWcM6pCB5D5rCwK2bxnp08+BJutG4B+3YIVslD9+EB+fibY2+p
         qZ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fa3NonT7uFixEjw+mFXts/QRHz1QGTzg+aYFZ1DSamI=;
        b=LaAN0NRd3968ReJdFcGKfwgvtnw1j/9zZMDWbw0sICAg0RF7V9FgMkjDl6YtPrWQx7
         +OmbPpKtoDhWttfBYy3rMbG/z/xOulWritTQJlVihLofTpw/A8zLbaQ0REPBU24+Prmj
         aK9gqn5MksuL4xgOjkVGjwGMksVt4lwB+cWYHapmRC+yz8GxqGfUhK1v+eMsgUP/fG/T
         o3IDRWNle2q/VsSgLUBfT08K1FYtsw42xoO6cAmUgZS/Lls5L4lsBozumi5ZS669RX2r
         WOAhsS/cq5ikpxW2Ac52y8a0hZn8wbxMzfOuCVXR3RIQNV4b1Yv/gqGsef+Z0MSuxS3H
         wN0A==
X-Gm-Message-State: AFqh2kpr6iz2rpqbFdzmqz2VeRC+ONOHUCv0Zd1VJKLtoo4zoFpKaxSL
        z96aGFZ3maLFT4klzNF1AW2cxQ==
X-Google-Smtp-Source: AMrXdXvK51H0IbshntMwpUlZI+AFdA28RuhJbW5H0nwtSX5T9NKgvLN4T82oPMNUoBjZnUPRsi2oJA==
X-Received: by 2002:adf:e883:0:b0:2be:4624:dd81 with SMTP id d3-20020adfe883000000b002be4624dd81mr16218138wrm.58.1674573292454;
        Tue, 24 Jan 2023 07:14:52 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id s9-20020adfdb09000000b002238ea5750csm2644979wri.72.2023.01.24.07.14.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 07:14:52 -0800 (PST)
Message-ID: <adb66162-6ff3-184e-fe92-109bdef8ed1c@linaro.org>
Date:   Tue, 24 Jan 2023 16:14:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH V1 7/8] arm64: dts: qcom: Add ipq9574 SoC and AL02 board
 support
Content-Language: en-US
To:     devi priya <quic_devipriy@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, ulf.hansson@linaro.org, linus.walleij@linaro.org,
        catalin.marinas@arm.com, will@kernel.org, p.zabel@pengutronix.de,
        shawnguo@kernel.org, arnd@arndb.de, marcel.ziswiler@toradex.com,
        dmitry.baryshkov@linaro.org, nfraprado@collabora.com,
        broonie@kernel.org, tdas@codeaurora.org, bhupesh.sharma@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com,
        quic_poovendh@quicinc.com
References: <20230124141541.8290-1-quic_devipriy@quicinc.com>
 <20230124141541.8290-8-quic_devipriy@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230124141541.8290-8-quic_devipriy@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 24/01/2023 15:15, devi priya wrote:
> From: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
> 
> Add initial device tree support for Qualcomm IPQ9574 SoC
> and AL02 board
> 
> Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
> Co-developed-by: devi priya <quic_devipriy@quicinc.com>
> Signed-off-by: devi priya <quic_devipriy@quicinc.com>
> Signed-off-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile            |   1 +
>  arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts |  78 +++++
>  arch/arm64/boot/dts/qcom/ipq9574.dtsi        | 285 +++++++++++++++++++
>  3 files changed, 364 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/ipq9574.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 3e79496292e7..872c62028a0b 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -7,6 +7,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= ipq6018-cp01-c1.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq8074-hk01.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq8074-hk10-c1.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq8074-hk10-c2.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= ipq9574-al02-c7.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-alcatel-idol347.dtb

This does not match current tree, so I could not apply it for tests. I
think you based it on a bit older version.

Best regards,
Krzysztof

