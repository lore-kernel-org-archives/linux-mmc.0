From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] mmc: omap_hsmmc: Add support for Erratum 2.1.1.128 in
 device tree boot
Date: Mon, 20 Jan 2014 17:39:41 -0600
Message-ID: <20140120233941.GG6516@saruman.home>
References: <1390260542-22213-1-git-send-email-nm@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4958116812461598747=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1390260542-22213-1-git-send-email-nm@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nishanth Menon <nm@ti.com>
Cc: devicetree@vger.kernel.org, Balaji T K <balajitk@ti.com>, Tony Lindgren <tony@atomide.com>, linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

--===============4958116812461598747==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="w/VI3ydZO+RcZ3Ux"
Content-Disposition: inline

--w/VI3ydZO+RcZ3Ux
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 20, 2014 at 05:29:02PM -0600, Nishanth Menon wrote:
> When device is booted using devicetree, platforms impacted by
> Erratum 2.1.1.128 is not detected easily in the mmc driver. This erratum
> indicates that the module cannot do multi-block transfers.
>=20
> Handle this by providing a boolean flag to indicate to driver that it is
> working on a hardware with mentioned limitation.

sure there's no way of reading the revision register to figure this one
out without having to add a new DT attribute ?

--=20
balbi

--w/VI3ydZO+RcZ3Ux
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJS3bO9AAoJEIaOsuA1yqREG3EP/05CRV54qvIN3Yxoea81Yshf
WtufQ4v6Q6McZZOz3UXUQjh+ZuHRdP+eNylhUD2etI8mUY7PS7yVC8Cm+TdOPeg5
sjrqiPxcIJbEC1+IhIrxHDaAFynArxQwXNg8ltF9sSNfNPamh9i8toSL7h/r17Ql
N6jGVdJ/rLNCTSvQwgpqFdZwSYibV+toIO8CvSrp3mWlNApCeG/d9YvTyYTL8Cqa
0+p3tqzsQLcSayXd3QZc83cMnYLNqDCytZVvGGRVL6AzM2sDsJXew9Ce8DCUkLfE
Tv/HeLOwzgnESzf2ZB8g/YPhtlKrdo/PvmXye5DF/05tY/tpWvHLsB/hTTY+5qUY
3se5l5moG+hjI4VbyMvOZmfZDmKxEobZeI3edTeMIN/1z/Z+6oXIsuCA1Lo4gxsI
yx/KyoFap7CRpC404lB+m6oYlVBoQJz724Il2ZiaLPJgZ9V8Mpe0sydikrfuZzFO
8c6fHFru7ZRQd1WykXeHuSk59v2cNLtXZI5HXe3J4wyyBlsRMhAdyFSRadVAzmoi
T6Y4WrdfysAxx18Zz+r9Ia1VRPZa9Gq+dfOYAATmRUOKoqpVKQAUZ6XZo328lUmW
/eLjPOTneDtHV7VyEzRDmSdC7uoV1ZGMdiRvI5XT3t26stzUes70nlPCz2dvHI+J
FAQORV2TlKF+LkBILihz
=j9gs
-----END PGP SIGNATURE-----

--w/VI3ydZO+RcZ3Ux--


--===============4958116812461598747==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4958116812461598747==--
