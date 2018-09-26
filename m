From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCHv4 4/6] ARM: dts: exynos: Add CD and WP pins to Odroid
 XU3/XU4 SD card
Date: Wed, 26 Sep 2018 21:06:39 +0200
Message-ID: <20180926190639.GA6461@kozik-lap>
References: <20180922075238.884-1-linux.amoon@gmail.com>
 <20180922075238.884-6-linux.amoon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180922075238.884-6-linux.amoon@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anand Moon <linux.amoon@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Kukjin Kim <kgene@kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Sat, Sep 22, 2018 at 07:52:36AM +0000, Anand Moon wrote:
> Add the card-detect and write-protect GPIO pins for OdroidXU3/XU4
> SD card by adding pinctrl setting for wp-gpio pin and set it to
> active low.
> 
> This also removes debug messages:
>     dwmmc_exynos 12220000.mmc: No GPIO consumer cd found
>     dwmmc_exynos 12220000.mmc: No GPIO consumer wp found
> 
> Suggested-by: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> Fix the commit message and squash it with cd-gpios and wp-gpio
> patches into single patch as suggested by Krzysztof.

As Marek pointed to my Odroid XU patch, there is no point of adding
cd-gpios and wp-gpios properties.

Adding pin configuration for wp pin is also not needed. Reset values are
working properly. However there might be meaning of adding it just in
case - if bootloader decided to touch it...

Best regards,
Krzysztof


> ---
>  arch/arm/boot/dts/exynos5420-pinctrl.dtsi     | 8 ++++++++
>  arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 4 +++-
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/exynos5420-pinctrl.dtsi b/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
> index dda8ca2d2324..9a39a0d8ec86 100644
> --- a/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
> +++ b/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
> @@ -289,6 +289,14 @@
>  		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
>  		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV4>;
>  	};
> +
> +	sd2_wp: sd2-wp {
> +		samsung,pins = "gpc4-0";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		/* Pin is floating so pull it up to disable write-protect */
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV4>;
> +	};
>  };
>  
>  &pinctrl_2 {
> diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> index a80b6c045154..2aacfb669140 100644
> --- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> +++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> @@ -498,10 +498,12 @@
>  	samsung,dw-mshc-sdr-timing = <0 4>;
>  	samsung,dw-mshc-ddr-timing = <0 2>;
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus1 &sd2_bus4>;
> +	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_wp &sd2_bus1 &sd2_bus4>;
>  	bus-width = <4>;
>  	cap-sd-highspeed;
>  	max-frequency = <200000000>;
> +	cd-gpios = <&gpc2 2 GPIO_ACTIVE_LOW>;
> +	wp-gpios = <&gpc4 0 GPIO_ACTIVE_LOW>;
>  	vmmc-supply = <&ldo19_reg>;
>  	vqmmc-supply = <&ldo13_reg>;
>  	sd-uhs-sdr50;
> -- 
> 2.17.1
> 
