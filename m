From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH RFC 08/15] ARM: dts: sun6i: Add mmc3 pins
 for 8 bit emmc
Date: Fri, 22 Jan 2016 21:31:38 +0100
Message-ID: <20160122203138.GB3682@lukather>
References: <1453354002-28366-1-git-send-email-wens@csie.org>
 <1453354002-28366-9-git-send-email-wens@csie.org>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XOIedfhf+7KOe/yw"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBK5DRK2QKGQEJTFPVEQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1453354002-28366-9-git-send-email-wens-jdAy2FN1RRM@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

--XOIedfhf+7KOe/yw
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

Hi, 

On Thu, Jan 21, 2016 at 01:26:35PM +0800, Chen-Yu Tsai wrote:
> mmc2 and mmc3 are available on the same pins, with different mux values.
> However, only mmc3 supports 8 bit DDR transfer modes.
> 
> Since preference for mmc3 over mmc2 is due to DDR transfer modes, just
> set the drive strength to 40mA, which is needed for DDR.
> 
> This pinmux setting also includes the hardware reset pin for emmc.
> 
> Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
> ---
>  arch/arm/boot/dts/sun6i-a31.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
> index b6ad7850fac6..1867af24ff52 100644
> --- a/arch/arm/boot/dts/sun6i-a31.dtsi
> +++ b/arch/arm/boot/dts/sun6i-a31.dtsi
> @@ -709,6 +709,16 @@
>  				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
>  			};
>  
> +			mmc3_8bit_emmc_pins: mmc3@1 {
> +				allwinner,pins = "PC6", "PC7", "PC8", "PC9",
> +						 "PC10", "PC11", "PC12",
> +						 "PC13", "PC14", "PC15",
> +						 "PC24";
> +				allwinner,function = "mmc3";
> +				allwinner,drive = <SUN4I_PINCTRL_40_MA>;
> +				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> +			};
> +

Is that reset pin optional?

If so, I'd prefer it to be a separate node, like we're doing for the
SPI chip selects for example.

It allows more reusability between different devices without declaring
new nodes.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
--XOIedfhf+7KOe/yw--
