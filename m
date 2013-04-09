From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 2/2] mmc: mxs-mmc: add non-removable property
Date: Tue, 09 Apr 2013 18:34:10 +0200
Message-ID: <51644302.6000109@pengutronix.de>
References: <1365166070-9370-1-git-send-email-mkl@pengutronix.de> <1365166070-9370-3-git-send-email-mkl@pengutronix.de> <51643053.7030302@digi.com> <516431F9.8010302@digi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2VKTVBJXGHRJIFDEKIGHU"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <516431F9.8010302@digi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hector Palacios <hector.palacios@digi.com>
Cc: linux-mmc@vger.kernel.org, kernel@pengutronix.de, cjb@laptop.org, aletes.xgr@gmail.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Marek Vasut <marex@denx.de>, Shawn Guo <shawn.guo@linaro.org>
List-Id: linux-mmc@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2VKTVBJXGHRJIFDEKIGHU
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 04/09/2013 05:21 PM, Hector Palacios wrote:
> On 04/09/2013 05:14 PM, Hector Palacios wrote:
>> @@ -95,7 +97,8 @@ static int mxs_mmc_get_cd(struct mmc_host *mmc)
>>          struct mxs_mmc_host *host =3D mmc_priv(mmc);
>>          struct mxs_ssp *ssp =3D &host->ssp;
>>
>> -       return !(readl(ssp->base + HW_SSP_STATUS(ssp)) &
>> +       return host->non_removable || host->broken_cd ||
>> +              !(readl(ssp->base + HW_SSP_STATUS(ssp)) &
>>                   BM_SSP_STATUS_CARD_DETECT);
>>   }
>=20
> Sorry, I missed your original XOR here, when merging my changes:

Can you send an incremental patch against my 2/2 with your
Signed-off-by, I'll squash your patch into mine and repost the series.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2VKTVBJXGHRJIFDEKIGHU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlFkQwsACgkQjTAFq1RaXHN5IACfdObCBUhProlxzuc3aC+XqXK3
6eoAnjJ3ZOa5VXc9N/QmCQj9X3e9Arl5
=YGNk
-----END PGP SIGNATURE-----

------enig2VKTVBJXGHRJIFDEKIGHU--
