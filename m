From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH 2/2] mmc: core: Support packed command for eMMC4.5 device
Date: Fri, 02 Dec 2011 18:06:30 +0900
Message-ID: <003201ccb0d1$ae9474c0$0bbd5e40$%jun@samsung.com>
References: <aad7cb35699550e89526a5fb083c520d.squirrel@www.codeaurora.org>
 <000201ccadab$1e57b8a0$5b0729e0$%jun@samsung.com>
 <5573ef5046779298ee1555838015e0e3.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:50943 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752938Ab1LBJGe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Dec 2011 04:06:34 -0500
In-reply-to: <5573ef5046779298ee1555838015e0e3.squirrel@www.codeaurora.org>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: merez@codeaurora.org
Cc: "'S, Venkatraman'" <svenkatr@ti.com>, linux-mmc@vger.kernel.org, 'Chris Ball' <cjb@laptop.org>, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, dh.han@samsung.com

Maya Erez wrote:
> > Maya Erez wrote:
> >> >> >> On Wed, Nov 2, 2011 at 1:33 PM, Seungwon Jeon
> >> <tgih.jun@samsung.com>
> >> >> wrote:
> >> >> >> > @@ -980,12 +988,67 @@ static int mmc_blk_err_check(struct
> >> mmc_card
> >> >> *card,
> >> >> >> > =A0 =A0 =A0 =A0if (!brq->data.bytes_xfered)
> >> >> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return MMC_BLK_RETRY;
> >> >> >> >
> >> >> >> > + =A0 =A0 =A0 if (mq_mrq->packed_cmd !=3D MMC_PACKED_NONE)=
 {
> >> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (unlikely(brq->data.block=
s << 9 !=3D
> >> >> brq->data.bytes_xfered))
> >> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return MMC_B=
LK_PARTIAL;
> >> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> >> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return MMC_B=
LK_SUCCESS;
> >> >> >> > + =A0 =A0 =A0 }
> >> >> >> > +
> >> >> >> > =A0 =A0 =A0 =A0if (blk_rq_bytes(req) !=3D brq->data.bytes_=
xfered)
> >> >> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return MMC_BLK_PARTIAL;
> >> >> >> >
> >> >> >> > =A0 =A0 =A0 =A0return MMC_BLK_SUCCESS;
> >> >> >> > =A0}
> >> >> >> >
> >> >> >> > +static int mmc_blk_packed_err_check(struct mmc_card *card=
, +
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct mmc_async_re=
q *areq)
> >> >> >> > +{
> >> >> >> > + =A0 =A0 =A0 struct mmc_queue_req *mq_mrq =3D container_o=
f(areq, struct
> >> >> mmc_queue_req,
> >> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_active);
> >> +
> >> =A0 =A0 =A0 int err, check, status;
> >> >> >> > + =A0 =A0 =A0 u8 ext_csd[512];
> >> >> >> > +
> >> >> >> > + =A0 =A0 =A0 check =3D mmc_blk_err_check(card, areq);
> >> >> >> > +
> >> >> >> > + =A0 =A0 =A0 if (check =3D=3D MMC_BLK_SUCCESS)
> >> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return check;
> >> I think we need to check the status for all cases and not only in =
case
> >> of
> >> MMC_BLK_PARTIAL. For example, in cases where the header was trafer=
red
> >> successfully but had logic errors (wrong number of sectors etc.)
> >> mmc_blk_err_check will return MMC_BLK_SUCCESS although the packed
> >> commands
> >> failed.
> > Similarly, Sahitya Tummala is already mentioned this.
> > Other error case will be checked in next version.
> > The case you suggested is about read or write?
> > Device may detect error and stop transferring the data.
> Sahitya suggested to also check other error cases that mmc_blk_err_ch=
eck
> returns (such as MMC_BLK_CMD_ERR, MMC_BLK_ECC_ERR and MMC_BLK_DATA_ER=
R).
> I suggest to also check the exception bit in the status even if
> mmc_blk_err_check returned success, since mmc_blk_err_check might not
> catch all the packed commands failures. One example for such a failur=
e is
> when the header of read packed commands will have logical error.
This part is modified in next version.

Thanks,
Seungwon Jeon.

> Thanks,
> Maya
> --
> Seny by a Consultant for Qualcomm innovation center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
>=20
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

