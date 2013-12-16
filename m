From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: Re: [PATCH 1/5] ARM: sunxi: Add driver for SD/MMC
 hosts found on Allwinner sunxi SoCs
Date: Mon, 16 Dec 2013 11:05:51 +0100
Message-ID: <20131216100551.GD3037@lukather>
References: <1387058295-20641-1-git-send-email-hdegoede@redhat.com>
 <1387058295-20641-2-git-send-email-hdegoede@redhat.com>
 <20131215134415.GE3651@lukather>
 <CAOMqctRspBPmNsyXye_gpfwGoZ=gMcCzEjM+hD3g+ZfQix7G6Q@mail.gmail.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VV4b6MQE+OnNyhkM"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRB6VCXOKQKGQEJ2TI5NY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAOMqctRspBPmNsyXye_gpfwGoZ=gMcCzEjM+hD3g+ZfQix7G6Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, David =?iso-8859-1?Q?Lanzend=F6rfer?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


--VV4b6MQE+OnNyhkM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 15, 2013 at 11:01:17PM +0100, Michal Suchanek wrote:
> On 15 December 2013 14:44, Maxime Ripard
> <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> >> --- a/drivers/mmc/host/Kconfig
> >> +++ b/drivers/mmc/host/Kconfig
> >> @@ -665,3 +665,11 @@ config MMC_REALTEK_PCI
> >>       help
> >>         Say Y here to include driver code to support SD/MMC card inter=
face
> >>         of Realtek PCI-E card reader
> >> +
> >> +config MMC_SUNXI
> >> +     tristate "Allwinner sunxi SD/MMC Host Controller support"
> >> +     depends on ARCH_SUNXI
> >> +     default y
> >
> > I'm not that fond of these "default y" patterns. It forces the driver
> > down to every user of the multiplatform kernels. I'd suggest removing
> > the default and adding the driver to the defconfigs we have.
>=20
> And why would you build support for sunxi without building support for
> sunxi mmc?

Because you can?

And where am I actually suggesting to do so?

> Like 90%+ sunxi devices actually have a SD slot or an eMMC or a SDIO
> card connected so what's the point of supporting sunxi without sunxi
> mmc?

And does your assumption still stand if you take into account all the
other ARM boards?

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--VV4b6MQE+OnNyhkM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJSrtB/AAoJEBx+YmzsjxAgWdUP/jBtbfyr3jKpfTu2i3Siis+l
GUztVtwYR8YwABongvJ5KbimwwyhT4Hd6VDsXaFRECDhfFqEymQQEjooswvhd8ZT
PoykxSfNvfFibIUQ9Z0rGfrHBseZVrqwDfmhvIUVznNtfqEbEpVwtiaVJEY61Tgs
RExuaz7nwMIYZFnhe/npyGmEf9iv8a6C6vywBzbgOcRU/VHv7ZccMB/9jKOBLvZJ
uuQ12mNlQHC82DQ7Mgu4/KQUDtLZMwRzumHQRXNSC7jAv5cQH/vizjNHst2IA6T2
Te8EfWkcUSjbEw0GJCucogBym3EOFc8bNxyv/tIPKVwVTIgsdj7UEon4mDxNpVyt
ZlthAyirdqtoD3JqaYglogAYca3AAIMsIv0hkUMoiwJwt2Pmn3pkuXzSWumKRMH8
5q5g7NIcFAgtKVi61b+75gA/OAiM5VaBOYz2HsyjlG4t2ODnyNhr5OduRkRZKYsg
SuXPpNz3PdOq5zJsASMc/pzPmyf8RZYL8Gv07UOQ4V6atQq6An6jGAWQJ3+QeQlV
pdJEc+22DuuGKRnQcda8gPcNUY3u45Q9QkL7dHOARQW3XIN9etQgVSix8//LPWMu
QvfUZV8kCJzjB6TSzIGR/ksWf+fQotYtTS5nZ7q7mycsiYEDON2vi78fZQTB/0Cg
3edb2jI59sX/Cxz1d2UA
=zUru
-----END PGP SIGNATURE-----

--VV4b6MQE+OnNyhkM--
