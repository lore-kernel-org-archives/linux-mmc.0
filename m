From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [patch 1/3] sdhci-pltfm: add call back get_quirk
Date: Tue, 28 Sep 2010 10:11:05 -0400
Message-ID: <AANLkTinY_zdF457ePv0tTMRsxz_49BN4Y7h=+u0c+Eud@mail.gmail.com>
References: <AANLkTimjF_rL7CcPQDo=LUa6GfofmqM0uGRJ1ZjVMDZn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:57725 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755365Ab0I1OLH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Sep 2010 10:11:07 -0400
Received: by pxi10 with SMTP id 10so1696705pxi.19
        for <linux-mmc@vger.kernel.org>; Tue, 28 Sep 2010 07:11:06 -0700 (PDT)
In-Reply-To: <AANLkTimjF_rL7CcPQDo=LUa6GfofmqM0uGRJ1ZjVMDZn@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Wolfram Sang <w.sang@pengutronix.de>, eric.y.miao@gmail.com, Haojian Zhuang <haojian.zhuang@gmail.com>

On Sun, Sep 26, 2010 at 10:57 PM, zhangfei gao <zhangfei.gao@gmail.com>=
 wrote:
> From af7aa1232efd3bb3bf3eac151b71dba7d4a0c875 Mon Sep 17 00:00:00 200=
1
> From: Zhangfei Gao <zhangfei.gao@marvell.com>
> Date: Mon, 27 Sep 2010 10:33:38 -0400
> Subject: [PATCH 2/3] dhci-pltfm: add call back get_quirk
>
> =A0 =A0 =A0 =A0One driver may serve several device, each one may have=
 different
> quirks instead of the initial one.
>
> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
> ---
> =A0drivers/mmc/host/sdhci-pltfm.c | =A0 =A08 ++++++--
> =A0include/linux/sdhci-pltfm.h =A0 =A0| =A0 =A01 +
> =A02 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-=
pltfm.c
> index 82d3d05..5c3c513 100644
> --- a/drivers/mmc/host/sdhci-pltfm.c
> +++ b/drivers/mmc/host/sdhci-pltfm.c
> @@ -91,8 +91,7 @@ static int __devinit sdhci_pltfm_probe(struct
> platform_device *pdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->ops =3D pdata->ops;
> =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->ops =3D &sdhci_pltfm_ops;
> - =A0 =A0 =A0 if (pdata)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->quirks =3D pdata->quirks;
> +
> =A0 =A0 =A0 =A0host->irq =3D platform_get_irq(pdev, 0);
>
> =A0 =A0 =A0 =A0if (!request_mem_region(iomem->start, resource_size(io=
mem),
> @@ -115,6 +114,11 @@ static int __devinit sdhci_pltfm_probe(struct
> platform_device *pdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_plat_init;
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 if (pdata && pdata->get_quirk)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->quirks =3D pdata->get_quirk(host)=
;
> + =A0 =A0 =A0 else if (pdata)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->quirks =3D pdata->quirks;
> +
> =A0 =A0 =A0 =A0ret =3D sdhci_add_host(host);
> =A0 =A0 =A0 =A0if (ret)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_add_host;
> diff --git a/include/linux/sdhci-pltfm.h b/include/linux/sdhci-pltfm.=
h
> index 80c415e..0d20cb4 100644
> --- a/include/linux/sdhci-pltfm.h
> +++ b/include/linux/sdhci-pltfm.h
> @@ -30,6 +30,7 @@ struct sdhci_pltfm_data {
> =A0 =A0 =A0 =A0unsigned int quirks;
> =A0 =A0 =A0 =A0int (*init)(struct sdhci_host *host, struct sdhci_pltf=
m_data *pdata,
> void* priv_pdata);
> =A0 =A0 =A0 =A0void (*exit)(struct sdhci_host *host);
> + =A0 =A0 =A0 unsigned int =A0(*get_quirk)(struct sdhci_host *host);
> =A0 =A0 =A0 =A0struct sdhci_host *(*alloc_host)(struct device *dev);
> =A0};
>
> --
> 1.7.0.4
>

Any feed back, the different device may require different quirk, so we
can not set the same one set in init.
