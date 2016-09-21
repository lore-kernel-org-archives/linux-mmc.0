From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 2/6] mmc: rtsx_pci: use new macro for R1 without CRC
Date: Wed, 21 Sep 2016 08:03:36 +0200
Message-ID: <20160921060336.GE1484@katana>
References: <20160919205750.4766-1-wsa+renesas@sang-engineering.com>
 <CGME20160919205936epcas1p405299736aa8bedf4bee71e7f2cf8af89@epcas1p4.samsung.com>
 <20160919205750.4766-3-wsa+renesas@sang-engineering.com>
 <38358765-9f93-6b4a-176a-2c8a87490936@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="X3gaHHMYHkYqP6yf"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <38358765-9f93-6b4a-176a-2c8a87490936@samsung.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Dirk Behme <dirk.behme@gmail.com>
List-Id: linux-mmc@vger.kernel.org


--X3gaHHMYHkYqP6yf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 20, 2016 at 06:29:58PM +0900, Jaehoon Chung wrote:
> Hi Wolfram,
>=20
> Add the commit message.

Can do, but would be highly redundant with the subject. Ulf, you want
one, too?

>=20
> On 09/20/2016 05:57 AM, Wolfram Sang wrote:
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > ---
> >  drivers/mmc/host/rtsx_pci_sdmmc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_=
pci_sdmmc.c
> > index 396c9b7e4121b0..3ccaa1415f33b2 100644
> > --- a/drivers/mmc/host/rtsx_pci_sdmmc.c
> > +++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
> > @@ -126,7 +126,7 @@ static int sd_response_type(struct mmc_command *cmd)
> >  		return SD_RSP_TYPE_R0;
> >  	case MMC_RSP_R1:
> >  		return SD_RSP_TYPE_R1;
> > -	case MMC_RSP_R1 & ~MMC_RSP_CRC:
> > +	case MMC_RSP_R1_NO_CRC:
> >  		return SD_RSP_TYPE_R1 | SD_NO_CHECK_CRC7;
> >  	case MMC_RSP_R1B:
> >  		return SD_RSP_TYPE_R1b;
> >=20
>=20

--X3gaHHMYHkYqP6yf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX4iK3AAoJEBQN5MwUoCm2RPsP/0GSoszLezm/P2oXitBvo1ss
+vw+18QTKj3gnH97jnlJxt/V6vMYI0KX6etUoesOT3y4ME/dpsV+thqgb+UEj0oW
SqXOGmKjzotUlkLiuKuklaflGUbv4GvhfFq3KdRVVu4Xwp64QlE1TBbKOiMS5f90
YNzs7dcAlwhuBFWXommuyuFoy/gfHSTSa9IrbwaRN3rRU/jKM3/Yrs7WdRxByvI1
qNHm2xL3nWEomG4Pi4KLXGY6y9Iq31UP4CrsTdPz9CBbD3w0gMVfd0zuWHrSXbvK
g1XSuIzVu+HXU7j847Y42nlFVTArf75loOzv5gJQAtwkJ7U/f+pwkXaHbL4udeuO
eqPxdffm1Q5libr4vAR3OiQY1Vz7g+jY1vN8TqbyZ6afngZ2KsVMdj/72yfG/xlZ
ic8dAh2XpuDblhWC5ayJTxLrx301G5USRZiLQ+BlgOtchp6/Q3mkvIspnSFzSq6q
p+m8Lxy0k5/ZA8S7aPMb5yScHE059vRNUT8+tM9+7fGp2SnSWL4VoHrrHb/I2YdU
ImTM2RK2XdpmfQc8TIm5+9PZi3iuszMUcTbQ/idYgSUo5rfNOannvJ1G3viIC48F
neYUuLojqkWfyPAF1yjhtt2Tzg0y1ls5jbZUQrri/1lYwiFyDkCF5Jfv4xBghTVc
IOMSiMiXUqwT60ebUUtZ
=7vTb
-----END PGP SIGNATURE-----

--X3gaHHMYHkYqP6yf--
