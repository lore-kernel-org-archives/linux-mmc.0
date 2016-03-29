From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] regulator: core: Ensure we are at least in bounds
 for our constraints
Date: Tue, 29 Mar 2016 11:27:25 -0700
Message-ID: <20160329182725.GD2350@sirena.org.uk>
References: <1458587912-32665-1-git-send-email-broonie@kernel.org>
 <1458587912-32665-2-git-send-email-broonie@kernel.org>
 <56F0624C.8010004@gmail.com>
 <CAJKOXPd5h0Cq++OxdiXytNJH94PN4Kh_wM3M=p3JdU1m_qyFTA@mail.gmail.com>
 <CAJKOXPcBOT_8NOH-=sEHSP0Rc+=Dvz-aqVTsBTMKg-VNWqQotw@mail.gmail.com>
 <CAJAp7OgGQ3qm-_QhydvN0n6QeNoHFdso4zOk41qvVJhKNeRn8Q@mail.gmail.com>
 <20160327090859.GH5028@sirena.org.uk>
 <CAMuHMdXuy2TxACTcsgOpZvrJEeTSQbCgCUmS9PXfBhhZfgbBBA@mail.gmail.com>
 <20160329145823.GK2350@sirena.org.uk>
 <CAMuHMdXx_=LzH7w+9u=o3WZ-qVPqMA2LDCeanvdGs-ywXRCy_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7QsOHKuLbhbLTwLB"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdXx_=LzH7w+9u=o3WZ-qVPqMA2LDCeanvdGs-ywXRCy_A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Bjorn Andersson <bjorn@kryo.se>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-renesas-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--7QsOHKuLbhbLTwLB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 29, 2016 at 08:05:34PM +0200, Geert Uytterhoeven wrote:

>         sh_mobile_sdhi ee100000.sd: Got WP GPIO
> ======> sh_mobile_sdhi ee100000.sd: could not set regulator OCR (-22)
>         gpio_rcar e6055400.gpio: sense irq = 6, type = 3
>         sh_mobile_sdhi ee100000.sd: mmc0 base at 0xee100000 clock rate 97 MHz

> The line marked with the arrow is introduced by the changed check, and looks
> to be the origin of the failure.

This isn't making any sense.  Why would a change in how we apply voltage
constraints on initial probe of the regulator have an impact here?  The
changed code shouldn't even be executing at the point where the SDHCI
driver is trying to use the regulator.  There's something else going on
here.

--7QsOHKuLbhbLTwLB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW+skLAAoJECTWi3JdVIfQ3GcH/1d/JVUnb6U4nra2rhLzVTiF
UPwWSW9pkuSrDgS0R5TZsK2Mylgq91/NOj3nVbxHg58VVSyTZL0i6QqN4YypfHpa
4hN4/A8e0vRX+s2SXKM8lg2c0NlPEaAbPHLg+xm4lp3ZfZwprIEYmPCII732J88O
Y6NfIM/WbKF27PsdIYjEuclevciBma5jCt4NMNpvFLX3jZO2UKU0ph0A5dcOtpkD
BKQFvJ8nagSt9o8IiWPRVF2sdQnAgQCR/EnrXqZXlebM6JFjCb3UuHVwzm9Y9ITA
8PbCwSn6KagpIjv0ipLfW9E2gPQJ0qvPV01weyWSTlAyBx1e0CvKMHqJ8iBbQdc=
=Wh6y
-----END PGP SIGNATURE-----

--7QsOHKuLbhbLTwLB--
