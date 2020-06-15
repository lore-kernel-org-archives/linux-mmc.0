Return-Path: <SRS0=6MuA=74=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD7CC433E0
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Jun 2020 16:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E9112080D
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Jun 2020 16:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592238293;
	bh=NvZ4xROZpS01Xr+qnNQUx1FmKHE5zI1O4pPdowqV0+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VrxRoBNGX1rAGmhWTqg+PmmKTGnEgDdssNtLYTEne0NmWQscl7FZpg+kOpArqB+Qf
	 NNZdD8jOmf/+2hTeJ3/y83nFQqFahTM4FuiJSVB1sUtAce26kaUjfskrw/sIeiIWpv
	 SJQ4IGlYz9JlHwl9u24Tie7AtnnuBIn9LmCkJkkE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730853AbgFOQYs (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 15 Jun 2020 12:24:48 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43328 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730837AbgFOQYs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Jun 2020 12:24:48 -0400
Received: by mail-io1-f67.google.com with SMTP id u13so949543iol.10;
        Mon, 15 Jun 2020 09:24:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YdqlCPeMy6mhxxUsYFBiIEErVyP/IfOhgQot6haL/bk=;
        b=I5e2QY3eZQrqlGn4yblkXnJhtih4rj+nydKLgcMIQvoGLgVSQVLnXotzdc2Wr7evNl
         uoSm/mu6TDDorwxO6x1iSt64gnQrV+WZKhN6YeElA8VcAdDCwFUxbMtmta+J7Sf+8jI8
         Rz5+MqAh1Hc8fXpnqzE/fnK21YRhpZYxEjsLjJYa4IyFw0b6R+DAATT4F5YdYpUeTWfU
         ExOk7pMg+/AGXrNGiF5wQCITGF7neycb41uBfF+Qhr76dMfw2fcBhiisdvVYJUY5j9Ab
         Gy/VSF2b0rhKlgvRfVtTHoY8k8GnlFGC0hULG1VoCLexTWAa1i9ixUS/kTGIu81cS1bf
         6rjQ==
X-Gm-Message-State: AOAM530054BYeytVx8yAWG361wHbEDKDFD6nn4iIOjDbnddBS3Ve9dtx
        R92rr7oPr4D1xWuYP6gFfQ==
X-Google-Smtp-Source: ABdhPJw9jyd07OqpB3eUqIEGtPzpWwPUI8yPAdfXF+9S621Y7f0IepBuQ20G4JgHvwQeMt9CPRwfrA==
X-Received: by 2002:a5e:dc03:: with SMTP id b3mr29058506iok.27.1592238286532;
        Mon, 15 Jun 2020 09:24:46 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id g64sm8166922iof.5.2020.06.15.09.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 09:24:46 -0700 (PDT)
Received: (nullmailer pid 1891953 invoked by uid 1000);
        Mon, 15 Jun 2020 16:24:45 -0000
Date:   Mon, 15 Jun 2020 10:24:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     ulf.hansson@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        mpa@pengutronix.de, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH V2 1/3] dt-bindings: mmc: Convert imx esdhc to json-schema
Message-ID: <20200615162445.GA1885779@bogus>
References: <1591234886-15351-1-git-send-email-Anson.Huang@nxp.com>
 <1591234886-15351-2-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591234886-15351-2-git-send-email-Anson.Huang@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Jun 04, 2020 at 09:41:24AM +0800, Anson Huang wrote:
> Convert the i.MX ESDHC binding to DT schema format using json-schema
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V1:
> 	- add "unevaluatedProperties: false".
> ---
>  .../devicetree/bindings/mmc/fsl-imx-esdhc.txt      |  67 -----------
>  .../devicetree/bindings/mmc/fsl-imx-esdhc.yaml     | 124 +++++++++++++++++++++
>  2 files changed, 124 insertions(+), 67 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
>  create mode 100644 Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> deleted file mode 100644
> index de1b8bd..0000000
> --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> +++ /dev/null
> @@ -1,67 +0,0 @@
> -* Freescale Enhanced Secure Digital Host Controller (eSDHC) for i.MX
> -
> -The Enhanced Secure Digital Host Controller on Freescale i.MX family
> -provides an interface for MMC, SD, and SDIO types of memory cards.
> -
> -This file documents differences between the core properties described
> -by mmc.txt and the properties used by the sdhci-esdhc-imx driver.
> -
> -Required properties:
> -- compatible : Should be "fsl,<chip>-esdhc", the supported chips include
> -	       "fsl,imx25-esdhc"
> -	       "fsl,imx35-esdhc"
> -	       "fsl,imx51-esdhc"
> -	       "fsl,imx53-esdhc"
> -	       "fsl,imx6q-usdhc"
> -	       "fsl,imx6sl-usdhc"
> -	       "fsl,imx6sx-usdhc"
> -	       "fsl,imx6ull-usdhc"
> -	       "fsl,imx7d-usdhc"
> -	       "fsl,imx7ulp-usdhc"
> -	       "fsl,imx8mq-usdhc"
> -	       "fsl,imx8mm-usdhc"
> -	       "fsl,imx8mn-usdhc"
> -	       "fsl,imx8mp-usdhc"
> -	       "fsl,imx8qm-usdhc"
> -	       "fsl,imx8qxp-usdhc"
> -
> -Optional properties:
> -- fsl,wp-controller : Indicate to use controller internal write protection
> -- fsl,delay-line : Specify the number of delay cells for override mode.
> -  This is used to set the clock delay for DLL(Delay Line) on override mode
> -  to select a proper data sampling window in case the clock quality is not good
> -  due to signal path is too long on the board. Please refer to eSDHC/uSDHC
> -  chapter, DLL (Delay Line) section in RM for details.
> -- voltage-ranges : Specify the voltage range in case there are software
> -  transparent level shifters on the outputs of the controller. Two cells are
> -  required, first cell specifies minimum slot voltage (mV), second cell
> -  specifies maximum slot voltage (mV). Several ranges could be specified.
> -- fsl,tuning-start-tap: Specify the start dealy cell point when send first CMD19
> -  in tuning procedure.
> -- fsl,tuning-step: Specify the increasing delay cell steps in tuning procedure.
> -  The uSDHC use one delay cell as default increasing step to do tuning process.
> -  This property allows user to change the tuning step to more than one delay
> -  cells which is useful for some special boards or cards when the default
> -  tuning step can't find the proper delay window within limited tuning retries.
> -- fsl,strobe-dll-delay-target: Specify the strobe dll control slave delay target.
> -  This delay target programming host controller loopback read clock, and this
> -  property allows user to change the delay target for the strobe input read clock.
> -  If not use this property, driver default set the delay target to value 7.
> -  Only eMMC HS400 mode need to take care of this property.
> -
> -Examples:
> -
> -esdhc@70004000 {
> -	compatible = "fsl,imx51-esdhc";
> -	reg = <0x70004000 0x4000>;
> -	interrupts = <1>;
> -	fsl,wp-controller;
> -};
> -
> -esdhc@70008000 {
> -	compatible = "fsl,imx51-esdhc";
> -	reg = <0x70008000 0x4000>;
> -	interrupts = <2>;
> -	cd-gpios = <&gpio1 6 0>; /* GPIO1_6 */
> -	wp-gpios = <&gpio1 5 0>; /* GPIO1_5 */
> -};
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> new file mode 100644
> index 0000000..74db24aa
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> @@ -0,0 +1,124 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/fsl-imx-esdhc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale Enhanced Secure Digital Host Controller (eSDHC) for i.MX
> +
> +maintainers:
> +  - Shawn Guo <shawn.guo@linaro.org>
> +
> +allOf:
> +  - $ref: "mmc-controller.yaml"
> +
> +description: |
> +  The Enhanced Secure Digital Host Controller on Freescale i.MX family
> +  provides an interface for MMC, SD, and SDIO types of memory cards.
> +
> +  This file documents differences between the core properties described
> +  by mmc.txt and the properties used by the sdhci-esdhc-imx driver.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - fsl,imx25-esdhc
> +      - fsl,imx35-esdhc
> +      - fsl,imx51-esdhc
> +      - fsl,imx53-esdhc
> +      - fsl,imx6q-usdhc
> +      - fsl,imx6sl-usdhc
> +      - fsl,imx6sx-usdhc
> +      - fsl,imx6ull-usdhc
> +      - fsl,imx7d-usdhc
> +      - fsl,imx7ulp-usdhc
> +      - fsl,imx8mq-usdhc
> +      - fsl,imx8mm-usdhc
> +      - fsl,imx8mn-usdhc
> +      - fsl,imx8mp-usdhc
> +      - fsl,imx8qm-usdhc
> +      - fsl,imx8qxp-usdhc
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  fsl,wp-controller:
> +    description: |
> +      boolean, if present, indicate to use controller internal write protection.
> +    type: boolean
> +
> +  fsl,delay-line:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Specify the number of delay cells for override mode.
> +      This is used to set the clock delay for DLL(Delay Line) on override mode
> +      to select a proper data sampling window in case the clock quality is not good
> +      due to signal path is too long on the board. Please refer to eSDHC/uSDHC
> +      chapter, DLL (Delay Line) section in RM for details.
> +    default: 0
> +
> +  voltage-ranges:
> +    $ref: '/schemas/types.yaml#/definitions/uint32-matrix'
> +    description: |
> +      Specify the voltage range in case there are software
> +      transparent level shifters on the outputs of the controller. Two cells are
> +      required, first cell specifies minimum slot voltage (mV), second cell
> +      specifies maximum slot voltage (mV). Several ranges could be specified.
> +    items:
> +      items:
> +        - description: value for minimum slot voltage
> +        - description: value for maximum slot voltage
> +    maxItems: 1

This contradicts 'Several ranges could be specified.'

> +
> +  fsl,tuning-start-tap:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Specify the start dealy cell point when send first CMD19 in tuning procedure.

typo: delay

> +    default: 0
> +
> +  fsl,tuning-step:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Specify the increasing delay cell steps in tuning procedure.
> +      The uSDHC use one delay cell as default increasing step to do tuning process.
> +      This property allows user to change the tuning step to more than one delay
> +      cells which is useful for some special boards or cards when the default
> +      tuning step can't find the proper delay window within limited tuning retries.
> +    default: 0
> +
> +  fsl,strobe-dll-delay-target:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Specify the strobe dll control slave delay target.
> +      This delay target programming host controller loopback read clock, and this
> +      property allows user to change the delay target for the strobe input read clock.
> +      If not use this property, driver default set the delay target to value 7.
> +      Only eMMC HS400 mode need to take care of this property.
> +    default: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    mmc@70004000 {
> +        compatible = "fsl,imx51-esdhc";
> +        reg = <0x70004000 0x4000>;
> +        interrupts = <1>;
> +        fsl,wp-controller;
> +    };
> +
> +    mmc@70008000 {
> +        compatible = "fsl,imx51-esdhc";
> +        reg = <0x70008000 0x4000>;
> +        interrupts = <2>;
> +        cd-gpios = <&gpio1 6 0>; /* GPIO1_6 */
> +        wp-gpios = <&gpio1 5 0>; /* GPIO1_5 */
> +    };
> -- 
> 2.7.4
> 
