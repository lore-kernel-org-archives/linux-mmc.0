From: Saugata Das <saugata.das@linaro.org>
Subject: Re: [PATCH] MMC-4.5 Data Tag Support
Date: Wed, 21 Dec 2011 16:42:09 +0530
Message-ID: <CAKLKtzf0G2JQfYiwXtXWCCVNmSSzzmAfUiK-kMEw40kEhyi24Q@mail.gmail.com>
References: <1324453157-30081-1-git-send-email-saugata.das@stericsson.com>
	<CAGxe1ZGrBDLargLAFnagOH47-icLVFReEzhV9PzZrXc1MQVsew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:60363 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750703Ab1LULML convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Dec 2011 06:12:11 -0500
Received: by werm1 with SMTP id m1so2593373wer.19
        for <linux-mmc@vger.kernel.org>; Wed, 21 Dec 2011 03:12:09 -0800 (PST)
In-Reply-To: <CAGxe1ZGrBDLargLAFnagOH47-icLVFReEzhV9PzZrXc1MQVsew@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Girish K S <girish.shivananjappa@linaro.org>
Cc: Saugata Das <saugata.das@stericsson.com>, linux-mmc@vger.kernel.org

On 21 December 2011 16:23, Girish K S <girish.shivananjappa@linaro.org>=
 wrote:
> On 21 December 2011 13:09, Saugata Das <saugata.das@stericsson.com> w=
rote:
>> From: Saugata Das <saugata.das@linaro.org>
>>
>> MMC-4.5 data tag feature will be used to store the file system meta-=
data in the
>> tagged region of eMMC. This will improve the write and subsequent re=
ad transfer
>> time for the meta data.
>>
>> Signed-off-by: Saugata Das <saugata.das@linaro.org>
>> ---
>> =A0drivers/mmc/card/block.c | =A0 17 +++++++++++++++--
>> =A0drivers/mmc/core/mmc.c =A0 | =A0 14 ++++++++++++++
>> =A0include/linux/mmc/card.h | =A0 =A02 ++
>> =A0include/linux/mmc/mmc.h =A0| =A0 =A03 +++
>> =A04 files changed, 34 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>> index a1cb21f..af3b6c3 100644
>> --- a/drivers/mmc/card/block.c
>> +++ b/drivers/mmc/card/block.c
>> @@ -995,6 +995,7 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_=
req *mqrq,
>> =A0 =A0 =A0 =A0struct mmc_blk_request *brq =3D &mqrq->brq;
>> =A0 =A0 =A0 =A0struct request *req =3D mqrq->req;
>> =A0 =A0 =A0 =A0struct mmc_blk_data *md =3D mq->data;
>> + =A0 =A0 =A0 bool do_data_tag;
>>
>> =A0 =A0 =A0 =A0/*
>> =A0 =A0 =A0 =A0 * Reliable writes are used to implement Forced Unit =
Access and
>> @@ -1071,6 +1072,16 @@ static void mmc_blk_rw_rq_prep(struct mmc_que=
ue_req *mqrq,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_apply_rel_rw(brq, card, req);
>>
>> =A0 =A0 =A0 =A0/*
>> + =A0 =A0 =A0 =A0* Data tag is used only during writing meta data to=
 speed
>> + =A0 =A0 =A0 =A0* up write and any subsequent read of this meta dat=
a
>> + =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 do_data_tag =3D (card->ext_csd.data_tag_unit_size) &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (req->cmd_flags & REQ_META) &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (rq_data_dir(req) =3D=3D WRITE) &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((brq->data.blocks * brq->data.blksz) =
>=3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.data_tag_unit_size) ;
>> +
>> + =A0 =A0 =A0 /*
>> =A0 =A0 =A0 =A0 * Pre-defined multi-block transfers are preferable t=
o
>> =A0 =A0 =A0 =A0 * open ended-ones (and necessary for reliable writes=
).
>> =A0 =A0 =A0 =A0 * However, it is not sufficient to just send CMD23,
>> @@ -1091,10 +1102,12 @@ static void mmc_blk_rw_rq_prep(struct mmc_qu=
eue_req *mqrq,
>>
>> =A0 =A0 =A0 =A0if ((md->flags & MMC_BLK_CMD23) &&
>> =A0 =A0 =A0 =A0 =A0 =A0mmc_op_multi(brq->cmd.opcode) &&
>> - =A0 =A0 =A0 =A0 =A0 (do_rel_wr || !(card->quirks & MMC_QUIRK_BLK_N=
O_CMD23))) {
>> + =A0 =A0 =A0 =A0 =A0 (do_rel_wr || !(card->quirks & MMC_QUIRK_BLK_N=
O_CMD23) ||
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 do_data_tag)) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0brq->sbc.opcode =3D MMC_SET_BLOCK_COU=
NT;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0brq->sbc.arg =3D brq->data.blocks |
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (do_rel_wr ? (1 << 31)=
 : 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (do_rel_wr ? (1 << 31)=
 : 0) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (do_data_tag ? (1 << 2=
9) : 0);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0brq->sbc.flags =3D MMC_RSP_R1 | MMC_C=
MD_AC;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0brq->mrq.sbc =3D &brq->sbc;
>> =A0 =A0 =A0 =A0}
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index dbf421a..244049b 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -488,6 +488,20 @@ static int mmc_read_ext_csd(struct mmc_card *ca=
rd, u8 *ext_csd)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ext_csd[EXT_CSD_CACHE=
_SIZE + 1] << 8 |
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ext_csd[EXT_CSD_CACHE=
_SIZE + 2] << 16 |
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ext_csd[EXT_CSD_CACHE=
_SIZE + 3] << 24;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ext_csd[EXT_CSD_DATA_SECTOR_SIZE] =
=3D=3D 1)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.data_sec=
tor_size =3D 4096;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.data_sec=
tor_size =3D 512;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((ext_csd[EXT_CSD_DATA_TAG_SUPPORT]=
 & 1) &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (ext_csd[EXT_CSD_TAG_U=
NIT_SIZE] <=3D 8)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.data_tag=
_unit_size =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((unsigned int) 1 << e=
xt_csd[EXT_CSD_TAG_UNIT_SIZE]) *
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (card->ext_csd.data_se=
ctor_size);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.data_tag=
_unit_size =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0}
>>
>> =A0out:
>> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
>> index 415f2db..a55668d 100644
>> --- a/include/linux/mmc/card.h
>> +++ b/include/linux/mmc/card.h
>> @@ -71,6 +71,8 @@ struct mmc_ext_csd {
>> =A0 =A0 =A0 =A0bool =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hpi_en; =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* HPI enablebit */
>> =A0 =A0 =A0 =A0bool =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hpi; =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* HPI support bit */
>> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0hpi_cmd; =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0/* cmd used as HPI */
>> + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0data_sector_size; =
=A0 =A0 =A0 /* 512Bytes or 4KB */
>> + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0data_tag_unit_size=
; =A0 =A0 /* DATA TAG UNIT size */
>> =A0 =A0 =A0 =A0u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0raw_par=
tition_support; =A0/* 160 */
>> =A0 =A0 =A0 =A0u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0raw_era=
sed_mem_count; =A0 /* 181 */
>> =A0 =A0 =A0 =A0u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0raw_ext=
_csd_structure; =A0/* 194 */
>> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
>> index 0e71356..e076f7f 100644
>> --- a/include/linux/mmc/mmc.h
>> +++ b/include/linux/mmc/mmc.h
>> @@ -273,6 +273,7 @@ struct _mmc_csd {
>> =A0#define EXT_CSD_FLUSH_CACHE =A0 =A0 =A0 =A0 =A0 =A032 =A0 =A0 =A0=
/* W */
>> =A0#define EXT_CSD_CACHE_CTRL =A0 =A0 =A0 =A0 =A0 =A0 33 =A0 =A0 =A0=
/* R/W */
>> =A0#define EXT_CSD_POWER_OFF_NOTIFICATION 34 =A0 =A0 =A0/* R/W */
>> +#define EXT_CSD_DATA_SECTOR_SIZE =A0 =A0 =A0 61 =A0 =A0 =A0/* R */
>> =A0#define EXT_CSD_GP_SIZE_MULT =A0 =A0 =A0 =A0 =A0 143 =A0 =A0 /* R=
/W */
>> =A0#define EXT_CSD_PARTITION_ATTRIBUTE =A0 =A0156 =A0 =A0 /* R/W */
>> =A0#define EXT_CSD_PARTITION_SUPPORT =A0 =A0 =A0160 =A0 =A0 /* RO */
>> @@ -313,6 +314,8 @@ struct _mmc_csd {
>> =A0#define EXT_CSD_POWER_OFF_LONG_TIME =A0 =A0247 =A0 =A0 /* RO */
>> =A0#define EXT_CSD_GENERIC_CMD6_TIME =A0 =A0 =A0248 =A0 =A0 /* RO */
>> =A0#define EXT_CSD_CACHE_SIZE =A0 =A0 =A0 =A0 =A0 =A0 249 =A0 =A0 /*=
 RO, 4 bytes */
>> +#define EXT_CSD_TAG_UNIT_SIZE =A0 =A0 =A0 =A0 =A0498 =A0 =A0 /* RO =
*/
>> +#define EXT_CSD_DATA_TAG_SUPPORT =A0 =A0 =A0 499 =A0 =A0 /* RO */
>> =A0#define EXT_CSD_HPI_FEATURES =A0 =A0 =A0 =A0 =A0 503 =A0 =A0 /* R=
O */
>>
>> =A0/*
>
> TAG_RES_SIZE in the extended csd register mentions about the resource
> size utilised by the device to keep data tag.
> This can be used to avoid the data exhaustion case.
>

Once the tag resource is exhausted, the further tag data writes will
be ignored by eMMC and those will be written to the non-tagged or
default area of eMMC (ref to section 6.6.25 in 4.5 spec : "The data
shall still be written to the device regardless of the resources
exhaustion; however, it may not have the improved characteristics").
So, host driver need not do additional tracking of the amount of data
written using tag option.


>> --
>> 1.7.4.3
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
