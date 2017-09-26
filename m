From: Mark Brown <broonie@kernel.org>
Subject: Re: next-20170926 build: 2 failures 1 warnings (next-20170926)
Date: Tue, 26 Sep 2017 09:11:00 -0700
Message-ID: <20170926161100.nzyb33o6l6lad2da@sirena.org.uk>
References: <E1dwn6w-0002eY-VE@optimist>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pekkr6qutk5glbfy"
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <E1dwn6w-0002eY-VE@optimist>
Sender: linux-next-owner@vger.kernel.org
To: Ritesh Harjani <riteshh@codeaurora.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Jeremy McNicoll <jeremymc@redhat.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: kernel-build-reports@lists.linaro.org, linaro-kernel@lists.linaro.org, linux-next@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org


--pekkr6qutk5glbfy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 26, 2017 at 11:29:06AM +0100, Build bot for Mark Brown wrote:

Today's -next fails to build an arm and arm64 allmodconfig with:

> 	arm64-allmodconfig
> ERROR: "clk_bulk_prepare" [drivers/mmc/host/sdhci-msm.ko] undefined!
>=20
> 	arm-allmodconfig
> ERROR: "clk_bulk_prepare" [drivers/mmc/host/sdhci-msm.ko] undefined!

caused by d8034e3379a83 (mmc: sdhci-msm: Utilize bulk clock API).

--pekkr6qutk5glbfy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlnKfAgACgkQJNaLcl1U
h9BROwf/drgL2Z0Me1u4e8gZ8a3mB5kMmuQ1RMrckrH7X75fkc1W/lIeILGUzP92
Yvb3vMxU34qzcmShNUaSFhnTOBKkFhkwrOSkAMg47ChqY8qYQcVN5l+YWF3tpTIV
buVuQueP/PbJJlKxDqCTOVdVC/I4v4h7AKT82FhpiPgRltSXIranMlKA3CDptMIQ
xgBPQN7vKugsMtRevN8Aj2LoB1d8WJxAOd1ygqBMlgVwEXbhDq9CeyMiJwAQh8lX
0VuHDLQLbub/4fqu6EvlLzmmRST6jAqSXluGenyjEEdsmm+ti3xpe9agUlFz2uqG
Oyh7wmVCwGgghaxnrIlYCrAGxTZdBg==
=BLH9
-----END PGP SIGNATURE-----

--pekkr6qutk5glbfy--
