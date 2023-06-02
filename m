Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB35C7EE2F
	for <linux-mmc@archiver.kernel.org>; Fri,  2 Jun 2023 08:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234370AbjFBI2u (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 2 Jun 2023 04:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234640AbjFBI22 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Jun 2023 04:28:28 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72EA410FB
        for <linux-mmc@vger.kernel.org>; Fri,  2 Jun 2023 01:27:41 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-5149390b20aso2619702a12.3
        for <linux-mmc@vger.kernel.org>; Fri, 02 Jun 2023 01:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685694436; x=1688286436;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rqiBV30sd6pVAOr/JC2i8NEvFQRhidh6InexBKyx7mo=;
        b=rIl0eivXD4yxDCT/YgMEsx+zB95XosuikN/Qy10i57lfY0bUaZOBftlmQqO+cFMD0D
         HZAAhd0VW/ieFo5zYGo6vv2v0zUDlZ52siklLw4uV81kybENAfWJX5R3rwrvf1buexm1
         yEMYUIUSzh/qNzwQBiwrUVRoKsvabnkfIAmeTWvOidfzk0NWYH9cT8KdwNTwXDRoHenP
         EInC+vD5ibY9evurg3TMnF2a3tcxmfxxjvXFWOSqpjcgLZIxu/CI4Luehlm1nqH4vHwD
         X0FqymZc2B+ehA1Y5i2CI/W5+vwNvIxBm+FpLQN812zDX0RThsO/Sk+wpIPeOHKFX7Xs
         uPSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685694436; x=1688286436;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rqiBV30sd6pVAOr/JC2i8NEvFQRhidh6InexBKyx7mo=;
        b=hUzCkVqMloT19sWK77VPUaxPz/EikZnlOQ+2+cuc5qi766QZkDLNfx33EIF9KyeJcf
         U7cWfldJQGNQKlNxA0gqDRD9NH5aBP0uXnTphZZWOb0DujKCTADQUF2zpYfafY5WfH7/
         Q7/7mzLnHVM0TdMTQ0oSlibE/j9vvwURY6tpG0X+T4wK2CZN2bznmlXB7azmR932AGZ+
         667ap+qn4T4Pkv1+wC+mC8XiNL/ehkiMYAgDNz+Tg8baE45V8TJyu0IbxtUfoUEcRY0u
         cSTBZaJCkW6B4+i4b3B9uXj/qVpHoe9t2AexmJleuwwPDjmwPhBm9d9b/w0rhiSM98jo
         +7rw==
X-Gm-Message-State: AC+VfDwytj/7cAkFEQP0OV4BG+HSjKHnIyM/5WNKaqeGQ3o51/IPk9C/
        WUPw7LbapnMryFv1a53+ayqKcQ==
X-Google-Smtp-Source: ACHHUZ7QkKl0T36/hmXWtoKKBK/0HSPptyUZfw8AKnhu87xXvJCANWT/QJH7XR+fLH3RF42PD2as2Q==
X-Received: by 2002:a05:6402:2cd:b0:506:976e:5242 with SMTP id b13-20020a05640202cd00b00506976e5242mr1511546edx.25.1685694436433;
        Fri, 02 Jun 2023 01:27:16 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id x26-20020aa7cd9a000000b005149461b1e0sm414404edv.25.2023.06.02.01.27.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 01:27:15 -0700 (PDT)
Message-ID: <1d6f70ab-e971-4a83-a9b3-e049b38c29a0@linaro.org>
Date:   Fri, 2 Jun 2023 10:27:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v1 1/7] dt-bindings: mmc: fsl-imx-esdhc: Add imx6ul
 support
To:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Abel Vesa <abelvesa@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     kernel@pengutronix.de, Peng Fan <peng.fan@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Mark Brown <broonie@kernel.org>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Anson Huang <Anson.Huang@nxp.com>, Marek Vasut <marex@denx.de>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-input@vger.kernel.org,
        linux-mmc@vger.kernel.org
References: <20230601101451.357662-1-o.rempel@pengutronix.de>
 <20230601101451.357662-2-o.rempel@pengutronix.de>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230601101451.357662-2-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 01/06/2023 12:14, Oleksij Rempel wrote:
> Add the 'fsl,imx6ul-usdhc' value to the compatible properties list in
> the fsl-imx-esdhc.yaml file. This is required to match the compatible
> strings present in the 'mmc@2190000' node of 'imx6ul-prti6g.dtb'. This
> commit addresses the following dtbs_check warning:
>   imx6ul-prti6g.dtb: mmc@2190000: compatible: 'oneOf' conditional failed,
>     one must be fixed: ['fsl,imx6ul-usdhc', 'fsl,imx6sx-usdhc'] is too long
>     'fsl,imx6ul-usdhc' is not one of ['fsl,imx25-esdhc', 'fsl,imx35-esdhc',
>     'fsl,imx51-esdhc', 'fsl,imx53-esdhc', 'fsl,imx6q-usdhc',
>     'fsl,imx6sl-usdhc', 'fsl,imx6sx-usdhc', 'fsl,imx7d-usdhc',
>     'fsl,imx7ulp-usdhc', 'fsl,imx8mm-usdhc', 'fsl,imxrt1050-usdhc',
>     'nxp,s32g2-usdhc']
>   From schema: Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml

Except what Conor wrote, please don't wrap that much the error log - it
is unreadable. Trim it, remove unneeded parts and keep some decent
one/two lines even if it exceeds the commit msg. This applies to other
patches as well.

Best regards,
Krzysztof

