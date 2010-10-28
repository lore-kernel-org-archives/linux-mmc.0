From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [PATCH 1/1]sdhci-pxa: add MMC_CAP_NONREMOVABLE for on-chip device
Date: Thu, 28 Oct 2010 12:42:26 +0900
Message-ID: <AANLkTim6_wuc+zSg7qKwGDAAiYfXTqjiMRJiffzNPvCY@mail.gmail.com>
References: <AANLkTik+Kg+po=na4Vx6B+BmJMAN_-bq+cB3VrvDpB38@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:56331 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757995Ab0J1Dm1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Oct 2010 23:42:27 -0400
Received: by wwi18 with SMTP id 18so2385326wwi.1
        for <linux-mmc@vger.kernel.org>; Wed, 27 Oct 2010 20:42:26 -0700 (PDT)
In-Reply-To: <AANLkTik+Kg+po=na4Vx6B+BmJMAN_-bq+cB3VrvDpB38@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Matt Fleming <matt@console-pimps.org>, eric.y.miao@gmail.com, Haojian Zhuang <haojian.zhuang@gmail.com>, Philip Rakity <prakity@marvell.com>

On Thu, Oct 28, 2010 at 11:54 AM, zhangfei gao <zhangfei.gao@gmail.com>=
 wrote:
> From 7f3529c21815990ebe4eec684e3c96156f774637 Mon Sep 17 00:00:00 200=
1
> From: Zhangfei Gao <zhangfei.gao@marvell.com>
> Date: Thu, 28 Oct 2010 10:44:15 -0400
> Subject: [PATCH] sdhci-pxa: add MMC_CAP_NONREMOVABLE for on-chip devi=
ce
>
> =A0 =A0 =A0 =A0To share SDHCI_QUIRK_BROKEN_CARD_DETECTION for on-chip=
 device,
> MMC_CAP_NONREMOVABLE also needed, otherwise polling mode used by
> default
>
> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
> CC: Philip Rakity <prakity@marvell.com>
> ---
> =A0arch/arm/plat-pxa/include/plat/sdhci.h | =A0 =A02 ++
> =A0drivers/mmc/host/sdhci-pxa.c =A0 =A0 =A0 =A0 =A0 | =A0 =A08 ++++++=
++
> =A02 files changed, 10 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/plat-pxa/include/plat/sdhci.h
> b/arch/arm/plat-pxa/include/plat/sdhci.h
> index e49c5b6..fc5ceab 100644
> --- a/arch/arm/plat-pxa/include/plat/sdhci.h
> +++ b/arch/arm/plat-pxa/include/plat/sdhci.h
> @@ -16,6 +16,8 @@
> =A0/* pxa specific flag */
> =A0/* Require clock free running */
> =A0#define PXA_FLAG_DISABLE_CLOCK_GATING (1<<0)
> +/* card alwayes wired to host, like on-chip emmc */
> +#define PXA_FLAG_CARD_PERMANENT =A0 =A0 =A0 =A0(1<<1)
>
> =A0/*
> =A0* struct pxa_sdhci_platdata() - Platform device data for PXA SDHCI
> diff --git a/drivers/mmc/host/sdhci-pxa.c b/drivers/mmc/host/sdhci-px=
a.c
> index fc406ac..a88c797 100644
> --- a/drivers/mmc/host/sdhci-pxa.c
> +++ b/drivers/mmc/host/sdhci-pxa.c
> @@ -138,6 +138,12 @@ static int __devinit sdhci_pxa_probe(struct
> platform_device *pdev)
> =A0 =A0 =A0 =A0host->irq =3D irq;
> =A0 =A0 =A0 =A0host->quirks =3D SDHCI_QUIRK_BROKEN_ADMA | SDHCI_QUIRK=
_BROKEN_TIMEOUT_VAL;
>
> + =A0 =A0 =A0 if (pxa->pdata->flags & PXA_FLAG_CARD_PERMANENT) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* on-chip device */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->quirks |=3D SDHCI_QUIRK_BROKEN_CA=
RD_DETECTION;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->mmc->caps =3D MMC_CAP_NONREMOVABL=
E;
As we don't know if mmc->caps are passing from platform data, how
about to ORing at this case?

Thank you,
Kyungmin Park
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0if (pdata->quirks)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->quirks |=3D pdata->quirks;
>
> @@ -149,6 +155,8 @@ static int __devinit sdhci_pxa_probe(struct
> platform_device *pdev)
>
> =A0 =A0 =A0 =A0if (pxa->pdata->max_speed)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->mmc->f_max =3D pxa->pdata->max_s=
peed;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->mmc->f_max =3D 50000000;
>
> =A0 =A0 =A0 =A0platform_set_drvdata(pdev, host);
>
> --
> 1.7.0.4
>
