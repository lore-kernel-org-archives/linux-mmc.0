From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH 2/2] mmc: dw_mmc: make sure of clearing HLE interrupt
Date: Thu, 29 Nov 2012 16:35:24 +0900
Message-ID: <001201cdce04$187dc8a0$497959e0$%jun@samsung.com>
References: <001c01cdcd52$e58a2260$b09e6720$%jun@samsung.com>
 <50B5EB38.9030401@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:29454 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750938Ab2K2Hf1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Nov 2012 02:35:27 -0500
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0ME8009WWNQKNDE0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 29 Nov 2012 16:35:25 +0900 (KST)
Received: from DOTGIHJUN01 ([12.23.118.161])
 by mmp2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0ME800LWCNR0LB10@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 29 Nov 2012 16:35:25 +0900 (KST)
In-reply-to: <50B5EB38.9030401@imgtec.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'James Hogan' <james.hogan@imgtec.com>
Cc: linux-mmc@vger.kernel.org, 'Chris Ball' <cjb@laptop.org>, 'Will Newton' <will.newton@imgtec.com>, 'Jaehoon Chung' <jh80.chung@samsung.com>

Hi James,

On Wednesday, November 28, 2012, James Hogan wrote:
> Hi,
>=20
> On 28/11/12 10:26, Seungwon Jeon wrote:
> > Even though HLE interrupt is enabled, there is no touch.
> > This patch clears HLE interrupt which is not unhandled.
>=20
> It's not entirely clear from this description what the patch is tryin=
g
> to do. I presume from the patch you're trying to say something like:
> "Even though the HLE interrupt is enabled, it isn't handled, so handl=
e
> the HLE interrupt by printing an error message."
Currently, there is no code to clean the HLE interrupt, when it happens=
=2E
So, interrupt will signaled permanently and then system is affected bad=
ly.
The purpose of this patch to prevent this. Printing an message is just =
to inform error.

>=20
> According to the TRM though, in the section Error Handling (HLE is al=
so
> mentioned elsewhere):
> >  Hardware locked error =E2=80=93 Set when the DWC_mobile_storage ca=
nnot load a command issued by
> > software. When software sets the start_cmd bit in the CMD register,=
 the DWC_mobile_storage tries
> > to load the command. If the command buffer is already filled with a=
 command, this error is raised.
> > The software then has to reload the command.
>=20
> So it sounds like the last command should be reloaded (either on
> interrupt or the interrupt status should be checked after starting a
> command). Is this done elsewhere already?
I didn't see that for normal command.=20
We need to investigate about HLE case more. It's difficult to meet HLE.
=46or this, I think this patch is effective at least.
If you have any good idea, please let me know.

Thanks,
Seungwon Jeon
>=20
> Cheers
> James
>=20
> >
> > Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> > ---
> >  drivers/mmc/host/dw_mmc.c |   11 +++++++++++
> >  1 files changed, 11 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> > index 6785d62..b6db0ae 100644
> > --- a/drivers/mmc/host/dw_mmc.c
> > +++ b/drivers/mmc/host/dw_mmc.c
> > @@ -1009,6 +1009,11 @@ static void dw_mci_tasklet_func(unsigned lon=
g priv)
> >  	state =3D host->state;
> >  	data =3D host->data;
> >
> > +	if (host->cmd_status & SDMMC_INT_HLE) {
> > +		dev_err(host->dev, "hardware locked write error\n");
> > +		goto unlock;
> > +	}
> > +
> >  	do {
> >  		prev_state =3D state;
> >
> > @@ -1577,6 +1582,12 @@ static irqreturn_t dw_mci_interrupt(int irq,=
 void *dev_id)
> >  		if (!pending)
> >  			break;
> >
> > +		if (pending & SDMMC_INT_HLE) {
> > +			mci_writel(host, RINTSTS, SDMMC_INT_HLE);
> > +			host->cmd_status =3D pending;
> > +			tasklet_schedule(&host->tasklet);
> > +		}
> > +
> >  		if (pending & DW_MCI_CMD_ERROR_FLAGS) {
> >  			mci_writel(host, RINTSTS, DW_MCI_CMD_ERROR_FLAGS);
> >  			host->cmd_status =3D pending;
> >
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

