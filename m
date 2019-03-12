From: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH v3 1/3] arm: dts: rk3288-tinker.dtsi: Fix SD card detection
Date: Tue, 12 Mar 2019 15:08:15 +0100
Message-ID: <10436027.DUyLE1RSiR@phil>
References: <20190217121513.22965-1-beagleboard@davidjohnsummers.uk>
 <20190309153923.22806-1-beagleboard@davidjohnsummers.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20190309153923.22806-1-beagleboard-8lkWs+DogrrqRUWtDFdff/XRex20P6io@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: David Summers <beagleboard-8lkWs+DogrrqRUWtDFdff/XRex20P6io@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Am Samstag, 9. M=E4rz 2019, 16:39:21 CET schrieb David Summers:
> The Problem:
> =

> On ASUS Tinker Board S, when booting from the eMMC, and there is card
> in the sd slot, there are constant errors.
> =

> Also when warm reboot, uboot can not access the sd slot
> =

> Cause:
> =

> Identified by Robin Murphy @ ARM. The Card Detect on rk3288
> devices is pulled up by vccio-sd; so when the regulator powers this
> off, card detect gives spurious errors. A second problem, is during
> power down, vccio-sd apprears to be powered down. This causes a
> problem when warm rebooting from the sd card. This was identified by
> Jonas Karlman.
> =

> History:
> =

> A common fault on these rk3288 board, which impliment the reference
> design.
> =

> When this arose before:
> =

> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-August/281153.=
html
> =

> And Ulf and Jaehoon clearly said this was a broken card detect design,
> which should be solved via polling
> =

> Solution:
> =

> Hence broken-cd is set as a property. This cures the errors. The
> powering down of vccio-sd during reboot is cured by adding
> regulator-boot-on.
> =

> This solutions has been fairly widely reviewed and tested.
> =

> Signed-off-by: David Summers <beagleboard-8lkWs+DogrrqRUWtDFdff/XRex20P6io@public.gmane.org>
> Reviewed by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> Reviewed by: Jonas Karlman <jonas-uIzNG4q0ceqzQB+pC5nmwQ@public.gmane.org>
> Test by: TheSaint @ ArchLinux Arm

please follow patch submission guidelines, here it would be
Tested-by: ... with an actual Name + mail address

Also I did try to go through the way big mail thread but didn't
find an actual "Reviewed-by" from Robin Murphy, similar to what
he pointed out in patch2

Other than that and including the past discussions, this looks good.


Heiko

> ---
>  arch/arm/boot/dts/rk3288-tinker.dtsi | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> =

> diff --git a/arch/arm/boot/dts/rk3288-tinker.dtsi b/arch/arm/boot/dts/rk3=
288-tinker.dtsi
> index aa107ee41b8b..ef653c3209bc 100644
> --- a/arch/arm/boot/dts/rk3288-tinker.dtsi
> +++ b/arch/arm/boot/dts/rk3288-tinker.dtsi
> @@ -254,6 +254,7 @@
>  			};
>  =

>  			vccio_sd: LDO_REG5 {
> +				regulator-boot-on;
>  				regulator-min-microvolt =3D <1800000>;
>  				regulator-max-microvolt =3D <3300000>;
>  				regulator-name =3D "vccio_sd";
> @@ -430,7 +431,7 @@
>  	bus-width =3D <4>;
>  	cap-mmc-highspeed;
>  	cap-sd-highspeed;
> -	card-detect-delay =3D <200>;
> +	broken-cd;
>  	disable-wp;			/* wp not hooked up */
>  	pinctrl-names =3D "default";
>  	pinctrl-0 =3D <&sdmmc_clk &sdmmc_cmd &sdmmc_cd &sdmmc_bus4>;
> =
