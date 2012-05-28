From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH v2 2/4] mmc: dw_mmc: fix the IDMAC sw reset
Date: Mon, 28 May 2012 12:32:10 +0900
Message-ID: <002801cd3c82$7755d020$66017060$%jun@samsung.com>
References: <006901cd37cf$81750420$845f0c60$%jun@samsung.com>
 <CALzehA3XceVSePzU5vcTNbhv7Gwvu4CR=+pjndvfyCjpoLsajw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:39040 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752983Ab2E1DcN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 27 May 2012 23:32:13 -0400
Received: from epcpsbgm1.samsung.com (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0M4P001UIR4Z64C0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 28 May 2012 12:32:11 +0900 (KST)
Received: from DOTGIHJUN01 ([12.23.118.161])
 by mmp1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0M4P00H76R5MIR90@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 28 May 2012 12:32:10 +0900 (KST)
In-reply-to: <CALzehA3XceVSePzU5vcTNbhv7Gwvu4CR=+pjndvfyCjpoLsajw@mail.gmail.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Dmitry Shmidt' <dimitrysh@android.com>
Cc: linux-mmc@vger.kernel.org, 'Chris Ball' <cjb@laptop.org>, 'Will Newton' <will.newton@imgtec.com>, 'James Hogan' <james.hogan@imgtec.com>

Dmitry Shmidt <dimitrysh@android.com>
> On Mon, May 21, 2012 at 9:01 PM, Seungwon Jeon <tgih.jun@samsung.com>=
 wrote:
> > IDMAC may not be cleaned in driver probe if it has
> > been already used in boot time. So IDMAC needs sw
> > reset newly. And DMA interface reset precedes the
> > internal DMAC reset. Additionally SDMMC_IDMAC_SWRESET
> > is replaced with magic code.
> >
> > Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> > ---
> > =A0drivers/mmc/host/dw_mmc.c | =A0 24 ++++++++++++------------
> > =A01 files changed, 12 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> > index b46faf0..98fe023 100644
> > --- a/drivers/mmc/host/dw_mmc.c
> > +++ b/drivers/mmc/host/dw_mmc.c
> > @@ -418,6 +418,8 @@ static int dw_mci_idmac_init(struct dw_mci *hos=
t)
> > =A0 =A0 =A0 =A0p->des3 =3D host->sg_dma;
> > =A0 =A0 =A0 =A0p->des0 =3D IDMAC_DES0_ER;
> >
> > + =A0 =A0 =A0 mci_writel(host, BMOD, SDMMC_IDMAC_SWRESET);
> > +
> > =A0 =A0 =A0 =A0/* Mask out interrupts - get Tx & Rx complete only *=
/
> > =A0 =A0 =A0 =A0mci_writel(host, IDINTEN, SDMMC_IDMAC_INT_NI | SDMMC=
_IDMAC_INT_RI |
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SDMMC_IDMAC_INT_TI);
> > @@ -1724,7 +1726,8 @@ static void dw_mci_work_routine_card(struct w=
ork_struct *work)
> >
> > =A0#ifdef CONFIG_MMC_DW_IDMAC
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ctrl=
 =3D mci_readl(host, BMOD);
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl =
|=3D 0x01; /* Software reset of DMA */
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* So=
ftware reset of DMA */
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl =
|=3D SDMMC_IDMAC_SWRESET;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mci_=
writel(host, BMOD, ctrl);
> > =A0#endif
> >
> > @@ -1949,10 +1952,6 @@ int dw_mci_probe(struct dw_mci *host)
> > =A0 =A0 =A0 =A0spin_lock_init(&host->lock);
> > =A0 =A0 =A0 =A0INIT_LIST_HEAD(&host->queue);
> >
> > -
> > - =A0 =A0 =A0 host->dma_ops =3D host->pdata->dma_ops;
> > - =A0 =A0 =A0 dw_mci_init_dma(host);
> > -
> > =A0 =A0 =A0 =A0/*
> > =A0 =A0 =A0 =A0 * Get the host data width - this assumes that HCON =
has been set with
> > =A0 =A0 =A0 =A0 * the correct values.
> > @@ -1980,10 +1979,11 @@ int dw_mci_probe(struct dw_mci *host)
> > =A0 =A0 =A0 =A0}
> >
> > =A0 =A0 =A0 =A0/* Reset all blocks */
> > - =A0 =A0 =A0 if (!mci_wait_reset(&host->dev, host)) {
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENODEV;
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_dmaunmap;
> > - =A0 =A0 =A0 }
> > + =A0 =A0 =A0 if (!mci_wait_reset(&host->dev, host))
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>=20
> You would probably want something like this:
> + =A0 =A0 =A0 if (!mci_wait_reset(&host->dev, host)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENODEV;
> +               goto err_free_hclk;
> +       }
This is applicable to only our local branch.

>=20
> > +
> > + =A0 =A0 =A0 host->dma_ops =3D host->pdata->dma_ops;
> > + =A0 =A0 =A0 dw_mci_init_dma(host);
> >
> > =A0 =A0 =A0 =A0/* Clear the interrupts for the host controller */
> > =A0 =A0 =A0 =A0mci_writel(host, RINTSTS, 0xFFFFFFFF);
> > @@ -2169,14 +2169,14 @@ int dw_mci_resume(struct dw_mci *host)
> > =A0 =A0 =A0 =A0if (host->vmmc)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0regulator_enable(host->vmmc);
> >
> > - =A0 =A0 =A0 if (host->dma_ops->init)
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->dma_ops->init(host);
> > -
> > =A0 =A0 =A0 =A0if (!mci_wait_reset(&host->dev, host)) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D -ENODEV;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ret;
> > =A0 =A0 =A0 =A0}
> >
> > + =A0 =A0 =A0 if (host->dma_ops->init)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->dma_ops->init(host);
> > +
> > =A0 =A0 =A0 =A0/* Restore the old value at FIFOTH register */
> > =A0 =A0 =A0 =A0mci_writel(host, FIFOTH, host->fifoth_val);
> >
> > --
> > 1.7.0.4
> >
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-mmc=
" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

