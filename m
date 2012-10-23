From: Marc Dietrich <marvin24-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: [PATCH 1/2] ARM: dt: tegra: Add sdhci regulators
Date: Tue, 23 Oct 2012 20:07:59 +0200
Message-ID: <4346406.Jy2o1pWcOR@ax5200p>
References: <1350976740-19284-1-git-send-email-pkunapuli@nvidia.com> <1350976740-19284-2-git-send-email-pkunapuli@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1350976740-19284-2-git-send-email-pkunapuli-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pavan Kunapuli <pkunapuli-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Pavan,

On Tuesday 23 October 2012 12:48:59 Pavan Kunapuli wrote:
> Adding vmmc and vmmcq supplies for sdhci nodes
> in tegra dt files.

<...>

> diff --git a/arch/arm/boot/dts/tegra20-paz00.dts
> b/arch/arm/boot/dts/tegra20-paz00.dts index 6a93d14..e161b65 100644
> --- a/arch/arm/boot/dts/tegra20-paz00.dts
> +++ b/arch/arm/boot/dts/tegra20-paz00.dts
> @@ -422,13 +422,17 @@
>  		status = "okay";
>  		cd-gpios = <&gpio 173 0>; /* gpio PV5 */
>  		wp-gpios = <&gpio 57 0>;  /* gpio PH1 */
> -		power-gpios = <&gpio 169 0>; /* gpio PV1 */
>  		bus-width = <4>;
> +		vmmc-supply = <&vddio_sd_reg>;
> +		vqmmc-supply = <&vddio_sd_reg>;
>  	};
> 
>  	sdhci@c8000600 {
>  		status = "okay";
>  		bus-width = <8>;
> +		vmmc-supply = <&vddio_sdmmc_reg>;
> +		vqmmc-supply = <&vddio_sdmmc_reg>;

to make it better, this should be:

vmmc-supply = <&vcore_mmc_reg>; and
vqmmc-supply = <&vddio_nand_reg>;

with vcore_mmc_reg is ldo5 and vddio_nand_reg is the fixed regulator below.

By doing so, I get "sdhci-tegra sdhci-tegra.3: could not set regulator OCR 
(-1)". MMC subsys wants to set ldo5 to 3.3V but it is fixed. I guess that's 
harmless for now. 

>  	};
> 
>  	gpio-keys {
> @@ -465,6 +469,24 @@
>  			regulator-max-microvolt = <5000000>;
>  			regulator-always-on;
>  		};
> +
> +		vddio_sd_reg: regulator@1 {
> +			compatible = "regulator-fixed";
> +			reg = <1>;
> +			regulator-name = "vddio_sd";
> +			regulator-min-microvolt = <3300000>;
> +			regulator-max-microvolt = <3300000>;
> +			enable-active-high;
> +			gpio = <&gpio 169 0>; /* gpio PV1 */
> +		};
> +
> +		vddio_sdmmc_reg: regulator@2 {

       ^^ vddio_nand_reg acording to schematics

> +			compatible = "regulator-fixed";
> +			reg = <2>;
> +			regulator-name  = "vddio_sdmmc";

also here

> +			regulator-min-microvolt = <3300000>;
> +			regulator-max-microvolt = <3300000>;
> +		};
>  	};
> 
>  	sound {
