From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH RFC 09/15] ARM: dts: sun6i: sina31s: Switch
 to mmc3 for onboard eMMC
Date: Fri, 22 Jan 2016 21:39:27 +0100
Message-ID: <20160122203927.GC3682@lukather>
References: <1453354002-28366-1-git-send-email-wens@csie.org>
 <1453354002-28366-10-git-send-email-wens@csie.org>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vOmOzSkFvhd7u8Ms"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBAFHRK2QKGQEXF3MPWA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1453354002-28366-10-git-send-email-wens-jdAy2FN1RRM@public.gmane.org>
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

--vOmOzSkFvhd7u8Ms
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

Hi,

On Thu, Jan 21, 2016 at 01:26:36PM +0800, Chen-Yu Tsai wrote:
> According to Allwinner, only mmc3 supports 8 bit DDR transfers for eMMC.
> Switch to mmc3 for the onboard eMMC, and also assign vqmmc for signal
> voltage sensing/switching, and "cap-mmc-hw-reset" to denote this
> instance can use eMMC hardware reset.
> 
> Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
> ---
>  arch/arm/boot/dts/sun6i-a31s-sina31s-core.dtsi | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/sun6i-a31s-sina31s-core.dtsi b/arch/arm/boot/dts/sun6i-a31s-sina31s-core.dtsi
> index ea69fb8ad4d8..4ec0c8679b2e 100644
> --- a/arch/arm/boot/dts/sun6i-a31s-sina31s-core.dtsi
> +++ b/arch/arm/boot/dts/sun6i-a31s-sina31s-core.dtsi
> @@ -61,12 +61,14 @@
>  };
>  
>  /* eMMC on core board */
> -&mmc2 {
> +&mmc3 {
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&mmc2_8bit_emmc_pins>;
> +	pinctrl-0 = <&mmc3_8bit_emmc_pins>;
>  	vmmc-supply = <&reg_dcdc1>;
> +	vqmmc-supply = <&reg_dcdc1>;

That seems odd. IIRC the VCC was supposed to be fixed and VCCQ could
be either at 1.8 or 3V. Having the same regulator on both would make
VCCQ forced to 3.3V, which seems to go against your commit log.

What's the catch ? :)

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
--vOmOzSkFvhd7u8Ms--
