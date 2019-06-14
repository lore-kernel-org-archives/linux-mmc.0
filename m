From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [RFC PATCH v6 5/5] mmc: queue: Use bigger segments if IOMMU can
	merge the segments
Date: Fri, 14 Jun 2019 12:42:52 +0200
Message-ID: <20190614104252.GA2245@kunai>
References: <1560421215-10750-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1560421215-10750-6-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<20190614072459.GD8420@lst.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5266369396665431993=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190614072459.GD8420-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: axboe-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-block-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


--===============5266369396665431993==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > +		host->can_merge =3D 1;
> > +	else
> > +		host->can_merge =3D 0;
> > +
>=20
> can_merge seems a little too generic a name to me.  Maybe can_iommu_merge?

Ack.


--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl0DeicACgkQFA3kzBSg
Kbai+A//TXe/UTCawLN26OjHt2UucUCPMqPhYULQbICoNMwgmVUqX54DWzikDx5o
A9NBpSff++FwU4hkdh80DQfdR4//S3uTQZnf0ZlND4AGFLKOCCSdZwsDCg3o8sAe
/Oc4pJa8BPV2W72PVKyZK+qFw5e5GFzC9jehlDHVWSI3/w08lICPzX2ogz5teYVn
8cmYjuaj9y6gibmMbRj/rgv3WvGn1jr2rjc+ekpZS5V/YlYqeUI3/5fp7n4Bit8X
OVQBXCcf6Z5oqVs+tio/MhA801qPykJvCwIrnsN9FN4P1C2iUZ72ynZ9z47jfxp2
MHAyV0h7glizA51S0YUqqW9ZeUIp2EKO6rPULVDlu4vxLtbELU0y8Yp5WmB6aJ4L
dRXpygqseWNgf9MlCFTT56L2VVVFnty/3Bm0f/LNiA+98XM103+bUsk3Y9nU9GnS
SBUEQbxyBnIt2JDhS978XAQWWNcy1Q1cyfj4Y4ywGatkCip7RjXC8jl2YQmOF7c9
sf+FIrEziEJKfWWXjtbz8NeWHFMsIt1GbP3+ICCgykgU5jrtGMhE8Xr/w1GV4RQ6
MPMdY2g9BwHGr27IVqCK0cHjs6mT4VRCH5NOEDdakN3FOmTXwFLsMEo2TXiSPjPa
TMMucF0Vlrt8S5/SuQQfz5L5JTRsr7RzLbOiV4mzDi00znetCwM=
=nycl
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--

--===============5266369396665431993==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5266369396665431993==--
