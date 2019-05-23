From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v2] arm64: dts: ls1028a: Add esdhc node in dts
Date: Thu, 23 May 2019 15:37:45 +0800
Message-ID: <20190523073744.GG9261@dragon>
References: <20190515040046.9230-1-yinbo.zhu@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190515040046.9230-1-yinbo.zhu@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yinbo Zhu <yinbo.zhu@nxp.com>
Cc: Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>, xiaobo.xie@nxp.com, Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, yangbo.lu@nxp.com, jiafei.pan@nxp.com, Ashish Kumar <Ashish.Kumar@nxp.com>
List-Id: linux-mmc@vger.kernel.org

On Wed, May 15, 2019 at 12:00:46PM +0800, Yinbo Zhu wrote:
> From: Ashish Kumar <Ashish.Kumar@nxp.com>
> 
> This patch is to add esdhc node and enable SD UHS-I,
> eMMC HS200 for ls1028ardb/ls1028aqds board.
> 
> Signed-off-by: Ashish Kumar <Ashish.Kumar@nxp.com>
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
> ---
> Change in v2:
> 		Update the patch title
> 		Add a commont in dts code
> 
>  arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts |    8 ++++++
>  arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts |   13 ++++++++++
>  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi    |   27 +++++++++++++++++++++
>  3 files changed, 48 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
> index 14c79f4..180e5d2 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
> @@ -42,6 +42,14 @@
>  	status = "okay";
>  };
>  
> +&esdhc {
> +	status = "okay";
> +};
> +
> +&esdhc1 {
> +	status = "okay";
> +};
> +
>  &i2c0 {
>  	status = "okay";
>  
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> index f86b054..1bfaf42 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> @@ -30,6 +30,19 @@
>  	};
>  };
>  
> +&esdhc {
> +	status = "okay";

We usually put 'status' at the end of property list.

> +	sd-uhs-sdr104;
> +	sd-uhs-sdr50;
> +	sd-uhs-sdr25;
> +	sd-uhs-sdr12;
> +	};

Bad indentation.

> +
> +&esdhc1 {
> +	status = "okay";
> +	mmc-hs200-1_8v;
> +	};
> +
>  &i2c0 {
>  	status = "okay";
>  
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> index 2896bbc..5c7546f 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> @@ -274,6 +274,33 @@
>  			status = "disabled";
>  		};
>  
> +		esdhc: esdhc@2140000 {

'mmc' for node name, and the node should be sorted in unit-address.

> +			compatible = "fsl,ls1028a-esdhc", "fsl,esdhc";
> +			reg = <0x0 0x2140000 0x0 0x10000>;
> +			interrupts = <0 28 0x4>; /* Level high type */

interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;

> +			clock-frequency = <0>; /* fixed up by bootloader */
> +			clocks = <&clockgen 2 1>;
> +			voltage-ranges = <1800 1800 3300 3300>;
> +			sdhci,auto-cmd12;
> +			little-endian;
> +			bus-width = <4>;
> +			status = "disabled";
> +		};
> +
> +		esdhc1: esdhc@2150000 {
> +			compatible = "fsl,ls1028a-esdhc", "fsl,esdhc";
> +			reg = <0x0 0x2150000 0x0 0x10000>;
> +			interrupts = <0 63 0x4>; /* Level high type */
> +			clock-frequency = <0>; /* fixed up by bootloader */
> +			clocks = <&clockgen 2 1>;
> +			voltage-ranges = <1800 1800 3300 3300>;
> +			sdhci,auto-cmd12;
> +			broken-cd;

Shouldn't this one be a board level property?

Shawn

> +			little-endian;
> +			bus-width = <4>;
> +			status = "disabled";
> +		};
> +
>  		sata: sata@3200000 {
>  			compatible = "fsl,ls1028a-ahci";
>  			reg = <0x0 0x3200000 0x0 0x10000>,
> -- 
> 1.7.1
> 
