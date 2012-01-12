From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH] MMC-4.5 Data Tag Support
Date: Thu, 12 Jan 2012 19:58:29 +0530
Message-ID: <CANfBPZ9gDkHK01bsMjf_CpkA-8s1U3X4WnAxO_=q9XdGODuf7w@mail.gmail.com>
References: <1324453157-30081-1-git-send-email-saugata.das@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:46669 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751556Ab2ALO2w convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 12 Jan 2012 09:28:52 -0500
Received: by mail-bk0-f51.google.com with SMTP id q10so1343266bka.38
        for <linux-mmc@vger.kernel.org>; Thu, 12 Jan 2012 06:28:50 -0800 (PST)
In-Reply-To: <1324453157-30081-1-git-send-email-saugata.das@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Saugata Das <saugata.das@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

On Wed, Dec 21, 2011 at 1:09 PM, Saugata Das <saugata.das@stericsson.co=
m> wrote:
> From: Saugata Das <saugata.das@linaro.org>
>
> MMC-4.5 data tag feature will be used to store the file system meta-d=
ata in the
> tagged region of eMMC. This will improve the write and subsequent rea=
d transfer
> time for the meta data.
>
> Signed-off-by: Saugata Das <saugata.das@linaro.org>

I tested this on a device which supports a data tag unit size of 8K.
Tested-by: Venkatraman S <svenkatr@ti.com>

Chris,
  Can this go into 3.3 ?

> ---
> =A0drivers/mmc/card/block.c | =A0 17 +++++++++++++++--
> =A0drivers/mmc/core/mmc.c =A0 | =A0 14 ++++++++++++++
> =A0include/linux/mmc/card.h | =A0 =A02 ++
> =A0include/linux/mmc/mmc.h =A0| =A0 =A03 +++
> =A04 files changed, 34 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index a1cb21f..af3b6c3 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -995,6 +995,7 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_r=
eq *mqrq,
> =A0 =A0 =A0 =A0struct mmc_blk_request *brq =3D &mqrq->brq;
> =A0 =A0 =A0 =A0struct request *req =3D mqrq->req;
> =A0 =A0 =A0 =A0struct mmc_blk_data *md =3D mq->data;
> + =A0 =A0 =A0 bool do_data_tag;
>
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * Reliable writes are used to implement Forced Unit A=
ccess and
> @@ -1071,6 +1072,16 @@ static void mmc_blk_rw_rq_prep(struct mmc_queu=
e_req *mqrq,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_apply_rel_rw(brq, card, req);
>
> =A0 =A0 =A0 =A0/*
> + =A0 =A0 =A0 =A0* Data tag is used only during writing meta data to =
speed
> + =A0 =A0 =A0 =A0* up write and any subsequent read of this meta data
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 do_data_tag =3D (card->ext_csd.data_tag_unit_size) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (req->cmd_flags & REQ_META) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (rq_data_dir(req) =3D=3D WRITE) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((brq->data.blocks * brq->data.blksz) >=
=3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.data_tag_unit_size) ;
> +
> + =A0 =A0 =A0 /*
> =A0 =A0 =A0 =A0 * Pre-defined multi-block transfers are preferable to
> =A0 =A0 =A0 =A0 * open ended-ones (and necessary for reliable writes)=
=2E
> =A0 =A0 =A0 =A0 * However, it is not sufficient to just send CMD23,
> @@ -1091,10 +1102,12 @@ static void mmc_blk_rw_rq_prep(struct mmc_que=
ue_req *mqrq,
>
> =A0 =A0 =A0 =A0if ((md->flags & MMC_BLK_CMD23) &&
> =A0 =A0 =A0 =A0 =A0 =A0mmc_op_multi(brq->cmd.opcode) &&
> - =A0 =A0 =A0 =A0 =A0 (do_rel_wr || !(card->quirks & MMC_QUIRK_BLK_NO=
_CMD23))) {
> + =A0 =A0 =A0 =A0 =A0 (do_rel_wr || !(card->quirks & MMC_QUIRK_BLK_NO=
_CMD23) ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 do_data_tag)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0brq->sbc.opcode =3D MMC_SET_BLOCK_COUN=
T;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0brq->sbc.arg =3D brq->data.blocks |
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (do_rel_wr ? (1 << 31) =
: 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (do_rel_wr ? (1 << 31) =
: 0) |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (do_data_tag ? (1 << 29=
) : 0);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0brq->sbc.flags =3D MMC_RSP_R1 | MMC_CM=
D_AC;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0brq->mrq.sbc =3D &brq->sbc;
> =A0 =A0 =A0 =A0}
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index dbf421a..244049b 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -488,6 +488,20 @@ static int mmc_read_ext_csd(struct mmc_card *car=
d, u8 *ext_csd)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ext_csd[EXT_CSD_CACHE_=
SIZE + 1] << 8 |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ext_csd[EXT_CSD_CACHE_=
SIZE + 2] << 16 |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ext_csd[EXT_CSD_CACHE_=
SIZE + 3] << 24;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ext_csd[EXT_CSD_DATA_SECTOR_SIZE] =3D=
=3D 1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.data_sect=
or_size =3D 4096;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.data_sect=
or_size =3D 512;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((ext_csd[EXT_CSD_DATA_TAG_SUPPORT] =
& 1) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (ext_csd[EXT_CSD_TAG_UN=
IT_SIZE] <=3D 8)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.data_tag_=
unit_size =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((unsigned int) 1 << ex=
t_csd[EXT_CSD_TAG_UNIT_SIZE]) *
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (card->ext_csd.data_sec=
tor_size);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.data_tag_=
unit_size =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0}
>
> =A0out:
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 415f2db..a55668d 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -71,6 +71,8 @@ struct mmc_ext_csd {
> =A0 =A0 =A0 =A0bool =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hpi_en; =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* HPI enablebit */
> =A0 =A0 =A0 =A0bool =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hpi; =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* HPI support bit */
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0hpi_cmd; =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0/* cmd used as HPI */
> + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0data_sector_size; =A0=
 =A0 =A0 /* 512Bytes or 4KB */
> + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0data_tag_unit_size;=
 =A0 =A0 /* DATA TAG UNIT size */
> =A0 =A0 =A0 =A0u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0raw_part=
ition_support; =A0/* 160 */
> =A0 =A0 =A0 =A0u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0raw_eras=
ed_mem_count; =A0 /* 181 */
> =A0 =A0 =A0 =A0u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0raw_ext_=
csd_structure; =A0/* 194 */
> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
> index 0e71356..e076f7f 100644
> --- a/include/linux/mmc/mmc.h
> +++ b/include/linux/mmc/mmc.h
> @@ -273,6 +273,7 @@ struct _mmc_csd {
> =A0#define EXT_CSD_FLUSH_CACHE =A0 =A0 =A0 =A0 =A0 =A032 =A0 =A0 =A0/=
* W */
> =A0#define EXT_CSD_CACHE_CTRL =A0 =A0 =A0 =A0 =A0 =A0 33 =A0 =A0 =A0/=
* R/W */
> =A0#define EXT_CSD_POWER_OFF_NOTIFICATION 34 =A0 =A0 =A0/* R/W */
> +#define EXT_CSD_DATA_SECTOR_SIZE =A0 =A0 =A0 61 =A0 =A0 =A0/* R */
> =A0#define EXT_CSD_GP_SIZE_MULT =A0 =A0 =A0 =A0 =A0 143 =A0 =A0 /* R/=
W */
> =A0#define EXT_CSD_PARTITION_ATTRIBUTE =A0 =A0156 =A0 =A0 /* R/W */
> =A0#define EXT_CSD_PARTITION_SUPPORT =A0 =A0 =A0160 =A0 =A0 /* RO */
> @@ -313,6 +314,8 @@ struct _mmc_csd {
> =A0#define EXT_CSD_POWER_OFF_LONG_TIME =A0 =A0247 =A0 =A0 /* RO */
> =A0#define EXT_CSD_GENERIC_CMD6_TIME =A0 =A0 =A0248 =A0 =A0 /* RO */
> =A0#define EXT_CSD_CACHE_SIZE =A0 =A0 =A0 =A0 =A0 =A0 249 =A0 =A0 /* =
RO, 4 bytes */
> +#define EXT_CSD_TAG_UNIT_SIZE =A0 =A0 =A0 =A0 =A0498 =A0 =A0 /* RO *=
/
> +#define EXT_CSD_DATA_TAG_SUPPORT =A0 =A0 =A0 499 =A0 =A0 /* RO */
> =A0#define EXT_CSD_HPI_FEATURES =A0 =A0 =A0 =A0 =A0 503 =A0 =A0 /* RO=
 */
>
> =A0/*
> --
> 1.7.4.3
>
> --
