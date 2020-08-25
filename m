Return-Path: <SRS0=3fsM=CD=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 354CBC433E1
	for <linux-mmc@archiver.kernel.org>; Tue, 25 Aug 2020 02:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14F34207D3
	for <linux-mmc@archiver.kernel.org>; Tue, 25 Aug 2020 02:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598323151;
	bh=7cBjvXsXt2jsE9jEr5vMNKtcaL20lT6BtpqNXXLAETs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cba9HiHNw3YKC6xAwJRkP7/20vrrUi4KND3hRzjnu69ryADNog5AMpibOZG1Axt46
	 DS6EbeLYkzfR7vKx3we9LFoiStUj+J0y4ty6nXysBibdmyoKP/NOEwg6XBuSvK3Mo+
	 tVDtP3A2pG4O0TpC96NwvIRJ4bYLAZv/lO5T+8uo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbgHYCjI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 24 Aug 2020 22:39:08 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:35794 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbgHYCjI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Aug 2020 22:39:08 -0400
Received: by mail-il1-f193.google.com with SMTP id q14so9160428ilm.2;
        Mon, 24 Aug 2020 19:39:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fL7pWD9A8RK0B1OZrOzwtZdS/77nrhwq1dxpG8mipBI=;
        b=fxgqU5VhC0VIO5xduv/sd2nOsOTzbfEIxn4cPYd5YgJcS7F9eHlm5M3rPdB7RWTRoI
         4SNQUz2Ou0iQuE5CVqUcT0eEc+SHo48uMZcjqrlkuBccMfIR8bSPxIAgP6RIk07PICYs
         mMEIlqiJ065pscO/ahJPsbUwNqikirN9vgUYJnoYO7dyOBqOnCWRtEgXQTnIuwAS2CF4
         Jv/7DsScDskM+MtbRGDgq2tBWrodIzdnWOezRsNDynKT/ONxIJInQhQJfqQfUBKNS6iG
         hJN+Y4MbBzKc1DzWf9km7vsAp82bH4/zqFz39ak5WbkgTk6zgqVTr3axiVYOO8AvzvAd
         b9Sg==
X-Gm-Message-State: AOAM532kaKEaECPXgin9rkwbu6GyNGuUxb4NifUqJ7GIePpqdbE8Rpqa
        SJys8NlXJAGB/GOWU63Pyg==
X-Google-Smtp-Source: ABdhPJzaBBWCv3karwrLTnFh+xW6JHFxPv6HuRRHM0izCtfP5onAJPkVfTMYNXVMmjyBAU8SvZKZrw==
X-Received: by 2002:a05:6e02:ef3:: with SMTP id j19mr7354144ilk.88.1598323146707;
        Mon, 24 Aug 2020 19:39:06 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id u124sm7809640iod.20.2020.08.24.19.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 19:39:06 -0700 (PDT)
Received: (nullmailer pid 3838650 invoked by uid 1000);
        Tue, 25 Aug 2020 02:39:04 -0000
Date:   Mon, 24 Aug 2020 20:39:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Li Yang <leoyang.li@nxp.com>, Han Xu <han.xu@nxp.com>,
        Frank Li <frank.li@nxp.com>, Fugang Duan <fugang.duan@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2 13/19] dt-bindings: nvmem: imx-ocotp: Update i.MX 8M
 compatibles
Message-ID: <20200825023904.GA3837236@bogus>
References: <20200824162652.21047-1-krzk@kernel.org>
 <20200824162652.21047-13-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824162652.21047-13-krzk@kernel.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Aug 24, 2020 at 06:26:46PM +0200, Krzysztof Kozlowski wrote:
> DTSes with new i.MX 8M SoCs use two compatibles so update the binding to
> fix dtbs_check warnings like:
> 
>   arch/arm64/boot/dts/freescale/imx8mn-evk.dt.yaml: efuse@30350000: compatible:1: 'syscon' was expected
>     From schema: Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml
> 
>   arch/arm64/boot/dts/freescale/imx8mn-evk.dt.yaml: efuse@30350000:
>     compatible: ['fsl,imx8mn-ocotp', 'fsl,imx8mm-ocotp', 'syscon'] is too long
> 
>   arch/arm64/boot/dts/freescale/imx8mn-evk.dt.yaml: efuse@30350000:
>     compatible: Additional items are not allowed ('syscon' was unexpected)
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  .../devicetree/bindings/nvmem/imx-ocotp.yaml  | 39 ++++++++++++-------
>  1 file changed, 24 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml b/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml
> index 1c9d7f05f173..b5b250185afd 100644
> --- a/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml
> @@ -19,21 +19,30 @@ allOf:
>  
>  properties:
>    compatible:
> -    items:
> -      - enum:
> -          - fsl,imx6q-ocotp
> -          - fsl,imx6sl-ocotp
> -          - fsl,imx6sx-ocotp
> -          - fsl,imx6ul-ocotp
> -          - fsl,imx6ull-ocotp
> -          - fsl,imx7d-ocotp
> -          - fsl,imx6sll-ocotp
> -          - fsl,imx7ulp-ocotp
> -          - fsl,imx8mq-ocotp
> -          - fsl,imx8mm-ocotp
> -          - fsl,imx8mn-ocotp
> -          - fsl,imx8mp-ocotp
> -      - const: syscon
> +    oneOf:
> +      - items:
> +          - enum:
> +              - fsl,imx6q-ocotp
> +              - fsl,imx6sl-ocotp
> +              - fsl,imx6sx-ocotp
> +              - fsl,imx6ul-ocotp
> +              - fsl,imx6ull-ocotp
> +              - fsl,imx7d-ocotp
> +              - fsl,imx6sll-ocotp
> +              - fsl,imx7ulp-ocotp
> +              - fsl,imx8mq-ocotp
> +              - fsl,imx8mm-ocotp

> +              - fsl,imx8mn-ocotp
> +              - fsl,imx8mp-ocotp

Should be dropped.

> +          - const: syscon
> +      - items:
> +          # The devices are not really compatible with fsl,imx8mm-ocotp, however
> +          # the code for getting SoC revision depends on fsl,imx8mm-ocotp compatible.
> +          - enum:
> +              - fsl,imx8mn-ocotp
> +              - fsl,imx8mp-ocotp
> +          - const: fsl,imx8mm-ocotp
> +          - const: syscon
>  
>    reg:
>      maxItems: 1
> -- 
> 2.17.1
> 
