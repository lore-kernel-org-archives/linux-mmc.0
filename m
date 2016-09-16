From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v7 05/11] ARM: dts: koelsch: Enable UHS-I SDR-50 and
 SDR-104
Date: Fri, 16 Sep 2016 12:23:22 +0200
Message-ID: <20160916102322.GH1411@katana>
References: <1473764228-24768-1-git-send-email-horms+renesas@verge.net.au>
 <1473764228-24768-6-git-send-email-horms+renesas@verge.net.au>
 <20160916100031.GH14562@verge.net.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="nOM8ykUjac0mNN89"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160916100031.GH14562@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org


--nOM8ykUjac0mNN89
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 16, 2016 at 12:00:32PM +0200, Simon Horman wrote:
> On Tue, Sep 13, 2016 at 12:57:02PM +0200, Simon Horman wrote:
> > Add the "1v8" pinctrl state and sd-uhs-sdr50 property to SDHI{0,1,2}.
> > And the sd-uhs-sdr104 property to SDHI0.
> >=20
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
>=20
> As SDR50 support is present in the driver in mainline (correct me if I am
> wrong!) I have queued this up after dropping the sdr104 portion and
> updating the changelog accordingly.

Looks good!

Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>



--nOM8ykUjac0mNN89
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX28gaAAoJEBQN5MwUoCm2+UYQAKOihNPaIo+dCbRlRHTPJnX6
86B5Q5li9K0DMA1JrUHehxRMQInmrZfjzl48BjNOjCxJqQS7zLPZH/BCXo82dh1v
xbptTOC3rRC9pK2PMoYNEKVtWwCqLYJzFvLDsLn59NLZBG5jgozfs/s2ZPvlp4li
uaU/cRwp+ttXmrMOnouhPxngva4Lj6kDfNf7IFoPvMuop9YQeVNvzaHnl/HeMSHu
fMI7Hm5e5tOO5LO5RYhbZyM6qwbvpZcozGMe34y3S5rNefa5EhL7Cn3AZiNppVp3
kRbSO/yVnx3wAh1E0mih/9zmp9gHPyhyHyF07C/9wOYLepAJBqqQzEgQjQXgsC2O
puAY/KMqwvHxC1P7N4SK8WZZuDrd8SH3c+79BjW2BDV8cLGmfRNMkTviXeAmnwFM
Dgmzi2il/dfoU3VieRbYYw36Z5hCHt/oYQG3PpxBBDSRlV1HLIIFSuKYq3hmBm+b
6ZCa5mvhD2Y3DyOWr0rC/fHrg4rPEOG/mV8nG6utnlIDQK0T1ZoqJNz8qWOrfhyn
gvWgpcGsEEXzDDztlhbDpcRKGl6OD9F9lro9ZZD8gQ6dSfBbSEEzzT8fAo9pRz7+
EtBHcvIvtz/WqtlVnpfN2bHI3wCHMAGTcKau+Tl0cQ43DRJYP4WxBl9muSWXM4Zt
Ox0Jz/3Yk3iJrCw5bUTJ
=G77G
-----END PGP SIGNATURE-----

--nOM8ykUjac0mNN89--
