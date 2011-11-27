From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] mmc: convert drivers/mmc/host/* to use
 module_platform_driver()
Date: Sun, 27 Nov 2011 09:58:13 +0100
Message-ID: <20111127085813.GC5263@pengutronix.de>
References: <1322283343.14278.2.camel@phoenix>
 <20111126121953.GA11865@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Izn7cH1Com+I3R9J"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20111126121953.GA11865@oksana.dev.rtsoft.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Anton Vorontsov <cbouatmailru@gmail.com>
Cc: Axel Lin <axel.lin@gmail.com>, linux-kernel@vger.kernel.org, Micha <mirq-linux@rere.qmqm.pl>, David Brown <davidb@codeaurora.org>, Ben Dooks <ben-linux@fluff.org>, Viresh Kumar <viresh.kumar@st.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Ian Molton <ian@mnementh.co.uk>, Sascha Hauer <s.hauer@pengutronix.de>, Grant Likely <grant.likely@secretlab.ca>, Linus Walleij <linus.walleij@linaro.org>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--Izn7cH1Com+I3R9J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 26, 2011 at 04:19:53PM +0400, Anton Vorontsov wrote:
> On Sat, Nov 26, 2011 at 12:55:43PM +0800, Axel Lin wrote:
> > This patch converts the drivers in drivers/mmc/host/* to use the
> > module_platform_driver() macro which makes the code smaller and a bit
> > simpler.

Lost the original mail, but checked the patch using an archive.

Acked-by: Wolfram Sang <w.sang@pengutronix.de>

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--Izn7cH1Com+I3R9J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk7R+6UACgkQD27XaX1/VRvv5QCgnAx2idQPQgU7MLIf+lQIvX1a
Y6oAoKyNMYfZIduxWkKAxZa5e7+IeipD
=LL3t
-----END PGP SIGNATURE-----

--Izn7cH1Com+I3R9J--
