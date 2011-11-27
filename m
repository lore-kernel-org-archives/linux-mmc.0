From: merez@codeaurora.org
Subject: RE: [PATCH 2/2] mmc: core: Support packed command for eMMC4.5      
     device
Date: Sun, 27 Nov 2011 11:41:11 -0800 (PST)
Message-ID: <aad7cb35699550e89526a5fb083c520d.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: "'S, Venkatraman'" <svenkatr@ti.com>, linux-mmc@vger.kernel.org, 'Chris Ball' <cjb@laptop.org>, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, dh.han@samsung.com
List-Id: linux-mmc@vger.kernel.org

>> >> On Wed, Nov 2, 2011 at 1:33 PM, Seungwon Jeon <tgih.jun@samsung.c=
om>
>> wrote:
>> >> > @@ -943,7 +950,8 @@ static int mmc_blk_err_check(struct mmc_car=
d
>> *card,
>> >> > =A0 =A0 =A0 =A0 * kind. =A0If it was a write, we may have trans=
itioned to =A0
=A0 =A0 =A0 * program mode, which we have to wait for it to complete. =A0
=A0 =A0 =A0 */
>> >> > - =A0 =A0 =A0 if (!mmc_host_is_spi(card->host) && rq_data_dir(r=
eq) !=3D
>> READ) {
>> >> > + =A0 =A0 =A0 if ((!mmc_host_is_spi(card->host) && rq_data_dir(=
req) !=3D
>> READ) ||
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (mq_mrq->packed_c=
md =3D=3D MMC_PACKED_WR_HDR))
Since the header's direction is WRITE I don't think we also need to che=
ck
if mq_mrq->packed_cmd =3D=3D MMC_PACKED_WR_HDR since it will be covered=
 by the
original condition.
>> {
>> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u32 status;
>> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0do {
>> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int err =3D get_=
card_status(card, &status,
5);
A general question, not related specifically to packed commands - Do yo=
u
know why the status is not checked to see which error we got?
>> >> > @@ -980,12 +988,67 @@ static int mmc_blk_err_check(struct mmc_c=
ard
>> *card,
>> >> > =A0 =A0 =A0 =A0if (!brq->data.bytes_xfered)
>> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return MMC_BLK_RETRY;
>> >> >
>> >> > + =A0 =A0 =A0 if (mq_mrq->packed_cmd !=3D MMC_PACKED_NONE) {
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (unlikely(brq->data.blocks << =
9 !=3D
>> brq->data.bytes_xfered))
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return MMC_BLK_PA=
RTIAL;
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return MMC_BLK_SU=
CCESS;
>> >> > + =A0 =A0 =A0 }
>> >> > +
>> >> > =A0 =A0 =A0 =A0if (blk_rq_bytes(req) !=3D brq->data.bytes_xfere=
d)
>> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return MMC_BLK_PARTIAL;
>> >> >
>> >> > =A0 =A0 =A0 =A0return MMC_BLK_SUCCESS;
>> >> > =A0}
>> >> >
>> >> > +static int mmc_blk_packed_err_check(struct mmc_card *card, + =A0=
 =A0
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct mmc_async_req *ar=
eq)
>> >> > +{
>> >> > + =A0 =A0 =A0 struct mmc_queue_req *mq_mrq =3D container_of(are=
q, struct
>> mmc_queue_req,
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_active); +
=A0 =A0 =A0 int err, check, status;
>> >> > + =A0 =A0 =A0 u8 ext_csd[512];
>> >> > +
>> >> > + =A0 =A0 =A0 check =3D mmc_blk_err_check(card, areq);
>> >> > +
>> >> > + =A0 =A0 =A0 if (check =3D=3D MMC_BLK_SUCCESS)
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return check;
I think we need to check the status for all cases and not only in case =
of
MMC_BLK_PARTIAL. For example, in cases where the header was traferred
successfully but had logic errors (wrong number of sectors etc.)
mmc_blk_err_check will return MMC_BLK_SUCCESS although the packed comma=
nds
failed.
>> >> > +
>> >> > + =A0 =A0 =A0 if (check =3D=3D MMC_BLK_PARTIAL) {
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D get_card_status(card, &st=
atus, 0);
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err)
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return MMC_BLK_AB=
ORT;
>> >> > +
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (status & R1_EXP_EVENT) {
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_send_=
ext_csd(card, ext_csd); + =A0
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err)
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 r=
eturn MMC_BLK_ABORT;
>> >> > +
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((ext_csd[EXT_=
CSD_EXP_EVENTS_STATUS +
0]
why do we need the + 0?
>> &
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0
>> EXT_CSD_PACKED_INDEXED_ERROR) {
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 /* Make be 0-based */
The comment is not understood
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 mq_mrq->packed_fail_idx =3D
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0
Thanks,
Maya Erez
--
Seny by a Consultant for Qualcomm innovation center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
