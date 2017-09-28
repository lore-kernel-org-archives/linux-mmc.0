From: Mark Brown <broonie@kernel.org>
Subject: Re: next-20170926 build: 2 failures 1 warnings (next-20170926)
Date: Thu, 28 Sep 2017 12:00:20 -0700
Message-ID: <20170928190020.yyntjpmh5jebydsa@sirena.org.uk>
References: <E1dwn6w-0002eY-VE@optimist>
 <20170926161100.nzyb33o6l6lad2da@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7akgsu6xb36gdp3o"
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170926161100.nzyb33o6l6lad2da@sirena.org.uk>
Sender: linux-next-owner@vger.kernel.org
To: Ritesh Harjani <riteshh@codeaurora.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Jeremy McNicoll <jeremymc@redhat.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: kernel-build-reports@lists.linaro.org, linaro-kernel@lists.linaro.org, linux-next@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org


--7akgsu6xb36gdp3o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 26, 2017 at 09:11:00AM -0700, Mark Brown wrote:
> On Tue, Sep 26, 2017 at 11:29:06AM +0100, Build bot for Mark Brown wrote:
>=20
> Today's -next fails to build an arm and arm64 allmodconfig with:
>=20
> > 	arm64-allmodconfig
> > ERROR: "clk_bulk_prepare" [drivers/mmc/host/sdhci-msm.ko] undefined!
> >=20
> > 	arm-allmodconfig
> > ERROR: "clk_bulk_prepare" [drivers/mmc/host/sdhci-msm.ko] undefined!
>=20
> caused by d8034e3379a83 (mmc: sdhci-msm: Utilize bulk clock API).

This is still present in today's -next.

--7akgsu6xb36gdp3o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlnNRsMACgkQJNaLcl1U
h9CMKgf/ajtcSon3jN3z4adNJPE0pC+5cNiz3VKp+oPaQp4v05sVHi9DJ4HMmuiQ
+1enYquN5ULEvlihxqM0UmSlA6SjpxL0DorRoqErFOXPueQTEMv0uB7RLY27Z1G4
K2HjgKmi5r3mVajEgAfLsh6ACoI+xVfTYUzexeqKVtbrWoj8bsQZRbMDmRH9WYjp
xC8cQlGZIJkzJ6n7m6BTCoDtfvk6u6sHRq3ModG8Nf39XLoQxfFx0lTwxmTho1lH
KcqTHjhbDpCjmxev6hAAVBCopV8CfQrQVSQU/tPOlc+TDGU6d8RKKEQH7CRA92HW
QHGKfi2aLUHR2BLiAL5gPGrwdfQi7g==
=pS2h
-----END PGP SIGNATURE-----

--7akgsu6xb36gdp3o--
