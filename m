From: "T Krishnamoorthy, Balaji" <balajitk-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 1/4] mmc: omap_hsmmc: Convert hsmmc driver to use
	device tree
Date: Fri, 24 Feb 2012 17:02:07 +0530
Message-ID: <CANrkHUarg5ntUW=S7k20LXuYe+ZNCN-cYJhfvvLKM=X8+Db4fg@mail.gmail.com>
References: <1329998490-27555-1-git-send-email-rnayak@ti.com>
	<1329998490-27555-2-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <1329998490-27555-2-git-send-email-rnayak-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
Cc: linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Thu, Feb 23, 2012 at 5:31 PM, Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org> wrote:
> Define dt bindings for the ti-omap-hsmmc, and adapt
> the driver to extract data (which was earlier passed as
> platform_data) from device tree.
>
> Signed-off-by: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
> ---
> =A0.../devicetree/bindings/mmc/ti-omap-hsmmc.txt =A0 =A0 =A0| =A0 31 ++++=
+++++
> =A0drivers/mmc/host/omap_hsmmc.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 68 ++++++++++++++++++++
> =A02 files changed, 99 insertions(+), 0 deletions(-)
> =A0create mode 100644 Documentation/devicetree/bindings/mmc/ti-omap-hsmmc=
.txt
>
> diff --git a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt b/Do=
cumentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
> new file mode 100644
> index 0000000..e4fa8f0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
> @@ -0,0 +1,31 @@
> +* TI Highspeed MMC host controller for OMAP
> +
> +The Highspeed MMC Host Controller on TI OMAP family
> +provides an interface for MMC, SD, and SDIO types of memory cards.
> +
> +Required properties:
> +- compatible:
> + Should be "ti,omap2-hsmmc", for OMAP2/3 controllers

omap_hsmmc is applicable for omap2430 and omap3.
omap2420 has non high speed controller mmci-omap - drivers/mmc/host/omap.c
May be omap3-hsmmc compatible with omap2430 ?

> + Should be "ti,omap4-hsmmc", for OMAP4 controllers
> +- ti,hwmods: Must be "mmc<n>", n is controller instance starting 1
> +- reg : should contain hsmmc registers location and length
> +
> +Optional properties:
> +ti,dual-volt: boolean, supports dual voltage cards
> +<supply-name>-supply: phandle to the regulator device tree node
> +"supply-name" examples are "vmmc", "vmmc_aux" etc
> +ti,bus-width: Number of data lines, default assumed is 1 if the property=
 is missing.
> +cd-gpios: GPIOs for card detection
> +wp-gpios: GPIOs for write protection
> +ti,non-removable: non-removable slot (like eMMC)
> +
> +Example:
> + =A0 =A0 =A0 mmc1: mmc@0x4809c000 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "ti,omap4-hsmmc";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x4809c000 0x400>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ti,hwmods =3D "mmc1";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ti,dual-volt;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ti,bus-width =3D <4>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vmmc-supply =3D <&vmmc>; /* phandle to regu=
lator node */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ti,non-removable;
> + =A0 =A0 =A0 };
