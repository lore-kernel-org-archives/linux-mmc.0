From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] regulator: core: Ensure we are at least in bounds
 for our constraints
Date: Tue, 29 Mar 2016 07:58:23 -0700
Message-ID: <20160329145823.GK2350@sirena.org.uk>
References: <1458587912-32665-1-git-send-email-broonie@kernel.org>
 <1458587912-32665-2-git-send-email-broonie@kernel.org>
 <56F0624C.8010004@gmail.com>
 <CAJKOXPd5h0Cq++OxdiXytNJH94PN4Kh_wM3M=p3JdU1m_qyFTA@mail.gmail.com>
 <CAJKOXPcBOT_8NOH-=sEHSP0Rc+=Dvz-aqVTsBTMKg-VNWqQotw@mail.gmail.com>
 <CAJAp7OgGQ3qm-_QhydvN0n6QeNoHFdso4zOk41qvVJhKNeRn8Q@mail.gmail.com>
 <20160327090859.GH5028@sirena.org.uk>
 <CAMuHMdXuy2TxACTcsgOpZvrJEeTSQbCgCUmS9PXfBhhZfgbBBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cN0A5YokcrYPGsSB"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdXuy2TxACTcsgOpZvrJEeTSQbCgCUmS9PXfBhhZfgbBBA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Bjorn Andersson <bjorn@kryo.se>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-renesas-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--cN0A5YokcrYPGsSB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 29, 2016 at 02:00:52PM +0200, Geert Uytterhoeven wrote:
> On Sun, Mar 27, 2016 at 11:08 AM, Mark Brown <broonie@kernel.org> wrote:

> > The existing check in the patch should be an || not an ==, or possibly
> > we should just not bother looking for min_uV at all.  I just pushed out
> > a version of that, let's see how that goes.

> Has the fix really been pushed out?

Yes.

> WARNING: CPU: 1 PID: 31 at drivers/regulator/core.c:2223
> _regulator_disable+0x2c/0x128
> unbalanced disables for SDHI0 VccQ

> when booting on r8a7791/koelsch.

This seems like a bug somewhere else in your code, we're looking at
changes in the voltage setting code but this is an unbalanced disable.

> I'm a bit confused by the discussion of "&&" vs. "||" vs. "==", but the
> warnings do go away when using "!=", cfr. the whitespace-damaged patch below.

>         /* Voltage change possible? */
> -       if (constraints->min_uV && constraints->max_uV) {
> +       if (constraints->min_uV != constraints->max_uV) {

Do you have constraints that specify a maximum voltage but no minimum
(which I'd say are broken), or constraints that are just plain wrong but
are now being applied like specifying the entire range of the regulator?
The above might be some follow on error handling from something that
happened the change in handling of the constraints.  You need to look at
what the relevant regulator constraints are...

Previously both voltages needed to be non-zero and equal for anything to
happen, now they only need to both be non-zero.

--cN0A5YokcrYPGsSB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW+pgMAAoJECTWi3JdVIfQCucH/1/USTGFrgDo9MmHSTdjircd
2/eqh3nsosSxmmlgjURnNI30aTA+GnRt4RQKudT4FrlYdKfTjLwi3pIBG+ErOHHq
wD8C0Zt6JKfb68Ghzgsf63kM7wHwL6VCBVOFxP55KzYAhtiAnb0Dsu10c/coeNNM
aaSqhy31/0MoU0p4f/OF+9h8NqR84nWS7qnJcTNS20FHV5iVhs75X3Q1csTfetoT
PuVvJ260fDrfsf778Ex9+To0CHkaKJYfcmCKfvNev869C4RGwBDfHHqey2XmlIUW
+CH7aj13KOJLxwvvF+Bj4Y+l3wJ4WWSb+y5dnTFZHQfGQz+oTIobckSl0we0NYs=
=hoVL
-----END PGP SIGNATURE-----

--cN0A5YokcrYPGsSB--
