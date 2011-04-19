From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 1/5] mmc: sdhci: make sdhci-pltfm device drivers self
	registered
Date: Tue, 19 Apr 2011 12:20:42 +0200
Message-ID: <20110419102042.GB4164@pengutronix.de>
References: <1301042931-4869-1-git-send-email-shawn.guo@linaro.org>
	<1301042931-4869-2-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1324334975346481199=="
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <1301042931-4869-2-git-send-email-shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


--===============1324334975346481199==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WYTEVAkct0FjGQmd"
Content-Disposition: inline


--WYTEVAkct0FjGQmd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On Fri, Mar 25, 2011 at 04:48:47PM +0800, Shawn Guo wrote:
> The patch turns the common stuff in sdhci-pltfm.c into functions, and
> add device drivers their own .probe and .remove which in turn call
> into the common functions, so that those sdhci-pltfm device drivers
> register itself and keep all device specific things away from common
> sdhci-pltfm file.
>=20
> Signed-off-by: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---

I'll second the comments from Grant (with one slight exception which is
noted below)

> +static int __devexit sdhci_dove_remove(struct platform_device *pdev)
> +{
> +	struct sdhci_host *host =3D platform_get_drvdata(pdev);
> +	int dead =3D 0;
> +	u32 scratch;
> +
> +	scratch =3D readl(host->ioaddr + SDHCI_INT_STATUS);
> +	if (scratch =3D=3D (u32)-1)
> +		dead =3D 1;

I'd prefer

	dead =3D (readl() =3D=3D 0xffffffff);

(or (u32)-1 if you prefer). But keeping a variable 'dead' is more
descriptive than keeping 'scratch'.

> +MODULE_LICENSE("GPL v2");

Just to be sure: Did you double-check if the original licenses were v2
or v2+?

> --- a/drivers/mmc/host/sdhci-pltfm.c
> +++ b/drivers/mmc/host/sdhci-pltfm.c

[...]

> -err_add_host:
> -	if (pdata && pdata->exit)
> -		pdata->exit(host);
> -err_plat_init:
> -	iounmap(host->ioaddr);
>  err_remap:
>  	release_mem_region(iomem->start, resource_size(iomem));
>  err_request:
>  	sdhci_free_host(host);
>  err:
> -	printk(KERN_ERR"Probing of sdhci-pltfm failed: %d\n", ret);
> -	return ret;
> +	pr_err("%s failed %d\n", __func__, ret);

dev_err?

> +	return NULL;
>  }
> =20

I didn't pay much attention to the OF version of the tegra driver, since
it still is not upstream yet, right?

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--WYTEVAkct0FjGQmd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk2tYfoACgkQD27XaX1/VRvprwCeOxMrsgcOBL12C+TW1Ypwa2bC
O8EAoJrQQOY/Bp94vhs1M4E3euHC3pSj
=BvdF
-----END PGP SIGNATURE-----

--WYTEVAkct0FjGQmd--


--===============1324334975346481199==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linaro-dev mailing list
linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
http://lists.linaro.org/mailman/listinfo/linaro-dev

--===============1324334975346481199==--
