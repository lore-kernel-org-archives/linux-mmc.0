Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F80343D85;
	Wed, 19 Aug 2026 13:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787144690; cv=none; b=KIHnO8gin44a9q3nKcUsdEwQPpvX/Bt809gelu6oSrVhZBQ2V1iomnYpT5z+o30JWBLDn7aoxUqpiKykjyYA2ouMCdUPjZWzJCfpc+sHaMkQSkKgj67lvBD60YGnqeoS7ikxF+nnhUH9mwTqCgmIauVVf/ysxRU/pip2eseVoSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787144690; c=relaxed/simple;
	bh=lWPFLCsiGfgh32Br2UZsmfKAynRtu+OGCDotR8NnhiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KKUVYeoZ1fpZdgPBaKcz9qofazTWvTNgfLtxNaen5FInAPyYwVuyouLqvDQ89G9KktmtzdNrWIeO9I6xK2VjcxxXQlSEH49ckqUMjF1MPbMuwR+47/6PDWNwj3WImPnfoRPqnL5LnBpFKUbXCMPYml03v4CDN/HjXwgZsKo6WN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YkJ6LAtK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YkJ6LAtK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA1E71F000E9;
	Wed, 19 Aug 2026 13:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787144688;
	bh=iSCa7gQrC6rqaxYPXg4BLQYbbR9IpydqIzyurplY6Rk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=YkJ6LAtKi3Kmvf+o2DB975QczZQyEMgT8XyajfZ+89PP1sLqZTColTatOGorAhsPF
	 GFPj9Cm5/1Ih5rpsRgtYXN8u2PVzb8vDArf+tZ1V0Pc4u5CmBZloEPA43KtTgP5ZQM
	 nvNdSHT1mO51ShNu4BDcrVHHqykoWo14V0SuXaAupG9pYlI1p5NuGO28KxP5vPIFa3
	 71FiDuAvkzQx1MEdI2xAaf57Hw/KdrK2Fp+tojDio/VEO+BURMo1HOwWhX3Wkt66Uc
	 MZCuOFOhxQYUEm4OkDS6HUw4Xf92fsdE+xH3n82Kuzm9hYrn1EJmntNtKdr2HHOgRE
	 7ltxmE+Ti1YJw==
Message-ID: <fcc5c96a-5b68-4eb3-bee2-952aa9029631@kernel.org>
Date: Wed, 19 Aug 2026 08:04:45 -0500
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/8] arm64: dts: agilex5: add SD/eMMC host controller
Content-Language: en-US
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>, linux-mmc@vger.kernel.org
Cc: ulfh@kernel.org, adrian.hunter@intel.com, krzk+dt@kernel.org,
 robh@kernel.org, conor+dt@kernel.org, p.zabel@pengutronix.de,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260810190025.25045-1-tanmay.kathpalia@altera.com>
 <20260810190025.25045-3-tanmay.kathpalia@altera.com>
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20260810190025.25045-3-tanmay.kathpalia@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/10/26 14:00, Tanmay Kathpalia wrote:
> The Agilex5 HPS includes a Cadence SD6HC that drives either an SD card
> or eMMC, depending on the SOCDK daughter card. It uses separate SDMCLK
> (CIU) and L4_MP (BIU) clocks, and has three resets for the host
> controller, Combo PHY, and SDMMC OCP bridge. DMA for this controller
> requires the SMMU (stream ID 5), so the SOCDK board enables it.
> 
> On the SOCDK OOBE card the slot is SD-only: fixed 3.3 V card supply and
> a GPIO-selected 3.3 V / 1.8 V I/O supply for UHS-I signalling up to
> SDR104.
> 
> Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
> ---
> Depends on commit ab45ecfab540 ("dt-bindings: reset: altr: add
> COMBOPHY_RESET for Agilex5"), which is already in mainline via the
> reset tree. It is not yet in mmc/next; apply or merge that commit when
> building/testing this patch on top of mmc/next.
> 
>   .../arm64/boot/dts/intel/socfpga_agilex5.dtsi | 25 ++++++++++++
>   .../boot/dts/intel/socfpga_agilex5_socdk.dts  | 38 ++++++++++++++++++-
>   2 files changed, 62 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
> index b06c6d5d60ee..5ccbd7bf2034 100644
> --- a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
> +++ b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
> @@ -300,6 +300,31 @@ portb: gpio-controller@0 {
>   			};
>   		};
>   
> +		/*
> +		 * Shared SD/eMMC controller node. On the SOCDK OOBE daughter-card
> +		 * this is used for SD card operation; on the SOCDK eMMC daughter-card
> +		 * it is configured for eMMC.
> +		 */
> +		emmc: mmc@10808000 {
> +			compatible = "altr,agilex5-sd6hc", "cdns,sd6hc";
> +			reg = <0x10808000 0x1000>;
> +			/*
> +			 * "ciu" (SDMCLK) is listed first so it is selected as the
> +			 * primary clock by the SDHCI platform layer; the SD6HC PHY
> +			 * timing calculations are derived from this clock rate.
> +			 */
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
>   		nand: nand-controller@10b80000 {
>   			compatible = "cdns,hp-nfc";
>   			reg = <0x10b80000 0x10000>,
> diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dts b/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dts
> index 57d3c5807c65..f37038066922 100644
> --- a/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dts
> +++ b/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dts
> @@ -36,9 +36,37 @@ memory@80000000 {
>   		/* We expect the bootloader to fill in the reg */
>   		reg = <0x0 0x80000000 0x0 0x0>;
>   	};
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
>   };
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
>   	status = "okay";
>   };
>   
> @@ -59,6 +87,10 @@ emac2_phy0: ethernet-phy@0 {
>   	};
>   };
>   
> +&gpio0 {
> +	status = "okay";
> +};
> +
>   &gpio1 {
>   	status = "okay";
>   };
> @@ -100,6 +132,10 @@ root: partition@4200000 {
>   	};
>   };
>   
> +&smmu {
> +	status = "okay";
> +};
> +

you should no longer need this because of

10cf797f3f8a ("arm64: dts: socfpga: agilex5: Enable the SMMU")

Thanks,
Dinh

