From: Sergio Prado <sergio.prado@e-labworks.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: mmc: add DT binding for S3C24XX
 MMC/SD/SDIO controller
Date: Tue, 24 Jan 2017 16:49:32 -0200
Message-ID: <20170124184932.GA20814@sprado-desktop>
References: <1484319953-6479-1-git-send-email-sergio.prado@e-labworks.com>
 <1484319953-6479-2-git-send-email-sergio.prado@e-labworks.com>
 <20170118223816.nccyc7aoa7succsi@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vk0-f68.google.com ([209.85.213.68]:36105 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750806AbdAXStk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Jan 2017 13:49:40 -0500
Received: by mail-vk0-f68.google.com with SMTP id n19so14519137vkd.3
        for <linux-mmc@vger.kernel.org>; Tue, 24 Jan 2017 10:49:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20170118223816.nccyc7aoa7succsi@rob-hp-laptop>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: ulf.hansson@linaro.org, mark.rutland@arm.com, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, ben-linux@fluff.org, linux-arm-kernel@lists.infradead.org

On Wed, Jan 18, 2017 at 04:38:16PM -0600, Rob Herring wrote:
> On Fri, Jan 13, 2017 at 01:05:52PM -0200, Sergio Prado wrote:
> > +This file documents differences between the core mmc properties described by
> > +mmc.txt and the properties used by the Samsung S3C24XX MMC/SD/SDIO controller
> > +implementation.
> > +
> > +Required SoC Specific Properties:
> > +- compatible: should be one of the following
> > +  - "samsung,s3c2410-sdi": for controllers compatible with s3c2410
> > +  - "samsung,s3c2412-sdi": for controllers compatible with s3c2412
> > +  - "samsung,s3c2440-sdi": for controllers compatible with s3c2440
> > +- clocks: Should reference the controller clock
> > +- clock-names: Should contain "sdi"
> 
> You are missing things from the example.

Properties "compatible", "clocks" and "clock-names" are documented.

Properties "bus-width", "cd-gpios" and "wp-gpios" are documented in
mmc.txt as I described before the example. Should I describe them again?

Do I need to document common properties like "pinctrl-names",
"pinctrl-0", "reg" and "interrupts"?

> 
> > +
> > +Example:
> > +	mmc0: mmc@5a000000 {
> > +		compatible = "samsung,s3c2440-sdi";
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&sdi_pins>;
> > +		reg = <0x5a000000 0x100000>;
> > +		interrupts = <0 0 21 3>;
> > +		clocks = <&clocks PCLK_SDI>;
> > +		clock-names = "sdi";
> > +		bus-width = <4>;
> > +		cd-gpios = <&gpg 8 GPIO_ACTIVE_LOW>;
> > +		wp-gpios = <&gph 8 GPIO_ACTIVE_LOW>;
> > +	};
> > +
> > +	Note: This example shows both SoC specific and board specific properties
> > +	in a single device node. The properties can be actually be separated
> > +	into SoC specific node and board specific node.
> 
> The source structure is not relavent to the binding.

OK.

> 
> Rob

-- 
Sergio Prado
Embedded Labworks
Office: +55 11 2628-3461
Mobile: +55 11 97123-3420
