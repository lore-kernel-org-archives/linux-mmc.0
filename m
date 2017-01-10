From: =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara@arm.com>
Subject: Re: [PATCH v2 5/6] arm64: allwinner: a64: Add MMC pinctrl nodes
Date: Tue, 10 Jan 2017 00:54:57 +0000
Message-ID: <0427ccd8-0aa5-2d98-938d-784321a3ec48@arm.com>
References: <cover.493dc67855a5f1837e875d37307319a03d14d1d0.1483980339.git-series.maxime.ripard@free-electrons.com>
 <f7a004f7905badbd8e6fea7fd8591a498b396b9d.1483980339.git-series.maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:39806 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032762AbdAJAzJ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 9 Jan 2017 19:55:09 -0500
In-Reply-To: <f7a004f7905badbd8e6fea7fd8591a498b396b9d.1483980339.git-series.maxime.ripard@free-electrons.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org

On 09/01/17 16:46, Maxime Ripard wrote:
> The A64 only has a single set of pins for each MMC controller. Since we
> already have boards that require all of them, let's add them to the DTSI.

This matches my reworked version from the previous series, so:

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre.

> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 25 ++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> index 143e9706438f..8e149498e096 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -205,6 +205,31 @@
>  				function = "i2c1";
>  			};
>  
> +			mmc0_pins: mmc0-pins {
> +				pins = "PF0", "PF1", "PF2", "PF3",
> +				       "PF4", "PF5";
> +				function = "mmc0";
> +				drive-strength = <30>;
> +				bias-pull-up;
> +			};
> +
> +			mmc1_pins: mmc1-pins {
> +				pins = "PG0", "PG1", "PG2", "PG3",
> +				       "PG4", "PG5";
> +				function = "mmc1";
> +				drive-strength = <30>;
> +				bias-pull-up;
> +			};
> +
> +			mmc2_pins: mmc2-pins {
> +				pins = "PC1", "PC5", "PC6", "PC8", "PC9",
> +				       "PC10","PC11", "PC12", "PC13",
> +				       "PC14", "PC15", "PC16";
> +				function = "mmc2";
> +				drive-strength = <30>;
> +				bias-pull-up;
> +			};
> +
>  			uart0_pins_a: uart0@0 {
>  				pins = "PB8", "PB9";
>  				function = "uart0";
> 

