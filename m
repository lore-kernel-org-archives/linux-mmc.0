From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH] mmc: sunxi: Clarify new timing mode usage and
 implementation
Date: Fri, 7 Sep 2018 10:14:49 +0200
Message-ID: <20180907081449.roowspmgmtd5zcs6@flea>
References: <20180906153107.20225-1-wens@csie.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1824519697787138667=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180906153107.20225-1-wens@csie.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org


--===============1824519697787138667==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="srsd3wpsq32tfxwc"
Content-Disposition: inline


--srsd3wpsq32tfxwc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 06, 2018 at 11:31:07PM +0800, Chen-Yu Tsai wrote:
> Newer sunxi mmc controller variants support what they call the "new
> timing mode". Support for this was implemented in two ways, according
> to the hardware that was seen at the time.
>=20
> The first type retained the old timing mode, and both the clock and mmc
> controllers had switches to select which mode was used. Both switches
> had to be set to the same setting. This variant was denoted with the
> .has_timings_switch field in the sunxi_mmc_cfg structure. This hardware
> is only seen on the A83T.
>=20
> The second type did away with the old timing mode. The clock controller
> no longer had the mode selection or clock delay setting bits. In some
> cases the mmc controller retained its mode selection bit, but this
> always needed to be set to the new mode, or instabilities would occur.
> In a few cases, such as the A64 and H6 eMMC controller, the mode
> selection bit is gone, but the controller still behaves like the new
> timing mode, requiring the module clock to be double the card clock
> in DDR transfer modes. This variant is denoted with the
> .needs_new_timings field.
>=20
> This patch adds more comments explaining the two fields, as well as
> the possibly nonexistent mode switch in the mmc controller.
>=20
> The .has_timings_switch is renamed to .ccu_has_timings_switch to clarify
> its meaning.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--srsd3wpsq32tfxwc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluSM3kACgkQ0rTAlCFN
r3STCg//f+NQ1qe11RRvj+GCjJZep2gCjhJolyMWzsZAGJkqGA2UX0xAP/OO/zNA
xnP+yrjNod1Wx+1pG3bdVV79gvaHcduZSoSFLUBWJQ4SyUEgMBkOGY0nsVTe+wso
ATk8q7IhIngo234fo+S8gUbDeKx+p/VHK1lKmOGffL6wGotUSLdo7bUYSlDnWYfm
ah2tsxV5lpYFgDZsrc068F/EDEagWPV++iDe7m20VgNfekgS9EQDIMMK57uLIajo
30JrC37FQQpa84E8DvI7yelw3jBmCXUi4LvxGTDfbGgXwTanKkqsWd+0pxFaMlu2
x4fL9U+oGI7eht5J64WzdQ9mRiCfO4NoWyw2jgKmZ09qIKGxTuvpvrbezOdui/JN
gcuYy2On6MDJpil97+a3JrLo24rNptUQFNl1ldNU558zILTfYe8KRHZZYK/2SSaZ
y7te0CnTlCHWU7FXw6Jt2+DlTAI2g5PMCKbp90sWr3GyCNZnmXope8GdUOsGvYhH
rAYZ+C3XxHrWpB++J6D5svkWWSAI89XTDc0rvL7D0o+qQhFu0heo0I+L3R2uU5QE
eaU9ltpVTqHwVGUWO8QMStVS7FAB8upB+cnoJmnDuvtTegZB01P/l1h1c3qD14vD
IKa3nuODThDDbAe8YV4ZAsvYepixf9J2UJZpdejRZCR7mm06NRs=
=HkjY
-----END PGP SIGNATURE-----

--srsd3wpsq32tfxwc--


--===============1824519697787138667==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1824519697787138667==--
