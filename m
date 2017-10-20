From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 1/2] mmc: tmio: fix swiotlb buffer is full
Date: Fri, 20 Oct 2017 06:00:11 +0200
Message-ID: <20171020040011.pgq3nnuueooi7ljb@ninjato>
References: <1508469162-12322-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1508469162-12322-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pochndvk5mqcplwz"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:35358 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750715AbdJTEAO (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 20 Oct 2017 00:00:14 -0400
Content-Disposition: inline
In-Reply-To: <1508469162-12322-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: wsa+renesas@sang-engineering.com, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org


--pochndvk5mqcplwz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2017 at 12:12:41PM +0900, Yoshihiro Shimoda wrote:
> Since the commit de3ee99b097d ("mmc: Delete bounce buffer handling")
> deletes the bounce buffer handling, a request data size will be referred
> to max_{req,seg}_size instead of MMC_QUEUE_BOUNCESZ (64k bytes).
>=20
> In other hand, renesas_sdhi_internal_dmac.c will set very big value of
> max_{req,seg}_size because the max_blk_count is set to 0xffffffff.
> And then, "swiotlb buffer is full" happens because swiotlb can handle
> a memory size up to 256k bytes only (IO_TLB_SEGSIZE =3D 128 and
> IO_TLB_SHIFT =3D 11).
>=20
> So, as a workaround, this patch avoids the issue by setting
> the max_{req,seg}_size up to 256k bytes if swiotlb is running.
>=20
> Reported-by: Dirk Behme <dirk.behme@de.bosch.com>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

For the issues we are seeing with v4.14, I think this fix is good. We
plan to fully fix this issue at a more generic level, then this addition
can go again. But we are not there yet, and likely need some additional
API, so:

Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--pochndvk5mqcplwz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlnpdMcACgkQFA3kzBSg
KbbNww//e4Gpso4avIhsdCRx9D8YUxdCbLgrCD2fuvrqFSLYEZxPJet0QroXAqt2
Z0SPfQ5RcNXUCqm7n+YmY/PzuKTq7qx8z8YNvvycy+LIYGDrRSetYbageeZRm2Mb
HNh/s24IqMLQdpgQqgrbQsYaqJgobHcDWTonEOea6sO2rawVrcJDmYATGfm3GS9F
nf7Gtkx/wgbpUKeLO57vDpYbCuBbdkTNZ3+dM/DQuQq8mIUWdZV9R2OSWbzYENGi
mL4VE5vPMPvnD4mamD2lb/jWUvtKZE7ziOakkST70ZutSc/sdXrorick+O9ixVUl
jl2IEn4x7u/hlh6c4mjEkMigN+ph5SxJOBieCxB2asEqHG5CL+sEvmHLc/+tTGCp
AKSGsGl1twQvCc/X6JQuPT5DIjXiGVIzQpHmrzUJqJ4F87q/GsXlPBFA9mrUDU5e
k+Vs6GzQy9IDWLtmbh+hs7mvMN2QXglel3ApaUCkHkDTMua4wiVYZIcrk5P48kSy
lwqKo6/yawps9C+5/beLbJjT1iCKeUco+LJWOKL7lXG1NzSHa+Q7rgpDhLvoajvO
ML2IOf8Sasd0qqmUVMTYoBDt1GmEFovxNmhURJwrDfwPMrjdxbwO3L2Ey29/Cl6y
U4+V9zc4OwqpokCn/LHTe47OTm3ka/e/POfSKTpxRlLA8g+B1QM=
=4Ywg
-----END PGP SIGNATURE-----

--pochndvk5mqcplwz--
