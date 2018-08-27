From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 1/2] mmc: sdhci: Export sdhci_request()
Date: Mon, 27 Aug 2018 12:11:52 +0200
Message-ID: <20180827101152.GA19520@ulmo>
References: <1534757013-4524-1-git-send-email-avienamo@nvidia.com>
 <1534757013-4524-2-git-send-email-avienamo@nvidia.com>
 <CAPDyKFrxMWBisB5uuhFjxosExJx5cqLnTLE5Eoxp5LVdFk_43g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFrxMWBisB5uuhFjxosExJx5cqLnTLE5Eoxp5LVdFk_43g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Aapo Vienamo <avienamo@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, Jonathan Hunter <jonathanh@nvidia.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-tegra@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 27, 2018 at 12:07:08PM +0200, Ulf Hansson wrote:
> On 20 August 2018 at 11:23, Aapo Vienamo <avienamo@nvidia.com> wrote:
> > Allow SDHCI drivers to hook code before and after sdhci_request() by
> > making it externally visible.
> >
> > Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
>=20
> This one happens to be useful for other variants but Tegras, hence I
> have applied this one for next. Thanks!
>=20
> Thierry, you may thus drop this one from your PR. Also, you should
> probably base your pull request on top of my next branch, as I have
> already started to queue up some changes for sdhci.

Will do that, thanks.

Thierry

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAluDzmgACgkQ3SOs138+
s6HJMBAArzWv4Ra35OlaCrF3Md8xwNK5WJhNrGaR/yk9G/UX6JcU9wuwSarV1DPc
WfuzF5iZzDqUdQTMGKugrNmDAzu+rtTdM0IaUcciayVh2tJk2DMreMiEpvembtT/
ta/6p69uKnxbyke/mN4nMIFfT2sQlEprb6LJf4YHn5DluQ8eylH8plXMDRLyjlgS
bzvvyAMZfTYNGJNSVFOmYOfOx1Z5QbevVp0+ksWnNiAO5TSr33LP+TyNoQOwGyao
vhT4o2DN1ZtVzwbx8WrNZFr5JBQijfw/9mqTroi9vJlK4eFnn8scZL+I9K1Cg1hw
qWnjSiwQAhayGV8eO7/OK0IZpaXTMKkPd44XftYBj5hUMoTbfUrnfh7Myka5zJeO
s2LM/LVqONPqaH1pjCg/UGwJY1EyzjOLtkoYdG4KRMWMq3Txwcwibff8LlMEk468
5ah5Libu4U/505eU4535F04Qfg8yzLcPn5JpzKVGwte2hNdekwJIDvqYWlxnSVcq
BH6gVOrRn5J8XLSd1LyxwZ0vALwX/GcfVEXllAVMywKRqDxpZZgq3bbLDO/tDtbK
1UTn0qEFGdlE/rdVkBZiOHZ6hxcE60wK/JCIhJhXi21vizUt4/qWj4EaUh08LDd/
wuXE0xtP5JteeL5XvUKzXKxZgebv3DdhriwwgSz6Rn6ZBYY56YM=
=R8vG
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
