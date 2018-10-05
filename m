From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] block: BFQ default for single queue devices
Date: Fri, 5 Oct 2018 10:04:57 +0200
Message-ID: <20181005080457.GB14466@amd>
References: <20181002124329.21248-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7745100349515429450=="
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20181002124329.21248-1-linus.walleij@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Jens Axboe <axboe@kernel.dk>, Ulf Hansson <ulf.hansson@linaro.org>, Paolo Valente <paolo.valente@linaro.org>, Artem Bityutskiy <dedekind1@gmail.com>, Richard Weinberger <richard@nod.at>, linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, linux-block@vger.kernel.org, linux-mtd@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org


--===============7745100349515429450==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tjCHc7DPkfUGtrlw"
Content-Disposition: inline


--tjCHc7DPkfUGtrlw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I talked to Pavel a bit back and it turns out he has a
> usecase for BFQ as well and I bet he also would like it
> as default scheduler for that system (Pavel tell us more,
> I don't remember what it was!)

I'm not sure I remember clearly, either.

IIRC I was working with ionice on spinning disks, and it had no
effect. I switched to BFQ and suddenly ionice was effective.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--tjCHc7DPkfUGtrlw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlu3GykACgkQMOfwapXb+vLPwACfdqGloCd9CjmTKQ5BeYsHA9Jc
AZoAoKwt4ORtanA0S3EqgvOJ2hMzMIp5
=s0++
-----END PGP SIGNATURE-----

--tjCHc7DPkfUGtrlw--


--===============7745100349515429450==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

--===============7745100349515429450==--
