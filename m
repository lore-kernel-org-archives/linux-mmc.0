From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: Re: [PATCH 1/2] ARM: dts: tegra: fix the activate polarity of
 cd-gpio in mmc host
Date: Thu, 21 Feb 2013 09:18:09 +0100
Message-ID: <20130221081809.GB7718@avionic-0098.mockup.avionic-design.de>
References: <1361343902-15223-1-git-send-email-josephl@nvidia.com>
 <1361343902-15223-2-git-send-email-josephl@nvidia.com>
 <512500EB.1070802@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="A6N2fC+uXW/VQSAv"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <512500EB.1070802-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Joseph Lo <josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Lucas Stach <dev-8ppwABl0HbeELgA04lAiVw@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


--A6N2fC+uXW/VQSAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 20, 2013 at 09:59:23AM -0700, Stephen Warren wrote:
> On 02/20/2013 12:05 AM, Joseph Lo wrote:
> > The GPIO pin of SD slot card detection should active low.
>=20
> Thierry, Lucas, can you please check if the same change should be made
> to all the Avionic Design and Toradex boards? I assume MMC CD should be
> active low on all of them. Once you've confirmed this, Joseph can respin
> this first patch, and perhaps we can get it into 3.9/stable as a
> bug-fix. Thanks.

The card-detect GPIO is certainly low-active on Tamonten. I'm not quite
sure why things worked before, but I guess it was due to the MMC core
assuming the CD GPIO to be low-active unless otherwise specified and the
Tegra DT code didn't pass the GPIO flags to the core.

Anyway, I've verified that on Tamonten the same change doesn't break
anything, card detect still works as expected with this patch series
applied, so if Joseph could carry the Tamonten change as part of this
patch it'd be great.

Thierry

--A6N2fC+uXW/VQSAv
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRJdhBAAoJEN0jrNd/PrOhUY8P/jGjaFnQvFHAgEwyoQVldtae
5zRPtoqKbSTkoRdiBbhDBf3ahZetY8MHeewHWmjHfPCsOc79+WDkxGE95ZXH7sML
UDsucTb4xm1jE1yjYR5YYHYSGaPl/oDwCUIvmtNtS2eS2DWV5nO07+O8D2luJHvf
vlfZaDO8SpPf2+LoYIyBwN1TtNgn9WwlHLPIE0gH/16lL7kE4ee1F5cg2ZLCzUmS
SHaRBdex4o/aTpqAyIXqLKi7fnt2CoIo9mvYWMLI6XWZ45g+97hqEd4QJZ11eCIk
hMfr+hm5W86aFyc7G/nI5gTr0Rcii4tMYWpeG+0kX84m258B9StHSIFImAz61zNU
MoofnKFIzsJv6KrB/LmBLUvkLbeT5DBAAwQwJU5zWzcCDgyVvdjVzlQQIh/CMPon
6z35yls1CiUfjUBGPFk5kyyGEIFGLNamOidh92DXpKHg4FvS3jkD5EJwgpeh/9fx
98133Jtu86s2jlYyeQ+NHEOO0RUYoi7cpV4nWgozLR1D1gKJmB03b7pJpydhQK+C
c5XUSv+XDUATaYuP5sMy0DJj2UxgWOs46DWdNc2WyilskvCQsXi7UVU0eAvzdiBx
sLLGOrwGfDpqFCS6geZa19AYuXj1o69JLWU6NEODkIFNV371UR6IoH+u19G2PsyO
+097Mq5jj5YCXVpgNJ7h
=HYG1
-----END PGP SIGNATURE-----

--A6N2fC+uXW/VQSAv--
