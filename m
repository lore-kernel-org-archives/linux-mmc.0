From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH 2/2] mmc: core: Support packed command for eMMC4.5 device
Date: Mon, 28 Nov 2011 17:52:54 +0900
Message-ID: <000201ccadab$1e57b8a0$5b0729e0$%jun@samsung.com>
References: <aad7cb35699550e89526a5fb083c520d.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:32425 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751150Ab1K1Iw4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Nov 2011 03:52:56 -0500
In-reply-to: <aad7cb35699550e89526a5fb083c520d.squirrel@www.codeaurora.org>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: merez@codeaurora.org
Cc: "'S, Venkatraman'" <svenkatr@ti.com>, linux-mmc@vger.kernel.org, 'Chris Ball' <cjb@laptop.org>, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, dh.han@samsung.com

Maya Erez wrote:
> >> >> On Wed, Nov 2, 2011 at 1:33 PM, Seungwon Jeon <tgih.jun@samsung=
=2Ecom>
> >> wrote:
> >> >> > @@ -943,7 +950,8 @@ static int mmc_blk_err_check(struct mmc_c=
ard
> >> *card,
> >> >> > =A0 =A0 =A0 =A0 * kind. =A0If it was a write, we may have tra=
nsitioned to
> =A0 =A0 =A0 * program mode, which we have to wait for it to complete.
> =A0 =A0 =A0 */
> >> >> > - =A0 =A0 =A0 if (!mmc_host_is_spi(card->host) && rq_data_dir=
(req) !=3D
> >> READ) {
> >> >> > + =A0 =A0 =A0 if ((!mmc_host_is_spi(card->host) && rq_data_di=
r(req) !=3D
> >> READ) ||
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (mq_mrq->packed=
_cmd =3D=3D MMC_PACKED_WR_HDR))
> Since the header's direction is WRITE I don't think we also need to c=
heck
> if mq_mrq->packed_cmd =3D=3D MMC_PACKED_WR_HDR since it will be cover=
ed by the
> original condition.
The header is written. But origin request is about read.
That means rq_data_dir(req) is READ. So new condition is needed.
> >> {
> >> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u32 status;
> >> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0do {
> >> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int err =3D ge=
t_card_status(card, &status,
> 5);
> A general question, not related specifically to packed commands - Do =
you
> know why the status is not checked to see which error we got?
This status is for checking whether the card is ready for new data.
> >> >> > @@ -980,12 +988,67 @@ static int mmc_blk_err_check(struct mmc=
_card
> >> *card,
> >> >> > =A0 =A0 =A0 =A0if (!brq->data.bytes_xfered)
> >> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return MMC_BLK_RETRY;
> >> >> >
> >> >> > + =A0 =A0 =A0 if (mq_mrq->packed_cmd !=3D MMC_PACKED_NONE) {
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (unlikely(brq->data.blocks <=
< 9 !=3D
> >> brq->data.bytes_xfered))
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return MMC_BLK_=
PARTIAL;
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return MMC_BLK_=
SUCCESS;
> >> >> > + =A0 =A0 =A0 }
> >> >> > +
> >> >> > =A0 =A0 =A0 =A0if (blk_rq_bytes(req) !=3D brq->data.bytes_xfe=
red)
> >> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return MMC_BLK_PARTIAL;
> >> >> >
> >> >> > =A0 =A0 =A0 =A0return MMC_BLK_SUCCESS;
> >> >> > =A0}
> >> >> >
> >> >> > +static int mmc_blk_packed_err_check(struct mmc_card *card, +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct mmc_async_req *=
areq)
> >> >> > +{
> >> >> > + =A0 =A0 =A0 struct mmc_queue_req *mq_mrq =3D container_of(a=
req, struct
> >> mmc_queue_req,
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_active); +
> =A0 =A0 =A0 int err, check, status;
> >> >> > + =A0 =A0 =A0 u8 ext_csd[512];
> >> >> > +
> >> >> > + =A0 =A0 =A0 check =3D mmc_blk_err_check(card, areq);
> >> >> > +
> >> >> > + =A0 =A0 =A0 if (check =3D=3D MMC_BLK_SUCCESS)
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return check;
> I think we need to check the status for all cases and not only in cas=
e of
> MMC_BLK_PARTIAL. For example, in cases where the header was traferred
> successfully but had logic errors (wrong number of sectors etc.)
> mmc_blk_err_check will return MMC_BLK_SUCCESS although the packed com=
mands
> failed.
Similarly, Sahitya Tummala is already mentioned this.
Other error case will be checked in next version.
The case you suggested is about read or write?
Device may detect error and stop transferring the data.
> >> >> > +
> >> >> > + =A0 =A0 =A0 if (check =3D=3D MMC_BLK_PARTIAL) {
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D get_card_status(card, &=
status, 0);
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err)
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return MMC_BLK_=
ABORT;
> >> >> > +
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (status & R1_EXP_EVENT) {
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_sen=
d_ext_csd(card, ext_csd); +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err)
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 return MMC_BLK_ABORT;
> >> >> > +
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((ext_csd[EX=
T_CSD_EXP_EVENTS_STATUS +
> 0]
> why do we need the + 0?
It is explicit expression, no more, no less.
Actually, there is no need.
> >> &
> >> >> > +
> >> EXT_CSD_PACKED_INDEXED_ERROR) {
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 /* Make be 0-based */
> The comment is not understood
PACKED_FAILURE_INDEX starts from '1'
It is converted to 0-base for use.
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 mq_mrq->packed_fail_idx =3D
> +
> Thanks,
> Maya Erez
> --
> Seny by a Consultant for Qualcomm innovation center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

