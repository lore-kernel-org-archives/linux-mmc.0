From: Felipe Balbi <balbi@ti.com>
Subject: Re: Regression for non-eMMC cards with commit fa550189?
Date: Tue, 29 May 2012 15:50:26 +0300
Message-ID: <20120529125024.GM9577@arwen.pp.htv.fi>
References: <20120528132147.GC12766@atomide.com>
 <CAPDyKFrcviT3_Fz13LpFJ+1oKxQ5LKswN7EmzVcWTJkiiDWusA@mail.gmail.com>
 <20120529074047.GE16340@arwen.pp.htv.fi>
 <20120529124732.GD12766@atomide.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2O+9B+xSKalj/wdD"
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120529124732.GD12766@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org


--2O+9B+xSKalj/wdD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, May 29, 2012 at 05:47:32AM -0700, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [120529 00:46]:
> >=20
> > Can you enable debugging on menelaus so we see what the driver is doing=
 ?
> >=20
> > I believe that to change the VMMC's supply voltage you need to turn off
> > the regulator, meaning LDO_CTRL7[1:0] =3D 0b00.
>=20
> Looks like it's some kind of race between the slots that now gets trigger=
ed
> in the omap driver.
>=20
> Commenting out the second slot in the board file fixes things. I tried ad=
ding
> a mutex to protect the sequence between POWER_UP and POWER_ON, but no luc=
k yet.
>=20
> Also adding printk statements here and there makes it work again.

does this help ?

diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n=
8x0.c
index 518091c..5a224fc 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -397,8 +397,8 @@ static int n8x0_mmc_late_init(struct device *dev)
 	if (r < 0)
 		return r;
=20
-	n8x0_mmc_set_power(dev, 0, MMC_POWER_ON, 16); /* MMC_VDD_28_29 */
-	n8x0_mmc_set_power(dev, 1, MMC_POWER_ON, 16);
+//	n8x0_mmc_set_power(dev, 0, MMC_POWER_ON, 16); /* MMC_VDD_28_29 */
+//	n8x0_mmc_set_power(dev, 1, MMC_POWER_ON, 16);
=20
 	r =3D menelaus_set_mmc_slot(1, 1, 0, 1);
 	if (r < 0)

--=20
balbi

--2O+9B+xSKalj/wdD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPxMYQAAoJEIaOsuA1yqREVNkP/2ZMX+NJspHHgSCupPknHv8E
F+WN8Qa/XEY4GvWmxKyaQc0YtjcIOBCC0lrxO5ceOTbPZtuQwaXE/s+1jV/oJ3Rv
rUY2Y2ZSXQyqyyJxKIqDB5lEDTKIe5tlwmUrVXFd5mD6M15fwu/3bQZXk1qeeiVX
N9OCytTWX0kt3PDdsaDBCuo4XWJmcOOUx3khIg0GnCMiS45HcEg03x2YISq8ORa9
IQDn5zW0oeCqqSQdipbt+vZOzaq0VHqTpZcgZR92lo5+bwFZ5M5EShWabmOqFThD
W9I6FhcJQ1+Aq4tNY4eVSK6tUprXjhE9IWPqI5BBbaNXSXYvYe9BteWJF/5zf15C
Tup4ltvZRV1KkwXhQXMLrDeaiASsMPhpicxSzeJ5wsi+cSXttj3r5Rk5qIZrJfbN
BvY5UxIS/VwZDx20QtJ642tJoNoOpCRKNU2GCQzB/Ti5RYqIPc7Xb+ZLT+9uLMyf
DtbSXE8vyDljzQHdClMB4UuMsWSHS2Z4/NaH2DXFstL9QzKr8Lp9VXBKSWN7otsZ
zENhLNyeXrc3NdyKXqVAMPnqRFtB/f8fx1UN85cyI/RPlR/9Xoc2Fl6FfJWrKHlK
e/cXXEby94qlh20qBu6trqaggr3avmcsJFRD/We/yRYPW/c9T/k0GrSU3q+PCiUw
3VG7puGZd5fwBs8+OdcQ
=qq9J
-----END PGP SIGNATURE-----

--2O+9B+xSKalj/wdD--
