From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [RFC] mmc: dw_mmc: Fix the max_blk_count in IDMAC
Date: Tue, 28 Feb 2012 11:05:51 +0900
Message-ID: <000101ccf5bd$7f17ec00$7d47c400$%jun@samsung.com>
References: <000301ccf1fc$64e5dbe0$2eb193a0$%jun@samsung.com>
 <CAFbHwiT_KTWBLUSDbfMvuK0UEa_RrVqVF5V1WBqm+5c39Rtnqg@mail.gmail.com>
 <000c01ccf287$0868bb90$193a32b0$%jun@samsung.com>
 <CAFbHwiRagAH7Hp6V6367CRfAxCBtC26OO19tAhCe6jUtAxb4Jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:58314 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753512Ab2B1CFx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Feb 2012 21:05:53 -0500
Received: from epcpsbgm1.samsung.com (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0M0200EP5Z571D40@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 28 Feb 2012 11:05:52 +0900 (KST)
Received: from DOTGIHJUN01 ([12.23.118.161])
 by mmp2.samsung.com (Oracle Communications Messaging Exchange Server 7u4-19.01
 64bit (built Sep  7 2010)) with ESMTPA id <0M0200DDKZ5RR380@mmp2.samsung.com>
 for linux-mmc@vger.kernel.org; Tue, 28 Feb 2012 11:05:51 +0900 (KST)
In-reply-to: <CAFbHwiRagAH7Hp6V6367CRfAxCBtC26OO19tAhCe6jUtAxb4Jw@mail.gmail.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Will Newton' <will.newton@gmail.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, 'James Hogan' <james.hogan@imgtec.com>

Will Newton <will.newton@gmail.com> wrote:
> On Thu, Feb 23, 2012 at 11:58 PM, Seungwon Jeon <tgih.jun@samsung.com=
> wrote:
> > Will Newton <will.newton@gmail.com> wrote:
> >> 2012/2/23 Seungwon Jeon <tgih.jun@samsung.com>:
> >> > Hi all,
> >> >
> >> > Even though 1MB is reserved for descriptor table in IDMAC,
> >> > the dw_mmc host driver is allowed to receive only maximum
> >> > 128KB block length in one request. This is caused by setting
> >> > improper max_blk_count. It needs to be e adjusted so that
> >> > descriptor table is used fully.
> >> >
> >> > It is found that the performance is improved with the increased =
the
> >> > max_blk_count. In my case, there is 82%(6%) improvement in seque=
ntial
> >> > write(read). Is there anybody who knows the reason about the old=
 setting?
> >> >
> >> > Best regards,
> >> > Seungwon Jeon.
> >> >
> >> > Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> >> > ---
> >> > =A0drivers/mmc/host/dw_mmc.c | =A0 =A04 ++--
> >> > =A01 files changed, 2 insertions(+), 2 deletions(-)
> >> >
> >> > diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc=
=2Ec
> >> > index bf3c9b4..af2b901 100644
> >> > --- a/drivers/mmc/host/dw_mmc.c
> >> > +++ b/drivers/mmc/host/dw_mmc.c
> >> > @@ -1804,9 +1804,9 @@ static int __init dw_mci_init_slot(struct =
dw_mci *host, unsigned int id)
> >> > =A0#ifdef CONFIG_MMC_DW_IDMAC
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->max_segs =3D host->ring_size=
;
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->max_blk_size =3D 65536;
> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->max_blk_count =3D host->ring_=
size;
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->max_seg_size =3D 0x1000;
> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->max_req_size =3D mmc->max_seg=
_size * mmc->max_blk_count;
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->max_req_size =3D mmc->max_seg=
_size * host->ring_size;
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->max_blk_count =3D mmc->max_re=
q_size / 512;
> >>
> >> I am not sure this is correct, it seems like most drivers calculat=
e
> >> max_req_size like this:
> >>
> >> mmc->max_req_size =3D mmc->max_blk_size * mmc->max_blk_count;
> >
> > Could you explain the following origin code in dw_mmc?
> > We need to change like most other drivers?
> > =A0mmc->max_req_size =3D mmc->max_seg_size * mmc->max_blk_count;
>=20
> All the other drivers seem to set max_req_size based on blk_size and
> blk_count not seg_size so the current code looks like it may be wrong=
=2E
Then, How can determine the blk_count?
max_req_size is a limitation which should be submitted to mmc stack.
dw_mmc can transfer the data as max_req_size with the DMA descriptors.
So I think max_seg_size and ring_size are good information for max_req_=
size in IDMAC
and current setting of mmc->max_req_size is fine.

>=20
> > =A0- mmc->max_blk_count is set as host->ring_size.
> > =A0- max_seg_size seems to represent max_blk_size.
>=20
> I believe max_seg_size should be set to a higher value as it appears
> to be only relevant for IOMMU-based drivers, possibly the same as
> max_req_size.
As we can refer kernel/block, several segments of max_seg_size make up
a request ,which has hardware sectors in the usual 512b unit.
Max hardware sectors can be offered to block layer like the following i=
n drivers/mmc/card/queue.c.

	blk_queue_max_hw_sectors(mq->queue, min(host->max_blk_count, host->max=
_req_size / 512));

That means "host->max_blk_count" or "host->max_req_size / 512" decides =
the max request size.
So we need to set the proper max-blk_count. This RFC patch is intended =
for that.

Thanks,
Seungwon Jeon.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

