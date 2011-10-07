From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 5/5] omap: hsmmc: use platform_driver_register
Date: Fri, 7 Oct 2011 16:28:53 -0600
Message-ID: <CACxGe6uTqCNSTECgFu51-Zu0YY2iy0mkjrrtfAJBC0zzQKTPpQ@mail.gmail.com>
References: <1317962127-29003-1-git-send-email-manjugk@ti.com> <1317962127-29003-6-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:35219 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754693Ab1JGW3P convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 7 Oct 2011 18:29:15 -0400
In-Reply-To: <1317962127-29003-6-git-send-email-manjugk@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <greg@kroah.com>, Dilan Lee <dilee@nvidia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Manjunath GKondaiah <manjunath.gkondaiah@linaro.org>, Arnd Bergmann <arnd@arndb.de>

On Thu, Oct 6, 2011 at 11:05 PM, G, Manjunath Kondaiah <manjugk@ti.com>=
 wrote:
>
> Existing omap hsmmc driver uses "platform_driver_probe" in init
> function. Change it to use "platform_driver_register" in order to
> use deferral probe mechanism.
>
> Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
> Reported-by: Grant Likely <grant.likely@secretlab.ca>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
> Cc: linux-omap@vger.kernel.org
> Cc: linux-mmc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Greg Kroah-Hartman <greg@kroah.com>
> Cc: Dilan Lee <dilee@nvidia.com>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Manjunath GKondaiah <manjunath.gkondaiah@linaro.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
>
> =A0drivers/mmc/host/omap_hsmmc.c | =A0 =A07 ++++---
> =A01 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hs=
mmc.c
> index 21e4a79..8dd2e7c 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1862,7 +1862,7 @@ static void omap_hsmmc_debugfs(struct mmc_host =
*mmc)
>
> =A0#endif
>
> -static int __init omap_hsmmc_probe(struct platform_device *pdev)
> +static int __devinit omap_hsmmc_probe(struct platform_device *pdev)
> =A0{
> =A0 =A0 =A0 =A0struct omap_mmc_platform_data *pdata =3D pdev->dev.pla=
tform_data;
> =A0 =A0 =A0 =A0struct mmc_host *mmc;
> @@ -2077,6 +2077,7 @@ static int __init omap_hsmmc_probe(struct platf=
orm_device *pdev)
> =A0 =A0 =A0 =A0pm_runtime_mark_last_busy(host->dev);
> =A0 =A0 =A0 =A0pm_runtime_put_autosuspend(host->dev);
>
> + =A0 =A0 =A0 dev_dbg(mmc_dev(host->mmc), "Probe success...\n");
> =A0 =A0 =A0 =A0return 0;
>
> =A0err_slot_name:
> @@ -2270,6 +2271,7 @@ static struct dev_pm_ops omap_hsmmc_dev_pm_ops =
=3D {
> =A0};
>
> =A0static struct platform_driver omap_hsmmc_driver =3D {
> + =A0 =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D omap_hsmmc_probe,
> =A0 =A0 =A0 =A0.remove =A0 =A0 =A0 =A0 =3D omap_hsmmc_remove,
> =A0 =A0 =A0 =A0.driver =A0 =A0 =A0 =A0 =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =3D DRIVER_NAME,
> @@ -2280,8 +2282,7 @@ static struct platform_driver omap_hsmmc_driver=
 =3D {
>
> =A0static int __init omap_hsmmc_init(void)
> =A0{
> - =A0 =A0 =A0 /* Register the MMC driver */
> - =A0 =A0 =A0 return platform_driver_probe(&omap_hsmmc_driver, omap_h=
smmc_probe);
> + =A0 =A0 =A0 return platform_driver_register(&omap_hsmmc_driver);
> =A0}
>
> =A0static void __exit omap_hsmmc_cleanup(void)
> --
> 1.7.4.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
