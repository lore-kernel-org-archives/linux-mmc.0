From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH 1/4] mmc: sdhci-pltfm: Add structure for host-specific data
Date: Sun, 26 Sep 2010 05:02:29 -0400
Message-ID: <AANLkTimcscR56u=-iT9v5V+Tsg2KNOqiuQ2DKojJ++6c@mail.gmail.com>
References: <1285072210-10207-1-git-send-email-w.sang@pengutronix.de>
	<1285072210-10207-2-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:37132 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751775Ab0IZJCa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 26 Sep 2010 05:02:30 -0400
Received: by iwn5 with SMTP id 5so3758735iwn.19
        for <linux-mmc@vger.kernel.org>; Sun, 26 Sep 2010 02:02:29 -0700 (PDT)
In-Reply-To: <1285072210-10207-2-git-send-email-w.sang@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Anton Vorontsov <cbouatmailru@gmail.com>, Richard Zhu <r65037@freescale.com>

On Tue, Sep 21, 2010 at 8:30 AM, Wolfram Sang <w.sang@pengutronix.de> w=
rote:
> We need to carry some information per host, e.g. the clock. Add a
> structure for it and initialize it in the generic part.
>
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> ---
> =A0drivers/mmc/host/sdhci-pltfm.c | =A0 =A07 +++++--
> =A0drivers/mmc/host/sdhci-pltfm.h | =A0 =A05 +++++
> =A02 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-=
pltfm.c
> index e045e3c..bf522a1 100644
> --- a/drivers/mmc/host/sdhci-pltfm.c
> +++ b/drivers/mmc/host/sdhci-pltfm.c
> @@ -55,6 +55,7 @@ static int __devinit sdhci_pltfm_probe(struct platf=
orm_device *pdev)
> =A0 =A0 =A0 =A0struct sdhci_pltfm_data *pdata =3D pdev->dev.platform_=
data;
> =A0 =A0 =A0 =A0const struct platform_device_id *platid =3D platform_g=
et_device_id(pdev);
> =A0 =A0 =A0 =A0struct sdhci_host *host;
> + =A0 =A0 =A0 struct sdhci_pltfm_host *pltfm_host;
> =A0 =A0 =A0 =A0struct resource *iomem;
> =A0 =A0 =A0 =A0int ret;
>
> @@ -72,15 +73,17 @@ static int __devinit sdhci_pltfm_probe(struct pla=
tform_device *pdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"experience problems.\=
n");
>
> =A0 =A0 =A0 =A0if (pdev->dev.parent)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 host =3D sdhci_alloc_host(pdev->dev.par=
ent, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host =3D sdhci_alloc_host(pdev->dev.par=
ent, sizeof(*pltfm_host));

Could you help clarify why pdev->dev.parent here, then
mmc_dev(host->mmc)  in child driver is platform, instead of specific
driver itself, is this the design.
> =A0 =A0 =A0 =A0else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 host =3D sdhci_alloc_host(&pdev->dev, 0=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host =3D sdhci_alloc_host(&pdev->dev, s=
izeof(*pltfm_host));
>

> =A0 =A0 =A0 =A0if (IS_ERR(host)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D PTR_ERR(host);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err;
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 pltfm_host =3D sdhci_priv(host);
> +
> =A0 =A0 =A0 =A0host->hw_name =3D "platform";
> =A0 =A0 =A0 =A0if (pdata && pdata->ops)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->ops =3D pdata->ops;
> diff --git a/drivers/mmc/host/sdhci-pltfm.h b/drivers/mmc/host/sdhci-=
pltfm.h
> index 900f329..c393289 100644
> --- a/drivers/mmc/host/sdhci-pltfm.h
> +++ b/drivers/mmc/host/sdhci-pltfm.h
> @@ -13,6 +13,11 @@
>
> =A0#include <linux/sdhci-pltfm.h>
>
> +struct sdhci_pltfm_host {
> + =A0 =A0 =A0 struct clk *clk;
> + =A0 =A0 =A0 u32 scratchpad; /* to handle quirks across io-accessor =
calls */
> +};
> +
How about move private data to child driver, and one call back
function alloc_host, then child driver could alloc private data,
including clk.

> =A0extern struct sdhci_pltfm_data sdhci_cns3xxx_pdata;
>
> =A0#endif /* _DRIVERS_MMC_SDHCI_PLTFM_H */
> --
> 1.7.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
