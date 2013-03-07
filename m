From: "Hiremath, Vaibhav" <hvaibhav-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 2/2] ARM: dts: add AM33XX MMC support
Date: Thu, 7 Mar 2013 05:29:24 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EC20028@DBDE01.ent.ti.com>
References: <1362629799-22485-1-git-send-email-mporter@ti.com>
 <1362629799-22485-3-git-send-email-mporter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1362629799-22485-3-git-send-email-mporter-l0cyMroinI0@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: "Porter, Matt" <mporter-l0cyMroinI0@public.gmane.org>, "Krishnamoorthy, Balaji T" <balajitk-l0cyMroinI0@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Devicetree Discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

> -----Original Message-----
> From: linux-omap-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:linux-omap-
> owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Porter, Matt
> Sent: Thursday, March 07, 2013 9:47 AM
> To: Krishnamoorthy, Balaji T; Chris Ball; Cousson, Benoit; Tony
> Lindgren; Russell King
> Cc: Devicetree Discuss; Linux ARM Kernel List; Linux OMAP List; Linux
> Kernel Mailing List; Linux MMC List
> Subject: [PATCH 2/2] ARM: dts: add AM33XX MMC support
> 
> Adds AM33XX MMC support for am335x-bone, am335x-evm, and
> am335x-evmsk.
> 
> Signed-off-by: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>
> Acked-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> ---
>  arch/arm/boot/dts/am335x-bone.dts  |    7 +++++++
>  arch/arm/boot/dts/am335x-evm.dts   |    7 +++++++
>  arch/arm/boot/dts/am335x-evmsk.dts |    7 +++++++
>  arch/arm/boot/dts/am33xx.dtsi      |   28 ++++++++++++++++++++++++++++
>  4 files changed, 49 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am335x-bone.dts
> b/arch/arm/boot/dts/am335x-bone.dts
> index 11b240c..a154ce0 100644
> --- a/arch/arm/boot/dts/am335x-bone.dts
> +++ b/arch/arm/boot/dts/am335x-bone.dts
> @@ -120,6 +120,8 @@
>  		};
> 
>  		ldo3_reg: regulator@5 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <3300000>;
>  			regulator-always-on;
>  		};
> 
> @@ -136,3 +138,8 @@
>  &cpsw_emac1 {
>  	phy_id = <&davinci_mdio>, <1>;
>  };
> +
> +&mmc1 {
> +	status = "okay";
> +	vmmc-supply = <&ldo3_reg>;
> +};
> diff --git a/arch/arm/boot/dts/am335x-evm.dts
> b/arch/arm/boot/dts/am335x-evm.dts
> index d649644..2907da6 100644
> --- a/arch/arm/boot/dts/am335x-evm.dts
> +++ b/arch/arm/boot/dts/am335x-evm.dts
> @@ -232,6 +232,8 @@
>  		};
> 
>  		vmmc_reg: regulator@12 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <3300000>;
>  			regulator-always-on;
>  		};
>  	};
> @@ -244,3 +246,8 @@
>  &cpsw_emac1 {
>  	phy_id = <&davinci_mdio>, <1>;
>  };
> +
> +&mmc1 {
> +	status = "okay";
> +	vmmc-supply = <&vmmc_reg>;
> +};
> diff --git a/arch/arm/boot/dts/am335x-evmsk.dts
> b/arch/arm/boot/dts/am335x-evmsk.dts
> index f5a6162..f050c46 100644
> --- a/arch/arm/boot/dts/am335x-evmsk.dts
> +++ b/arch/arm/boot/dts/am335x-evmsk.dts
> @@ -244,7 +244,14 @@
>  		};
> 
>  		vmmc_reg: regulator@12 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <3300000>;
>  			regulator-always-on;
>  		};
>  	};
>  };
> +
> +&mmc1 {
> +	status = "okay";
> +	vmmc-supply = <&vmmc_reg>;
> +};
> diff --git a/arch/arm/boot/dts/am33xx.dtsi
> b/arch/arm/boot/dts/am33xx.dtsi
> index c3c781a..e029eea 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -234,6 +234,34 @@
>  			status = "disabled";
>  		};
> 
> +		mmc1: mmc@48060000 {
> +			compatible = "ti,omap3-hsmmc";
> +			ti,hwmods = "mmc1";
> +			ti,dual-volt;
> +			ti,needs-special-reset;
> +			dmas = <&edma 24
> +				&edma 25>;
> +			dma-names = "tx", "rx";
> +			status = "disabled";
> +		};
> +
> +		mmc2: mmc@481d8000 {
> +			compatible = "ti,omap3-hsmmc";
> +			ti,hwmods = "mmc2";
> +			ti,needs-special-reset;
> +			dmas = <&edma 2
> +				&edma 3>;
> +			dma-names = "tx", "rx";
> +			status = "disabled";
> +		};
> +
> +		mmc3: mmc@47810000 {
> +			compatible = "ti,omap3-hsmmc";
> +			ti,hwmods = "mmc3";
> +			ti,needs-special-reset;
> +			status = "disabled";
> +		};
Any specific reason why you did not add edma entry here as well?

Also, I wonder why "interrupt" property is not coming here, I understand
That hwmod is filling the gap here; but I would still recommend you to complete
The DT node, as we only support DT boot.

I will test the whole patch series today and update you.

Thanks,
Vaibhav


> +
>  		wdt2: wdt@44e35000 {
>  			compatible = "ti,omap3-wdt";
>  			ti,hwmods = "wd_timer2";
> --
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"
> in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
