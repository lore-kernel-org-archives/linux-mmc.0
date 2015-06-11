From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH V2 2/3] i2c-piix4: Use Macro for AMD CZ SMBus device ID
Date: Thu, 11 Jun 2015 22:07:35 +0900
Message-ID: <20150611130734.GA1510@katana>
References: <1434024707-6245-1-git-send-email-Vincent.Wan@amd.com>
 <1434024707-6245-2-git-send-email-Vincent.Wan@amd.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1434024707-6245-2-git-send-email-Vincent.Wan@amd.com>
Sender: linux-pci-owner@vger.kernel.org
To: Wan ZongShun <Vincent.Wan@amd.com>
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-i2c@vger.kernel.org, bp@alien8.de, jdelvare@suse.de, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, mcuos.com@gmail.com
List-Id: linux-mmc@vger.kernel.org


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2015 at 08:11:46PM +0800, Wan ZongShun wrote:
> Change AMD CZ SMBUS device ID from 0x790b to
> use Macro definition
>=20
> Signed-off-by: Wan ZongShun <Vincent.Wan@amd.com>

I think it makes sense that this patch goes in via MMC. This I2C change
is trivial, but for MMC there is more to handle. I don't expect
conflicts. So:

Acked-by: Wolfram Sang <wsa@the-dreams.de>

> ---
>  drivers/i2c/busses/i2c-piix4.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix=
4.c
> index 67cbec6..630bce6 100644
> --- a/drivers/i2c/busses/i2c-piix4.c
> +++ b/drivers/i2c/busses/i2c-piix4.c
> @@ -245,7 +245,7 @@ static int piix4_setup_sb800(struct pci_dev *PIIX4_de=
v,
>  	     PIIX4_dev->device =3D=3D PCI_DEVICE_ID_AMD_HUDSON2_SMBUS &&
>  	     PIIX4_dev->revision >=3D 0x41) ||
>  	    (PIIX4_dev->vendor =3D=3D PCI_VENDOR_ID_AMD &&
> -	     PIIX4_dev->device =3D=3D 0x790b &&
> +	     PIIX4_dev->device =3D=3D PCI_DEVICE_ID_AMD_KERNCZ_SMBUS &&
>  	     PIIX4_dev->revision >=3D 0x49))
>  		smb_en =3D 0x00;
>  	else
> @@ -545,7 +545,7 @@ static const struct pci_device_id piix4_ids[] =3D {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP400_SMBUS) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_SBX00_SMBUS) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_HUDSON2_SMBUS) },
> -	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, 0x790b) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_KERNCZ_SMBUS) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_SERVERWORKS,
>  		     PCI_DEVICE_ID_SERVERWORKS_OSB4) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_SERVERWORKS,
> --=20
> 1.9.1
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVeYgWAAoJEBQN5MwUoCm2QvEP/jYI/5yGd3x2EmLzgg402dSa
7eUCtoN/wDtLECdisx34ORQ8CTmD6QMXjv7/Uqtv191mS4RdFK6IFI6OpQcnLvdj
ZS/7GSR7x7MG8lLeZkkzxvwhtlihWJILqZ8UZGWTRa3tO12V06P+dIH7icpF7MAS
3bYveVKpgolPFCXKj6o19LZgkrBYkCP47Or2haX0BhoBMom4DaMy9fjUr171dqN8
GzNbx/uAdQSTzVp5YTKHoXQ+31WFVRSxOPtbCuPN0b9qay4GZ4aV1R/V3RI8sUBt
JTGRzbdf09nwa3KZudFSA2WXcRf+6Wr7sevU93SyMK6N5jcinlZBOwoKqMVTmUuK
YLAqHpl3JPyiaEkJ5MVbMN+xgGFatl+2fFwhl6VxLFu2IdxYhbUKZomnwCRPjVHL
K7Xue/PxZmh71cr6fnftomjYW8Ds/QiMfqA46/YuEnkjObvPMp2sQCU8uMeH06QT
0wsQ1u7KU5Go1cDA9iuYGLIx0Jc06hPMCQpNQL8wZCJmJI82BJ78JyeRpRm+9Tk+
R0G7m8g/0wFuhnMxqqiH2xbueYqNyrZXAKUGp7TQ0pmzdSUsozYlTS7CMcf2umma
CzZevQqb1JO0lvTttRV1JJ3oKjRgB18nna+1lpGw0pea7nNcfFszylLJ4Pl+ZhHb
hI6cE2Ab9ilMheG0Natq
=WYym
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
