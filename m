From: Saugata Das <saugata.das@linaro.org>
Subject: Re: [RFC] MMC-4.5 Context ID
Date: Fri, 3 Feb 2012 11:17:51 +0530
Message-ID: <CAKLKtzd4EwMGhbNyZwDZXkBQAkgUzNXQwDWDcmyT8SnNptHPvg@mail.gmail.com>
References: <1328110021-15199-1-git-send-email-saugata.das@stericsson.com>
	<CANfBPZ96jSe8rUr2Mvif-F76v0xPP=2Rg7-eOCxP8L3j481WTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:55245 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752853Ab2BCFrw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Feb 2012 00:47:52 -0500
Received: by werb13 with SMTP id b13so2416740wer.19
        for <linux-mmc@vger.kernel.org>; Thu, 02 Feb 2012 21:47:51 -0800 (PST)
In-Reply-To: <CANfBPZ96jSe8rUr2Mvif-F76v0xPP=2Rg7-eOCxP8L3j481WTg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "S, Venkatraman" <svenkatr@ti.com>
Cc: Saugata Das <saugata.das@stericsson.com>, linux-mmc@vger.kernel.org

On 2 February 2012 21:38, S, Venkatraman <svenkatr@ti.com> wrote:
> On Wed, Feb 1, 2012 at 8:57 PM, Saugata Das <saugata.das@stericsson.c=
om> wrote:
>> From: Saugata Das <saugata.das@linaro.org>
>>
>> This patch groups the read or write transfers to eMMC in different c=
ontexts
>> based on the block number. Transfers to consecutive blocks are group=
ed to a
>> common context. So several small transfers combine to give performan=
ce like
>> a large multi block transfer.
>>
>> The patch creates a context of 1MB multiple in non-large unit mode. =
Reliable
>> mode is enabled in the context based on whether reliable write is en=
abled.
>>
>> Signed-off-by: Saugata Das <saugata.das@linaro.org>
>> ---
> The patch subject could be better off as "mmc: eMMC4.5 context ID sup=
port"

OK

>
>> =A0drivers/mmc/card/block.c | =A0263 +++++++++++++++++++++++++++++++=
+++++++++++----
>> =A0drivers/mmc/core/mmc.c =A0 | =A0 =A06 +
>> =A0include/linux/mmc/card.h | =A0 13 +++
>> =A0include/linux/mmc/core.h | =A0 =A09 ++
>> =A0include/linux/mmc/host.h | =A0 =A01 +
>> =A0include/linux/mmc/mmc.h =A0| =A0 =A03 +
>> =A06 files changed, 275 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>> index 176b78e..161174a 100644
>> --- a/drivers/mmc/card/block.c
>> +++ b/drivers/mmc/card/block.c
>> @@ -127,6 +127,8 @@ enum mmc_blk_status {
>> =A0module_param(perdev_minors, int, 0444);
>> =A0MODULE_PARM_DESC(perdev_minors, "Minors numbers to allocate per d=
evice");
>>
>> +static int mmc_blk_issue_rw_rq(struct mmc_queue *, struct request *=
);
>> +
>> =A0static struct mmc_blk_data *mmc_blk_get(struct gendisk *disk)
>> =A0{
>> =A0 =A0 =A0 =A0struct mmc_blk_data *md;
>> @@ -1071,6 +1073,192 @@ static int mmc_blk_err_check(struct mmc_card=
 *card,
>> =A0 =A0 =A0 =A0return MMC_BLK_SUCCESS;
>> =A0}
>>
>> +/*
>> + * Update the context information in the ext. CSD
>
> Mixed case

OK

>
>> + */
>> +static int mmc_context_modify(struct mmc_queue *mq,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct=
 mmc_card *card,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsign=
ed int context_id,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsign=
ed char context_conf)
>> +{
>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0* Wait for any ongoing transfer
>> + =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 if (card->host->areq)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_blk_issue_rw_rq(mq, NULL);
>> +
>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0* CONTEXT_CONF array starts from context id 1
>> + =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 return mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 EXT_CSD_CONTEXT_CONF +=
 context_id - 1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 context_conf,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.generic_=
cmd6_time);
>> +}
>> +
>> +/*
>> + * Update timestamp, size and close context if needed
>> + */
>> +static int mmc_check_close_context(struct mmc_queue *mq,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct=
 mmc_card *card,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsign=
ed int context_id,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsign=
ed int status)
>> +{
>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0* Check only for valid contexts
>> + =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 if ((context_id > 0) &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (context_id <=3D card->ext_csd.max_con=
text_id) &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (card->mmc_context[context_id].valid))=
 {
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Incase of an error or we are mult=
iple of erase block then
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* close the context
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((status) ||
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((card->mmc_context[co=
ntext_id].size %
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->=
ext_csd.lu_size) =3D=3D 0)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc_context_modify=
(mq, card, context_id,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 MMC_CONTEXT_CLOSE))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return=
 -1;
> Should propagate the error code instead of returning -1
>

OK

>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->mmc_context[cont=
ext_id].valid =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> + =A0 =A0 =A0 }
>> + =A0 =A0 =A0 return 0;
>> +}
>> +
>> +/*
>> + * Update timestamp, size and close context if needed
>> + */
>> +static int mmc_force_close_all_write_context(struct mmc_queue *mq,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct=
 mmc_card *card)
>> +{
>> + =A0 =A0 =A0 int i, ret =3D 0;
>> + =A0 =A0 =A0 for (i =3D 1; i <=3D card->ext_csd.max_context_id; i++=
) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (card->mmc_context[i].direction !=3D=
 MMC_CONTEXT_READ) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D mmc_check_clos=
e_context(mq, card, i,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 MMC_CONTEXT_FORCE_CLOSE);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return=
 ret;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 }
>> + =A0 =A0 =A0 return ret;
>> +}
>> +
>> +/*
>> + * Search for a context which is in the same direction and
>> + * continuous in block numbers. If no matching context is
>> + * found then take up an unused context. If all contexts are
>> + * used then close the context which is least recently used,
>> + * close it and the use it for the new transfer
>> + */
>> +static int mmc_get_context_id(struct mmc_queue *mq,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct=
 mmc_card *card,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsign=
ed int offset,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsign=
ed int size,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsign=
ed int direction,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsign=
ed int rel_wr)
>> +{
>> + =A0 =A0 =A0 int i, free_index =3D -1, lru_index =3D -1, ret_index;
>> + =A0 =A0 =A0 unsigned int old_timestamp =3D -1;
>> + =A0 =A0 =A0 unsigned int reliability_mode =3D rel_wr ? (0x01<<5) :=
 0;
>> + =A0 =A0 =A0 struct mmc_context *context_ptr =3D &card->mmc_context=
[1];
>> +
>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0* For older than 4.5 eMMC, there is no context ID
>> + =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 if (card->ext_csd.max_context_id =3D=3D 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> +
>> + =A0 =A0 =A0 if (card->host->caps2 & MMC_CAP2_NO_CONTEXT)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> +
>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0* If the request is LU size multiple then avoid
>> + =A0 =A0 =A0 =A0* using any context
>> + =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 if ((size % card->ext_csd.lu_size) =3D=3D 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> +
>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0* Context 0 is unused
>> + =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 for (i =3D 1; i <=3D card->ext_csd.max_context_id; i++=
, context_ptr++) {
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int context_start_blk;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!context_ptr->valid) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (free_index =3D=3D =
-1)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_i=
ndex =3D i;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 context_start_blk =3D context_ptr->off=
set -
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 context_ptr->size;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((context_start_blk <=3D offset) &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (context_ptr->offset >=
 offset)) {
>
> How would this condition ever match ? The starting offset of the
> previous request is usually less than the current request or it is
> more, but not both.

Perhaps the names are misleading. "context_ptr->offset" is the next
expected block number (i.e. 1 more than the last block number
transferred). "offset" is the start block number of the current
request. "context_start_blk" is the first block number of the context.
The idea was to make sure that we do not access back some previous
block within the context. I will change the name of
"context_ptr->offset" to "context_ptr->next_blk" and "offset" to
"current_req_start_blk". Is it OK for you ?

Note that, the spec does not prevent us from random or overlapping
access within a context in non-LU mode. But the spec is strict for LU
mode and I followed the principles of LU mode transfers in non-LU mode
because I assumed eMMC performance would be more optimized with such
restrictions.


>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int ret =3D mmc_check_=
close_context(mq, card, i,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 MMC_CONTEXT_FORCE_CLOSE);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return=
 ret;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (free_index =3D=3D =
-1)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_i=
ndex =3D i;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((lru_index =3D=3D -1) ||
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (context_ptr->timestam=
p < old_timestamp)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 old_timestamp =3D cont=
ext_ptr->timestamp;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 lru_index =3D i;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((context_ptr->direction !=3D direc=
tion) ||
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (context_ptr->offset !=
=3D offset) ||
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (context_ptr->reliabil=
ity_mode !=3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reliab=
ility_mode))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>
> I think the reliability mode match shouldn't matter. If the writes to
> the same section of the device, the best of the reliability modes can
> be applied.

Once the reliability of the context is chosen then the individual
writes reliability bit (in CMD23) will be ignored. So, if some writes
need reliability, it needs to check for the reliable context.

> This section should be moved above the context_start_blk and offset
> checking code.

On the same pass of the "for" loop we are trying to set the
"lru_index". The current place is OK, in my view.

> Why close an ongoing context if the directions don't match eventually=
 ?

We open a context with a specific direction (read or write). If
direction do not match, then we can not use that context.

>
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 context_ptr->timestamp =3D jiffies;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 context_ptr->offset +=3D size;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 context_ptr->size +=3D size;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return i;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 if (free_index !=3D -1) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Open a free context
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc_context_modify(mq, card, free_=
index,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (direc=
tion & 0x03) | reliability_mode))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret_index =3D free_index;
>> + =A0 =A0 =A0 } else if (lru_index !=3D -1) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Close and reopen the LRU context
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc_context_modify(mq, card, lru_i=
ndex, MMC_CONTEXT_CLOSE))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc_context_modify(mq, card, lru_i=
ndex,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (direc=
tion & 0x03) | reliability_mode))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret_index =3D lru_index;
>> + =A0 =A0 =A0 } else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
>> +
>> + =A0 =A0 =A0 context_ptr =3D &card->mmc_context[ret_index];
>> + =A0 =A0 =A0 context_ptr->offset =3D offset+size;
>> + =A0 =A0 =A0 context_ptr->size =3D size;
>> + =A0 =A0 =A0 context_ptr->direction =3D direction;
>> + =A0 =A0 =A0 context_ptr->timestamp =3D jiffies;
>> + =A0 =A0 =A0 context_ptr->reliability_mode =3D reliability_mode;
>> + =A0 =A0 =A0 context_ptr->valid =3D 1;
>> +
>> + =A0 =A0 =A0 return ret_index;
>> +}
>> +
>> =A0static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct m=
mc_card *card,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int disa=
ble_multi,
>> @@ -1080,7 +1268,6 @@ static void mmc_blk_rw_rq_prep(struct mmc_queu=
e_req *mqrq,
>> =A0 =A0 =A0 =A0struct mmc_blk_request *brq =3D &mqrq->brq;
>> =A0 =A0 =A0 =A0struct request *req =3D mqrq->req;
>> =A0 =A0 =A0 =A0struct mmc_blk_data *md =3D mq->data;
>> - =A0 =A0 =A0 bool do_data_tag;
>>
>> =A0 =A0 =A0 =A0/*
>> =A0 =A0 =A0 =A0 * Reliable writes are used to implement Forced Unit =
Access and
>> @@ -1157,16 +1344,6 @@ static void mmc_blk_rw_rq_prep(struct mmc_que=
ue_req *mqrq,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_apply_rel_rw(brq, card, req);
>>
>> =A0 =A0 =A0 =A0/*
>> - =A0 =A0 =A0 =A0* Data tag is used only during writing meta data to=
 speed
>> - =A0 =A0 =A0 =A0* up write and any subsequent read of this meta dat=
a
>> - =A0 =A0 =A0 =A0*/
>> - =A0 =A0 =A0 do_data_tag =3D (card->ext_csd.data_tag_unit_size) &&
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 (req->cmd_flags & REQ_META) &&
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 (rq_data_dir(req) =3D=3D WRITE) &&
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((brq->data.blocks * brq->data.blksz) =
>=3D
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0card->ext_csd.data_tag_unit_size);
>> -
>> - =A0 =A0 =A0 /*
>> =A0 =A0 =A0 =A0 * Pre-defined multi-block transfers are preferable t=
o
>> =A0 =A0 =A0 =A0 * open ended-ones (and necessary for reliable writes=
).
>> =A0 =A0 =A0 =A0 * However, it is not sufficient to just send CMD23,
>> @@ -1184,15 +1361,54 @@ static void mmc_blk_rw_rq_prep(struct mmc_qu=
eue_req *mqrq,
>> =A0 =A0 =A0 =A0 * We'll avoid using CMD23-bounded multiblock writes =
for
>> =A0 =A0 =A0 =A0 * these, while retaining features like reliable writ=
es.
>> =A0 =A0 =A0 =A0 */
>> - =A0 =A0 =A0 if ((md->flags & MMC_BLK_CMD23) && mmc_op_multi(brq->c=
md.opcode) &&
>> - =A0 =A0 =A0 =A0 =A0 (do_rel_wr || !(card->quirks & MMC_QUIRK_BLK_N=
O_CMD23) ||
>> - =A0 =A0 =A0 =A0 =A0 =A0do_data_tag)) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 brq->sbc.opcode =3D MMC_SET_BLOCK_COUN=
T;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 brq->sbc.arg =3D brq->data.blocks |
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (do_rel_wr ? (1 << 31)=
 : 0) |
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (do_data_tag ? (1 << 2=
9) : 0);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 brq->sbc.flags =3D MMC_RSP_R1 | MMC_CM=
D_AC;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 brq->mrq.sbc =3D &brq->sbc;
>> + =A0 =A0 =A0 if ((md->flags & MMC_BLK_CMD23) && mmc_op_multi(brq->c=
md.opcode)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Context ID is used for non-large =
unit and non-reliable
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* write transfers provided the star=
t block number
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* sequentially follows any of the o=
pen contexts
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int context_id;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Data tag is used only during writ=
ing meta data to speed
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* up write and any subsequent read =
of this meta data
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bool do_data_tag =3D (card->ext_csd.da=
ta_tag_unit_size) &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (req->cmd_flags & REQ_=
META) &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (rq_data_dir(req) =3D=3D=
 WRITE) &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((brq->data.blocks * b=
rq->data.blksz) >=3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.data_tag=
_unit_size);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* During fsync, ensure that data is=
 committed to storage
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (req->cmd_flags & (REQ_FLUSH | REQ_=
SYNC))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_force_close_all_wr=
ite_context(mq, card);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Context ID is used for non-large =
unit and non-reliable
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* write transfers provided the star=
t block number
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* sequentially follows any of the o=
pen contexts
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 context_id =3D mmc_get_context_id(mq,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 blk_rq_pos(req),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 brq->data.blocks,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (rq_data_dir(req) =3D=3D=
 WRITE) ? MMC_CONTEXT_WRITE :
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MMC_CO=
NTEXT_READ,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 do_rel_wr);
>> +
>> + =A0 =A0 =A0 =A0 =A0 if (do_rel_wr || !(card->quirks & MMC_QUIRK_BL=
K_NO_CMD23) ||
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 do_data_tag || (contex=
t_id > 0)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 brq->sbc.opcode =3D MM=
C_SET_BLOCK_COUNT;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 brq->sbc.arg =3D brq->=
data.blocks |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (do_re=
l_wr ? (1 << 31) : 0) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (do_da=
ta_tag ? (1 << 29) : 0) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (((con=
text_id > 0) && (!do_rel_wr)) ?
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 ((context_id & 0x0f) << 25) : 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 brq->sbc.flags =3D MMC=
_RSP_R1 | MMC_CMD_AC;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 brq->mrq.sbc =3D &brq-=
>sbc;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0}
>>
>> =A0 =A0 =A0 =A0mmc_set_data_timeout(&brq->data, card);
>> @@ -1284,6 +1500,13 @@ static int mmc_blk_issue_rw_rq(struct mmc_que=
ue *mq, struct request *rqc)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0type =3D rq_data_dir(req) =3D=3D READ=
 ? MMC_BLK_READ : MMC_BLK_WRITE;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_queue_bounce_post(mq_rq);
>>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc_check_close_context(mq,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((brq-=
>sbc.arg) >> 25) & 0x0f,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 status=
) < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D MMC_BLK_CMD=
_ERR;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0switch (status) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case MMC_BLK_SUCCESS:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case MMC_BLK_PARTIAL:
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index dc03291..469d100 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -533,6 +533,12 @@ static int mmc_read_ext_csd(struct mmc_card *ca=
rd, u8 *ext_csd)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0card->ext_csd.data_ta=
g_unit_size =3D 0;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* LU size in 512 byte sectors */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.lu_size =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (ext_csd[EXT_CSD_LARGE=
_UNIT_SIZE_M1] + 1) * 0x800;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.max_context_id =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ext_csd[EXT_CSD_CONTEX=
T_CAPABILITIES] & 0x0f;
>> =A0 =A0 =A0 =A0}
>>
>> =A0out:
>> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
>> index f9a0663..2e5b85a 100644
>> --- a/include/linux/mmc/card.h
>> +++ b/include/linux/mmc/card.h
>> @@ -73,6 +73,8 @@ struct mmc_ext_csd {
>> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0hpi_cmd; =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0/* cmd used as HPI */
>> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0data_sector_size;=
 =A0 =A0 =A0 /* 512 bytes or 4KB */
>> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0data_tag_unit_siz=
e; =A0 =A0 /* DATA TAG UNIT size */
>> + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0lu_size;
>> + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0max_context_id;
>> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0boot_ro_lock; =A0=
 =A0 =A0 =A0 =A0 /* ro lock support */
>> =A0 =A0 =A0 =A0bool =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0boot_ro_l=
ockable;
>> =A0 =A0 =A0 =A0u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0raw_par=
tition_support; =A0/* 160 */
>> @@ -184,6 +186,16 @@ struct sdio_func_tuple;
>> =A0#define MAX_MMC_PART_NAME_LEN =A020
>>
>> =A0/*
>> + * Contexts can be upto 15
>> + */
>> +#define MMC_NUM_CONTEXT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A015
>> +#define MMC_CONTEXT_CLOSE =A0 =A0 =A0 =A0 =A0 =A0 =A00
>> +#define MMC_CONTEXT_WRITE =A0 =A0 =A0 =A0 =A0 =A0 =A01
>> +#define MMC_CONTEXT_READ =A0 =A0 =A0 =A0 =A0 =A0 =A0 2
>> +
>> +#define MMC_CONTEXT_FORCE_CLOSE =A0 =A0 =A0 =A01
>> +
>> +/*
>> =A0* MMC Physical partitions
>> =A0*/
>> =A0struct mmc_part {
>> @@ -268,6 +280,7 @@ struct mmc_card {
>> =A0 =A0 =A0 =A0struct dentry =A0 =A0 =A0 =A0 =A0 *debugfs_root;
>> =A0 =A0 =A0 =A0struct mmc_part part[MMC_NUM_PHY_PARTITION]; /* physi=
cal partitions */
>> =A0 =A0 =A0 =A0unsigned int =A0 =A0nr_parts;
>> + =A0 =A0 =A0 struct mmc_context =A0mmc_context[MMC_NUM_CONTEXT];
>> =A0};
>>
>> =A0/*
>> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
>> index 87a976c..f20ebc5 100644
>> --- a/include/linux/mmc/core.h
>> +++ b/include/linux/mmc/core.h
>> @@ -130,6 +130,15 @@ struct mmc_request {
>> =A0 =A0 =A0 =A0void =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(*done)(s=
truct mmc_request *);/* completion function */
>> =A0};
>>
>> +struct mmc_context {
>> + =A0 =A0 =A0 unsigned int offset;
>> + =A0 =A0 =A0 unsigned int size;
>> + =A0 =A0 =A0 unsigned int direction;
>> + =A0 =A0 =A0 unsigned int timestamp;
>> + =A0 =A0 =A0 unsigned int reliability_mode;
>> + =A0 =A0 =A0 unsigned int valid;
>> +};
>> +
>> =A0struct mmc_host;
>> =A0struct mmc_card;
>> =A0struct mmc_async_req;
>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
>> index dd13e05..661e262 100644
>> --- a/include/linux/mmc/host.h
>> +++ b/include/linux/mmc/host.h
>> @@ -255,6 +255,7 @@ struct mmc_host {
>> =A0#define MMC_CAP2_NO_SLEEP_CMD =A0(1 << 4) =A0 =A0 =A0 =A0/* Don't=
 allow sleep command */
>> =A0#define MMC_CAP2_HS200_1_8V_SDR =A0 =A0 =A0 =A0(1 << 5) =A0 =A0 =A0=
 =A0/* can support */
>> =A0#define MMC_CAP2_HS200_1_2V_SDR =A0 =A0 =A0 =A0(1 << 6) =A0 =A0 =A0=
 =A0/* can support */
>> +#define MMC_CAP2_NO_CONTEXT =A0 =A0(1 << 7) =A0 =A0 =A0 =A0/* conte=
xt ID not supported */
>> =A0#define MMC_CAP2_HS200 =A0 =A0 =A0 =A0 (MMC_CAP2_HS200_1_8V_SDR |=
 \
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MMC_=
CAP2_HS200_1_2V_SDR)
>>
>> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
>> index b822a2c..809c3a5 100644
>> --- a/include/linux/mmc/mmc.h
>> +++ b/include/linux/mmc/mmc.h
>> @@ -274,6 +274,7 @@ struct _mmc_csd {
>> =A0#define EXT_CSD_FLUSH_CACHE =A0 =A0 =A0 =A0 =A0 =A032 =A0 =A0 =A0=
/* W */
>> =A0#define EXT_CSD_CACHE_CTRL =A0 =A0 =A0 =A0 =A0 =A0 33 =A0 =A0 =A0=
/* R/W */
>> =A0#define EXT_CSD_POWER_OFF_NOTIFICATION 34 =A0 =A0 =A0/* R/W */
>> +#define EXT_CSD_CONTEXT_CONF =A0 =A0 =A0 =A0 =A0 37 =A0 =A0 =A0/* R=
/W : array of 15 config */
>> =A0#define EXT_CSD_DATA_SECTOR_SIZE =A0 =A0 =A0 61 =A0 =A0 =A0/* R *=
/
>> =A0#define EXT_CSD_GP_SIZE_MULT =A0 =A0 =A0 =A0 =A0 143 =A0 =A0 /* R=
/W */
>> =A0#define EXT_CSD_PARTITION_ATTRIBUTE =A0 =A0156 =A0 =A0 /* R/W */
>> @@ -316,6 +317,8 @@ struct _mmc_csd {
>> =A0#define EXT_CSD_POWER_OFF_LONG_TIME =A0 =A0247 =A0 =A0 /* RO */
>> =A0#define EXT_CSD_GENERIC_CMD6_TIME =A0 =A0 =A0248 =A0 =A0 /* RO */
>> =A0#define EXT_CSD_CACHE_SIZE =A0 =A0 =A0 =A0 =A0 =A0 249 =A0 =A0 /*=
 RO, 4 bytes */
>> +#define EXT_CSD_LARGE_UNIT_SIZE_M1 =A0 =A0 495 /* RO */
>> +#define EXT_CSD_CONTEXT_CAPABILITIES =A0 496 =A0 =A0 /* RO */
>> =A0#define EXT_CSD_TAG_UNIT_SIZE =A0 =A0 =A0 =A0 =A0498 =A0 =A0 /* R=
O */
>> =A0#define EXT_CSD_DATA_TAG_SUPPORT =A0 =A0 =A0 499 =A0 =A0 /* RO */
>> =A0#define EXT_CSD_HPI_FEATURES =A0 =A0 =A0 =A0 =A0 503 =A0 =A0 /* R=
O */
>> --
>> 1.7.4.3
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
