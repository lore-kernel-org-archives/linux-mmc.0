From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] mmc: omap_hsmmc: Get rid of of_have_populated_dt() usage
Date: Wed, 11 Apr 2012 13:26:33 +0300
Message-ID: <20120411102632.GY12064@arwen.pp.htv.fi>
References: <1334138593-9692-1-git-send-email-rnayak@ti.com>
 <20120411100956.GT12064@arwen.pp.htv.fi>
 <4F855BDC.9070103@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="c6YcJYqqMhegfX14"
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4F855BDC.9070103@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: balbi@ti.com, cjb@laptop.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, b-cousson@ti.com, Balaji TK <balajitk@ti.com>, Rob Herring <rob.herring@calxeda.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
List-Id: linux-mmc@vger.kernel.org


--c6YcJYqqMhegfX14
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 11, 2012 at 03:54:28PM +0530, Rajendra Nayak wrote:
> On Wednesday 11 April 2012 03:39 PM, Felipe Balbi wrote:
> >On Wed, Apr 11, 2012 at 03:33:13PM +0530, Rajendra Nayak wrote:
> >>@@ -1564,7 +1564,7 @@ static void omap_hsmmc_set_ios(struct mmc_host *m=
mc, struct mmc_ios *ios)
> >>  			 * can't be allowed when booting with device
> >>  			 * tree.
> >>  			 */
> >>-			(!of_have_populated_dt())) {
> >>+			!host->dev->of_node) {
> >
> >won't compile
> >
> why? compiles fine for me.

aren't you missing the opening parenthesis ? Or is there a something not
shown in the context ?

--=20
balbi

--c6YcJYqqMhegfX14
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPhVxYAAoJEIaOsuA1yqRE2wkP/2aMmXwlmR8+I6bX3ix9PpdK
2aAy4jyQ2UMycHNUXkKj2YDyOpqAQdhSQN5Iy13o09OSC1/oFlvJsZgiZAClv6zU
6AxsLqRf6IYVNXRVVKtB/gXXUjVwANCRg/R5ulTs+QmIAH80WueRH+vCI1jHGJSE
SPDgPnrdEYszBnmGlM9XLeXA849QrUkAdFgtUaBWt0ak6qy4PrjS2/S6+YtZLvwl
9JU03uKfqqFOWsBD+Wswdg8ssAz9RAwrwKWW40bYmGEP7Ct14mZJq7C1IA71Hdk5
laoQMBFWIJMjE+3O5BQyzBOehOsJmYJX4NXDLvKhDAm763ITqQ7ltldKoS0iQi1M
FAX1/Em08x2aZxpOPza45M6BhdutKE4kvmWt5POgWWERDlOn9chBRk5PaPH2XFsw
i/cA7w7QjUmx0mtY8WnUhUfmExgipFbn3bUcngMQz9xnsspfQy9FDrNL04W92KCz
rOSYd3RP35RmJ+4TJAs2wrrFFEunP0NbbRvRD02Z87K/ZOJIDoxNGx+gvjl9timI
cw80OtsE8LZNpLPv6KdMaT5bEw6Crih0Tj8W4P8kWj51H3f7Th5Q7VBkNE90KRdb
RDsbTDXigh4fKk2BhIFtMPMa4qGISlSxgEKdkZndBYm6dZV6KCEkf+i2WQYFQUGK
bhcjmOniJR2wkCZMNuLb
=h4wZ
-----END PGP SIGNATURE-----

--c6YcJYqqMhegfX14--
