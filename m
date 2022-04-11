Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFDEEC433F5
	for <linux-mmc@archiver.kernel.org>; Mon, 11 Apr 2022 06:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245046AbiDKGp1 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 11 Apr 2022 02:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239551AbiDKGp0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Apr 2022 02:45:26 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48AEF28E0A
        for <linux-mmc@vger.kernel.org>; Sun, 10 Apr 2022 23:43:13 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id t11so1754832eju.13
        for <linux-mmc@vger.kernel.org>; Sun, 10 Apr 2022 23:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9Vqofv8LVUK572dtLwE2D5FeqaGv/N4ekUHyn/Cn/j4=;
        b=aRz4swXmDsmqG+eRKSkI/ahoMX3Z/0+3/IdbMM9Lc8OPR1+PvFaMloi9d8ln3cWg1D
         fFa/a0RWMJLhAh8AiAl8S2dClrHropyKIfUjkgkRthdMuU+jYXmerQW/KdHYaRcf1rBK
         CCN7muKJixe3xgYs5WsNpQuTbNg4VzM9Zeqml/lFLdEdpAxRTGtOuNiFIxcm1vZZhf+G
         252ZiFnVbmNeSq+Nn5IxQVq/zM2fzoJ4I9gC8ctsVGkBsWVRvCC+LL6aj38kxjUBa2Z5
         LfYm0F8UjsTmCJZt/sNQFTGYlI8S1rkqmmN8XrYAcxe5d7jKHYSJw8gOaOUiZ4e5VxdK
         xuaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9Vqofv8LVUK572dtLwE2D5FeqaGv/N4ekUHyn/Cn/j4=;
        b=MrS9+qlRTwJlUWM+ZK45zyBs2vzjrESorBBXuAH1rLqjWkF/UALg+cWUPXYbjIcxxz
         E6zuP81eT/C+iggWiQCofD9qIa51zowMJjDcVoH2JdS5DmUqvEC3Ltu0jR53ZaU9yaVD
         uv6RAobYtQ+hRb05C6IAPZ0N2oUjp/FdhMswHYUzu8KCCkU9ZWAsrT6v1yruxCHA2Q9s
         MueUi2X22PTv0ziLR4pPdkn+YAfvFaCP48nQbF45h6qkqItomiacUo4lNOh48cqo4pKS
         AyiIh/qp+13WV8V4xUSMWdF5NfR76tEqxTLfZGINWkh8qeUkABE2b7rm6uQ2cYlIp2QF
         iC3w==
X-Gm-Message-State: AOAM533MjTZ8qbeopqLndB6JaKkJMeFfLYBLCXiF1ykOJ14YW9Ynu5mG
        srwtrRpI3Fi1gx/dQmqwF4iHLg==
X-Google-Smtp-Source: ABdhPJzpt5TX2Bie3ZJ+Cp3TofE0dqCbXEJt2VD5MxF5GDj+HJBKryEeNGbKNr4zbFYPpiSY/t5VMQ==
X-Received: by 2002:a17:907:a40b:b0:6da:b4a1:33fa with SMTP id sg11-20020a170907a40b00b006dab4a133famr27713766ejc.22.1649659391560;
        Sun, 10 Apr 2022 23:43:11 -0700 (PDT)
Received: from [192.168.0.191] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id e9-20020a17090618e900b006e8669f3941sm2985013ejf.209.2022.04.10.23.43.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Apr 2022 23:43:11 -0700 (PDT)
Message-ID: <ae5326a7-076a-f7a8-f6af-6efb4de0ea7e@linaro.org>
Date:   Mon, 11 Apr 2022 08:43:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V4 3/3] arm64: dts: imx8mp: Enable HS400-ES
Content-Language: en-US
To:     Adam Ford <aford173@gmail.com>, linux-mmc@vger.kernel.org
Cc:     aford@beaconembedded.com, Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220410193544.1745684-1-aford173@gmail.com>
 <20220410193544.1745684-3-aford173@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220410193544.1745684-3-aford173@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 10/04/2022 21:35, Adam Ford wrote:
> The SDHC controller in the imx8mp has the same controller
> as the imx8mm which supports HS400-ES. Change the compatible
> fallback to imx8mm to enable it, but keep the imx7d-usdhc
> to prevent breaking backwards compatibility.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
