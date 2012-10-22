From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/PATCH] mmc: omap_hsmmc: introduce
 omap_hsmmc_prepare/complete
Date: Mon, 22 Oct 2012 16:27:08 +0300
Message-ID: <20121022132708.GA14033@arwen.pp.htv.fi>
References: <1350910768-8522-1-git-send-email-balbi@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J8DmsxNGmrt1tVhI"
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1350910768-8522-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: "\\\"Venkatraman S.\\\"" <svenkatr@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-mmc@vger.kernel.org, cjb@laptop.org, Tony Lindgren <tony@atomide.com>, Balaji T K <balajitk@ti.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

--J8DmsxNGmrt1tVhI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 22, 2012 at 03:59:28PM +0300, Felipe Balbi wrote:
> prepare() is supposed to prevent new children from
> being registered. On the MMC subsystem, children
> (new cards) registration starts with the card
> detect IRQ.
>=20
> Move card detect IRQ disabling to prepare() so that
> no new cards will be registered while we're trying
> to suspend.
>=20
> Likewise, move card detect IRQ enabling to complete()
> so we only try to register new children after our MMC
> IP is back up.
>=20
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>=20
> Venkat, do you think the patch below makes sense ?

btw, just checked suspend to ram with beagle and panda. We still have
our filesystem after waking up.

ps: you will [1] to test it:

[1] http://marc.info/?l=3Dlinux-arm-kernel&m=3D135090724817604&w=3D2

> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 54bfd0c..4c8b41e 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -2022,6 +2022,26 @@ static int __devexit omap_hsmmc_remove(struct plat=
form_device *pdev)
>  }
> =20
>  #ifdef CONFIG_PM
> +static int omap_hsmmc_prepare(struct device *dev)
> +{
> +	struct omap_hsmmc_host *host =3D dev_get_drvdata(dev);
> +
> +	if (host->pdata->suspend)
> +		return host->pdata->suspend(dev, host->slot_id);
> +
> +	return 0;
> +}
> +
> +static int omap_hsmmc_complete(struct device *dev)
> +{
> +	struct omap_hsmmc_host *host =3D dev_get_drvdata(dev);
> +
> +	if (host->pdata->resume)
> +		return host->pdata->resume(dev, host->slot_id);
> +
> +	return 0;
> +}
> +
>  static int omap_hsmmc_suspend(struct device *dev)
>  {
>  	int ret =3D 0;
> @@ -2035,23 +2055,10 @@ static int omap_hsmmc_suspend(struct device *dev)
> =20
>  	pm_runtime_get_sync(host->dev);
>  	host->suspended =3D 1;
> -	if (host->pdata->suspend) {
> -		ret =3D host->pdata->suspend(dev, host->slot_id);
> -		if (ret) {
> -			dev_dbg(dev, "Unable to handle MMC board"
> -					" level suspend\n");
> -			host->suspended =3D 0;
> -			return ret;
> -		}
> -	}
>  	ret =3D mmc_suspend_host(host->mmc);
> =20
>  	if (ret) {
>  		host->suspended =3D 0;
> -		if (host->pdata->resume) {
> -			if (host->pdata->resume(dev, host->slot_id))
> -				dev_dbg(dev, "Unmask interrupt failed\n");
> -		}
>  		goto err;
>  	}
> =20
> @@ -2088,12 +2095,6 @@ static int omap_hsmmc_resume(struct device *dev)
>  	if (!(host->mmc->pm_flags & MMC_PM_KEEP_POWER))
>  		omap_hsmmc_conf_bus_power(host);
> =20
> -	if (host->pdata->resume) {
> -		ret =3D host->pdata->resume(dev, host->slot_id);
> -		if (ret)
> -			dev_dbg(dev, "Unmask interrupt failed\n");
> -	}
> -
>  	omap_hsmmc_protect_card(host);
> =20
>  	/* Notify the core to resume the host */
> @@ -2109,8 +2110,10 @@ static int omap_hsmmc_resume(struct device *dev)
>  }
> =20
>  #else
> +#define omap_hsmmc_prepare	NULL
> +#define omap_hsmmc_complete	NULL
>  #define omap_hsmmc_suspend	NULL
> -#define omap_hsmmc_resume		NULL
> +#define omap_hsmmc_resume	NULL
>  #endif
> =20
>  static int omap_hsmmc_runtime_suspend(struct device *dev)
> @@ -2138,6 +2141,8 @@ static int omap_hsmmc_runtime_resume(struct device =
*dev)
>  static struct dev_pm_ops omap_hsmmc_dev_pm_ops =3D {
>  	.suspend	=3D omap_hsmmc_suspend,
>  	.resume		=3D omap_hsmmc_resume,
> +	.prepare	=3D omap_hsmmc_prepare,
> +	.complete	=3D omap_hsmmc_complete,
>  	.runtime_suspend =3D omap_hsmmc_runtime_suspend,
>  	.runtime_resume =3D omap_hsmmc_runtime_resume,
>  };
> --=20
> 1.8.0.rc0
>=20

--=20
balbi

--J8DmsxNGmrt1tVhI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQhUmrAAoJEIaOsuA1yqREr7YP+gKkQTHjxhaFoVElesVQnUT0
T9vAKxMkfFPLJn6ulPLvDsOXR2bCSJ34zLRVbOgztMqiTc+/PRH6UyRKPuAmKCuU
Dh/MAqscKU0w3uR+jRU9a59egvM1ayNDhnYkzu2xuqx3pbUAZPBwyBHA76LsggnZ
kwkvDlzzu/nTqTlM7JeDDsBzvwVZQBVpHm4j+/24uzzb5DthW9FH92BO6Kaz7TUx
vDh58Wnnhxi70I95PZZlAxLnp0Myu1VpLw4Xy9ncFgaBBYU4ogDcN7rZzefiNBnW
lLxcE0t9fa4mhZNsdOaUQuO692lYKKCnvz324aVt7bgWBXMH4KW2q2WNCLPQcA7Y
8eYDz5KYTPe5GUnkVMP7fk1RfOORaYWvUDEiD+a94L+rpocl/0PhVRwAiba93U+f
lts06OzvCgSb8JtxiAqFl9Tnz4P/dwd9q2v83d2fA756DdDc4V5z3LOcxsmfl/wo
en/hnwEbfvKXfSeC2LYXuoHMxeOL9JTfaXogsHJnHAH8RMci1oy3QgxAahmWWdXm
VqrgTAwzXK96bXETDrQidcquEUNKh7kdXDP7k0gk+8SwOsaxwb+nqGvnF9j29LHC
8hqD4Ilb7c5Lu+3CO/XatbjJ/9oaMM9vVKCcDf18IelyXdJ4Cop9bq8SVyGqluI3
wdA12c7GILBluzWRK2em
=rz6+
-----END PGP SIGNATURE-----

--J8DmsxNGmrt1tVhI--
