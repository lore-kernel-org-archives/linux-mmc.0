From: David =?ISO-8859-1?Q?Lanzend=F6rfer?= <david.lanzendoerfer@o2s.ch>
Subject: Re: [PATCH] mmc: sunxi: avoid invalid pointer calculation
Date: Tue, 24 Feb 2015 10:50:54 +0100
Message-ID: <2935950.xzmbIlk6I0@pagira.o2s.ch>
References: <27509084.spYfayGTeo@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9170426556477931038=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <27509084.spYfayGTeo@wuerfel>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, maxime.ripard@free-electrons.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org


--===============9170426556477931038==
Content-Type: multipart/signed; boundary="nextPart5891807.YQQIUDHt2O"; micalg="pgp-sha1"; protocol="application/pgp-signature"


--nextPart5891807.YQQIUDHt2O
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Acked-by: David Lanzend=F6rfer <david.lanzendoerfer@o2s.ch>

Am Dienstag, 24. Februar 2015, 10.47:27 schrieb Arnd Bergmann:
> The sunxi mmc driver tries to calculate a dma address by using pointe=
r
> arithmetic, which causes a warning when dma_addr_t is wider than a po=
inter:
>=20
> drivers/mmc/host/sunxi-mmc.c: In function 'sunxi_mmc_init_idma_des':
> drivers/mmc/host/sunxi-mmc.c:296:35: warning: cast to pointer from in=
teger
> of different size [-Wint-to-pointer-cast] struct sunxi_idma_des *pdes=
_pa =3D
> (struct sunxi_idma_des *)host->sg_dma; ^
>=20
> To avoid this warning and to simplify the logic, this changes
> the code to avoid the cast and calculate the correct address
> manually. The behavior should be unchanged.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>=20
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mm=
c.c
> index e8a4218b5726..c326ac965806 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -293,7 +293,7 @@ static void sunxi_mmc_init_idma_des(struct
> sunxi_mmc_host *host, struct mmc_data *data)
>  {
>  =09struct sunxi_idma_des *pdes =3D (struct sunxi_idma_des *)host->sg=
_cpu;
> -=09struct sunxi_idma_des *pdes_pa =3D (struct sunxi_idma_des *)host-=
>sg_dma;
> +=09dma_addr_t next_desc =3D host->sg_dma;
>  =09int i, max_len =3D (1 << host->idma_des_size_bits);
>=20
>  =09for (i =3D 0; i < data->sg_len; i++) {
> @@ -305,8 +305,9 @@ static void sunxi_mmc_init_idma_des(struct
> sunxi_mmc_host *host, else
>  =09=09=09pdes[i].buf_size =3D data->sg[i].length;
>=20
> +=09=09next_desc +=3D sizeof(struct sunxi_idma_des);
>  =09=09pdes[i].buf_addr_ptr1 =3D sg_dma_address(&data->sg[i]);
> -=09=09pdes[i].buf_addr_ptr2 =3D (u32)&pdes_pa[i + 1];
> +=09=09pdes[i].buf_addr_ptr2 =3D (u32)next_desc;
>  =09}
>=20
>  =09pdes[0].config |=3D SDXC_IDMAC_DES0_FD;

=2D-=20
David Lanzend=F6rfer
OpenSourceSupport GmbH
System engineer and supporter
http://www.o2s.ch/
--nextPart5891807.YQQIUDHt2O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAlTsSX4ACgkQAeZw77btGjoAmgCgmvwFnPxw4mjoNKiWuClDf951
664AnA2XjStWGnlWJe6jHNMQAQPKj+dK
=GfTD
-----END PGP SIGNATURE-----

--nextPart5891807.YQQIUDHt2O--



--===============9170426556477931038==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============9170426556477931038==--
