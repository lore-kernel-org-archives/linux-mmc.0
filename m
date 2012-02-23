From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [RFC] mmc: dw_mmc: Fix the max_blk_count in IDMAC
Date: Fri, 24 Feb 2012 08:58:25 +0900
Message-ID: <000c01ccf287$0868bb90$193a32b0$%jun@samsung.com>
References: <000301ccf1fc$64e5dbe0$2eb193a0$%jun@samsung.com>
 <CAFbHwiT_KTWBLUSDbfMvuK0UEa_RrVqVF5V1WBqm+5c39Rtnqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:53793 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755444Ab2BWX62 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Feb 2012 18:58:28 -0500
Received: from epcpsbgm2.samsung.com (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LZV005BMEL4WEA0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 24 Feb 2012 08:58:26 +0900 (KST)
Received: from DOTGIHJUN01 ([12.23.118.161])
 by mmp1.samsung.com (Oracle Communications Messaging Exchange Server 7u4-19.01
 64bit (built Sep  7 2010)) with ESMTPA id <0LZV00BEAELEEK10@mmp1.samsung.com>
 for linux-mmc@vger.kernel.org; Fri, 24 Feb 2012 08:58:26 +0900 (KST)
In-reply-to: <CAFbHwiT_KTWBLUSDbfMvuK0UEa_RrVqVF5V1WBqm+5c39Rtnqg@mail.gmail.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Will Newton' <will.newton@gmail.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, 'James Hogan' <james.hogan@imgtec.com>

Will Newton <will.newton@gmail.com> wrote:
> 2012/2/23 Seungwon Jeon <tgih.jun@samsung.com>:
> > Hi all,
> >
> > Even though 1MB is reserved for descriptor table in IDMAC,
> > the dw_mmc host driver is allowed to receive only maximum
> > 128KB block length in one request. This is caused by setting
> > improper max_blk_count. It needs to be e adjusted so that
> > descriptor table is used fully.
> >
> > It is found that the performance is improved with the increased the
> > max_blk_count. In my case, there is 82%(6%) improvement in sequenti=
al
> > write(read). Is there anybody who knows the reason about the old se=
tting?
> >
> > Best regards,
> > Seungwon Jeon.
> >
> > Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> > ---
> > =A0drivers/mmc/host/dw_mmc.c | =A0 =A04 ++--
> > =A01 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> > index bf3c9b4..af2b901 100644
> > --- a/drivers/mmc/host/dw_mmc.c
> > +++ b/drivers/mmc/host/dw_mmc.c
> > @@ -1804,9 +1804,9 @@ static int __init dw_mci_init_slot(struct dw_=
mci *host, unsigned int id)
> > =A0#ifdef CONFIG_MMC_DW_IDMAC
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->max_segs =3D host->ring_size;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->max_blk_size =3D 65536;
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->max_blk_count =3D host->ring_siz=
e;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->max_seg_size =3D 0x1000;
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->max_req_size =3D mmc->max_seg_si=
ze * mmc->max_blk_count;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->max_req_size =3D mmc->max_seg_si=
ze * host->ring_size;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->max_blk_count =3D mmc->max_req_s=
ize / 512;
>=20
> I am not sure this is correct, it seems like most drivers calculate
> max_req_size like this:
>=20
> mmc->max_req_size =3D mmc->max_blk_size * mmc->max_blk_count;

Could you explain the following origin code in dw_mmc?
We need to change like most other drivers?
  mmc->max_req_size =3D mmc->max_seg_size * mmc->max_blk_count;
  - mmc->max_blk_count is set as host->ring_size.
  - max_seg_size seems to represent max_blk_size.

I think max_req_size means the total transfer size through DMA descript=
ors.
max_blk_size just is limited to 16 bits for BLKSIZ register. Actually 5=
12 is used.
Host driver doesn't inform block layer of this size.
Also, block layer doesn't utilize max_blk_size.

Thanks,
Seungwon Jeon.
>=20
> And indeed in the external DMA case dw_mmc does that too.
>=20
> It should probably be safe to set max_seg_size to max_req_size too.
>=20

> > =A0#else
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->max_segs =3D 64;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->max_blk_size =3D 65536; /* BLKS=
IZ is 16 bits */
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

