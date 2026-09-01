Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B907B3264D9;
	Tue,  1 Sep 2026 08:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788252272; cv=none; b=cH3OpfOy5ysCQGKb74HlThrlziJvcMSiDeJq4PtUDQ3fMGYDw5XU1bESKlg0RJFJuJBFDa/NcoaVTGQYsQK7zhyE83P5vtZB9H/f8mULwCDGuqTMxTTeHznO5NwTYHYdMsYqdvDMfGcTlz23dgUFx0gWLar8uEa3QxzYUvem/DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788252272; c=relaxed/simple;
	bh=wAmMl1ueBEMxFGVvtEJ6rMk45ZH4RjeATS51DVQndWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U5Cve2d028pHNeWLOFaaeFvL8fZsWcfkQ40iCLoUAilNU3D4Ye54GmIGGvGGr2vD9BPtT139qDUiCE4ZdJc6TcryGf/aTXLYQXxtWGa0mm3b4zAwPVlPMcAPCS3bqFYCCT6b66LMQkZiJLlqF8tnjNqaTAqPL4Sj3sOhceGpKtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptx.office.stw.pengutronix.de (ptx.office.stw.pengutronix.de [IPv6:2a0a:edc0:0:900:1d::109])
	(Authenticated sender: relay-from-ptx.office.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id BC3FB201552;
	Tue, 01 Sep 2026 10:44:15 +0200 (CEST)
Received: by ptx.office.stw.pengutronix.de (Postfix, from userid 1056)
	id 9D1181BF8B0; Tue, 01 Sep 2026 10:44:15 +0200 (CEST)
Date: Tue, 1 Sep 2026 10:44:15 +0200
From: Michael Tretter <m.tretter@pengutronix.de>
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Cc: linux-mmc@vger.kernel.org, ulfh@kernel.org, adrian.hunter@intel.com,
	krzk+dt@kernel.org, robh@kernel.org, conor+dt@kernel.org,
	dinguyen@kernel.org, p.zabel@pengutronix.de,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/8] arm64: dts: agilex5: add SD/eMMC host controller
Message-ID: <apaQX_bHpEcP4Tp5@pengutronix.de>
References: <20260829184252.27644-1-tanmay.kathpalia@altera.com>
 <20260829184252.27644-3-tanmay.kathpalia@altera.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260829184252.27644-3-tanmay.kathpalia@altera.com>

On Sat, 29 Aug 2026 11:42:44 -0700, Tanmay Kathpalia wrote:
> The Agilex5 HPS includes a Cadence SD6HC that drives either an SD card
> or eMMC, depending on the SOCDK daughter card. It uses separate SDMCLK
> (CIU) and L4_MP (BIU) clocks, and has three resets for the host
> controller, Combo PHY, and SDMMC OCP bridge.
> 
> On the SOCDK OOBE card the slot is SD-only: fixed 3.3 V card supply and
> a GPIO-selected 3.3 V / 1.8 V I/O supply for UHS-I signalling up to
> SDR104.
> 
> Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
> ---
>  .../arm64/boot/dts/intel/socfpga_agilex5.dtsi | 25 ++++++++++++++
>  .../boot/dts/intel/socfpga_agilex5_socdk.dts  | 34 ++++++++++++++++++-
>  2 files changed, 58 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
> index b06c6d5d60ee..5ccbd7bf2034 100644
> --- a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
> +++ b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
> @@ -300,6 +300,31 @@ portb: gpio-controller@0 {
>  			};
>  		};
>  
> +		/*
> +		 * Shared SD/eMMC controller node. On the SOCDK OOBE daughter-card
> +		 * this is used for SD card operation; on the SOCDK eMMC daughter-card
> +		 * it is configured for eMMC.
> +		 */

The documentation about the daughter-card configuration belongs into the
device trees of the daughter-cards and not in the SoC device tree.

> +		emmc: mmc@10808000 {

The HPS register address map uses the name "sdmmc" for this group. Maybe
that's a better label than emmc, if the controller may be used for eMMC
or SD card.

> +			compatible = "altr,agilex5-sd6hc", "cdns,sd6hc";
> +			reg = <0x10808000 0x1000>;
> +			/*
> +			 * "ciu" (SDMCLK) is listed first so it is selected as the
> +			 * primary clock by the SDHCI platform layer; the SD6HC PHY
> +			 * timing calculations are derived from this clock rate.
> +			 */

This is surprising to me and I can't find where the first clock is
selected as primary clock by the SDHCI platform layer.

Could you point me to the code that relies on the order of clocks in the
device tree?

> +			clocks = <&clkmgr AGILEX5_SDMCLK>, <&clkmgr AGILEX5_L4_MP_CLK>;
> +			clock-names = "ciu", "biu";
> +			dma-coherent;
> +			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
> +			iommus = <&smmu 5>;
> +			resets = <&rst SDMMC_RESET>, <&rst COMBOPHY_RESET>,
> +				 <&rst SDMMC_OCP_RESET>;
> +			reset-names = "sdhc-reset", "combophy", "sdmmc-ocp";
> +
> +			status = "disabled";
> +		};
> +
>  		nand: nand-controller@10b80000 {
>  			compatible = "cdns,hp-nfc";
>  			reg = <0x10b80000 0x10000>,
> diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dts b/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dts
> index 57d3c5807c65..93222b199038 100644
> --- a/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dts
> +++ b/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dts
> @@ -36,9 +36,37 @@ memory@80000000 {
>  		/* We expect the bootloader to fill in the reg */
>  		reg = <0x0 0x80000000 0x0 0x0>;
>  	};
> +
> +	vqmmc_io_reg: regulator-1p8v {
> +		compatible = "regulator-gpio";
> +		gpios = <&portb 3 GPIO_ACTIVE_HIGH>;
> +		gpios-states = <0>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-min-microvolt = <1800000>;
> +		regulator-name = "vqmmc-io";
> +		states = <1800000 0x1>,
> +			 <3300000 0x0>;
> +	};
> +
> +	vmmc_reg: regulator-fixed-3p3v {
> +		compatible = "regulator-fixed";
> +		regulator-always-on;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-name = "vcc-sd";
> +	};
>  };
>  
> -&gpio0 {
> +&emmc {
> +	bus-width = <4>;
> +	cap-sd-highspeed;
> +	disable-wp;
> +	max-frequency = <200000000>;
> +	no-mmc;
> +	sd-uhs-sdr104;
> +	vmmc-supply = <&vmmc_reg>;
> +	vqmmc-supply = <&vqmmc_io_reg>;
> +
>  	status = "okay";

I'd have split the addition of the controller to the SoC device tree and
the enabling for the board in two separate patches, but that's probably
just personal taste.

Michael

>  };
>  
> @@ -59,6 +87,10 @@ emac2_phy0: ethernet-phy@0 {
>  	};
>  };
>  
> +&gpio0 {
> +	status = "okay";
> +};
> +
>  &gpio1 {
>  	status = "okay";
>  };
> -- 
> 2.43.7
> 
