From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH v2] mmc: dt: Consolidate DT bindings
Date: Sun, 13 May 2012 21:29:15 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1205132121220.25323@axis700.grange>
References: <1328032576-9269-1-git-send-email-thomas.abraham@linaro.org>
 <201203271619.13320.arnd@arndb.de> <4F7553D1.4030008@st.com>
 <201203301136.05038.arnd@arndb.de> <4F75D5C0.5050307@wwwdotorg.org>
 <871umou38f.fsf_-_@laptop.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:57292 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752580Ab2EMT3Y (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 13 May 2012 15:29:24 -0400
In-Reply-To: <871umou38f.fsf_-_@laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Stephen Warren <swarren@wwwdotorg.org>, Viresh Kumar <viresh.kumar@st.com>, "patches@linaro.org" <patches@linaro.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Anton Vorontsov <anton.vorontsov@linaro.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "ben-linux@fluff.org" <ben-linux@fluff.org>, "kgene.kim@samsung.com" <kgene.kim@samsung.com>, Lee Jones <lee.jones@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Olof Johansson <olof@lixom.net>

Hi Chris

Good to see this happening! Is anyone also planning to submit a generic OF 
parser to convert OF properties into respective host capability flags? I 
didn't thoroughly review this patch, just a minor typo correction:

On Sun, 13 May 2012, Chris Ball wrote:

> Hi Arnd,
> 
> On Fri, Mar 30 2012, Stephen Warren wrote:
> >> No progress so far. I would suggest we apply the patch below to unify
> >> the bindings we have. I tried to minimize the impact by picking the most
> >> common version for each property, but if we know about devices that would
> >> get broken by this, we may have to be more careful.
> >> 
> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Here's a version of your MMC DT bindings patch that responds to Stephen
> Warren's review comments, refreshed against latest linux-next -- I'd
> like to get this merged for v3.5.  Since it touches many .dts files,
> should it go via arm-soc?  Thanks.
> 
> 
> From: Arnd Bergmann <arnd@arndb.de>
> Subject: [PATCH] mmc: dt: Consolidate DT bindings
> 
> This patch unifies the current DT MMC bindings documentation and code,
> adds generic MMC DT bindings documentation, and updates .dts files for
> consistency.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> [cjb: typo fixes, addition of max-frequency property]
> Signed-off-by: Chris Ball <cjb@laptop.org>
> ---
> Changes since Arnd's v1:
>  * Typo fix from Stephen Warren: s/interrupt/interrupts/
>  * Typo fix: s/non-removable/ti,non-removable/. This one's being
>    preserved for backwards compatibility.
>  * Add max-frequency property.
> 
> .../devicetree/bindings/mmc/fsl-esdhc.txt          |    6 +++--
>  .../devicetree/bindings/mmc/fsl-imx-esdhc.txt      |    2 +-
>  .../devicetree/bindings/mmc/mmc-spi-slot.txt       |    3 ++-
>  Documentation/devicetree/bindings/mmc/mmc.txt      |   27 ++++++++++++++++++++
>  .../devicetree/bindings/mmc/nvidia-sdhci.txt       |    4 +--
>  .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |    4 +--
>  arch/arm/boot/dts/imx53-smd.dts                    |    4 +--
>  arch/arm/boot/dts/imx6q-arm2.dts                   |    2 +-
>  arch/arm/boot/dts/omap3-beagle.dts                 |    2 +-
>  arch/arm/boot/dts/omap4-panda.dts                  |    4 +--
>  arch/arm/boot/dts/omap4-sdp.dts                    |    6 ++---
>  arch/arm/boot/dts/tegra-cardhu.dts                 |    2 ++
>  arch/arm/boot/dts/tegra-harmony.dts                |    2 ++
>  arch/arm/boot/dts/tegra-paz00.dts                  |    2 ++
>  arch/arm/boot/dts/tegra-seaboard.dts               |    2 ++
>  arch/arm/boot/dts/tegra-ventana.dts                |    2 ++
>  arch/powerpc/boot/dts/mpc8569mds.dts               |    1 +
>  drivers/mmc/host/omap_hsmmc.c                      |    2 +-
>  drivers/mmc/host/sdhci-esdhc-imx.c                 |    2 +-
>  drivers/mmc/host/sdhci-pltfm.c                     |    8 ++++--
>  20 files changed, 66 insertions(+), 21 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/mmc.txt
> 
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt b/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
> index 64bcb8b..0d93b4b 100644
> --- a/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
> +++ b/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
> @@ -11,9 +11,11 @@ Required properties:
>    - interrupt-parent : interrupt source phandle.
>    - clock-frequency : specifies eSDHC base clock frequency.
>    - sdhci,wp-inverted : (optional) specifies that eSDHC controller
> -    reports inverted write-protect state;
> +    reports inverted write-protect state; New devices should use
> +    the generic "wp-inverted" property.
>    - sdhci,1-bit-only : (optional) specifies that a controller can
> -    only handle 1-bit data transfers.
> +    only handle 1-bit data transfers. New devices should use the
> +    generic "bus-width = <1>" property.
>    - sdhci,auto-cmd12: (optional) specifies that a controller can
>      only handle auto CMD12.
>  
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> index ab22fe6..c7e404b 100644
> --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> @@ -9,7 +9,7 @@ Required properties:
>  - interrupts : Should contain eSDHC interrupt
>  
>  Optional properties:
> -- fsl,card-wired : Indicate the card is wired to host permanently
> +- non-removable : Indicate the card is wired to host permanently
>  - fsl,cd-internal : Indicate to use controller internal card detection
>  - fsl,wp-internal : Indicate to use controller internal write protection
>  - cd-gpios : Specify GPIOs for card detection
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-spi-slot.txt b/Documentation/devicetree/bindings/mmc/mmc-spi-slot.txt
> index 89a0084..d64aea5 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc-spi-slot.txt
> +++ b/Documentation/devicetree/bindings/mmc/mmc-spi-slot.txt
> @@ -10,7 +10,8 @@ Required properties:
>  
>  Optional properties:
>  - gpios : may specify GPIOs in this order: Card-Detect GPIO,
> -  Write-Protect GPIO.
> +  Write-Protect GPIO. Note that this does not follow the
> +  binding from mmc.txt, for historic reasons.
>  - interrupts : the interrupt of a card detect interrupt.
>  - interrupt-parent : the phandle for the interrupt controller that
>    services interrupts for this device.
> diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
> new file mode 100644
> index 0000000..6e70dcd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/mmc.txt
> @@ -0,0 +1,27 @@
> +These properties are common to multiple MMC host controllers. Any host
> +that requires the respective functionality should implement them using
> +these definitions.
> +
> +Required properties:
> +- bus-width: Number of data lines, can be <1>, <4>, or <8>
> +
> +Optional properties:
> +- cd-gpios : Specify GPIOs for card detection, see gpio binding
> +- wp-gpios : Specify GPIOs for write protection, see gpio binding
> +- cd-inverted: when present, polarity on the wp gpio line is inverted

You certainly meant "cd gpio line is inverted." But in fact, as Olof 
proposed in his reply to my patch - cannot we just use the existing 
OF_GPIO_ACTIVE_LOW flag to invert CD and WP polarity?

Thanks
Guennadi

> +- wp-inverted: when present, polarity on the wp gpio line is inverted
> +- non-removable: non-removable slot (like eMMC)
> +- max-frequency: maximum operating clock frequency
> +
> +Example:
> +
> +sdhci@ab000000 {
> +	compatible = "sdhci";
> +	reg = <0xab000000 0x200>;
> +	interrupts = <23>;
> +	bus-width = <4>;
> +	cd-gpios = <&gpio 69 0>;
> +	cd-inverted;
> +	wp-gpios = <&gpio 70 0>;
> +	max-frequency = <50000000>;
> +}
> diff --git a/Documentation/devicetree/bindings/mmc/nvidia-sdhci.txt b/Documentation/devicetree/bindings/mmc/nvidia-sdhci.txt
> index 7e51154..f77c303 100644
> --- a/Documentation/devicetree/bindings/mmc/nvidia-sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/nvidia-sdhci.txt
> @@ -7,12 +7,12 @@ Required properties:
>  - compatible : Should be "nvidia,<chip>-sdhci"
>  - reg : Should contain SD/MMC registers location and length
>  - interrupts : Should contain SD/MMC interrupt
> +- bus-width : Number of data lines, can be <1>, <4>, or <8>
>  
>  Optional properties:
>  - cd-gpios : Specify GPIOs for card detection
>  - wp-gpios : Specify GPIOs for write protection
>  - power-gpios : Specify GPIOs for power control
> -- support-8bit : Boolean, indicates if 8-bit mode should be used.
>  
>  Example:
>  
> @@ -23,5 +23,5 @@ sdhci@c8000200 {
>  	cd-gpios = <&gpio 69 0>; /* gpio PI5 */
>  	wp-gpios = <&gpio 57 0>; /* gpio PH1 */
>  	power-gpios = <&gpio 155 0>; /* gpio PT3 */
> -	support-8bit;
> +	bus-width = <8>;
>  };
> diff --git a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
> index dbd4368..8a53958 100644
> --- a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
> +++ b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
> @@ -15,7 +15,7 @@ Optional properties:
>  ti,dual-volt: boolean, supports dual voltage cards
>  <supply-name>-supply: phandle to the regulator device tree node
>  "supply-name" examples are "vmmc", "vmmc_aux" etc
> -ti,bus-width: Number of data lines, default assumed is 1 if the property is missing.
> +bus-width: Number of data lines, default assumed is 1 if the property is missing.
>  cd-gpios: GPIOs for card detection
>  wp-gpios: GPIOs for write protection
>  ti,non-removable: non-removable slot (like eMMC)
> @@ -27,7 +27,7 @@ Example:
>  		reg = <0x4809c000 0x400>;
>  		ti,hwmods = "mmc1";
>  		ti,dual-volt;
> -		ti,bus-width = <4>;
> +		bus-width = <4>;
>  		vmmc-supply = <&vmmc>; /* phandle to regulator node */
>  		ti,non-removable;
>  	};
> diff --git a/arch/arm/boot/dts/imx53-smd.dts b/arch/arm/boot/dts/imx53-smd.dts
> index c7ee86c..139138a 100644
> --- a/arch/arm/boot/dts/imx53-smd.dts
> +++ b/arch/arm/boot/dts/imx53-smd.dts
> @@ -35,7 +35,7 @@
>  				};
>  
>  				esdhc@50008000 { /* ESDHC2 */
> -					fsl,card-wired;
> +					non-removable;
>  					status = "okay";
>  				};
>  
> @@ -76,7 +76,7 @@
>  				};
>  
>  				esdhc@50020000 { /* ESDHC3 */
> -					fsl,card-wired;
> +					non-removable;
>  					status = "okay";
>  				};
>  			};
> diff --git a/arch/arm/boot/dts/imx6q-arm2.dts b/arch/arm/boot/dts/imx6q-arm2.dts
> index ce1c823..d2eaf52 100644
> --- a/arch/arm/boot/dts/imx6q-arm2.dts
> +++ b/arch/arm/boot/dts/imx6q-arm2.dts
> @@ -41,7 +41,7 @@
>  			};
>  
>  			usdhc@0219c000 { /* uSDHC4 */
> -				fsl,card-wired;
> +				non-removable;
>  				vmmc-supply = <&reg_3p3v>;
>  				status = "okay";
>  			};
> diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
> index 8c756be..5b4506c 100644
> --- a/arch/arm/boot/dts/omap3-beagle.dts
> +++ b/arch/arm/boot/dts/omap3-beagle.dts
> @@ -57,7 +57,7 @@
>  &mmc1 {
>  	vmmc-supply = <&vmmc1>;
>  	vmmc_aux-supply = <&vsim>;
> -	ti,bus-width = <8>;
> +	bus-width = <8>;
>  };
>  
>  &mmc2 {
> diff --git a/arch/arm/boot/dts/omap4-panda.dts b/arch/arm/boot/dts/omap4-panda.dts
> index ea6f5bb..31fb421 100644
> --- a/arch/arm/boot/dts/omap4-panda.dts
> +++ b/arch/arm/boot/dts/omap4-panda.dts
> @@ -55,7 +55,7 @@
>  
>  &mmc1 {
>  	vmmc-supply = <&vmmc>;
> -	ti,bus-width = <8>;
> +	bus-width = <8>;
>  };
>  
>  &mmc2 {
> @@ -72,5 +72,5 @@
>  
>  &mmc5 {
>  	ti,non-removable;
> -	ti,bus-width = <4>;
> +	bus-width = <4>;
>  };
> diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
> index 67b2e98..a1dd873 100644
> --- a/arch/arm/boot/dts/omap4-sdp.dts
> +++ b/arch/arm/boot/dts/omap4-sdp.dts
> @@ -94,12 +94,12 @@
>  
>  &mmc1 {
>  	vmmc-supply = <&vmmc>;
> -	ti,bus-width = <8>;
> +	bus-width = <8>;
>  };
>  
>  &mmc2 {
>  	vmmc-supply = <&vaux1>;
> -	ti,bus-width = <8>;
> +	bus-width = <8>;
>  	ti,non-removable;
>  };
>  
> @@ -112,6 +112,6 @@
>  };
>  
>  &mmc5 {
> -	ti,bus-width = <4>;
> +	bus-width = <4>;
>  	ti,non-removable;
>  };
> diff --git a/arch/arm/boot/dts/tegra-cardhu.dts b/arch/arm/boot/dts/tegra-cardhu.dts
> index facb950..f00480a 100644
> --- a/arch/arm/boot/dts/tegra-cardhu.dts
> +++ b/arch/arm/boot/dts/tegra-cardhu.dts
> @@ -129,6 +129,7 @@
>  		cd-gpios = <&gpio 69 0>; /* gpio PI5 */
>  		wp-gpios = <&gpio 155 0>; /* gpio PT3 */
>  		power-gpios = <&gpio 31 0>; /* gpio PD7 */
> +		bus-width = <4>;
>  	};
>  
>  	sdhci@78000200 {
> @@ -141,6 +142,7 @@
>  
>  	sdhci@78000400 {
>  		support-8bit;
> +		bus-width = <8>;
>  	};
>  
>  	ahub@70080000 {
> diff --git a/arch/arm/boot/dts/tegra-harmony.dts b/arch/arm/boot/dts/tegra-harmony.dts
> index 6857cec..7cd513a 100644
> --- a/arch/arm/boot/dts/tegra-harmony.dts
> +++ b/arch/arm/boot/dts/tegra-harmony.dts
> @@ -324,6 +324,7 @@
>  		cd-gpios = <&gpio 69 0>; /* gpio PI5 */
>  		wp-gpios = <&gpio 57 0>; /* gpio PH1 */
>  		power-gpios = <&gpio 155 0>; /* gpio PT3 */
> +		bus-width = <4>;
>  	};
>  
>  	sdhci@c8000400 {
> @@ -335,6 +336,7 @@
>  		wp-gpios = <&gpio 59 0>; /* gpio PH3 */
>  		power-gpios = <&gpio 70 0>; /* gpio PI6 */
>  		support-8bit;
> +		bus-width = <8>;
>  	};
>  
>  	usb@c5004000 {
> diff --git a/arch/arm/boot/dts/tegra-paz00.dts b/arch/arm/boot/dts/tegra-paz00.dts
> index 34a9177..8d625e4 100644
> --- a/arch/arm/boot/dts/tegra-paz00.dts
> +++ b/arch/arm/boot/dts/tegra-paz00.dts
> @@ -313,6 +313,7 @@
>  		cd-gpios = <&gpio 173 0>; /* gpio PV5 */
>  		wp-gpios = <&gpio 57 0>;  /* gpio PH1 */
>  		power-gpios = <&gpio 169 0>; /* gpio PV1 */
> +		bus-width = <4>;
>  	};
>  
>  	sdhci@c8000200 {
> @@ -325,6 +326,7 @@
>  
>  	sdhci@c8000600 {
>  		support-8bit;
> +		bus-width = <8>;
>  	};
>  
>  	gpio-keys {
> diff --git a/arch/arm/boot/dts/tegra-seaboard.dts b/arch/arm/boot/dts/tegra-seaboard.dts
> index c4d171e..38e40a1 100644
> --- a/arch/arm/boot/dts/tegra-seaboard.dts
> +++ b/arch/arm/boot/dts/tegra-seaboard.dts
> @@ -380,10 +380,12 @@
>  		cd-gpios = <&gpio 69 0>; /* gpio PI5 */
>  		wp-gpios = <&gpio 57 0>; /* gpio PH1 */
>  		power-gpios = <&gpio 70 0>; /* gpio PI6 */
> +		bus-width = <4>;
>  	};
>  
>  	sdhci@c8000600 {
>  		support-8bit;
> +		bus-width = <8>;
>  	};
>  
>  	usb@c5000000 {
> diff --git a/arch/arm/boot/dts/tegra-ventana.dts b/arch/arm/boot/dts/tegra-ventana.dts
> index c20d5e9..149ab6d 100644
> --- a/arch/arm/boot/dts/tegra-ventana.dts
> +++ b/arch/arm/boot/dts/tegra-ventana.dts
> @@ -338,10 +338,12 @@
>  		cd-gpios = <&gpio 69 0>; /* gpio PI5 */
>  		wp-gpios = <&gpio 57 0>; /* gpio PH1 */
>  		power-gpios = <&gpio 70 0>; /* gpio PI6 */
> +		bus-width = <4>;
>  	};
>  
>  	sdhci@c8000600 {
>  		support-8bit;
> +		bus-width = <8>;
>  	};
>  
>  	usb@c5004000 {
> diff --git a/arch/powerpc/boot/dts/mpc8569mds.dts b/arch/powerpc/boot/dts/mpc8569mds.dts
> index 7e283c8..fe0d609 100644
> --- a/arch/powerpc/boot/dts/mpc8569mds.dts
> +++ b/arch/powerpc/boot/dts/mpc8569mds.dts
> @@ -119,6 +119,7 @@
>  		sdhc@2e000 {
>  			status = "disabled";
>  			sdhci,1-bit-only;
> +			bus-width = <1>;
>  		};
>  
>  		par_io@e0100 {
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index d15b149..ebaf62a 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1781,7 +1781,7 @@ static struct omap_mmc_platform_data *of_get_hsmmc_pdata(struct device *dev)
>  		pdata->slots[0].nonremovable = true;
>  		pdata->slots[0].no_regulator_off_init = true;
>  	}
> -	of_property_read_u32(np, "ti,bus-width", &bus_width);
> +	of_property_read_u32(np, "bus-width", &bus_width);
>  	if (bus_width == 4)
>  		pdata->slots[0].caps |= MMC_CAP_4_BIT_DATA;
>  	else if (bus_width == 8)
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 8abdaf6..0d2b082 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -402,7 +402,7 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
>  	if (!np)
>  		return -ENODEV;
>  
> -	if (of_get_property(np, "fsl,card-wired", NULL))
> +	if (of_get_property(np, "non-removable", NULL))
>  		boarddata->cd_type = ESDHC_CD_PERMANENT;
>  
>  	if (of_get_property(np, "fsl,cd-controller", NULL))
> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
> index c5c2a48..a3858d0 100644
> --- a/drivers/mmc/host/sdhci-pltfm.c
> +++ b/drivers/mmc/host/sdhci-pltfm.c
> @@ -42,7 +42,8 @@ static struct sdhci_ops sdhci_pltfm_ops = {
>  #ifdef CONFIG_OF
>  static bool sdhci_of_wp_inverted(struct device_node *np)
>  {
> -	if (of_get_property(np, "sdhci,wp-inverted", NULL))
> +	if (of_get_property(np, "sdhci,wp-inverted", NULL) ||
> +	    of_get_property(np, "wp-inverted", NULL))
>  		return true;
>  
>  	/* Old device trees don't have the wp-inverted property. */
> @@ -59,13 +60,16 @@ void sdhci_get_of_property(struct platform_device *pdev)
>  	struct sdhci_host *host = platform_get_drvdata(pdev);
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	const __be32 *clk;
> +	u32 bus_width;
>  	int size;
>  
>  	if (of_device_is_available(np)) {
>  		if (of_get_property(np, "sdhci,auto-cmd12", NULL))
>  			host->quirks |= SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;
>  
> -		if (of_get_property(np, "sdhci,1-bit-only", NULL))
> +		if (of_get_property(np, "sdhci,1-bit-only", NULL) ||
> +		    (of_property_read_u32(np, "bus-width", &bus_width) == 0 &&
> +		    bus_width = 1))
>  			host->quirks |= SDHCI_QUIRK_FORCE_1_BIT_DATA;
>  
>  		if (sdhci_of_wp_inverted(np))
> -- 
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
