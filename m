From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: host: dw: fix possible build error
Date: Wed, 26 Feb 2014 07:03:59 +0900
Message-ID: <530D134F.5090403@samsung.com>
References: <1393340264-22687-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:24827 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751356AbaBYWDm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Feb 2014 17:03:42 -0500
In-reply-to: <1393340264-22687-1-git-send-email-balbi@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>, chris@printf.net
Cc: jh80.chung@samsung.com, tgih.jun@samsung.com, linux-mmc@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>

Hi, Felipe.

When you send the patch related with dw_mmc controller, could you use t=
he prefix "mmc: dw_mmc:"?
"mmc: dw_mmc: fix possible build error"

Acked-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

On 02/25/2014 11:57 PM, Felipe Balbi wrote:
> Fix the following build errors:
>=20
> drivers/mmc/host/dw_mmc-k3.c: In function =E2=80=98dw_mci_k3_suspend=E2=
=80=99:
> drivers/mmc/host/dw_mmc-k3.c:58:2: error: implicit declaration of
> 	function =E2=80=98dw_mci_suspend=E2=80=99 [-Werror=3Dimplicit-functi=
on-declaration]
>   ret =3D dw_mci_suspend(host);
>   ^
> drivers/mmc/host/dw_mmc-k3.c: In function =E2=80=98dw_mci_k3_resume=E2=
=80=99:
> drivers/mmc/host/dw_mmc-k3.c:76:2: error: implicit declaration of
> 	function =E2=80=98dw_mci_resume=E2=80=99 [-Werror=3Dimplicit-functio=
n-declaration]
>   return dw_mci_resume(host);
>   ^
> drivers/mmc/host/dw_mmc-k3.c: At top level:
> drivers/mmc/host/dw_mmc-k3.c:53:12: warning: =E2=80=98dw_mci_k3_suspe=
nd=E2=80=99 defined
> 	but not used [-Wunused-function]
>  static int dw_mci_k3_suspend(struct device *dev)
>             ^
> drivers/mmc/host/dw_mmc-k3.c:65:12: warning: =E2=80=98dw_mci_k3_resum=
e=E2=80=99 defined
> 	but not used [-Wunused-function]
>  static int dw_mci_k3_resume(struct device *dev)
>             ^
>=20
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  drivers/mmc/host/dw_mmc-k3.c | 2 ++
>  drivers/mmc/host/dw_mmc.h    | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/mmc/host/dw_mmc-k3.c b/drivers/mmc/host/dw_mmc-k=
3.c
> index f567c21..650f9cc 100644
> --- a/drivers/mmc/host/dw_mmc-k3.c
> +++ b/drivers/mmc/host/dw_mmc-k3.c
> @@ -50,6 +50,7 @@ static int dw_mci_k3_probe(struct platform_device *=
pdev)
>  	return dw_mci_pltfm_register(pdev, drv_data);
>  }
> =20
> +#ifdef CONFIG_PM_SLEEP
>  static int dw_mci_k3_suspend(struct device *dev)
>  {
>  	struct dw_mci *host =3D dev_get_drvdata(dev);
> @@ -75,6 +76,7 @@ static int dw_mci_k3_resume(struct device *dev)
> =20
>  	return dw_mci_resume(host);
>  }
> +#endif /* CONFIG_PM_SLEEP */
> =20
>  static SIMPLE_DEV_PM_OPS(dw_mci_k3_pmops, dw_mci_k3_suspend, dw_mci_=
k3_resume);
> =20
> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
> index 6bf24ab..1f7a745 100644
> --- a/drivers/mmc/host/dw_mmc.h
> +++ b/drivers/mmc/host/dw_mmc.h
> @@ -185,7 +185,7 @@
> =20
>  extern int dw_mci_probe(struct dw_mci *host);
>  extern void dw_mci_remove(struct dw_mci *host);
> -#ifdef CONFIG_PM
> +#ifdef CONFIG_PM_SLEEP
>  extern int dw_mci_suspend(struct dw_mci *host);
>  extern int dw_mci_resume(struct dw_mci *host);
>  #endif
>=20

