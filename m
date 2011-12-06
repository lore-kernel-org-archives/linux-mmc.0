From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: uninitialized variable in mmc_blk_issue_secdiscard_rq()
Date: Tue, 6 Dec 2011 11:15:25 +0300
Message-ID: <20111206081525.GE3374@mwanda>
References: <20111206080842.GA10021@elgon.mountain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tVmo9FyGdCe4F4YN"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:60407 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932880Ab1LFIPU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Dec 2011 03:15:20 -0500
Content-Disposition: inline
In-Reply-To: <20111206080842.GA10021@elgon.mountain>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kyungmin Park <kyungmin.park@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org


--tVmo9FyGdCe4F4YN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 06, 2011 at 11:08:59AM +0300, Dan Carpenter wrote:
> There is a new gcc warning in this function:
>=20
> drivers/mmc/card/block.c:836:18: warning: =E2=80=98arg=E2=80=99 may be us=
ed uninitialized in this function [-Wuninitialized]
>=20

Sorry for the bad subject.  The email escaped before it should have.

Same thing for "nr" and "from".

drivers/mmc/card/block.c:835:6: warning: =E2=80=98nr=E2=80=99 may be used u=
ninitialized in this function [-Wuninitialized]
drivers/mmc/card/block.c:835:6: warning: =E2=80=98from=E2=80=99 may be used=
 uninitialized in this function [-Wuninitialized]

regards,
dan carpenter


--tVmo9FyGdCe4F4YN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIbBAEBAgAGBQJO3c8cAAoJEOnZkXI/YHqR07MP+LYcgOFXSCwxF/TaoPqXo9mn
WHikZNF0lLz2wnNDx7Zf6TyTVUzdq/F5vkdx9mPNUG/UMZQi3N3K1W/peMhCChqO
f9eOGC/BLJhQOE3zlEv+b6nOiEaebpieVQBvXl2gm09c2w78GDpBkA+PQUed2FGr
eZHDvFlwuy1Lh++GcxtJTfgNDYYrg10v2AvTf7/PXxAA4UfyFEZyx6tD3pKHXmy4
9mJJG9tlR8K9GTIGdnmX322AAcF+TgtPVFuOgewBfkRvKWVXvH5H/VB0L8ADRUN/
WX0tAc4AzAzYo4X6zrQYZP+V/5cV8PbEfzq4axfscbTlLI7HGXt04k8czSDH9Qu/
9GbA9g7SvVNCbdrQRK+mnJqCM64E58GR9HZYH6ONljSKwF3Ox05N1Fy2qqO8iiyk
ox84bFStF5+7+PCMglhxwq7+wPhj3y7BdOOgn64fJUmvVE8b/WQ7CPS2VizSejdQ
DZEz8RZz3Rw2YpuD1WdM7IxyTXwOv53NL4Jb10+GB/XiPaw1jo/xe06dQ7VuhNEw
bbajh/cjXUbaJwtVrLSvvOQmy1fe58sx4Tw5RAsyodbR2xesRaMU3dgzXvq+7gJX
U34COtTHOEBsd396vVU8BhKzxRxAG2G8FXi7ZQG3oOwNWl7bnLgjmPyl8Cisl9G+
/fipL8MYwlrFRKAAknU=
=I0DD
-----END PGP SIGNATURE-----

--tVmo9FyGdCe4F4YN--
