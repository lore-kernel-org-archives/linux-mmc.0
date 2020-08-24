Return-Path: <SRS0=kf8L=CC=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC8B9C433E1
	for <linux-mmc@archiver.kernel.org>; Mon, 24 Aug 2020 07:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98E10206F0
	for <linux-mmc@archiver.kernel.org>; Mon, 24 Aug 2020 07:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598252831;
	bh=L7lFreml+LeSlRAYWIfDf6ivAo/g2mibkewQKdqPv8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SbO0Htmbw7tISvVFue5xBLHazKta6PSjSQvunqLVbWq4jSIfUukJbBBCuWu5ZrGhh
	 zFRronCU5QJzZrkJpN5VcXFshdczTacvXgC33J3OghBbOKIjOTNoGB0ve7xjgMiLLv
	 lOa6ae3IBkfBp0KCVLVmxyVqtPBx31wrxRrBG+4Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725850AbgHXHHL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 24 Aug 2020 03:07:11 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40907 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgHXHHK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Aug 2020 03:07:10 -0400
Received: by mail-wm1-f68.google.com with SMTP id k20so7114138wmi.5;
        Mon, 24 Aug 2020 00:07:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jMkESQ6/qDeh8yFOp5ut20DDKvKP8Egt8HrPQWgV3hI=;
        b=qO1tdIinoFPIXWPm5/19KfBpyFAwq8uKSg7EQU1L8V6ovQx9nJWVqyn3VV5ax8kBxQ
         pbVqTRVoiDADr0KvqztcBve3TkrN3Fl9lFP1UXt+MjKM+BULUR6gOD7v2Zhusjq4JE6W
         PzNQzwmCMMpsOIyNMIOA0r7/IZ6GjQyzxV8g4uEdQmkom9Zl5Wc4naHb4zWQicafXGE+
         ZBZfmBbEr3kyOvrivi2+KJJN9VY4xshpgyieT9qL2aC/lW3Zdm8z3E7U62EPJScgJYHS
         rZDR3h+FNeOgElnSHLwSH/Qkfq6sJmMvHVFSA1T6JeHKf6x2mv2hDTBPb4P6UFBtA1J4
         dwpg==
X-Gm-Message-State: AOAM530XgyTPKsoaliYNEw6PrdoDEeX2dCtCpr8HI1/B5ZGAHNi9rttZ
        zxzwkG2bBffmUngDYt1gm9g=
X-Google-Smtp-Source: ABdhPJyU61NszbES0k6p1PAHajV48Erw/hGcjANLVNAFBKqGCzpj1Y19Wb9rD9qlokEO4JMhFKYb8w==
X-Received: by 2002:a7b:c1c1:: with SMTP id a1mr4297940wmj.137.1598252826663;
        Mon, 24 Aug 2020 00:07:06 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id m1sm21788437wmc.28.2020.08.24.00.07.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Aug 2020 00:07:06 -0700 (PDT)
Date:   Mon, 24 Aug 2020 09:07:03 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Anson Huang <Anson.Huang@nxp.com>
Subject: Re: [PATCH 02/22] dt-bindings: gpio: fsl-imx-gpio: Add gpio-ranges
 property
Message-ID: <20200824070703.GA5382@kozik-lap>
References: <20200823161550.3981-1-krzk@kernel.org>
 <20200823161550.3981-2-krzk@kernel.org>
 <20200824052446.GE13023@pengutronix.de>
 <20200824063806.GA2497@kozik-lap>
 <20200824065801.GH13023@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200824065801.GH13023@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Aug 24, 2020 at 08:58:01AM +0200, Sascha Hauer wrote:
> On Mon, Aug 24, 2020 at 08:38:06AM +0200, Krzysztof Kozlowski wrote:
> > On Mon, Aug 24, 2020 at 07:24:46AM +0200, Sascha Hauer wrote:
> > > On Sun, Aug 23, 2020 at 06:15:30PM +0200, Krzysztof Kozlowski wrote:
> > > > The GPIO controller node can have gpio-ranges property.  This fixes
> > > > dtbs_check warnings like:
> > > > 
> > > >   arch/arm64/boot/dts/freescale/imx8mm-evk.dt.yaml: gpio@30200000: 'gpio-ranges' does not match any of the regexes: 'pinctrl-[0-9]+'
> > > >     From schema: Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml
> > > > 
> > > > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > > > ---
> > > >  .../devicetree/bindings/gpio/fsl-imx-gpio.yaml    | 15 +++++++++++++++
> > > >  1 file changed, 15 insertions(+)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml b/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml
> > > > index 454db20c2d1a..1fac69573bb9 100644
> > > > --- a/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml
> > > > +++ b/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml
> > > > @@ -51,6 +51,9 @@ properties:
> > > >  
> > > >    gpio-controller: true
> > > >  
> > > > +  gpio-ranges:
> > > > +    maxItems: 1
> > > > +
> > > >  required:
> > > >    - compatible
> > > >    - reg
> > > > @@ -62,6 +65,18 @@ required:
> > > >  
> > > >  additionalProperties: false
> > > >  
> > > > +allOf:
> > > > +  - if:
> > > > +      properties:
> > > > +        compatible:
> > > > +          contains:
> > > > +            const: fsl,imx8mp-gpio
> > > > +    then:
> > > > +      properties:
> > > > +        gpio-ranges:
> > > > +          minItems: 1
> > > > +          maxItems: 2
> > > 
> > > Why do you limit this to fsl,imx8mp-gpio? The i.MX5,6,7 dtsi files use
> > > gpio-ranges as well and other i.MX dtsi files could also use it.
> > 
> > All other cases use maximum one element in gpio-ranges, so they are
> > covered so I assumed they are continuous. But if it not the case, I can
> > make all them maximum 2.
> 
> I misread this, I thought you allow gpio-ranges only for imx8mp, but
> it's only the maxItems you set differently for that SoC. Anyway,
> arch/arm/boot/dts/imx6dl.dtsi has this:
> 
> &gpio1 {
>         gpio-ranges = <&iomuxc  0 131 2>, <&iomuxc  2 137 8>, <&iomuxc 10 189 2>,
>                       <&iomuxc 12 194 1>, <&iomuxc 13 193 1>, <&iomuxc 14 192 1>,
>                       <&iomuxc 15 191 1>, <&iomuxc 16 185 2>, <&iomuxc 18 184 1>,
>                       <&iomuxc 19 187 1>, <&iomuxc 20 183 1>, <&iomuxc 21 188 1>,
>                       <&iomuxc 22 123 3>, <&iomuxc 25 121 1>, <&iomuxc 26 127 1>,
>                       <&iomuxc 27 126 1>, <&iomuxc 28 128 1>, <&iomuxc 29 130 1>,
>                       <&iomuxc 30 129 1>, <&iomuxc 31 122 1>;
> };
> 
> I don't think it makes sense to specify maxItems.

Indeed, I will skip the max limit.

Best regards,
Krzysztof

