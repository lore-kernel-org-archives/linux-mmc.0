From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v3 11/16] mmc: tmio: deprecate
 "toshiba,mmc-wrprotect-disable" DT property
Date: Wed, 7 Feb 2018 20:32:27 +0100
Message-ID: <20180207193227.hu6cyh2e27dmrqwt@ninjato>
References: <1516206496-16612-1-git-send-email-yamada.masahiro@socionext.com>
 <1516206496-16612-12-git-send-email-yamada.masahiro@socionext.com>
 <CAK7LNAQUJw-fjuJO68Kvskn8BRYW3rZj4YMtbo-Oxfv7c=6Ggg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="n64esxgg2ls3up2p"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAK7LNAQUJw-fjuJO68Kvskn8BRYW3rZj4YMtbo-Oxfv7c=6Ggg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
Cc: linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>, Ulf Magnusson <ulfalizer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org


--n64esxgg2ls3up2p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2018 at 10:58:36AM +0900, Masahiro Yamada wrote:
> 2018-01-18 1:28 GMT+09:00 Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>:
> > This property is equivalent to "disable-wp" defined in
> > Documentation/devicetree/bindings/mmc/tmio_mmc.txt
>=20
> This is mistake.
>=20
> "disable-wp" is defined in
>=20
> Documentation/devicetree/bindings/mmc/mmc.txt

With that fixed:

Reviewed-by: Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>


--n64esxgg2ls3up2p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlp7VEoACgkQFA3kzBSg
KbZ2MQ//cTK2L1RNvVTODkTz7P/XIz7dtmszlYSZXMagmYtqh1rW19FRPo40yo89
XL0DNLiXTgN0yEWv6178HBPe4QGASdxxpjIJBH5CT5/uQT2nX8C2VG0d+w82WESO
zwTshuqKfRDYWWFIII6FPu4YZZQT+Nk9pSBvAUR0l9MPrI7uSkrVdOCK/DpK60Jf
bkuXqvo3QmCI76Cz6cBAiF9lAM9d0mIFst247fH3Cvf0IE/elXkWej3elZiOgZVt
orqcdGZDBbCmGFx0OCUItl5o+Zb2wIefAG/lfk3ULPoajNAiHHgvjTKfoxWD7s3d
b1P/WT3Yx3VttVTOvIaUWOV6NXoOehFIVxiuufrzyUIuiM11s2VTHTa1PeyJf/L/
QTrnG67yvOhyKLtrQ4egaxF+NMKySbd3Wl7apAB3yMvz72t2gnrFm86W+WUHy5kY
2VuBxP4iDToRaQ+dqVLq+csnbOG83jf7O2jk3h6M0eIuULhRp+XcyqBfsMkhmaP1
OddjI5LBdU2oIMkVzXxo36JaNKgyWjJgHq1ztJ/nZGfL4KNckHTj0VRJgvftmiwa
vbr4FJ2/jy9H3pva0qLEcTuynk11jA0onZ+4uK2YBIvs3zJbai2YQyBUvVBDfCOJ
gKA5cI3mmZ/Is3zx8pL1L4egtK39eGmGo57oJ/KJpsK3FrgKavI=
=mKCt
-----END PGP SIGNATURE-----

--n64esxgg2ls3up2p--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
