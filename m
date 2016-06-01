From: Peter Chen <hzpeterchen@gmail.com>
Subject: Re: [PATCH v3 12/12] ARM: dts: exynos: Fix LAN and HUB after
 bootloader initialization on Odroid U3
Date: Wed, 1 Jun 2016 19:59:30 +0800
Message-ID: <20160601115929.GA16740@shlinux2>
References: <1464768141-25420-1-git-send-email-k.kozlowski@samsung.com>
 <1464768141-25420-13-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1464768141-25420-13-git-send-email-k.kozlowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Javier Martinez Canillas <javier@osg.samsung.com>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-pm@vger.kernel.or, Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-mmc@vger.kernel.org

On Wed, Jun 01, 2016 at 10:02:21AM +0200, Krzysztof Kozlowski wrote:
> On Odroid U3 (Exynos4412-based) board if USB was initialized by
> bootloader (in U-Boot "usb start" before tftpboot), the HUB (usb3503)
> and LAN (smsc95xx) after after successful probing were not visible in the
> system ("lsusb").
> 
> In such case the devices had to be fully reset before configuring.
> Reset by GPIO (called RESET_N pin) and by RESET field in STCD register
> in usb3503 HUB are not sufficient. Instead full reset has to be done by
> disabling and enabling regulator.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  arch/arm/boot/dts/exynos4412-odroidu3.dts | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos4412-odroidu3.dts b/arch/arm/boot/dts/exynos4412-odroidu3.dts
> index 31cdc036fda4..23e30e4609df 100644
> --- a/arch/arm/boot/dts/exynos4412-odroidu3.dts
> +++ b/arch/arm/boot/dts/exynos4412-odroidu3.dts
> @@ -99,11 +99,15 @@
>  	clock-names = "refclk";
>  	clocks = <&pmu_system_controller 0>;
>  	refclk-frequency = <24000000>;
> +
> +	power-sequence;
> +	ext-supply = <&buck8_reg>;
>  };
>  
>  &ehci {
>  	port@1 {
>  		status = "okay";
> +		usb-pwrseq = <&usb3503>;
>  	};
>  	port@2 {
>  		status = "okay";
> -- 
> 1.9.1
> 

The hub is under the port1, you may need to describe it
under the port@1, see below:
Documentation/devicetree/bindings/usb/usb-device.txt

If I get Rob's comments correctly, you may need to consider 
below MMC and USB device tree description together, it seems
hard for USB to use pwrseq driver, sorry for confusing you.

If rob can accept below USB device description, we have to
do it under USB. In future, if there is some suitable framework,
we can move it.

1. MMC device:
	usdhc3_pwrseq: usdhc3_pwrseq {
		compatible = "mmc-pwrseq-simple";
		reset-gpios = <&gpio4 5 GPIO_ACTIVE_LOW>, 	/* WL_REG_ON */
			      <&gpio4 7 GPIO_ACTIVE_LOW>, 	/* WL_HOSTWAKE */
			      <&gpio3 25 GPIO_ACTIVE_LOW>, 	/* BT_REG_ON */
			      <&gpio3 27 GPIO_ACTIVE_LOW>,	/* BT_HOSTWAKE */
			      <&gpio4 4 GPIO_ACTIVE_LOW>, 	/* BT_WAKE */
			      <&gpio4 6 GPIO_ACTIVE_LOW>; 	/* BT_RST_N */
	};

&usdhc3 {
	pinctrl-names = "default", "state_100mhz", "state_200mhz";
	pinctrl-0 = <&pinctrl_usdhc3>;
	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
	bus-width = <4>;
	non-removable;
	keep-power-in-suspend;
	wakeup-source;
	mmc-pwrseq = <&usdhc3_pwrseq>;
	status = "okay";
};

2. USB device 

&usbotg1 {
	vbus-supply = <&reg_usb_otg1_vbus>;
	pinctrl-names = "default";
	pinctrl-0 = <&pinctrl_usb_otg1_id>;
	status = "okay";

	#address-cells = <1>;
	#size-cells = <0>;
	hub: genesys@1 {
		compatible = "usb5e3,608";
		reg = <1>;
		reset-gpios = <&gpio4 5 GPIO_ACTIVE_LOW>; /* hub reset pin */
		reset-duration-us = <10>;
		clocks = <&clks IMX6SX_CLK_CKO>;
	};
};

};
-- 

Best Regards,
Peter Chen
