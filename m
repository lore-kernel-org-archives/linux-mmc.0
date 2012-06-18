From: Namjae Jeon <linkinjeon@gmail.com>
Subject: Re: [PATCH RESEND v7 3/3] mmc: core: Support packed read command for
 eMMC4.5 device
Date: Mon, 18 Jun 2012 23:22:55 +0900
Message-ID: <CAKYAXd9_szMcE=pPWBrOw_7j6XMvpVQhBq9-HfwJq92BEV9Lcg@mail.gmail.com>
References: <007c01cd4d15$b7ca1aa0$275e4fe0$%jun@samsung.com>
	<21efe0f84cde4f8317a4ebb4de0b8207.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:47486 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751294Ab2FROW5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Jun 2012 10:22:57 -0400
In-Reply-To: <21efe0f84cde4f8317a4ebb4de0b8207.squirrel@www.codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: merez@codeaurora.org
Cc: Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Chris Ball <cjb@laptop.org>, Subhash Jadavani <subhashj@codeaurora.org>, "S, Venkatraman" <svenkatr@ti.com>

2012/6/18  <merez@codeaurora.org>:
> I would prefer that you didn't submit this.
> Let's wait with packed read until it is proven to be beneficial.
Hi. Merez.
I have reported packed read speed issue was because of firmware of mmc
card before.
And host can select packed read and write cmd by each performance.
mmc vendors willl be considering to improve packed read cmd.

Reviewed-by: Namjae Jeon <linkinjeon@gmail.com>

Thanks.
>
> Thanks,
> Maya
> On Sun, June 17, 2012 10:46 pm, Seungwon Jeon wrote:
>> Add the packed read command for issuing data. Unlike the
>> packed write, command header is handled separately.
>>
>> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
>> ---
>> =C2=A0drivers/mmc/card/block.c | =C2=A0134
>> +++++++++++++++++++++++++++++++++++++++++++---
>> =C2=A0drivers/mmc/card/queue.c | =C2=A0 =C2=A06 ++-
>> =C2=A0drivers/mmc/card/queue.h | =C2=A0 =C2=A02 +
>> =C2=A03 files changed, 133 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>> index eb99e35..25f42e8 100644
>> --- a/drivers/mmc/card/block.c
>> +++ b/drivers/mmc/card/block.c
>> @@ -62,6 +62,7 @@ MODULE_ALIAS("mmc:block");
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 (req->cmd_flags & REQ_META)) && \
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 (rq_data_dir(req) =3D=3D WRITE))
>> =C2=A0#define PACKED_CMD_VER =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 0x01
>> +#define PACKED_CMD_RD =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A00x01
>> =C2=A0#define PACKED_CMD_WR =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A00x02
>>
>> =C2=A0static DEFINE_MUTEX(block_mutex);
>> @@ -104,6 +105,7 @@ struct mmc_blk_data {
>> =C2=A0#define MMC_BLK_WRITE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0BIT(1)
>> =C2=A0#define MMC_BLK_DISCARD =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0BIT(2)
>> =C2=A0#define MMC_BLK_SECDISCARD =C2=A0 BIT(3)
>> +#define MMC_BLK_WR_HDR =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 BIT(4)
>>
>> =C2=A0 =C2=A0 =C2=A0 /*
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0* Only set in main mmc_blk_data associate=
d
>> @@ -1062,7 +1064,8 @@ static int mmc_blk_err_check(struct mmc_card *=
card,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0* kind. =C2=A0If it was a write, we may h=
ave transitioned to
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0* program mode, which we have to wait for=
 it to complete.
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>> - =C2=A0 =C2=A0 if (!mmc_host_is_spi(card->host) && rq_data_dir(req)=
 !=3D READ) {
>> + =C2=A0 =C2=A0 if ((!mmc_host_is_spi(card->host) && rq_data_dir(req=
) !=3D READ) ||
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 (mq_mrq->packed_cmd =3D=3D MMC_PACKED_WR_HDR)) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 status;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 do {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 int err =3D get_card_status(card, &status, 5);
>> @@ -1087,7 +1090,8 @@ static int mmc_blk_err_check(struct mmc_card *=
card,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0(unsigned)blk_rq_sectors(req),
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0brq->cmd.resp[0], brq->stop.resp[0]);
>>
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rq_data_dir(req) =3D=
=3D READ) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rq_data_dir(req) =3D=
=3D READ &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mq_mrq->packed_cmd !=3D MMC_PACKED_WR_H=
DR) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 if (ecc_err)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return MMC_BLK_ECC_ERR;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 return MMC_BLK_DATA_ERR;
>> @@ -1330,6 +1334,9 @@ static u8 mmc_blk_prep_packed_list(struct mmc_=
queue
>> *mq, struct request *req)
>> =C2=A0 =C2=A0 =C2=A0 if ((rq_data_dir(cur) =3D=3D WRITE) &&
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 (card->host->caps2 & MMC_CAP2_PACKED_WR))
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 max_packed_rw =3D c=
ard->ext_csd.max_packed_writes;
>> + =C2=A0 =C2=A0 else if ((rq_data_dir(cur) =3D=3D READ) &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 (card->host->caps2 & MMC_CAP2_PACKED_RD))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 max_packed_rw =3D card->=
ext_csd.max_packed_reads;
>>
>> =C2=A0 =C2=A0 =C2=A0 if (max_packed_rw =3D=3D 0)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto no_packed;
>> @@ -1426,13 +1433,16 @@ static void mmc_blk_packed_hdr_wrq_prep(stru=
ct
>> mmc_queue_req *mqrq,
>> =C2=A0 =C2=A0 =C2=A0 u32 *packed_cmd_hdr =3D mqrq->packed_cmd_hdr;
>> =C2=A0 =C2=A0 =C2=A0 u8 i =3D 1;
>>
>> - =C2=A0 =C2=A0 mqrq->packed_cmd =3D MMC_PACKED_WRITE;
>> + =C2=A0 =C2=A0 mqrq->packed_cmd =3D (rq_data_dir(req) =3D=3D READ) =
?
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MMC_PACKED_WR_HDR : MMC_=
PACKED_WRITE;
>> =C2=A0 =C2=A0 =C2=A0 mqrq->packed_blocks =3D 0;
>> =C2=A0 =C2=A0 =C2=A0 mqrq->packed_fail_idx =3D MMC_PACKED_N_IDX;
>>
>> =C2=A0 =C2=A0 =C2=A0 memset(packed_cmd_hdr, 0, sizeof(mqrq->packed_c=
md_hdr));
>> =C2=A0 =C2=A0 =C2=A0 packed_cmd_hdr[0] =3D (mqrq->packed_num << 16) =
|
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (PACKED_CMD_WR << 8) | P=
ACKED_CMD_VER;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (((rq_data_dir(req) =3D=3D=
 READ) ?
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PACKED_CMD_RD : P=
ACKED_CMD_WR) << 8) |
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PACKED_CMD_VER;
>>
>> =C2=A0 =C2=A0 =C2=A0 /*
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0* Argument for each entry of packed group
>> @@ -1464,7 +1474,8 @@ static void mmc_blk_packed_hdr_wrq_prep(struct
>> mmc_queue_req *mqrq,
>> =C2=A0 =C2=A0 =C2=A0 brq->mrq.stop =3D &brq->stop;
>>
>> =C2=A0 =C2=A0 =C2=A0 brq->sbc.opcode =3D MMC_SET_BLOCK_COUNT;
>> - =C2=A0 =C2=A0 brq->sbc.arg =3D MMC_CMD23_ARG_PACKED | (mqrq->packe=
d_blocks + 1);
>> + =C2=A0 =C2=A0 brq->sbc.arg =3D MMC_CMD23_ARG_PACKED |
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ((rq_data_dir(req) =3D=3D=
 READ) ? 1 : mqrq->packed_blocks + 1);
>> =C2=A0 =C2=A0 =C2=A0 brq->sbc.flags =3D MMC_RSP_R1 | MMC_CMD_AC;
>>
>> =C2=A0 =C2=A0 =C2=A0 brq->cmd.opcode =3D MMC_WRITE_MULTIPLE_BLOCK;
>> @@ -1474,7 +1485,12 @@ static void mmc_blk_packed_hdr_wrq_prep(struc=
t
>> mmc_queue_req *mqrq,
>> =C2=A0 =C2=A0 =C2=A0 brq->cmd.flags =3D MMC_RSP_SPI_R1 | MMC_RSP_R1 =
| MMC_CMD_ADTC;
>>
>> =C2=A0 =C2=A0 =C2=A0 brq->data.blksz =3D 512;
>> - =C2=A0 =C2=A0 brq->data.blocks =3D mqrq->packed_blocks + 1;
>> + =C2=A0 =C2=A0 /*
>> + =C2=A0 =C2=A0 =C2=A0* Write separately the packd command header on=
ly for packed read.
>> + =C2=A0 =C2=A0 =C2=A0* In case of packed write, header is sent with=
 blocks of data.
>> + =C2=A0 =C2=A0 =C2=A0*/
>> + =C2=A0 =C2=A0 brq->data.blocks =3D (rq_data_dir(req) =3D=3D READ) =
?
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1 : mqrq->packed_blocks =
+ 1;
>> =C2=A0 =C2=A0 =C2=A0 brq->data.flags |=3D MMC_DATA_WRITE;
>>
>> =C2=A0 =C2=A0 =C2=A0 brq->stop.opcode =3D MMC_STOP_TRANSMISSION;
>> @@ -1487,6 +1503,45 @@ static void mmc_blk_packed_hdr_wrq_prep(struc=
t
>> mmc_queue_req *mqrq,
>> =C2=A0 =C2=A0 =C2=A0 brq->data.sg_len =3D mmc_queue_map_sg(mq, mqrq)=
;
>>
>> =C2=A0 =C2=A0 =C2=A0 mqrq->mmc_active.mrq =3D &brq->mrq;
>> + =C2=A0 =C2=A0 mqrq->mmc_active.err_check =3D (rq_data_dir(req) =3D=
=3D READ) ?
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmc_blk_err_check : mmc_=
blk_packed_err_check;
>> +
>> + =C2=A0 =C2=A0 mmc_queue_bounce_pre(mqrq);
>> +}
>> +
>> +static void mmc_blk_packed_rrq_prep(struct mmc_queue_req *mqrq,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct mmc_card *card,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct mmc_queue *mq)
>> +{
>> + =C2=A0 =C2=A0 struct mmc_blk_request *brq =3D &mqrq->brq;
>> + =C2=A0 =C2=A0 struct request *req =3D mqrq->req;
>> +
>> + =C2=A0 =C2=A0 mqrq->packed_cmd =3D MMC_PACKED_READ;
>> +
>> + =C2=A0 =C2=A0 memset(brq, 0, sizeof(struct mmc_blk_request));
>> + =C2=A0 =C2=A0 brq->mrq.cmd =3D &brq->cmd;
>> + =C2=A0 =C2=A0 brq->mrq.data =3D &brq->data;
>> + =C2=A0 =C2=A0 brq->mrq.stop =3D &brq->stop;
>> +
>> + =C2=A0 =C2=A0 brq->cmd.opcode =3D MMC_READ_MULTIPLE_BLOCK;
>> + =C2=A0 =C2=A0 brq->cmd.arg =3D blk_rq_pos(req);
>> + =C2=A0 =C2=A0 if (!mmc_card_blockaddr(card))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 brq->cmd.arg <<=3D 9;
>> + =C2=A0 =C2=A0 brq->cmd.flags =3D MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC=
_CMD_ADTC;
>> + =C2=A0 =C2=A0 brq->data.blksz =3D 512;
>> + =C2=A0 =C2=A0 brq->data.blocks =3D mqrq->packed_blocks;
>> + =C2=A0 =C2=A0 brq->data.flags |=3D MMC_DATA_READ;
>> +
>> + =C2=A0 =C2=A0 brq->stop.opcode =3D MMC_STOP_TRANSMISSION;
>> + =C2=A0 =C2=A0 brq->stop.arg =3D 0;
>> + =C2=A0 =C2=A0 brq->stop.flags =3D MMC_RSP_SPI_R1B | MMC_RSP_R1B | =
MMC_CMD_AC;
>> +
>> + =C2=A0 =C2=A0 mmc_set_data_timeout(&brq->data, card);
>> +
>> + =C2=A0 =C2=A0 brq->data.sg =3D mqrq->sg;
>> + =C2=A0 =C2=A0 brq->data.sg_len =3D mmc_queue_map_sg(mq, mqrq);
>> +
>> + =C2=A0 =C2=A0 mqrq->mmc_active.mrq =3D &brq->mrq;
>> =C2=A0 =C2=A0 =C2=A0 mqrq->mmc_active.err_check =3D mmc_blk_packed_e=
rr_check;
>>
>> =C2=A0 =C2=A0 =C2=A0 mmc_queue_bounce_pre(mqrq);
>> @@ -1521,6 +1576,56 @@ static int mmc_blk_cmd_err(struct mmc_blk_dat=
a *md,
>> struct mmc_card *card,
>> =C2=A0 =C2=A0 =C2=A0 return ret;
>> =C2=A0}
>>
>> +static int mmc_blk_chk_hdr_err(struct mmc_queue *mq, int status)
>> +{
>> + =C2=A0 =C2=A0 struct mmc_blk_data *md =3D mq->data;
>> + =C2=A0 =C2=A0 struct mmc_card *card =3D md->queue.card;
>> + =C2=A0 =C2=A0 int type =3D MMC_BLK_WR_HDR, err =3D 0;
>> +
>> + =C2=A0 =C2=A0 switch (status) {
>> + =C2=A0 =C2=A0 case MMC_BLK_PARTIAL:
>> + =C2=A0 =C2=A0 case MMC_BLK_RETRY:
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D 0;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>> + =C2=A0 =C2=A0 case MMC_BLK_CMD_ERR:
>> + =C2=A0 =C2=A0 case MMC_BLK_ABORT:
>> + =C2=A0 =C2=A0 case MMC_BLK_DATA_ERR:
>> + =C2=A0 =C2=A0 case MMC_BLK_ECC_ERR:
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D mmc_blk_reset(md=
, card->host, type);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!err)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 mmc_blk_reset_success(md, type);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 return err;
>> +}
>> +
>> +static int mmc_blk_issue_packed_rd(struct mmc_queue *mq,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct mmc_queue_req *mq_r=
q)
>> +{
>> + =C2=A0 =C2=A0 struct mmc_blk_data *md =3D mq->data;
>> + =C2=A0 =C2=A0 struct mmc_card *card =3D md->queue.card;
>> + =C2=A0 =C2=A0 int status, ret, retry =3D 2;
>> +
>> + =C2=A0 =C2=A0 do {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmc_start_req(card->host=
, NULL, (int *) &status);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (status) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ret =3D mmc_blk_chk_hdr_err(mq, status);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if (ret)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 mmc_blk_packed_hdr_wrq_prep(mq_rq, card, mq);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 mmc_start_req(card->host, &mq_rq->mmc_active, NULL);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 mmc_blk_packed_rrq_prep(mq_rq, card, mq);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 mmc_start_req(card->host, &mq_rq->mmc_active, NULL);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ret =3D 0;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 break;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 } while (retry-- > 0);
>> +
>> + =C2=A0 =C2=A0 return ret;
>> +}
>> +
>> =C2=A0static int mmc_blk_end_packed_req(struct mmc_queue_req *mq_rq)
>> =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 struct request *prq;
>> @@ -1626,8 +1731,12 @@ static int mmc_blk_issue_rw_rq(struct mmc_que=
ue
>> *mq, struct request *rqc)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 areq =3D NULL;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 areq =3D mmc_start_=
req(card->host, areq, (int *) &status);
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!areq)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 return 0;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!areq) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if (mq->mqrq_cur->packed_cmd =3D=3D MMC_PACKED_WR_HDR)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto snd_packed_rd;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 else
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mq_rq =3D container=
_of(areq, struct mmc_queue_req, mmc_active);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 brq =3D &mq_rq->brq=
;
>> @@ -1726,10 +1835,19 @@ static int mmc_blk_issue_rw_rq(struct mmc_qu=
eue
>> *mq, struct request *rqc)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmc_blk_packed_hdr_wrq_prep(mq_rq, =
card, mq);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmc_start_req(card->host,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 &mq_rq->mmc_active, NULL);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (mq_rq->packed_cmd =3D=3D MMC_PACKED=
_WR_HDR) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (mmc_blk=
_issue_packed_rd(mq, mq_rq))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 goto cmd_abort;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 }
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> =C2=A0 =C2=A0 =C2=A0 } while (ret);
>>
>> +snd_packed_rd:
>> + =C2=A0 =C2=A0 if (mq->mqrq_cur->packed_cmd =3D=3D MMC_PACKED_WR_HD=
R) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (mmc_blk_issue_packed=
_rd(mq, mq->mqrq_cur))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 goto start_new_req;
>> + =C2=A0 =C2=A0 }
>> =C2=A0 =C2=A0 =C2=A0 return 1;
>>
>> =C2=A0 cmd_abort:
>> diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
>> index 165d85a..277905e 100644
>> --- a/drivers/mmc/card/queue.c
>> +++ b/drivers/mmc/card/queue.c
>> @@ -389,11 +389,15 @@ static unsigned int mmc_queue_packed_map_sg(st=
ruct
>> mmc_queue *mq,
>>
>> =C2=A0 =C2=A0 =C2=A0 cmd =3D mqrq->packed_cmd;
>>
>> - =C2=A0 =C2=A0 if (cmd =3D=3D MMC_PACKED_WRITE) {
>> + =C2=A0 =C2=A0 if (cmd =3D=3D MMC_PACKED_WR_HDR || cmd =3D=3D MMC_P=
ACKED_WRITE) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __sg =3D sg;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sg_set_buf(__sg, mq=
rq->packed_cmd_hdr,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(mqrq->packed_cmd_hdr));
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sg_len++;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cmd =3D=3D MMC_PACKE=
D_WR_HDR) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 sg_mark_end(__sg);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 return sg_len;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __sg->page_link &=3D=
 ~0x02;
>> =C2=A0 =C2=A0 =C2=A0 }
>>
>> diff --git a/drivers/mmc/card/queue.h b/drivers/mmc/card/queue.h
>> index 5e04938..a8cad1f 100644
>> --- a/drivers/mmc/card/queue.h
>> +++ b/drivers/mmc/card/queue.h
>> @@ -14,7 +14,9 @@ struct mmc_blk_request {
>>
>> =C2=A0enum mmc_packed_cmd {
>> =C2=A0 =C2=A0 =C2=A0 MMC_PACKED_NONE =3D 0,
>> + =C2=A0 =C2=A0 MMC_PACKED_WR_HDR,
>> =C2=A0 =C2=A0 =C2=A0 MMC_PACKED_WRITE,
>> + =C2=A0 =C2=A0 MMC_PACKED_READ,
>> =C2=A0};
>>
>> =C2=A0struct mmc_queue_req {
>> --
>> 1.7.0.4
>>
>>
>>
>
>
> --
> Sent by consultant of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
