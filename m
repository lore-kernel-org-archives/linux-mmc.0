Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC0D2DF6EA;
	Mon, 29 Jun 2026 07:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782716781; cv=none; b=cBsvt0aeybKBCcjUSUo8nc8KbeRim9KRwU42ox6l/OHF9/whI1riYEA3QIb/VsD2OZuP/HPTavBOiRatIkv4FdXvPuOsBLK/AQdMJpEI6wPc2QOgP3o1jaT9LbKQnECInp+nq1tiun+19EjYluWsMPUH+4wt/eMuzEQ7/18WhRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782716781; c=relaxed/simple;
	bh=/ffu7S91LDVYFDk94ULXepy5DfMjq4D77F8qd/ZSdG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LaEacseZi+5kbgvgwirqYMvbGuIbje9UMX9IUtLiJkNPj9ih9RSN/uIaV0jGot8TVUNYRwTnHWLH+MjV1jpTI12Visf3LnFFFTp+zztAw2N7BGG+DAjrlRPbl0PSLfljaeO2alW5n+RF/of35fo2opCimSHNYllpbUbhvFqkLR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BD321F000E9;
	Mon, 29 Jun 2026 07:06:18 +0000 (UTC)
Date: Mon, 29 Jun 2026 09:06:13 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Cc: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, 
	Dinh Nguyen <dinguyen@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/9] arm64: dts: agilex5: add Cadence SD6HC controller
 and SOCDK enablement
Message-ID: <20260629-tireless-hippo-of-innovation-eb5e27@quoll>
References: <20260627201457.12318-1-tanmay.kathpalia@altera.com>
 <20260627201457.12318-4-tanmay.kathpalia@altera.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260627201457.12318-4-tanmay.kathpalia@altera.com>

On Sat, Jun 27, 2026 at 01:14:48PM -0700, Tanmay Kathpalia wrote:
> Add the Cadence SD6HC controller node to the Agilex5 SoC DTSI as a
> shared SD/eMMC node, disabled by default. The controller integrates
> with the system SMMU for IOMMU support and uses SDMCLK as the primary
> clock source for PHY timing.
> 
> On the SOCDK board, add a fixed 3.3V regulator for card power and a
> GPIO-controlled regulator for I/O voltage switching between 1.8V and
> 3.3V. Enable the controller for SD-only operation in 4-bit bus width
> with high-speed and SDR104 UHS-I modes at 200 MHz.
> 
> Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
> ---
>  .../arm64/boot/dts/intel/socfpga_agilex5.dtsi | 25 +++++++++++++++
>  .../boot/dts/intel/socfpga_agilex5_socdk.dts  | 31 +++++++++++++++++++
>  2 files changed, 56 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
> index 02e62d954e94..f552aa0c1faa 100644
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
> +		emmc: mmc@10808000 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;

Please follow DTS coding style for new code.

> +			compatible = "altr,agilex5-sd6hc", "cdns,sd6hc";
> +			reg = <0x10808000 0x1000>;
> +			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
> +			resets = <&rst SDMMC_RESET>, <&rst COMBOPHY_RESET>, <&rst SDMMC_OCP_RESET>;
> +			reset-names = "sdhc-reset", "combophy", "sdmmc-ocp";
> +			/*
> +			 * "ciu" (SDMCLK) is listed first so it is selected as the
> +			 * primary clock by the SDHCI platform layer; the SD6HC PHY
> +			 * timing calculations are derived from this clock rate.
> +			 */
> +			clocks = <&clkmgr AGILEX5_SDMCLK>, <&clkmgr AGILEX5_L4_MP_CLK>;
> +			clock-names = "ciu", "biu";
> +			iommus = <&smmu 5>;
> +			dma-coherent;
> +			status = "disabled";
> +		};
> +
>  		nand: nand-controller@10b80000 {
>  			compatible = "cdns,hp-nfc";
>  			reg = <0x10b80000 0x10000>,
> diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dts b/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dts
> index 262bb3e8e5c7..c56f46721bb0 100644
> --- a/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dts
> +++ b/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dts
> @@ -34,6 +34,24 @@ memory@80000000 {
>  		/* We expect the bootloader to fill in the reg */
>  		reg = <0x0 0x80000000 0x0 0x0>;
>  	};
> +
> +	vmmc_reg: regulator-fixed-3p3v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc-sd";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-always-on;
> +	};
> +
> +	vqmmc_io_reg: regulator-1p8v {
> +		compatible = "regulator-gpio";
> +		regulator-name = "vqmmc-io";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <3300000>;
> +		states =	<1800000 0x1>,

There is only one space after '='.

> +				<3300000 0x0>;
> +		gpios = <&portb 3 GPIO_ACTIVE_HIGH>;
> +	};
>  };

Best regards,
Krzysztof

