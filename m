From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 6/7 v4] ARM: shmobile: r8a7790: add MMCIF parent clock
 range
Date: Thu, 7 May 2015 14:26:59 +0900
Message-ID: <20150507052656.GJ28846@verge.net.au>
References: <873840a4ch.wl%kuninori.morimoto.gx@renesas.com>
 <87d22vgt8u.wl%kuninori.morimoto.gx@renesas.com>
 <87383rgsy1.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87383rgsy1.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Laurent <laurent.pinchart@ideasonboard.com>, kobayashi <keita.kobayashi.ym@renesas.com>
List-Id: linux-mmc@vger.kernel.org

Hi Morimoto-san,

On Thu, Apr 23, 2015 at 08:18:04AM +0000, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Tested-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>

Could you indicate if:
* you think this and the next patch of the series is ready to be merged or;
* I should wait for patch 5 to be merged/reworked/...

> ---
> v3 -> v4
> 
>  - new patch
> 
>  arch/arm/boot/dts/r8a7790.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
> index f3b8430..ac61636 100644
> --- a/arch/arm/boot/dts/r8a7790.dtsi
> +++ b/arch/arm/boot/dts/r8a7790.dtsi
> @@ -467,6 +467,7 @@
>  		dma-names = "tx", "rx";
>  		reg-io-width = <4>;
>  		status = "disabled";
> +		clk-range = <12187500 97500000>;
>  	};
>  
>  	mmcif1: mmc@ee220000 {
> @@ -478,6 +479,7 @@
>  		dma-names = "tx", "rx";
>  		reg-io-width = <4>;
>  		status = "disabled";
> +		clk-range = <12187500 97500000>;
>  	};
>  
>  	pfc: pfc@e6060000 {
> -- 
> 1.9.1
> 
