From: =?ISO-8859-15?Q?Andreas_F=E4rber?= <afaerber@suse.de>
Subject: Re: [PATCHv7 2/5] ARM: dts: exynos: unuse the slot-node and deprecated
 the supports-highspeed for dw-mmc
Date: Wed, 30 Jul 2014 14:33:29 +0200
Message-ID: <53D8E619.90601@suse.de>
References: <1406514579-3769-1-git-send-email-jh80.chung@samsung.com> <1406514579-3769-3-git-send-email-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1406514579-3769-3-git-send-email-jh80.chung@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, kgene.kim@samsung.com
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, tgih.jun@samsung.com, devicetree@vger.kernel.org, heiko@sntech.de, dinguyen@altera.com, Mark Rutland <mark.rutland@arm.com>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Am 28.07.2014 04:29, schrieb Jaehoon Chung:
> dw-mmc controller can support multiple slots.
> But, there are no use-cases anywhere. So we don't need to support the
> slot-node for dw-mmc controller.
> And "supports-highspeed" property in dw-mmc is deprecated.
> "supports-highspeed" property can be replaced to "cap-sd/mmc-highspee=
d".

s/replaced to/replaced with/

> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Reviewed-by: Tushar Behera <trblinux@gmail.com>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Tested-by: Sachin Kamat <sachin.kamat@samsung.com>
> Acked-by: Seungwon Jeon <tgih.jun@samsung.com>
> Acked-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
>  arch/arm/boot/dts/exynos4412-odroidx.dts      |    8 ++------
>  arch/arm/boot/dts/exynos4412-origen.dts       |    8 ++------
>  arch/arm/boot/dts/exynos4412-trats2.dts       |    8 ++------
>  arch/arm/boot/dts/exynos5250-arndale.dts      |   18 +++++----------=
--
>  arch/arm/boot/dts/exynos5250-cros-common.dtsi |   26 +++++++--------=
----------
>  arch/arm/boot/dts/exynos5250-smdk5250.dts     |   18 +++++----------=
--
>  arch/arm/boot/dts/exynos5250-snow.dts         |    6 ++----
>  arch/arm/boot/dts/exynos5260-xyref5260.dts    |   18 +++++----------=
--
>  arch/arm/boot/dts/exynos5410-smdk5410.dts     |   18 +++++----------=
--
>  arch/arm/boot/dts/exynos5420-arndale-octa.dts |   16 ++++-----------
>  arch/arm/boot/dts/exynos5420-peach-pit.dts    |   16 ++++-----------
>  arch/arm/boot/dts/exynos5420-smdk5420.dts     |   16 ++++-----------
>  arch/arm/boot/dts/exynos5800-peach-pi.dts     |   16 ++++-----------
>  13 files changed, 51 insertions(+), 141 deletions(-)
[...]
> diff --git a/arch/arm/boot/dts/exynos5250-cros-common.dtsi b/arch/arm=
/boot/dts/exynos5250-cros-common.dtsi
> index 89ac90f..af51361 100644
> --- a/arch/arm/boot/dts/exynos5250-cros-common.dtsi
> +++ b/arch/arm/boot/dts/exynos5250-cros-common.dtsi
> @@ -248,7 +248,6 @@
> =20
>  	mmc@12200000 {
>  		num-slots =3D <1>;
> -		supports-highspeed;
>  		broken-cd;
>  		card-detect-delay =3D <200>;
>  		samsung,dw-mshc-ciu-div =3D <3>;
> @@ -256,44 +255,33 @@
>  		samsung,dw-mshc-ddr-timing =3D <1 2>;
>  		pinctrl-names =3D "default";
>  		pinctrl-0 =3D <&sd0_clk &sd0_cmd &sd0_cd &sd0_bus4 &sd0_bus8>;
> -
> -		slot@0 {
> -			reg =3D <0>;
> -			bus-width =3D <8>;
> -		};
> +		bus-width =3D <8>;
> +		cap-mmc-highspeed;
>  	};
> =20
>  	mmc@12220000 {
>  		num-slots =3D <1>;
> -		supports-highspeed;
>  		card-detect-delay =3D <200>;
>  		samsung,dw-mshc-ciu-div =3D <3>;
>  		samsung,dw-mshc-sdr-timing =3D <2 3>;
>  		samsung,dw-mshc-ddr-timing =3D <1 2>;
>  		pinctrl-names =3D "default";
>  		pinctrl-0 =3D <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
> -
> -		slot@0 {
> -			reg =3D <0>;
> -			bus-width =3D <4>;
> -			wp-gpios =3D <&gpc2 1 0>;
> -		};
> +		bus-width =3D <4>;
> +		wp-gpios =3D <&gpc2 1 0>;
> +		cap-sd-highspeed;
>  	};
> =20
>  	mmc@12230000 {
>  		num-slots =3D <1>;
> -		supports-highspeed;
>  		broken-cd;
>  		card-detect-delay =3D <200>;
>  		samsung,dw-mshc-ciu-div =3D <3>;
>  		samsung,dw-mshc-sdr-timing =3D <2 3>;
>  		samsung,dw-mshc-ddr-timing =3D <1 2>;
>  		/* See board-specific dts files for pin setup */
> -
> -		slot@0 {
> -			reg =3D <0>;
> -			bus-width =3D <4>;
> -		};
> +		bus-width =3D <4>;
> +		cap-sd-highspeed;
>  	};
> =20
>  	spi_1: spi@12d30000 {
[...]
> diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dt=
s/exynos5250-snow.dts
> index 079fdf9..17d8f53 100644
> --- a/arch/arm/boot/dts/exynos5250-snow.dts
> +++ b/arch/arm/boot/dts/exynos5250-snow.dts
> @@ -329,10 +329,8 @@
>  	 */
>  	mmc@12230000 {
>  		status =3D "okay";
> -		slot@0 {
> -			pinctrl-names =3D "default";
> -			pinctrl-0 =3D <&sd3_clk &sd3_cmd &sd3_bus4>;
> -		};
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&sd3_clk &sd3_cmd &sd3_bus4>;
>  	};
> =20
>  	i2c@12CD0000 {

Since you said you are targeting 3.16 still, FYI Doug asked me to do th=
e
same change for 3.17 in my Spring series for correctness reasons. So we
shouldn't have merge conflict there.

However, we are also dropping exynos5250-cros-common.dtsi, so at some
point the above changes will need to be merged into -snow.dts as
conflict resolution.

[...]
> diff --git a/arch/arm/boot/dts/exynos5410-smdk5410.dts b/arch/arm/boo=
t/dts/exynos5410-smdk5410.dts
> index 7275bbd..be3e025 100644
> --- a/arch/arm/boot/dts/exynos5410-smdk5410.dts
> +++ b/arch/arm/boot/dts/exynos5410-smdk5410.dts
> @@ -40,33 +40,25 @@
>  &mmc_0 {
>  	status =3D "okay";
>  	num-slots =3D <1>;
> -	supports-highspeed;
> +	cap-mmc-highspeed;
>  	broken-cd;
>  	card-detect-delay =3D <200>;
>  	samsung,dw-mshc-ciu-div =3D <3>;
>  	samsung,dw-mshc-sdr-timing =3D <2 3>;
>  	samsung,dw-mshc-ddr-timing =3D <1 2>;
> -
> -	slot@0 {
> -		reg =3D <0>;
> -		bus-width =3D <8>;
> -	};
> +	bus-width =3D <8>;
>  };
> =20
>  &mmc_2 {
>  	status =3D "okay";
>  	num-slots =3D <1>;
> -	supports-highspeed;
> +	cap-sd-highspeed;
>  	card-detect-delay =3D <200>;
>  	samsung,dw-mshc-ciu-div =3D <3>;
>  	samsung,dw-mshc-sdr-timing =3D <2 3>;
>  	samsung,dw-mshc-ddr-timing =3D <1 2>;
> -
> -	slot@0 {
> -		reg =3D <0>;
> -		bus-width =3D <4>;
> -		disable-wp;
> -	};
> +	bus-width =3D <4>;
> +	disable-wp;
>  };
> =20
>  &uart0 {

Similarly here, I am adding an exynos5410-odroidxu.dts file that will
need to get the same changes as -smdk5410.dts then.

Regards,
Andreas

--=20
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N=FCrnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend=F6rffer; HRB 16746 AG N=FCrn=
berg
