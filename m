From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: [PATCH] pxamci: fix printing gpio numbers in pxamci_probe
Date: Mon, 5 Oct 2009 12:45:58 +0200
Message-ID: <20091005124558.04dd13cd.ospite@studenti.unina.it>
References: <1254493442-32312-1-git-send-email-ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0419523824=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1254493442-32312-1-git-send-email-ospite@studenti.unina.it>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-mmc@vger.kernel.org, eric.y.miao@gmail.com, Antonio Ospite <ospite@studenti.unina.it>
List-Id: linux-mmc@vger.kernel.org

--===============0419523824==
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Mon__5_Oct_2009_12_45_58_+0200_=hTMuFWr1ZPsWSq."

--Signature=_Mon__5_Oct_2009_12_45_58_+0200_=hTMuFWr1ZPsWSq.
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri,  2 Oct 2009 16:24:02 +0200
Antonio Ospite <ospite@studenti.unina.it> wrote:

> Signed-off-by: Antonio Ospite <ospite@studenti.unina.it>
> ---
>  drivers/mmc/host/pxamci.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
> index 5e0b152..b00d673 100644
> --- a/drivers/mmc/host/pxamci.c
> +++ b/drivers/mmc/host/pxamci.c
> @@ -693,7 +693,7 @@ static int pxamci_probe(struct platform_device *pdev)
>  	if (gpio_is_valid(gpio_ro)) {
>  		ret =3D gpio_request(gpio_ro, "mmc card read only");
>  		if (ret) {
> -			dev_err(&pdev->dev, "Failed requesting gpio_ro %d\n", gpio_power);
> +			dev_err(&pdev->dev, "Failed requesting gpio_ro %d\n", gpio_ro);
>  			goto err_gpio_ro;
>  		}
>  		gpio_direction_input(gpio_ro);
> @@ -701,7 +701,7 @@ static int pxamci_probe(struct platform_device *pdev)
>  	if (gpio_is_valid(gpio_cd)) {
>  		ret =3D gpio_request(gpio_cd, "mmc card detect");
>  		if (ret) {
> -			dev_err(&pdev->dev, "Failed requesting gpio_cd %d\n", gpio_power);
> +			dev_err(&pdev->dev, "Failed requesting gpio_cd %d\n", gpio_cd);
>  			goto err_gpio_cd;
>  		}
>  		gpio_direction_input(gpio_cd);
> --=20
> 1.6.4.3
>=20

Ping.

Thanks,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

--Signature=_Mon__5_Oct_2009_12_45_58_+0200_=hTMuFWr1ZPsWSq.
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkrJzmYACgkQ5xr2akVTsAFmpACgmLSB0nK/cOYZKX4t3IwS8LOp
zQAAn0XmliFy33uRjbdNxLNSRixJAome
=nRAu
-----END PGP SIGNATURE-----

--Signature=_Mon__5_Oct_2009_12_45_58_+0200_=hTMuFWr1ZPsWSq.--


--===============0419523824==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0419523824==--
