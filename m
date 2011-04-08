From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH v3 1/2] mmc: sdhci: add error checking for mmc_add_host
Date: Fri, 8 Apr 2011 20:31:57 +0200
Message-ID: <20110408183157.GA23883@pengutronix.de>
References: <4D9ACC8B.8070407@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53372 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756899Ab1DHScB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 8 Apr 2011 14:32:01 -0400
Content-Disposition: inline
In-Reply-To: <4D9ACC8B.8070407@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Apr 05, 2011 at 05:02:19PM +0900, Jaehoon Chung wrote:
> Sometimes we can't add the device,but we didn't check any error status.
> Need to check error status for mmc_add_host.
>=20
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Kyungin Park <kyungmin.park@samsung.com>
> ---
>  drivers/mmc/host/sdhci.c |   20 ++++++++++++++++++--
>  1 files changed, 18 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 9e15f41..1768ffb 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2025,7 +2025,9 @@ int sdhci_add_host(struct sdhci_host *host)
> =20
>  	mmiowb();
> =20
> -	mmc_add_host(mmc);
> +	ret =3D mmc_add_host(mmc);
> +	if (unlikely(ret))
> +		goto err_free_mmc;
> =20
>  	printk(KERN_INFO "%s: SDHCI controller on %s [%s] using %s\n",
>  		mmc_hostname(mmc), host->hw_name, dev_name(mmc_dev(mmc)),
> @@ -2036,15 +2038,29 @@ int sdhci_add_host(struct sdhci_host *host)
> =20
>  	return 0;
> =20
> +err_free_mmc:
> +	mmc_remove_host(host);

As I asked in my last review: Why do you remove the host when add_host fail=
ed?
Doesn't that crash?

> +
>  #ifdef SDHCI_USE_LEDS_CLASS
> +	led_classdev_ungregister(&host->led);
>  reset:
> +#endif
>  	sdhci_reset(host, SDHCI_RESET_ALL);
>  	free_irq(host->irq, host);
> -#endif
> +	del_timer_sync(&host->timer);
> +
>  untasklet:
>  	tasklet_kill(&host->card_tasklet);
>  	tasklet_kill(&host->finish_tasklet);
> =20
> +	if (host->flags & SDHCI_USE_ADMA) {
> +		kfree(host->adma_desc);
> +		kfree(host->align_buffer);
> +
> +		host->adma_desc =3D NULL;
> +		host->align_buffer =3D NULL;
> +	}

The if-condition is not needed, kfree is NULL-safe.

> +
>  	return ret;
>  }
> =20

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAk2fVJ0ACgkQD27XaX1/VRsZFwCgsgZ567Z5EP981NF4/cEXG9z/
HvAAoMFOud43MnfeKNDX2/HCBKBdVnJu
=RTub
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
