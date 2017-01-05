From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 3/5] arm64: dts: sun50i: add MMC nodes
Date: Thu, 5 Jan 2017 18:50:10 +0100
Message-ID: <20170105175010.j3qpqqkj3kmgrmyc@lukather>
References: <1483398226-29321-1-git-send-email-andre.przywara@arm.com>
 <1483398226-29321-4-git-send-email-andre.przywara@arm.com>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="unu55hffykuh5z4a"
Return-path: <linux-sunxi+bncBDSJBYGBRIMBBCMPXLBQKGQED75HSQY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <1483398226-29321-4-git-send-email-andre.przywara-5wv7dgnIgG8@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Hans De Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


--unu55hffykuh5z4a
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Mon, Jan 02, 2017 at 11:03:44PM +0000, Andre Przywara wrote:
> Signed-off-by: Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 67 +++++++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> index e0dcab8..c680566 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -150,6 +150,32 @@
>  				pins = "PB8", "PB9";
>  				function = "uart0";
>  			};
> +
> +			mmc0_pins: mmc0@0 {
> +				pins = "PF0", "PF1", "PF2", "PF3", "PF4", "PF5";
> +				function = "mmc0";
> +				drive-strength = <30>;
> +			};
> +
> +			mmc0_default_cd_pin: mmc0_cd_pin@0 {
> +				pins = "PF6";
> +				function = "gpio_in";
> +				bias-pull-up;
> +			};
> +
> +			mmc1_pins: mmc1@0 {
> +				pins = "PG0", "PG1", "PG2", "PG3", "PG4", "PG5";
> +				function = "mmc1";
> +				drive-strength = <30>;
> +			};
> +
> +			mmc2_pins: mmc2@0 {
> +				pins = "PC1", "PC5", "PC6", "PC8", "PC9",
> +				       "PC10", "PC11", "PC12", "PC13", "PC14",
> +				       "PC15", "PC16";
> +				function = "mmc2";
> +				drive-strength = <30>;
> +			};
>  		};
>  
>  		uart0: serial@1c28000 {
> @@ -240,6 +266,47 @@
>  			#size-cells = <0>;
>  		};
>  
> +		mmc0: mmc@1c0f000 {
> +			compatible = "allwinner,sun50i-a64-mmc",
> +				     "allwinner,sun5i-a13-mmc";

That's not correct. There's a bunch of features that are broken
without A64-specific (or at least not present on the A13)
quirks. Those features include for example the SDIO aggregation that
are currently broken for all modes supported so far.

I was in holidays and send those patches tomorrow, but you were a bit
too quick :)

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
--unu55hffykuh5z4a--
