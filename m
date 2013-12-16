From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: Re: [PATCH 1/5] ARM: sunxi: Add driver for SD/MMC
 hosts found on Allwinner sunxi SoCs
Date: Mon, 16 Dec 2013 13:53:06 +0100
Message-ID: <20131216125306.GK3037@lukather>
References: <1387058295-20641-1-git-send-email-hdegoede@redhat.com>
 <1387058295-20641-2-git-send-email-hdegoede@redhat.com>
 <20131215134415.GE3651@lukather>
 <CAOMqctRspBPmNsyXye_gpfwGoZ=gMcCzEjM+hD3g+ZfQix7G6Q@mail.gmail.com>
 <20131216100551.GD3037@lukather>
 <CAOMqctTdasLxJki0xu4aq_sEgujDt3Jdu=BXy9WvQeji282_Rg@mail.gmail.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+HmK7y6O+lKZIGkr"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBJ7QXOKQKGQEJ34RTMI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAOMqctTdasLxJki0xu4aq_sEgujDt3Jdu=BXy9WvQeji282_Rg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, David =?iso-8859-1?Q?Lanzend=F6rfer?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


--+HmK7y6O+lKZIGkr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2013 at 12:59:31PM +0100, Michal Suchanek wrote:
> On 16 December 2013 11:05, Maxime Ripard
> <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> > On Sun, Dec 15, 2013 at 11:01:17PM +0100, Michal Suchanek wrote:
> >> On 15 December 2013 14:44, Maxime Ripard
> >> <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> >> >> --- a/drivers/mmc/host/Kconfig
> >> >> +++ b/drivers/mmc/host/Kconfig
> >> >> @@ -665,3 +665,11 @@ config MMC_REALTEK_PCI
> >> >>       help
> >> >>         Say Y here to include driver code to support SD/MMC card in=
terface
> >> >>         of Realtek PCI-E card reader
> >> >> +
> >> >> +config MMC_SUNXI
> >> >> +     tristate "Allwinner sunxi SD/MMC Host Controller support"
> >> >> +     depends on ARCH_SUNXI
> >> >> +     default y
> >> >
> >> > I'm not that fond of these "default y" patterns. It forces the driver
> >> > down to every user of the multiplatform kernels. I'd suggest removing
> >> > the default and adding the driver to the defconfigs we have.
> >>
> >> And why would you build support for sunxi without building support for
> >> sunxi mmc?
> >
> > Because you can?
>=20
> But does that need to be the default? And is that sane default?
>=20
> >
> > And where am I actually suggesting to do so?
>=20
> Just a few lines above. You suggest it should not be built by default.

No, this is not what I'm saying. I'm saying that this default should
be enforced at the defconfig level, and not at the Kconfig level.

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--+HmK7y6O+lKZIGkr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJSrveyAAoJEBx+YmzsjxAgaRwQAKKM/pzblJzmEEihsRBm918W
X+Ntbatzaeox1JWsnYChf7YM/rgpZpeFMSe7nFQPmSSCCT0fMcarojGPEWdnVU/R
bejwaagYRAGWXa1B2dH7asqomlCOXdVs6GcgjceH55aNdKJ0lPT/V4ez8lbE0Drd
YggaJucXKjwOCQn2Yi6FHrm8KxjhUBfuigpaZjzBIyHV4jslkb23+ANiXdkCL5IJ
Q3MrLGNGvPQOzRwx6fSoTpXTrZleA3CJqpBO+eueJBJP2CNwtIN1aprTFeIl1MAw
8ibrNo03Tm52n7bmM5HVdEVjl5DYAVCWuRqPb0uHmrNha64zJjuBqR4uNUhNh/fV
8Tlx5hJfRtil+ox7LPtgC81CiVArbu59PuiMRemX9fYAnPrxPHI2GGsmUnCl4oz/
NdxB0Tcg05EAiFJ4VwjTbhY9fHrg9rDrqddvEpaL5GYjzFEeGtslj6Y8/GPEtKjp
BzVchPsZN0kyZpgjGrtYUVl8DHkAMTsfuXHailR3I+9G+QYOx0vGXXaVmGaYt2dH
MWvrH937n8uTJgl9mWfI6OsZ3171RoxDsaq9p2zrpkX2xXs/OMz7jWImaU3+cV4W
QjhOp9qS9YESy2ZNGLs+LMIPQ+buq3Ac0SWu/unW1m+munD4yTqngFi/lXV7tp6p
StdhQzQJCuK0RzAvUL1/
=7Hvp
-----END PGP SIGNATURE-----

--+HmK7y6O+lKZIGkr--
