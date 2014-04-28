From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v9 03/17] ARM: sunxi: Add driver for SD/MMC
 hosts found on Allwinner sunxi SoCs
Date: Mon, 28 Apr 2014 12:36:29 -0700
Message-ID: <20140428193629.GI3134@lukather>
References: <1398507381-5614-1-git-send-email-hdegoede@redhat.com>
 <1398507381-5614-4-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r4QXMf6/kyF/FvJJ"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBFO57KNAKGQEACMTNGQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1398507381-5614-4-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, David =?iso-8859-1?Q?Lanzend=F6rfer?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org


--r4QXMf6/kyF/FvJJ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 26, 2014 at 12:16:07PM +0200, Hans de Goede wrote:
> From: David Lanzend=F6rfer <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>
>=20
> The Allwinner sunxi mmc host uses dma in bus-master mode using a built-in
> designware idmac controller, which is identical to the one found in the m=
mc-dw
> hosts. However the rest of the host is not identical to mmc-dw, it deals =
with
> sending stop commands in hardware which makes it significantly different
> from the mmc-dw devices.
>=20
> HdG: Various cleanups and fixes.
>=20
> Signed-off-by: David Lanzend=F6rfer <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>
> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  .../devicetree/bindings/mmc/sunxi-mmc.txt          |   43 +
>  drivers/mmc/host/Kconfig                           |    7 +
>  drivers/mmc/host/Makefile                          |    2 +
>  drivers/mmc/host/sunxi-mmc.c                       | 1125 ++++++++++++++=
++++++
>  4 files changed, 1177 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
>  create mode 100644 drivers/mmc/host/sunxi-mmc.c
>=20
> diff --git a/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt b/Docume=
ntation/devicetree/bindings/mmc/sunxi-mmc.txt
> new file mode 100644
> index 0000000..f0c06e7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
> @@ -0,0 +1,43 @@
> +* Allwinner sunxi MMC controller
> +
> +The highspeed MMC host controller on Allwinner SoCs provides an interface
> +for MMC, SD and SDIO types of memory cards.
> +
> +Supported maximum speeds are the ones of the eMMC standard 4.5 as well
> +as the speed of SD standard 3.0.
> +Absolute maximum transfer rate is 200MB/s
> +
> +Required properties:
> + - compatible : "allwinner,sun4i-a10-mmc" or "allwinner,sun5i-a13-mmc"
> + - reg : mmc controller base registers
> + - clocks : a list with 2 phandle + clock specifier pairs
> + - clock-names : must contain "ahb" and "mod"

Again, this is not a module0 clock, so the clock name is misleading.

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--r4QXMf6/kyF/FvJJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTXq29AAoJEBx+YmzsjxAgKXgP/0Q0EESI1sm8WVubJROjivAF
c1CDeI46uwi5joZ07akfDt9JEBf/vNdHIXi0ZYrDa2r1f+HJbVT8eULFNzWn0XGq
Q6gg0ENvHEBAV6YaN+ooODsGwb9qhng3/Z9BPq0IFNWJkU7rJ1fDOdbOIu8OSay7
+CDTzER3RRzDsfgdQCIRm21xSwBxPhJ2QnlfXPH5lRdS5FNZB0Wmn5+WsGV4eNa0
usNBGoR0Y5KHoi2PJFvIRSj3M3jAdxTGaD40unoAaRH9kxPjoRMmyDLUHvdghC7c
1vgSLrrI4b1cZoJtd6t/zf7rU2htbuF21qTlIRPnR07+wkzJfaSgLCHSuncVFC1W
Teu6S1mCnc8B6xwVOwVCxeZzYiQjTBCNNwFZrMzVAkdJ/CZhcCJIetyh83Pz1VKZ
Rj4v8cO5DV5sEFfQ3eN1clNWM8AE73aTxFAUJf6ozExLenG5DC8ygIycSG1nXied
u5NGU0McnM1FZlQAMzYxosA4sIkCgJ+rgSBMsPA339pArxJxK8nujWeOH2QZR1Z6
t6Gi2kJyopiTqlSOoZFqN+kw2+KRu53XSXtQZeZ5c3baCt3Q7I68BruZdrK3SLUU
WSygclg9g4Je+DjVZKzn3+7bCiMW+078D+EN2kagmzWGBEZ97FXYjY7+ALh99pd3
OaExmqEwqAJWcP2a2bpW
=5kVj
-----END PGP SIGNATURE-----

--r4QXMf6/kyF/FvJJ--
