From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [RFC] sdhci_pltfm: pass platform_data on custom init-call
Date: Mon, 27 Sep 2010 10:47:23 +0800
Message-ID: <AANLkTi=o66ZKXfvAoK61Wtxv4emyDLZCc5v+6+A3MaWY@mail.gmail.com>
References: <1285073767-19900-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:49645 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758686Ab0I0CrX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 26 Sep 2010 22:47:23 -0400
Received: by iwn5 with SMTP id 5so4364379iwn.19
        for <linux-mmc@vger.kernel.org>; Sun, 26 Sep 2010 19:47:23 -0700 (PDT)
In-Reply-To: <1285073767-19900-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, Richard Zhu <r65037@freescale.com>

On Tue, Sep 21, 2010 at 8:56 PM, Wolfram Sang <w.sang@pengutronix.de> w=
rote:
> The custom init call may need more data to perform its job, so we pas=
s it a
> pointer to the platform_data, too. Now, for drivers extending sdhci-p=
ltfm (like
> sdhci-cns3xxx), a fixed platform_data is used according to the platfo=
rm device
> id. Because that one does not contain board specific information, we =
simply
> name the board specific information information priv_pdata and pass i=
t to the
> init routine as well. (Note: the old behaviour was that you could ove=
rride the
> platform id specific data with your own. However, one can still do th=
is by
> using the "sdhci" id instead of "sdhci-<something>".)
>
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> ---
>
> This approach has its issues, but all I tried had some. So, let's sta=
rt arguing
> over code ;)
>
> =A0drivers/mmc/host/sdhci-esdhc.c =A0| =A0 =A03 ++-
> =A0drivers/mmc/host/sdhci-pltfm.c =A0| =A0 11 ++++++++---
> =A0include/linux/mmc/sdhci-pltfm.h | =A0 =A02 +-
> =A03 files changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc.c b/drivers/mmc/host/sdhci-=
esdhc.c
> index 132e9c9..ccdafd9 100644
> --- a/drivers/mmc/host/sdhci-esdhc.c
> +++ b/drivers/mmc/host/sdhci-esdhc.c

Can not find such file, and specific driver should handle in different =
patch

> @@ -97,7 +97,8 @@ static unsigned int esdhc_pltfm_get_min_clock(struc=
t sdhci_host *host)
> =A0 =A0 =A0 =A0return clk_get_rate(pltfm_host->clk) / 256 / 16;
> =A0}
>
> -static int esdhc_pltfm_init(struct sdhci_host *host)
> +static int esdhc_pltfm_init(struct sdhci_host *host,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct sdhci_pltfm_data *pdata, void *p=
riv_pdata)
> =A0{
> =A0 =A0 =A0 =A0struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(hos=
t);
> =A0 =A0 =A0 =A0struct clk *clk;
> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-=
pltfm.c
> index 6ba3f3d..04f3117 100644
> --- a/drivers/mmc/host/sdhci-pltfm.c
> +++ b/drivers/mmc/host/sdhci-pltfm.c
> @@ -52,15 +52,20 @@ static struct sdhci_ops sdhci_pltfm_ops =3D {
>
> =A0static int __devinit sdhci_pltfm_probe(struct platform_device *pde=
v)
> =A0{
> - =A0 =A0 =A0 struct sdhci_pltfm_data *pdata =3D pdev->dev.platform_d=
ata;
> =A0 =A0 =A0 =A0const struct platform_device_id *platid =3D platform_g=
et_device_id(pdev);
> + =A0 =A0 =A0 struct sdhci_pltfm_data *pdata;
> + =A0 =A0 =A0 void *priv_pdata =3D NULL;
> =A0 =A0 =A0 =A0struct sdhci_host *host;
> =A0 =A0 =A0 =A0struct sdhci_pltfm_host *pltfm_host;
> =A0 =A0 =A0 =A0struct resource *iomem;
> =A0 =A0 =A0 =A0int ret;
>
> - =A0 =A0 =A0 if (!pdata && platid && platid->driver_data)
> + =A0 =A0 =A0 if (platid && platid->driver_data) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pdata =3D (void *)platid->driver_data;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 priv_pdata =3D pdev->dev.platform_data;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata =3D pdev->dev.platform_data;
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0iomem =3D platform_get_resource(pdev, IORESOURCE_MEM, =
0);
> =A0 =A0 =A0 =A0if (!iomem) {
> @@ -108,7 +113,7 @@ static int __devinit sdhci_pltfm_probe(struct pla=
tform_device *pdev)
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0if (pdata && pdata->init) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D pdata->init(host);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D pdata->init(host, pdata, priv_p=
data);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (ret)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_plat_init;
> =A0 =A0 =A0 =A0}
> diff --git a/include/linux/mmc/sdhci-pltfm.h b/include/linux/mmc/sdhc=
i-pltfm.h

include/linux/mmc/sdhci-pltfm.h should be include/linux/sdhci-pltfm.h

> index 0239bd7..e14fce3 100644
> --- a/include/linux/mmc/sdhci-pltfm.h
> +++ b/include/linux/mmc/sdhci-pltfm.h
> @@ -28,7 +28,7 @@ struct sdhci_host;
> =A0struct sdhci_pltfm_data {
> =A0 =A0 =A0 =A0struct sdhci_ops *ops;
> =A0 =A0 =A0 =A0unsigned int quirks;
> - =A0 =A0 =A0 int (*init)(struct sdhci_host *host);
> + =A0 =A0 =A0 int (*init)(struct sdhci_host *host, struct sdhci_pltfm=
_data *pdata, void* priv_pdata);
> =A0 =A0 =A0 =A0void (*exit)(struct sdhci_host *host);
> =A0};
>
> --
> 1.7.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
