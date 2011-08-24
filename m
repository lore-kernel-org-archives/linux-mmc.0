From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: RFC : mmc: mmc_blk_issue_secdiscard_rq() and mmc_blk_issue_discard_rq()
 effectively merged into one.
Date: Wed, 24 Aug 2011 14:52:14 +0900
Message-ID: <CAH9JG2WYcLpOtP-uy_nNHqe6yzOaxzW1cPMo==5UfUt0FqFrDA@mail.gmail.com>
References: <CAKYAXd9MwO-JEMNt9-0C8pzgYn5Tvtv8ovJ35TNiqqe8PWGogQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:47124 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750795Ab1HXFwP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 24 Aug 2011 01:52:15 -0400
In-Reply-To: <CAKYAXd9MwO-JEMNt9-0C8pzgYn5Tvtv8ovJ35TNiqqe8PWGogQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: NamJae Jeon <linkinjeon@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Chris Ball <cjb@laptop.org>, linus.walleij@linaro.org

Hi,

On Wed, Aug 24, 2011 at 2:09 PM, NamJae Jeon <linkinjeon@gmail.com> wro=
te:
> Hi.
>
> I am wordering why mmc_blk_issue_secdiscard_rq() and
> mmc_blk_issue_discard_rq() is seperated.
> So I try to make mmc_blk_issue_secdiscard_rq() and
> mmc_blk_issue_discard_rq() effectively merged into one.
>
> I want to know your opinion.

I think not special reason. It can merge one function. but note that
secdiscard function is rarely called. there's only one path from
BLKSECDISCARD ioctl.

however discard is different. it's called relatively frequently if you
turn on discard mount option. or often when batched discard.
So it's helpful to reduce the code size if one function is used. it's
more helpful to optimize the code flow when discard is used.

Thank you,
Kyungmin Park
>
> Thanks.
>
> ---------------------------------------------------------------------=
-----------------------------------------------------------------------=
--------------------------
> static int mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct requ=
est *req)
> {
> =A0 =A0 =A0 =A0struct mmc_blk_data *md =3D mq->data;
> =A0 =A0 =A0 =A0struct mmc_card *card =3D md->queue.card;
> =A0 =A0 =A0 =A0unsigned int from, nr, arg;
> =A0 =A0 =A0 =A0int err =3D 0;
> =A0 =A0 =A0 =A0from =3D blk_rq_pos(req);
> =A0 =A0 =A0 =A0nr =3D blk_rq_sectors(req);
> =A0 =A0 =A0 =A0if (req->cmd_flags & REQ_SECURE) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!mmc_can_secure_erase_trim(card)) =
{
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D -EOPNOTSUPP;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if(mmc_can_trim(card) &&
> !mmc_erase_group_aligned(card, from, nr))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0arg =3D MMC_SECURE_TRI=
M1_ARG;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0arg =3D MMC_SECURE_ERA=
SE_ARG;
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!mmc_can_erase(card)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D -EOPNOTSUPP;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (mmc_can_trim(card))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0arg =3D MMC_TRIM_ARG;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0arg =3D MMC_ERASE_ARG;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0if (card->quirks & MMC_QUIRK_INAND_CMD38) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if(req->cmd_flags & REQ_SECURE)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D mmc_switch(car=
d, EXT_CSD_CMD_SET_NORMAL,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0NAND_CMD38_ARG_EXT_CSD,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0arg =3D=3D MMC_SECURE_TRIM1_ARG ?
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0INAND_CMD38_ARG_SECTRIM1 :
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0INAND_CMD38_ARG_SECERASE,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A00);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D mmc_switch(car=
d, EXT_CSD_CMD_SET_NORMAL,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0INAND_CMD38_ARG_EXT_CSD,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0arg =3D=3D MMC_TRIM_ARG ?
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0INAND_CMD38_ARG_TRIM :
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0INAND_CMD38_ARG_ERASE,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A00);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (err)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0err =3D mmc_erase(card, from, nr, arg);
> =A0 =A0 =A0 =A0if (!err && arg =3D=3D MMC_SECURE_TRIM1_ARG) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (card->quirks & MMC_QUIRK_INAND_CMD=
38) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D mmc_switch(car=
d, EXT_CSD_CMD_SET_NORMAL,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 INAND_CMD38_ARG_EXT_CSD,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 INAND_CMD38_ARG_SECTRIM2,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 0);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (err)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto o=
ut;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D mmc_erase(card, from, nr, MMC_=
SECURE_TRIM2_ARG);
> =A0 =A0 =A0 =A0}
> out:
> =A0 =A0 =A0 =A0spin_lock_irq(&md->lock);
> =A0 =A0 =A0 =A0__blk_end_request(req, err, blk_rq_bytes(req));
> =A0 =A0 =A0 =A0spin_unlock_irq(&md->lock);
> =A0 =A0 =A0 =A0return err ? 0 : 1;
> }
>
>
> static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req=
)
> {
> =A0 =A0 =A0 =A0int ret;
> =A0 =A0 =A0 =A0struct mmc_blk_data *md =3D mq->data;
> =A0 =A0 =A0 =A0struct mmc_card *card =3D md->queue.card;
> =A0 =A0 =A0 =A0mmc_claim_host(card->host);
> =A0 =A0 =A0 =A0ret =3D mmc_blk_part_switch(card, md);
> =A0 =A0 =A0 =A0if (ret) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0if (req->cmd_flags & REQ_DISCARD) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D mmc_blk_issue_discard_rq(mq, r=
eq);
> =A0 =A0 =A0 =A0} else if (req->cmd_flags & REQ_FLUSH) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D mmc_blk_issue_flush(mq, req);
> =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D mmc_blk_issue_rw_rq(mq, req);
> =A0 =A0 =A0 =A0}
> out:
> =A0 =A0 =A0 =A0mmc_release_host(card->host);
> =A0 =A0 =A0 =A0return ret;
> }
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
