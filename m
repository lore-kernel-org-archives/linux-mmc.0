From: Dmitry Shmidt <dimitrysh@android.com>
Subject: Re: [PATCH v2 2/4] mmc: dw_mmc: fix the IDMAC sw reset
Date: Wed, 23 May 2012 10:33:34 -0700
Message-ID: <CALzehA3XceVSePzU5vcTNbhv7Gwvu4CR=+pjndvfyCjpoLsajw@mail.gmail.com>
References: <006901cd37cf$81750420$845f0c60$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:63745 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757228Ab2EWRdg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 23 May 2012 13:33:36 -0400
Received: by lahd3 with SMTP id d3so5296587lah.19
        for <linux-mmc@vger.kernel.org>; Wed, 23 May 2012 10:33:34 -0700 (PDT)
In-Reply-To: <006901cd37cf$81750420$845f0c60$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Will Newton <will.newton@imgtec.com>, James Hogan <james.hogan@imgtec.com>

On Mon, May 21, 2012 at 9:01 PM, Seungwon Jeon <tgih.jun@samsung.com> w=
rote:
> IDMAC may not be cleaned in driver probe if it has
> been already used in boot time. So IDMAC needs sw
> reset newly. And DMA interface reset precedes the
> internal DMAC reset. Additionally SDMMC_IDMAC_SWRESET
> is replaced with magic code.
>
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> ---
> =A0drivers/mmc/host/dw_mmc.c | =A0 24 ++++++++++++------------
> =A01 files changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index b46faf0..98fe023 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -418,6 +418,8 @@ static int dw_mci_idmac_init(struct dw_mci *host)
> =A0 =A0 =A0 =A0p->des3 =3D host->sg_dma;
> =A0 =A0 =A0 =A0p->des0 =3D IDMAC_DES0_ER;
>
> + =A0 =A0 =A0 mci_writel(host, BMOD, SDMMC_IDMAC_SWRESET);
> +
> =A0 =A0 =A0 =A0/* Mask out interrupts - get Tx & Rx complete only */
> =A0 =A0 =A0 =A0mci_writel(host, IDINTEN, SDMMC_IDMAC_INT_NI | SDMMC_I=
DMAC_INT_RI |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SDMMC_IDMAC_INT_TI);
> @@ -1724,7 +1726,8 @@ static void dw_mci_work_routine_card(struct wor=
k_struct *work)
>
> =A0#ifdef CONFIG_MMC_DW_IDMAC
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ctrl =3D=
 mci_readl(host, BMOD);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl |=3D=
 0x01; /* Software reset of DMA */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Soft=
ware reset of DMA */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl |=3D=
 SDMMC_IDMAC_SWRESET;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mci_wr=
itel(host, BMOD, ctrl);
> =A0#endif
>
> @@ -1949,10 +1952,6 @@ int dw_mci_probe(struct dw_mci *host)
> =A0 =A0 =A0 =A0spin_lock_init(&host->lock);
> =A0 =A0 =A0 =A0INIT_LIST_HEAD(&host->queue);
>
> -
> - =A0 =A0 =A0 host->dma_ops =3D host->pdata->dma_ops;
> - =A0 =A0 =A0 dw_mci_init_dma(host);
> -
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * Get the host data width - this assumes that HCON ha=
s been set with
> =A0 =A0 =A0 =A0 * the correct values.
> @@ -1980,10 +1979,11 @@ int dw_mci_probe(struct dw_mci *host)
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0/* Reset all blocks */
> - =A0 =A0 =A0 if (!mci_wait_reset(&host->dev, host)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENODEV;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_dmaunmap;
> - =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (!mci_wait_reset(&host->dev, host))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;

You would probably want something like this:
+ =A0 =A0 =A0 if (!mci_wait_reset(&host->dev, host)) {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENODEV;
+               goto err_free_hclk;
+       }

> +
> + =A0 =A0 =A0 host->dma_ops =3D host->pdata->dma_ops;
> + =A0 =A0 =A0 dw_mci_init_dma(host);
>
> =A0 =A0 =A0 =A0/* Clear the interrupts for the host controller */
> =A0 =A0 =A0 =A0mci_writel(host, RINTSTS, 0xFFFFFFFF);
> @@ -2169,14 +2169,14 @@ int dw_mci_resume(struct dw_mci *host)
> =A0 =A0 =A0 =A0if (host->vmmc)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0regulator_enable(host->vmmc);
>
> - =A0 =A0 =A0 if (host->dma_ops->init)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->dma_ops->init(host);
> -
> =A0 =A0 =A0 =A0if (!mci_wait_reset(&host->dev, host)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D -ENODEV;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ret;
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 if (host->dma_ops->init)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->dma_ops->init(host);
> +
> =A0 =A0 =A0 =A0/* Restore the old value at FIFOTH register */
> =A0 =A0 =A0 =A0mci_writel(host, FIFOTH, host->fifoth_val);
>
> --
> 1.7.0.4
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
