From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH/RFC 2/2] ARM: shmobile: kzm9g: support DDR50 mode with
 1.8V VccQ on MMCIF
Date: Tue, 30 Jul 2013 11:18:02 +0900
Message-ID: <20130730021801.GA31526@verge.net.au>
References: <Pine.LNX.4.64.1307261747210.22137@axis700.grange>
 <Pine.LNX.4.64.1307261748260.22137@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1307261748260.22137@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Chris Ball <cjb@laptop.org>, devicetree@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Fri, Jul 26, 2013 at 05:51:32PM +0200, Guennadi Liakhovetski wrote:
> MMCIF on sh73a0 supports the UHS DDR50 mode and on the kzm9g board it can
> be used with MMC VccQ = 1.8V. This patch enables them.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> ---
> 
> This patch is correct AFAICS, but pointless on kzm9g, because (at least on 
> my board) th eMMC chip, installed on the board and connected to MMCIF 
> doesn't support DDR, so, it cannot be enabled. This patch is therefore 
> more of an example how these flags shall be used, than a real use case. If 
> it is decided to apply it, it can be applied even before patch 1/2, it 
> just won't have any effect at all.

Thanks, understood.

At this point I prefer not to apply it as it doesn't have any effect.
I am more than happy to discuss this further if others would
like it applied.

> 
>  arch/arm/boot/dts/sh73a0-kzm9g-reference.dts |    1 +
>  arch/arm/boot/dts/sh73a0.dtsi                |    1 +
>  2 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
> index b99e890..d90de01 100644
> --- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
> +++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
> @@ -191,6 +191,7 @@
>  
>  	bus-width = <8>;
>  	vmmc-supply = <&reg_1p8v>;
> +	ddr-1v8;
>  	status = "okay";
>  };
>  
> diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
> index 86e79fe..1146be8 100644
> --- a/arch/arm/boot/dts/sh73a0.dtsi
> +++ b/arch/arm/boot/dts/sh73a0.dtsi
> @@ -186,6 +186,7 @@
>  		interrupts = <0 140 0x4
>  			      0 141 0x4>;
>  		reg-io-width = <4>;
> +		uhs-ddr50;
>  		status = "disabled";
>  	};
>  
> -- 
> 1.7.2.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
