From: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Subject: Re: [RFC PATCH 6/7] ARM: shmobile: r8a7790-lager.dts: Set sdhi and
 mmcif clock rates
Date: Fri, 1 May 2015 09:59:20 +0900
Message-ID: <20150501005920.GH13754@verge.net.au>
References: <1430396995.5802.39.camel@xylophone.i.decadent.org.uk>
 <1430397166.5802.45.camel@xylophone.i.decadent.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1430397166.5802.45.camel-2NU49sBE5Aze9VDwLV8dzJPsBRI6B4nW9dF7HbQ/qKg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Hutchings <ben.hutchings-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
Cc: Ian Molton <ian-zdned+2MO1+9FHfhHBbuYA@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-81qHHgoATdFT9dQujB1mzip2UmYkHbXO@public.gmane.org, Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi Ben,

Please use the following prefix for r8a7790-lager.dts patches:

ARM: shmobile: lager:

On Thu, Apr 30, 2015 at 01:32:46PM +0100, Ben Hutchings wrote:
> From: Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
> 
> [bwh: Fold in fix from Ian Molton]
> Signed-off-by: Ben Hutchings <ben.hutchings-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
> ---
>  arch/arm/boot/dts/r8a7790-lager.dts |   11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
> index aaa4f258e279..343ec0ccc8df 100644
> --- a/arch/arm/boot/dts/r8a7790-lager.dts
> +++ b/arch/arm/boot/dts/r8a7790-lager.dts
> @@ -413,6 +413,11 @@
>  	vmmc-supply = <&fixedregulator3v3>;
>  	bus-width = <8>;
>  	non-removable;
> +
> +	assigned-clocks = <&mstp3_clks R8A7790_CLK_MMCIF1>;
> +	assigned-clock-rates = <97500000>;
> +	max-frequency = <50000000>;
> +
>  	status = "okay";
>  };
>  
> @@ -488,6 +493,9 @@
>  	pinctrl-0 = <&sdhi0_pins>;
>  	pinctrl-names = "default";
>  
> +	assigned-clocks = <&mstp3_clks R8A7790_CLK_SDHI0>;
> +	assigned-clock-rates = <156000000>;
> +
>  	vmmc-supply = <&vcc_sdhi0>;
>  	vqmmc-supply = <&vccq_sdhi0>;
>  	cd-gpios = <&gpio3 6 GPIO_ACTIVE_LOW>;
> @@ -498,6 +506,9 @@
>  	pinctrl-0 = <&sdhi2_pins>;
>  	pinctrl-names = "default";
>  
> +	assigned-clocks = <&mstp3_clks R8A7790_CLK_SDHI2>;
> +	assigned-clock-rates = <97500000>;
> +
>  	vmmc-supply = <&vcc_sdhi2>;
>  	vqmmc-supply = <&vccq_sdhi2>;
>  	cd-gpios = <&gpio3 22 GPIO_ACTIVE_LOW>;
> -- 
> 1.7.10.4
> 
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
