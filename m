From: Simon Horman <horms@verge.net.au>
Subject: Re: [RFC PATCH 4/7] ARM: shmobile: r8a7790: Add nodes for pfc SD
 voltage regulators
Date: Fri, 1 May 2015 09:57:19 +0900
Message-ID: <20150501005719.GG13754@verge.net.au>
References: <1430396995.5802.39.camel@xylophone.i.decadent.org.uk>
 <1430397114.5802.43.camel@xylophone.i.decadent.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1430397114.5802.43.camel@xylophone.i.decadent.org.uk>
Sender: linux-sh-owner@vger.kernel.org
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: Ian Molton <ian@mnementh.co.uk>, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@lists.codethink.co.uk
List-Id: linux-mmc@vger.kernel.org

Hi Ben,

thanks for your patch-set.

On Thu, Apr 30, 2015 at 01:31:54PM +0100, Ben Hutchings wrote:
> Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
> ---
>  arch/arm/boot/dts/r8a7790.dtsi |   21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
> index 4bb2f4c17321..23e826153a9d 100644
> --- a/arch/arm/boot/dts/r8a7790.dtsi
> +++ b/arch/arm/boot/dts/r8a7790.dtsi
> @@ -483,6 +483,23 @@
>  	pfc: pfc@e6060000 {
>  		compatible = "renesas,pfc-r8a7790";
>  		reg = <0 0xe6060000 0 0x250>;
> +
> +		vccq_ref_sdhi0: sd-regulator@0 {
> +			compatible = "renesas,pfc-r8a7790-sd-regulator";

I'm a little confused. What is "renesas,pfc-r8a7790-sd-regulator"?
It suspect that it should at least be documented under
Documentation/devicetree/bindings/

> +			status = "disabled";
> +		};
> +		vccq_ref_sdhi1: sd-regulator@1 {
> +			compatible = "renesas,pfc-r8a7790-sd-regulator";
> +			status = "disabled";
> +		};
> +		vccq_ref_sdhi2: sd-regulator@2 {
> +			compatible = "renesas,pfc-r8a7790-sd-regulator";
> +			status = "disabled";
> +		};
> +		vccq_ref_sdhi3: sd-regulator@3 {
> +			compatible = "renesas,pfc-r8a7790-sd-regulator";
> +			status = "disabled";
> +		};
>  	};
>  
>  	sdhi0: sd@ee100000 {
> @@ -490,6 +507,7 @@
>  		reg = <0 0xee100000 0 0x328>;
>  		interrupts = <0 165 IRQ_TYPE_LEVEL_HIGH>;
>  		clocks = <&mstp3_clks R8A7790_CLK_SDHI0>;
> +		vqmmc-ref-supply = <&vccq_ref_sdhi0>;
>  		dmas = <&dmac1 0xcd>, <&dmac1 0xce>;
>  		dma-names = "tx", "rx";
>  		status = "disabled";
> @@ -500,6 +518,7 @@
>  		reg = <0 0xee120000 0 0x328>;
>  		interrupts = <0 166 IRQ_TYPE_LEVEL_HIGH>;
>  		clocks = <&mstp3_clks R8A7790_CLK_SDHI1>;
> +		vqmmc-ref-supply = <&vccq_ref_sdhi1>;
>  		dmas = <&dmac1 0xc9>, <&dmac1 0xca>;
>  		dma-names = "tx", "rx";
>  		status = "disabled";
> @@ -510,6 +529,7 @@
>  		reg = <0 0xee140000 0 0x100>;
>  		interrupts = <0 167 IRQ_TYPE_LEVEL_HIGH>;
>  		clocks = <&mstp3_clks R8A7790_CLK_SDHI2>;
> +		vqmmc-ref-supply = <&vccq_ref_sdhi2>;
>  		dmas = <&dmac1 0xc1>, <&dmac1 0xc2>;
>  		dma-names = "tx", "rx";
>  		status = "disabled";
> @@ -520,6 +540,7 @@
>  		reg = <0 0xee160000 0 0x100>;
>  		interrupts = <0 168 IRQ_TYPE_LEVEL_HIGH>;
>  		clocks = <&mstp3_clks R8A7790_CLK_SDHI3>;
> +		vqmmc-ref-supply = <&vccq_ref_sdhi3>;
>  		dmas = <&dmac1 0xd3>, <&dmac1 0xd4>;
>  		dma-names = "tx", "rx";
>  		status = "disabled";
> -- 
> 1.7.10.4
> 
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
