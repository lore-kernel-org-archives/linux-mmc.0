From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RFC 4/7] mmc: tmio: Add UHS-I mode support
Date: Wed, 9 Mar 2016 17:17:35 +0100
Message-ID: <20160309161735.GB9443@katana>
References: <1455913003-6140-1-git-send-email-wsa@the-dreams.de>
 <1455913003-6140-5-git-send-email-wsa@the-dreams.de>
 <CAPDyKFpxE3XU8ocRLTyMvBo-FPOECY7zeJAr7O1oLwKXEZ20zQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/NkBOFFp2J2Af1nK"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFpxE3XU8ocRLTyMvBo-FPOECY7zeJAr7O1oLwKXEZ20zQ@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-renesas-soc@vger.kernel.org, linux-mmc <linux-mmc@vger.kernel.org>, Ben Hutchings <ben.hutchings@codethink.co.uk>, Dirk Behme <dirk.behme@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-mmc@vger.kernel.org


--/NkBOFFp2J2Af1nK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > +
> > +       int (*start_signal_voltage_switch)(struct tmio_mmc_host *host,
> > +                                          unsigned char signal_voltage=
);
>=20
> Do you really need to add a new tmio specific callback for this?
>=20
> Why can't you instead have the tmio variant driver assign the
> ->start_signal_voltage_switch() callback into the struct mmc_host_ops
> instead?

Just to see how it looks, I tried your suggestion. However, mmc_ops is
consted all the way into the core (rightfully, I'd say), so this makes
this approach quite clumsy. I kept the above callback now, just changed
the second paramater to pass the whole ios so I can use it with
mmc_regulator_set_vqmmc().

> > +static int tmio_mmc_card_busy(struct mmc_host *mmc)
> > +{
> > +       struct tmio_mmc_host *host =3D mmc_priv(mmc);
> > +       u32 status;
> > +
> > +       pm_runtime_get_sync(mmc_dev(mmc));
>=20
> This isn't needed as the mmc core already deal with runtime PM of the
> host device via mmc_claim|release_host().

sdhci.c does it, too - missing cleanup?


--/NkBOFFp2J2Af1nK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW4EyfAAoJEBQN5MwUoCm2OTEP/RJ70sds82REnnWaEwE2kTUf
ndmOFioksuyIj5hd/hCUVTuC0ieWOIb+81/nsPfSVldr2nvE568g32Hmc4wxxuGs
GY4TwUjUA79TYZC2EoQKxIZTBHHjiEbYZ3rIvFLb9PCCfF4lDpH/fcq7wTygysCY
jAIU/rvH5pi3LOTAvdCdd+oj1wWthcRyuiN5F04lJ+ZDv9iAb2bhop5H5k/ufb4F
BFwj3TQ0ueHoNkL+iZhGwVIowTbz8AlYZQy5eGqzM3JueNY4AMrZQCtJ2cbsxAuH
O3G/TBC7Yt32MkKE7+YTLqy1dGG6o1FFE3izx7m1Dy/DQdt5frFg4xf+ngR/DRkb
aNziZJO14kTe9blqCAxeTeo/H20qqoEHUcHvN5U321KaNnmCHu2ZFIKcK8XNbycq
NnY1PPUm2R0tRZEPGDMW1ncDMcuUcLJVSWaVLURwFP1th3p69WMDp+sK79egr1WR
ajqm3nANeyu7ZRzG6ndbNtFnGmt2Kdjhzmviz6FKL3EXAPt/lIyS3UAGR8QBGUi6
i5iXUhQc4GzdAQB8yQZdaSlO9sKBjPEcjTVT8taEFbHek5H5nIFe9LoqlD+9UX65
vHGPeoYZp3sZ4JZLCT9wl7JfOSNm3V1Twjf3/wqTykz4WJhNDp4cJtDB/B4QiihQ
9Peodqp2Ae42XWAa1DBp
=jsAX
-----END PGP SIGNATURE-----

--/NkBOFFp2J2Af1nK--
