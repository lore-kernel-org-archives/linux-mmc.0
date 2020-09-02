Return-Path: <SRS0=r8P+=CL=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C351DC433E2
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Sep 2020 09:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DF3D20709
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Sep 2020 09:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZNr7dTiM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgIBJD5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 2 Sep 2020 05:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgIBJDr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Sep 2020 05:03:47 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E62CC061258
        for <linux-mmc@vger.kernel.org>; Wed,  2 Sep 2020 02:03:47 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id g11so1338975ual.2
        for <linux-mmc@vger.kernel.org>; Wed, 02 Sep 2020 02:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G7z93t1Etv3+Y7YRGqoitCZfELcgVcpVmZuSYiiuAMc=;
        b=ZNr7dTiMyg6AJhHsdVCwXw5CQaH02wnOnH42Zr5wVBHqxb0354fDvNOiMNx6Lmc0hE
         QvUDEGEWKwtU63Sv5gfBy3asdk4Xo6wqAh6SE5d/9t3h1Fxsg32wfjXT/7xiodD5G5pZ
         0EKEDKEi/A7o5IvEbPeol4SFl6PQFNNTja+vjlcRop0AWOnZ6JXzH6BbUGiJylF0O1Lx
         PgOOwKbmHa4RJS0q13zHAf5qCeEB1iseAEndTs3QjRUXhEGIRfelydA6FGU1BnRoV/bw
         KjsQoPeNLOw3BNLzdxNjYZpjA3Mq+Ou8H87Ud5PLEAhDNMXtemEaevQudQWIQhnvouuq
         3ypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G7z93t1Etv3+Y7YRGqoitCZfELcgVcpVmZuSYiiuAMc=;
        b=bmWCrWvLEGNvC8wxCSG9AMIEHG+Yy+Yljw4L0gL/jqxZ5JTj16CkatEJzJNib/AvAe
         2wrOXRA1uvOOn2tCOTkT6ZXRfg8DWX6WSpCluwVSoaMMpc8dY+Cnpg48CzQATHb1cxLn
         FNX7b+A/UdKI54sAXovH0NHL8BJY2iEQZUM1O2zUD9gfYSg8B7bp/ZzKIa9m7JAoJI3Y
         /waqW/lFOOiCuhkv6kwVlfjQl403EZviJZom8TMcZt4yjlJn6jKrB1RrZZy4WYLy5cB8
         qvOtiDLa0DAkEF+1peZ4zKjOYXJI6tHwBcDbXpxJHb0YAu8PIwQ1QxlOwnbY85PBpnMf
         B+Rg==
X-Gm-Message-State: AOAM531isvL2gTvTN8SYmTv31MPHs6JuEHtEFvOhXKpCzQt02xaJsQ/N
        kxq9zIwuvjAuHq+J0tqxQx/rqxaAXW1AUa/jd9+u0A==
X-Google-Smtp-Source: ABdhPJyTJjkE0DbQ9blDWav98w+X2eEv5Ao+aqHbo6v8vW6kAJ3iH1xM8Vn6niOHiZAqARCskMhgKTsCoqH+TsHxDac=
X-Received: by 2002:a9f:2722:: with SMTP id a31mr4520715uaa.100.1599037426432;
 Wed, 02 Sep 2020 02:03:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200829062505.4642-1-krzk@kernel.org>
In-Reply-To: <20200829062505.4642-1-krzk@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 2 Sep 2020 11:03:09 +0200
Message-ID: <CAPDyKFrVLZUXEV6pCa6aPJFtFsZ4xv9mtcycUQ1-XHyGOqKi+A@mail.gmail.com>
Subject: Re: [PATCH v4] dt-bindings: mmc: fsl-imx-esdhc: Fix i.MX 8 compatible matching
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, 29 Aug 2020 at 08:25, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> The i.MX 8 DTSes use two compatibles so update the binding to fix
> dtbs_check warnings like:
>
>   arch/arm64/boot/dts/freescale/imx8mn-evk.dt.yaml: mmc@30b40000:
>     compatible: ['fsl,imx8mn-usdhc', 'fsl,imx7d-usdhc'] is too long
>     From schema: Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
>
>   arch/arm64/boot/dts/freescale/imx8mn-evk.dt.yaml: mmc@30b40000:
>     compatible: Additional items are not allowed ('fsl,imx7d-usdhc' was unexpected)
>
>   arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dt.yaml: mmc@30b40000:
>     compatible: ['fsl,imx8mn-usdhc', 'fsl,imx7d-usdhc'] is too long
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied for next, thanks!

Kind regards
Uffe


>
> ---
>
> Changes since v3:
> 1. Fix also example in Documentation/devicetree/bindings/clock/imx8qxp-lpcg.yaml
>
> Changes since v2:
> 1. Remove moved compatibles.
>
> Changes since v1:
> 1. Handle also fsl,imx8mm-usdhc and fsl,imx8qxp-usdhc
> ---
>  .../bindings/clock/imx8qxp-lpcg.yaml          |  2 +-
>  .../bindings/mmc/fsl-imx-esdhc.yaml           | 37 ++++++++++---------
>  2 files changed, 21 insertions(+), 18 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/clock/imx8qxp-lpcg.yaml b/Documentation/devicetree/bindings/clock/imx8qxp-lpcg.yaml
> index 1d5e9bcce4c8..33f3010f48c3 100644
> --- a/Documentation/devicetree/bindings/clock/imx8qxp-lpcg.yaml
> +++ b/Documentation/devicetree/bindings/clock/imx8qxp-lpcg.yaml
> @@ -62,7 +62,7 @@ examples:
>      };
>
>      mmc@5b010000 {
> -        compatible = "fsl,imx8qxp-usdhc";
> +        compatible = "fsl,imx8qxp-usdhc", "fsl,imx7d-usdhc";
>          interrupts = <GIC_SPI 232 IRQ_TYPE_LEVEL_HIGH>;
>          reg = <0x5b010000 0x10000>;
>          clocks = <&conn_lpcg IMX_CONN_LPCG_SDHC0_IPG_CLK>,
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> index 10b45966f1b8..e71d13c2d109 100644
> --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> @@ -21,23 +21,26 @@ description: |
>
>  properties:
>    compatible:
> -    enum:
> -      - fsl,imx25-esdhc
> -      - fsl,imx35-esdhc
> -      - fsl,imx51-esdhc
> -      - fsl,imx53-esdhc
> -      - fsl,imx6q-usdhc
> -      - fsl,imx6sl-usdhc
> -      - fsl,imx6sx-usdhc
> -      - fsl,imx6ull-usdhc
> -      - fsl,imx7d-usdhc
> -      - fsl,imx7ulp-usdhc
> -      - fsl,imx8mq-usdhc
> -      - fsl,imx8mm-usdhc
> -      - fsl,imx8mn-usdhc
> -      - fsl,imx8mp-usdhc
> -      - fsl,imx8qm-usdhc
> -      - fsl,imx8qxp-usdhc
> +    oneOf:
> +      - enum:
> +          - fsl,imx25-esdhc
> +          - fsl,imx35-esdhc
> +          - fsl,imx51-esdhc
> +          - fsl,imx53-esdhc
> +          - fsl,imx6q-usdhc
> +          - fsl,imx6sl-usdhc
> +          - fsl,imx6sx-usdhc
> +          - fsl,imx6ull-usdhc
> +          - fsl,imx7d-usdhc
> +          - fsl,imx7ulp-usdhc
> +      - items:
> +          - enum:
> +              - fsl,imx8mm-usdhc
> +              - fsl,imx8mn-usdhc
> +              - fsl,imx8mp-usdhc
> +              - fsl,imx8mq-usdhc
> +              - fsl,imx8qxp-usdhc
> +          - const: fsl,imx7d-usdhc
>
>    reg:
>      maxItems: 1
> --
> 2.17.1
>
