From: "AnilKumar, Chimata" <anilkumar-l0cyMroinI0@public.gmane.org>
Subject: RE: [RFC PATCH v3 13/16] ARM: dts: add AM33XX MMC support
Date: Tue, 30 Oct 2012 05:33:40 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA5AE57@DBDE01.ent.ti.com>
References: <1350566815-409-1-git-send-email-mporter@ti.com>
 <1350566815-409-14-git-send-email-mporter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1350566815-409-14-git-send-email-mporter-l0cyMroinI0@public.gmane.org>
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
To: "Porter, Matt" <mporter-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "Nori,
 Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Cc: Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Linux Documentation List <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Devicetree Discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Dan Williams <djbw-b10kYP2dOMg@public.gmane.org>, Linux SPI Devel List <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, Oct 18, 2012 at 18:56:52, Porter, Matt wrote:
> Adds AM33XX MMC support for am335x-bone and am335x-evm.
> 
> Signed-off-by: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>
> ---
>  arch/arm/boot/dts/am335x-bone.dts |    6 ++++++
>  arch/arm/boot/dts/am335x-evm.dts  |    6 ++++++
>  arch/arm/boot/dts/am33xx.dtsi     |   27 +++++++++++++++++++++++++++
>  3 files changed, 39 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
> index c634f87..5510979 100644
> --- a/arch/arm/boot/dts/am335x-bone.dts
> +++ b/arch/arm/boot/dts/am335x-bone.dts
> @@ -70,6 +70,8 @@
>  		};
>  
>  		ldo3_reg: regulator@5 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <3300000>;

I think these min & max limits are regulator limits. Are these fields
required? Add details of these additions. AFAIK fine-tuned (board
specific) min/max limits should be add here(like mpu and core
regulator nodes)

>  			regulator-always-on;
>  		};
>  
> @@ -78,3 +80,7 @@
>  		};
>  	};
>  };
> +
> +&mmc1 {
> +	vmmc-supply = <&ldo3_reg>;
> +};
> diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
> index 185d632..d63fce8 100644
> --- a/arch/arm/boot/dts/am335x-evm.dts
> +++ b/arch/arm/boot/dts/am335x-evm.dts
> @@ -114,7 +114,13 @@
>  		};
>  
>  		vmmc_reg: regulator@12 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <3300000>;

=same=

>  			regulator-always-on;
>  		};
>  	};
>  };
> +
> +&mmc1 {
> +	vmmc-supply = <&vmmc_reg>;
> +};
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index ab9c78f..26a6af7 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -234,6 +234,33 @@
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

Add status = "disabled" here and "okay" in corresponding
.dts file

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

What about DMA resources for mmc3?

AnilKumar

> +			status = "disabled";
> +		};
> +
>  		wdt2: wdt@44e35000 {
>  			compatible = "ti,omap3-wdt";
>  			ti,hwmods = "wd_timer2";
> -- 
> 1.7.9.5
> 
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
> 
