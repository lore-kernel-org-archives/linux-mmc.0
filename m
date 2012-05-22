From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH 2/4] mmc: dw_mmc: fix the IDMAC sw reset
Date: Tue, 22 May 2012 12:34:12 +0900
Message-ID: <006301cd37cb$c167da70$44378f50$%jun@samsung.com>
References: <003301cd3640$dfa1eb70$9ee5c250$%jun@samsung.com>
 <CAFbHwiQtKvut6yNiwkHRZEptidQMYa7DKUrFsTAd69tTihrwDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:64774 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758858Ab2EVDeb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 May 2012 23:34:31 -0400
Received: from epcpsbgm2.samsung.com (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0M4E006Z3N7QIOA0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 22 May 2012 12:34:12 +0900 (KST)
Received: from DOTGIHJUN01 ([12.23.118.161])
 by mmp1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0M4E009M2N90PJM0@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 22 May 2012 12:34:12 +0900 (KST)
In-reply-to: <CAFbHwiQtKvut6yNiwkHRZEptidQMYa7DKUrFsTAd69tTihrwDA@mail.gmail.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Will Newton' <will.newton@gmail.com>
Cc: linux-mmc@vger.kernel.org, 'Chris Ball' <cjb@laptop.org>, 'James Hogan' <james.hogan@imgtec.com>

Will Newton <will.newton@gmail.com> wrote:
> On Sun, May 20, 2012 at 5:27 AM, Seungwon Jeon <tgih.jun@samsung.com>=
 wrote:
> > IDMAC may not be cleaned in driver probe if it has
> > been already used in boot time. So IDMAC needs sw
> > reset newly. And DMA interface reset precedes the
> > internal DMAC reset. Additionally SDMMC_IDMAC_SWRESET
> > is replaced with magic code.
> >
> > Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> > ---
> > =A0drivers/mmc/host/dw_mmc.c | =A0 18 ++++++++++--------
> > =A01 files changed, 10 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> > index b46faf0..44aa292 100644
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
> > @@ -1985,6 +1984,9 @@ int dw_mci_probe(struct dw_mci *host)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_dmaunmap;
> > =A0 =A0 =A0 =A0}
> >
> > + =A0 =A0 =A0 host->dma_ops =3D host->pdata->dma_ops;
> > + =A0 =A0 =A0 dw_mci_init_dma(host);
> > +
>=20
> I think this change may break the error handling. The error label
> err_dmaunmap jumped to above expects
> that host->dma_ops is non-NULL. Please check that the error handling =
is ok.
Right. I'll apply it.

Thanks,
Seungwon Jeon
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

