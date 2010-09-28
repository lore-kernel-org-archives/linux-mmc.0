From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH (mmc-next) 2/3] mmc: fix a warning when compile the
 sdhci d.d. (V2)
Date: Tue, 28 Sep 2010 13:09:42 +0200
Message-ID: <20100928110942.GE4441@pengutronix.de>
References: <1285663289-20283-1-git-send-email-peppe.cavallaro@st.com>
 <1285663289-20283-2-git-send-email-peppe.cavallaro@st.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mR8QP4gmHujQHb1c"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48879 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752426Ab0I1LJn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Sep 2010 07:09:43 -0400
Content-Disposition: inline
In-Reply-To: <1285663289-20283-2-git-send-email-peppe.cavallaro@st.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Giuseppe CAVALLARO <peppe.cavallaro@st.com>
Cc: linux-mmc@vger.kernel.org


--mR8QP4gmHujQHb1c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 28, 2010 at 10:41:28AM +0200, Giuseppe CAVALLARO wrote:
> This patch fixes a warning when compile the sdhci:
>   pwr may be used uninitialized in sdhci_set_power
>=20
> Tested with the following compiler versions: 4.2.4 and 4.4.4
>=20
> Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>

Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>

> ---
>  drivers/mmc/host/sdhci.c |    6 ++----
>  1 files changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 96c7f60..d3f924b 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1050,11 +1050,9 @@ out:
> =20
>  static void sdhci_set_power(struct sdhci_host *host, unsigned short powe=
r)
>  {
> -	u8 pwr;
> +	u8 pwr =3D 0;
> =20
> -	if (power =3D=3D (unsigned short)-1)
> -		pwr =3D 0;
> -	else {
> +	if (power !=3D (unsigned short)-1) {
>  		switch (1 << power) {
>  		case MMC_VDD_165_195:
>  			pwr =3D SDHCI_POWER_180;
> --=20
> 1.5.5.6
>=20

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--mR8QP4gmHujQHb1c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkyhzPYACgkQD27XaX1/VRugswCeNax/IdfsoAI5/Z+6tlk/RC1o
2Y8An3cIlwYVU6Pqbr2seJ50mZiS1ysn
=vIDm
-----END PGP SIGNATURE-----

--mR8QP4gmHujQHb1c--
