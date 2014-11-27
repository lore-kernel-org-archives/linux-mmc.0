From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: davinci-evm: Do not include edma
	headers
Date: Thu, 27 Nov 2014 10:58:15 +0000
Message-ID: <20141127105815.GE7712@sirena.org.uk>
References: <1417084891-17990-1-git-send-email-peter.ujfalusi@ti.com>
 <1417084891-17990-2-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5591616059259594004=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1417084891-17990-2-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, arnd@arndb.de, vinod.koul@intel.com, linux-mmc@vger.kernel.org, nsekhar@ti.com, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, khilman@deeprootsystems.com, Tony Lindgren <tony@atomide.com>, chris@printf.net, dmaengine@vger.kernel.org, ulf.hansson@linaro.org, linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org


--===============5591616059259594004==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PcDVawgyoD+Fem/v"
Content-Disposition: inline


--PcDVawgyoD+Fem/v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2014 at 12:41:29PM +0200, Peter Ujfalusi wrote:
> The machine driver has no business with the underlying dma.
>=20
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Acked-by: Mark Brown <broonie@kernel.org>

--PcDVawgyoD+Fem/v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUdwPGAAoJECTWi3JdVIfQ7MAH/RnpLGoXRwTP9XeiV2TTbYT5
tJZBqFx5ZrFhdJICHzRhGTMnbKKEcYZ+zjVIs5ln6jEgn/YhOxAfR1lfwNUs9T+/
m3RZqF1ZBHPHWP+dLSwXSsdzZNxSO1G+4sx/+GtmXMeUZLODJb9ZJguMSDd7I+f7
jYH41qW9Y5/z7yp3Oo0Jx2BDwQZA0KmJ0jffN7XGmXMd+/fHUWFLknujfeq1XPkD
VDMElbg3PMqLKYLXNE1yCfP3jb/Sn50DEyyiotRFNU5pyU2vp+0nmIeygtRsukmE
RPdeQI6UAn/Wdj6PBVVhx7DbvVOjdIkwfdopP47RQolnFtf44Q9wmMtJwCaqNVM=
=fVaF
-----END PGP SIGNATURE-----

--PcDVawgyoD+Fem/v--

--===============5591616059259594004==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5591616059259594004==--
