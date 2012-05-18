From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 06/29] regulator: export a function to check if regulator
 can change status
Date: Fri, 18 May 2012 16:08:58 +0100
Message-ID: <20120518150858.GB4039@opensource.wolfsonmicro.com>
References: <1336057558-11031-1-git-send-email-g.liakhovetski@gmx.de>
 <1336057558-11031-7-git-send-email-g.liakhovetski@gmx.de>
 <20120503152558.GL3955@opensource.wolfsonmicro.com>
 <Pine.LNX.4.64.1205181030550.23140@axis700.grange>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WYTEVAkct0FjGQmd"
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1205181030550.23140@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--WYTEVAkct0FjGQmd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 18, 2012 at 10:33:42AM +0200, Guennadi Liakhovetski wrote:
> On Thu, 3 May 2012, Mark Brown wrote:

> > Bear in mind that the regulator may be shared by other users so even if
> > the regulator is flagged as potentially being able to change status that
> > doesn't mean that it actually can change status.

> Yes, I think, that's ok. We just need to know, that the card can in=20
> principle be powered off. We don't need a guarantee, that we can power it=
=20
> down at any time, when we think we need it.

Well, in that case what's the benefit in not just unconditionally
claiming that you can power off and doing runtime PM on the card?

--WYTEVAkct0FjGQmd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPtmYEAAoJEBus8iNuMP3d0bAP/2x/c6P1gzk7JuT1jgG/C+Rf
a8+illx2abROcA8NK2t9wZu/dobqv8vSpQUxl1400sDJ69gm7dufsbF+tb9MXhuI
jPx0ZGkCSghX/JuVaWyDL9qZ+rxHVOr6wtVs7mN5IAICkUCX2Gz5v8bG+0NIFrDT
e3KA8+fWbImCb9XWhnlykXs6NWodel8WXbq/Vh+B0rezhMU3w2WOqU8uJHPRGWab
0lpuXUEX3uKLxumNVdiHhpMo049Qi6qb9Vwctu5C12HmYWXUHq+25GqLvFftnCNN
vjhH7SpPhhH2pjA3K55PjdwNTafWdQ0vLfCSpzlMDier/ahTPVHuF6XOyrcdduuG
2j6iywBG4wagUaYK/E+jyyQvGUh9DWSE00luF8wDoKqmmkUojdneoAxZLh4diMXa
sEkyfmdUMnYB1CkHvhgOu+bXy7ls5Tk0ygt23DeeG+aWjIQUBCi8kh3gQMVxnDUi
/DOOvTt6k+5/KNA9sFMGiHzRHeCQflo+A2A92NsmeA14DhyZKeEWrn6N6vaNW56Q
5+HDSruibCixePURW8cXx2pfmfzXi5aAIEpMpwyVvXQmG9IK7nSdFRkHhLY/6BFM
bVDkNLZQp5F8q0/EoBY8GHZhF16l8Ywzj3vbSMnCI2ZDSWfsD1h/sU2ZoXdtkkyR
dc9Sqzw7iyscGiKROncw
=Zzlb
-----END PGP SIGNATURE-----

--WYTEVAkct0FjGQmd--
