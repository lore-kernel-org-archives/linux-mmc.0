From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 05/46] ARM: pxa: split up mach/hardware.h
Date: Tue, 22 Oct 2019 17:36:13 +0100
Message-ID: <20191022163613.GL5554@sirena.co.uk>
References: <20191018154052.1276506-1-arnd@arndb.de>
 <20191018154201.1276638-5-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1406154586=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20191018154201.1276638-5-arnd@arndb.de>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-usb@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Dominik Brodowski <linux@dominikbrodowski.net>, linux-mtd@lists.infradead.org, Pavel Machek <pavel@ucw.cz>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-clk@vger.kernel.org, linux-leds@vger.kernel.org, linux-rtc@vger.kernel.org, linux-input@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>, Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org, alsa-devel@alsa-project.org, linux-pm@vger.kernel.org, Haojian Zhuang <haojian.zhuang@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, linux-fbdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Stephen Boyd <sboyd@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, dri-devel@lists.freedesktop.org, Dmitry Torokhov <dmitry.to>
List-Id: linux-mmc@vger.kernel.org


--===============1406154586==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cy9Nn4fUvYST66Pl"
Content-Disposition: inline


--cy9Nn4fUvYST66Pl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 18, 2019 at 05:41:20PM +0200, Arnd Bergmann wrote:
> The mach/hardware.h is included in lots of places, and it provides
> three different things on pxa:

Acked-by: Mark Brown <broonie@kernel.org>

--cy9Nn4fUvYST66Pl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2vL/wACgkQJNaLcl1U
h9A46Qf/bdiNYPmWVC2CHNC1L2OLkyJ66QpIcTPyD+TqK5kJogwOBaO1gXSF9Zzl
FrZ20C2apP/oPsDhXu0l5d3giQifXBNvev/89QnOX2UBhrtJV9qE4LHll1hjeyKZ
BEGejSMZnKNLyUDKEbrGg/LeAlDx8G1odI34QfZvmSJVBKinRssnwpnH7UNZhU9s
9SvLSPJjxoWD6gDsShV0vYuFkd6XQ68qOna4lj6KknkkAE9jIpQb+fFBVqYNKNgp
Ttp0KkT/l1DAlDx4lMDfWkr/8u3807G0HTJ6xYcjeyd7e40utLqPnFLeQpMS+RGb
96bq1ZoL9nd8PdzO8lOK09fB0kB8Mg==
=tCNh
-----END PGP SIGNATURE-----

--cy9Nn4fUvYST66Pl--

--===============1406154586==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs

--===============1406154586==--
