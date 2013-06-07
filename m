From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] mmc: dw_mmc: Handle late vmmc regulator with
 EPROBE_DEFER
Date: Fri, 7 Jun 2013 11:24:04 +0100
Message-ID: <20130607102404.GO31367@sirena.org.uk>
References: <1370580406-10254-1-git-send-email-dianders@chromium.org>
 <1664692.GUOAAQ3FLn@flatron>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5163217904812608901=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1664692.GUOAAQ3FLn@flatron>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Will Newton <will.newton-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Seungwon Jeon <tgih.jun-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Abhilash Kesavan <a.kesavan-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Alim Akhtar <alim.akhtar-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org


--===============5163217904812608901==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DT/miTrKQuDYoJpq"
Content-Disposition: inline


--DT/miTrKQuDYoJpq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 07, 2013 at 12:19:58PM +0200, Tomasz Figa wrote:
> On Thursday 06 of June 2013 21:46:45 Doug Anderson wrote:

> > dw_mmc is probed.  This regulator is optional, though a warning will
> > be printed if it's missing.  The fact that the regulator is optional
> > means that (at the moment) it's not possible to use a regulator that
> > probes _after_ dw_mmc.

> > Fix this limitation by adding the ability to make vmmc required.  If a
> > vmmc-supply is specified in the device tree we'll assume that vmmc is
> > required.

> This interesting case makes me think that regulator core should=20
> differentiate between regulator lookup failure due to no lookup specified=
=20
> and due to the regulator specified in lookup being unavailable, returning=
=20
> appropriate (different) error codes.

It does exactly that in so far as it can - you get -ENODEV if there's
definitely no supply and -EPROBE_DEFER otherwise.

--DT/miTrKQuDYoJpq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRsbTAAAoJELSic+t+oim98CMQAI+zyImtt0r0OTvU74sprUb9
FZzN60D2+GUgf8v72Nzz7YTiDbTDUsehEI/FapNdxNA8HHgF8aDq63uIHgdtyuSA
ThmNYWRRh1oacjzOXDFpl8JfWKm0EwTuTScOV8trBBbbfgTUlcf4+AYwyTF79fV3
u6l5ijYFQFdmATuOgPDKqSTMzX6eFVynf1kn2nviMn23ksbwFnGqyKXoloRfEW+n
IRQLWasm0eH0dH5XiVeNpyQfHqnTxgybQVrEAD/kjKy8VE6L9vOgWYYE7Yljpa2d
8vO2wnoabGDCUvPyxW866p29VkQ20/xVBpoSu61U6dwaSh81OiGp7rjfZorUcgxy
puANtbD9AtOElrM/lv0kVinf5vsNhQaUI5ND0/57WHQDq/DbJ+ceoGimjE371K0x
jhIVYd9rv7nALSdxI8sQeIpEgkOBeX83pKsJO+VPijOw9r56PgUeW03Dkz4WcpCh
eO7tMUYgYAEF6hx/xGKSiUcD4EIiRoKMd5nn5yV5nmV2j4ja5kosSUHMiDBSwolS
DTIj8bu0m4ztrr9R43TJuNbvXBPzptZP8qg3ZuwAwv/s9xEHCJaDEUJa+bFj4G55
khTa9eOko95+PeaNi8dFYxn0Cr9aws62i2vg+tGypEtYgHb5rj0RwTSPEpXfuvQf
GFsAuQ+/wyjgD9G6gcMN
=36I0
-----END PGP SIGNATURE-----

--DT/miTrKQuDYoJpq--

--===============5163217904812608901==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============5163217904812608901==--
