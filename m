From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v5 3/7] regulator: add pbias regulator support
Date: Tue, 10 Dec 2013 10:33:30 -0800
Message-ID: <20131210183330.GK13171@atomide.com>
References: <20131210104005.GB29268@sirena.org.uk>
 <1386686098-7779-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1386686098-7779-1-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: linux-omap@vger.kernel.org, bcousson@baylibre.com, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, broonie@kernel.org
List-Id: linux-mmc@vger.kernel.org

* Balaji T K <balajitk@ti.com> [131210 06:36]:
> pbias register controls internal power supply to sd card i/o pads
> in most OMAPs (OMAP2-5, DRA7).
> Control bits for selecting voltage level and
> enabling/disabling are in the same PBIAS register.

Good to see this, few comments below.

> +++ lo/Documentation/devicetree/bindings/regulator/pbias-regulator.txt	2013-12-10 16:58:28.907927745 +0530
> @@ -0,0 +1,21 @@
> +PBIAS internal regulator for SD card i/o pads on OMAP SoCs.
> +
> +Required properties:
> +- compatible:
> +  - "regulator-pbias-omap2" for OMAP2
> +  - "regulator-pbias-omap3" for OMAP3
> +  - "regulator-pbias-omap4" for OMAP4
> +  - "regulator-pbias-omap5" for OMAP5, DRA7
> +- pbias-reg-offset: PBIAS control register offset from syscon base address
> +
> +Optional properties:
> +- Any optional property defined in bindings/regulator/regulator.txt
> +
> +Example:
> +
> +		pbias_regulator: pbias_regulator {
> +			pbias-reg-offset = <0>;
> +			regulator-name = "pbias_regulator";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <3000000>;
> +	};

This does not seem to support the other PBIAS controls the same
register has?

> @@ -369,6 +369,15 @@ config REGULATOR_PALMAS
>  	  on the muxing. This is handled automatically in the driver by
>  	  reading the mux info from OTP.
>  
> +config REGULATOR_PBIAS
> +	tristate "PBIAS OMAP regulator driver"
> +	depends on (ARCH_OMAP || COMPILE_TEST) && MFD_SYSCON
> +	help
> +	 Say y here to support pbias regulator for mmc1:SD card i/o
> +	 on OMAP SoCs.
> +	 This driver provides support for OMAP pbias modelled
> +	 regulators.
> +

The PBIAS register is not just for MMC. Depending on the SoC revision,
you may also have 2 - 3 PBIAS devices in the same register. Please check
the 2430 TRM, it has also I2C secondary pulls in this same register. And
on 3430, there PBIAS register has also SIM voltage bits.

Certainly nothing stops from intially implementing the MMC pieces
as those are needed badly, but it should be done in a way where adding
support for the other PBIAS bits can be done easily.

You're also missing the PBIAS interrupts, so it might be worth checking
the code from that point of view also to make sure adding the support
for interrupts won't require massive changes to the driver.

Regards,

Tony
