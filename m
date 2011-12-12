From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: mmc: dw_mmc: Add more capabilities field
Date: Mon, 12 Dec 2011 19:55:41 +0900
Message-ID: <000001ccb8bc$9770db60$c6529220$%jun@samsung.com>
References: <00a801ccb636$5bbe2920$133a7b60$%jun@samsung.com>
 <CAAG0J99SSLm6r0NoqXCMmEvdpVnW-zwHdFhA-n=zEiagyGHuTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:27531 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751423Ab1LLKzl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Dec 2011 05:55:41 -0500
In-reply-to: <CAAG0J99SSLm6r0NoqXCMmEvdpVnW-zwHdFhA-n=zEiagyGHuTQ@mail.gmail.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'James Hogan' <james@albanarts.com>
Cc: linux-mmc@vger.kernel.org, 'Chris Ball' <cjb@laptop.org>, linux-samsung-soc@vger.kernel.org

James Hogan wrote:
> On 9 December 2011 05:49, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> > Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
>=20
> A commit message would be useful.
"This patch adds another capabilities field for MMC_CAPS2_XXX."
Is a commit message disappeared?
>=20
> > ---
> > =A0drivers/mmc/host/dw_mmc.c =A0| =A0 =A06 ++++++
> > =A0include/linux/mmc/dw_mmc.h | =A0 =A01 +
> > =A02 files changed, 7 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> > index 3aaeb08..366df6b 100644
> > --- a/drivers/mmc/host/dw_mmc.c
> > +++ b/drivers/mmc/host/dw_mmc.c
> > @@ -1681,6 +1681,12 @@ static int __init dw_mci_init_slot(struct dw=
_mci *host, unsigned int id)
> > =A0 =A0 =A0 =A0else
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->caps =3D 0;
> >
> > + =A0 =A0 =A0 if (host->pdata->caps2)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps2 =3D host->pdata->caps2;
> > + =A0 =A0 =A0 else
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps2 =3D 0;
> > +
> > +
>=20
> There's really no need to check the value here, just copy it over.
> Same with the other caps field really.
Yes. No need to check.
It would be added rather than be copied.

Thanks,
Seungwon Jeon.
>=20
> > =A0 =A0 =A0 =A0if (host->pdata->get_bus_wd)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (host->pdata->get_bus_wd(slot->id=
) >=3D 4)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->caps |=3D MMC_C=
AP_4_BIT_DATA;
> > diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.=
h
> > index 6dc9b80..e8779c6 100644
> > --- a/include/linux/mmc/dw_mmc.h
> > +++ b/include/linux/mmc/dw_mmc.h
> > @@ -214,6 +214,7 @@ struct dw_mci_board {
> > =A0 =A0 =A0 =A0unsigned int bus_hz; /* Bus speed */
> >
> > =A0 =A0 =A0 =A0unsigned int caps; =A0 =A0 =A0/* Capabilities */
> > + =A0 =A0 =A0 unsigned int caps2; =A0 =A0 /* More capabilities */
> > =A0 =A0 =A0 =A0/*
> > =A0 =A0 =A0 =A0 * Override fifo depth. If 0, autodetect it from the=
 FIFOTH register,
> > =A0 =A0 =A0 =A0 * but note that this may not be reliable after a bo=
otloader has used
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
>=20
> other than that it looks fine to me.
>=20
> --
> James Hogan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

