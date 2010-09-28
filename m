From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [patch 1/3] sdhci-pltfm: add call back alloc_host
Date: Tue, 28 Sep 2010 10:08:27 -0400
Message-ID: <AANLkTikmEGpRdbdfCxgY2Qy9c--TeTh+ywVc-Qkevssf@mail.gmail.com>
References: <AANLkTin_BEE+LgZuJHeewvFDUQCipG98ZbkhMJGbnprC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:36507 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755244Ab0I1OIk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Sep 2010 10:08:40 -0400
Received: by iwn5 with SMTP id 5so6015745iwn.19
        for <linux-mmc@vger.kernel.org>; Tue, 28 Sep 2010 07:08:39 -0700 (PDT)
In-Reply-To: <AANLkTin_BEE+LgZuJHeewvFDUQCipG98ZbkhMJGbnprC@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Wolfram Sang <w.sang@pengutronix.de>
Cc: eric.y.miao@gmail.com, Haojian Zhuang <haojian.zhuang@gmail.com>

On Sun, Sep 26, 2010 at 10:55 PM, zhangfei gao <zhangfei.gao@gmail.com>=
 wrote:
> From 7a870a620fa868ed4ce0cffcbd6b0683a00ae2e5 Mon Sep 17 00:00:00 200=
1
> From: Zhangfei Gao <zhangfei.gao@marvell.com>
> Date: Mon, 27 Sep 2010 10:30:01 -0400
> Subject: [PATCH 1/3] sdhci-pltfm: add call back alloc_host
>
> =A0 =A0 =A0 =A0alloc_host could alloc specific structure of device to=
 meet different
> requirement
>
> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
> ---
> =A0drivers/mmc/host/sdhci-pltfm.c | =A0 =A04 ++--
> =A0include/linux/sdhci-pltfm.h =A0 =A0| =A0 =A01 +
> =A02 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-=
pltfm.c
> index 9669f21..82d3d05 100644
> --- a/drivers/mmc/host/sdhci-pltfm.c
> +++ b/drivers/mmc/host/sdhci-pltfm.c
> @@ -76,8 +76,8 @@ static int __devinit sdhci_pltfm_probe(struct
> platform_device *pdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&pdev->dev, "Invalid iomem siz=
e. You may "
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"experience problems.\=
n");
>
> - =A0 =A0 =A0 if (pdev->dev.parent)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 host =3D sdhci_alloc_host(pdev->dev.par=
ent, 0);
> + =A0 =A0 =A0 if (pdata && pdata->alloc_host)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host =3D pdata->alloc_host(&pdev->dev);
> =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host =3D sdhci_alloc_host(&pdev->dev, =
0);
>
> diff --git a/include/linux/sdhci-pltfm.h b/include/linux/sdhci-pltfm.=
h
> index e14fce3..80c415e 100644
> --- a/include/linux/sdhci-pltfm.h
> +++ b/include/linux/sdhci-pltfm.h
> @@ -30,6 +30,7 @@ struct sdhci_pltfm_data {
> =A0 =A0 =A0 =A0unsigned int quirks;
> =A0 =A0 =A0 =A0int (*init)(struct sdhci_host *host, struct sdhci_pltf=
m_data *pdata,
> void* priv_pdata);
> =A0 =A0 =A0 =A0void (*exit)(struct sdhci_host *host);
> + =A0 =A0 =A0 struct sdhci_host *(*alloc_host)(struct device *dev);
> =A0};
>
> =A0#endif /* _SDHCI_PLTFM_H */
> --
> 1.7.0.4
>

Any feed back, much thanks.
