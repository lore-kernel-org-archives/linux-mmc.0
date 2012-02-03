From: Saugata Das <saugata.das@linaro.org>
Subject: Re: [RFC] MMC-4.5 Context ID
Date: Fri, 3 Feb 2012 11:18:46 +0530
Message-ID: <CAKLKtzdSJfrHfP8V=NHKPfY-FrTn7V-HPEeb-sgoQ09b3nx3og@mail.gmail.com>
References: <1328110021-15199-1-git-send-email-saugata.das@stericsson.com>
	<CANfBPZ96jSe8rUr2Mvif-F76v0xPP=2Rg7-eOCxP8L3j481WTg@mail.gmail.com>
	<4F2B4A65.3090405@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:48207 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752965Ab2BCFsr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Feb 2012 00:48:47 -0500
Received: by wgbdt10 with SMTP id dt10so3432219wgb.1
        for <linux-mmc@vger.kernel.org>; Thu, 02 Feb 2012 21:48:46 -0800 (PST)
In-Reply-To: <4F2B4A65.3090405@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "S, Venkatraman" <svenkatr@ti.com>, Saugata Das <saugata.das@stericsson.com>, linux-mmc@vger.kernel.org

On 3 February 2012 08:15, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> On 02/03/2012 01:08 AM, S, Venkatraman wrote:
>
>> On Wed, Feb 1, 2012 at 8:57 PM, Saugata Das <saugata.das@stericsson.=
com> wrote:
>>> From: Saugata Das <saugata.das@linaro.org>
>>>
>>> This patch groups the read or write transfers to eMMC in different =
contexts
>>> based on the block number. Transfers to consecutive blocks are grou=
ped to a
>>> common context. So several small transfers combine to give performa=
nce like
>>> a large multi block transfer.
>>>
>>> The patch creates a context of 1MB multiple in non-large unit mode.=
 Reliable
>>> mode is enabled in the context based on whether reliable write is e=
nabled.
>>>
>>> Signed-off-by: Saugata Das <saugata.das@linaro.org>
>>> ---
>> The patch subject could be better off as "mmc: eMMC4.5 context ID su=
pport"
>>
>>> =A0drivers/mmc/card/block.c | =A0263 ++++++++++++++++++++++++++++++=
++++++++++++----
>>> =A0drivers/mmc/core/mmc.c =A0 | =A0 =A06 +
>>> =A0include/linux/mmc/card.h | =A0 13 +++
>>> =A0include/linux/mmc/core.h | =A0 =A09 ++
>>> =A0include/linux/mmc/host.h | =A0 =A01 +
>>> =A0include/linux/mmc/mmc.h =A0| =A0 =A03 +
>>> =A06 files changed, 275 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>>> index 176b78e..161174a 100644
>>> --- a/drivers/mmc/card/block.c
>>> +++ b/drivers/mmc/card/block.c
>>> @@ -127,6 +127,8 @@ enum mmc_blk_status {
>>> =A0module_param(perdev_minors, int, 0444);
>>> =A0MODULE_PARM_DESC(perdev_minors, "Minors numbers to allocate per =
device");
>>>
>>> +static int mmc_blk_issue_rw_rq(struct mmc_queue *, struct request =
*);
>>> +
>>> =A0static struct mmc_blk_data *mmc_blk_get(struct gendisk *disk)
>>> =A0{
>>> =A0 =A0 =A0 =A0struct mmc_blk_data *md;
>>> @@ -1071,6 +1073,192 @@ static int mmc_blk_err_check(struct mmc_car=
d *card,
>>> =A0 =A0 =A0 =A0return MMC_BLK_SUCCESS;
>>> =A0}
>>>
>>> +/*
>>> + * Update the context information in the ext. CSD
>>
>> Mixed case
>>
>>> + */
>>> +static int mmc_context_modify(struct mmc_queue *mq,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struc=
t mmc_card *card,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsig=
ned int context_id,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsig=
ned char context_conf)
>>> +{
>>> + =A0 =A0 =A0 /*
>>> + =A0 =A0 =A0 =A0* Wait for any ongoing transfer
>>> + =A0 =A0 =A0 =A0*/
>>> + =A0 =A0 =A0 if (card->host->areq)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_blk_issue_rw_rq(mq, NULL);
>>> +
>>> + =A0 =A0 =A0 /*
>>> + =A0 =A0 =A0 =A0* CONTEXT_CONF array starts from context id 1
>>> + =A0 =A0 =A0 =A0*/
>>> + =A0 =A0 =A0 return mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 EXT_CSD_CONTEXT_CONF =
+ context_id - 1,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 context_conf,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.generic=
_cmd6_time);
>>> +}
>>> +
>>> +/*
>>> + * Update timestamp, size and close context if needed
>>> + */
>>> +static int mmc_check_close_context(struct mmc_queue *mq,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struc=
t mmc_card *card,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsig=
ned int context_id,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsig=
ned int status)
>>> +{
>>> + =A0 =A0 =A0 /*
>>> + =A0 =A0 =A0 =A0* Check only for valid contexts
>>> + =A0 =A0 =A0 =A0*/
>>> + =A0 =A0 =A0 if ((context_id > 0) &&
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (context_id <=3D card->ext_csd.max_co=
ntext_id) &&
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (card->mmc_context[context_id].valid)=
) {
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Incase of an error or we are mul=
tiple of erase block then
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* close the context
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((status) ||
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((card->mmc_context[c=
ontext_id].size %
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card-=
>ext_csd.lu_size) =3D=3D 0)) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc_context_modif=
y(mq, card, context_id,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 MMC_CONTEXT_CLOSE))
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 retur=
n -1;
>> Should propagate the error code instead of returning -1
>>
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->mmc_context[con=
text_id].valid =3D 0;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>>> + =A0 =A0 =A0 }
>>> + =A0 =A0 =A0 return 0;
>>> +}
>>> +
>>> +/*
>>> + * Update timestamp, size and close context if needed
>>> + */
>>> +static int mmc_force_close_all_write_context(struct mmc_queue *mq,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struc=
t mmc_card *card)
>>> +{
>>> + =A0 =A0 =A0 int i, ret =3D 0;
>>> + =A0 =A0 =A0 for (i =3D 1; i <=3D card->ext_csd.max_context_id; i+=
+) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (card->mmc_context[i].direction !=3D=
 MMC_CONTEXT_READ) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D mmc_check_clo=
se_context(mq, card, i,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 MMC_CONTEXT_FORCE_CLOSE);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 retur=
n ret;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>> + =A0 =A0 =A0 }
>>> + =A0 =A0 =A0 return ret;
>>> +}
>>> +
>>> +/*
>>> + * Search for a context which is in the same direction and
>>> + * continuous in block numbers. If no matching context is
>>> + * found then take up an unused context. If all contexts are
>>> + * used then close the context which is least recently used,
>>> + * close it and the use it for the new transfer
>>> + */
>>> +static int mmc_get_context_id(struct mmc_queue *mq,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struc=
t mmc_card *card,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsig=
ned int offset,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsig=
ned int size,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsig=
ned int direction,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsig=
ned int rel_wr)
>>> +{
>>> + =A0 =A0 =A0 int i, free_index =3D -1, lru_index =3D -1, ret_index=
;
>>> + =A0 =A0 =A0 unsigned int old_timestamp =3D -1;
>>> + =A0 =A0 =A0 unsigned int reliability_mode =3D rel_wr ? (0x01<<5) =
: 0;
>>> + =A0 =A0 =A0 struct mmc_context *context_ptr =3D &card->mmc_contex=
t[1];
>>> +
>>> + =A0 =A0 =A0 /*
>>> + =A0 =A0 =A0 =A0* For older than 4.5 eMMC, there is no context ID
>>> + =A0 =A0 =A0 =A0*/
>>> + =A0 =A0 =A0 if (card->ext_csd.max_context_id =3D=3D 0)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>>> +
>>> + =A0 =A0 =A0 if (card->host->caps2 & MMC_CAP2_NO_CONTEXT)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>>> +
>>> + =A0 =A0 =A0 /*
>>> + =A0 =A0 =A0 =A0* If the request is LU size multiple then avoid
>>> + =A0 =A0 =A0 =A0* using any context
>>> + =A0 =A0 =A0 =A0*/
>>> + =A0 =A0 =A0 if ((size % card->ext_csd.lu_size) =3D=3D 0)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>>> +
>>> + =A0 =A0 =A0 /*
>>> + =A0 =A0 =A0 =A0* Context 0 is unused
>>> + =A0 =A0 =A0 =A0*/
>>> + =A0 =A0 =A0 for (i =3D 1; i <=3D card->ext_csd.max_context_id; i+=
+, context_ptr++) {
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int context_start_blk;
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!context_ptr->valid) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (free_index =3D=3D=
 -1)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_=
index =3D i;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 context_start_blk =3D context_ptr->of=
fset -
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 context_ptr->size;
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((context_start_blk <=3D offset) &=
&
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (context_ptr->offset =
> offset)) {
>>
>> How would this condition ever match ? The starting offset of the
>> previous request is usually less than the current request or it is
>> more, but not both.
>>
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int ret =3D mmc_check=
_close_context(mq, card, i,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 MMC_CONTEXT_FORCE_CLOSE);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret < 0)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 retur=
n ret;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (free_index =3D=3D=
 -1)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_=
index =3D i;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((lru_index =3D=3D -1) ||
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (context_ptr->timesta=
mp < old_timestamp)) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 old_timestamp =3D con=
text_ptr->timestamp;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 lru_index =3D i;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((context_ptr->direction !=3D dire=
ction) ||
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (context_ptr->offset =
!=3D offset) ||
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (context_ptr->reliabi=
lity_mode !=3D
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 relia=
bility_mode))
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>>
>> I think the reliability mode match shouldn't matter. If the writes t=
o
>> the same section of the device, the best of the reliability modes ca=
n
>> be applied.
>> This section should be moved above the context_start_blk and offset
>> checking code.
>> Why close an ongoing context if the directions don't match eventuall=
y ?
>>
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 context_ptr->timestamp =3D jiffies;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 context_ptr->offset +=3D size;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 context_ptr->size +=3D size;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return i;
>>> + =A0 =A0 =A0 }
>>> +
>>> + =A0 =A0 =A0 if (free_index !=3D -1) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Open a free context
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc_context_modify(mq, card, free=
_index,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (dire=
ction & 0x03) | reliability_mode))
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret_index =3D free_index;
>>> + =A0 =A0 =A0 } else if (lru_index !=3D -1) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Close and reopen the LRU context
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc_context_modify(mq, card, lru_=
index, MMC_CONTEXT_CLOSE))
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc_context_modify(mq, card, lru_=
index,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (dire=
ction & 0x03) | reliability_mode))
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret_index =3D lru_index;
>>> + =A0 =A0 =A0 } else
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
>>> +
>>> + =A0 =A0 =A0 context_ptr =3D &card->mmc_context[ret_index];
>>> + =A0 =A0 =A0 context_ptr->offset =3D offset+size;
>>> + =A0 =A0 =A0 context_ptr->size =3D size;
>>> + =A0 =A0 =A0 context_ptr->direction =3D direction;
>>> + =A0 =A0 =A0 context_ptr->timestamp =3D jiffies;
>>> + =A0 =A0 =A0 context_ptr->reliability_mode =3D reliability_mode;
>>> + =A0 =A0 =A0 context_ptr->valid =3D 1;
>>> +
>>> + =A0 =A0 =A0 return ret_index;
>>> +}
>>> +
>>> =A0static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct =
mmc_card *card,
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int dis=
able_multi,
>>> @@ -1080,7 +1268,6 @@ static void mmc_blk_rw_rq_prep(struct mmc_que=
ue_req *mqrq,
>>> =A0 =A0 =A0 =A0struct mmc_blk_request *brq =3D &mqrq->brq;
>>> =A0 =A0 =A0 =A0struct request *req =3D mqrq->req;
>>> =A0 =A0 =A0 =A0struct mmc_blk_data *md =3D mq->data;
>>> - =A0 =A0 =A0 bool do_data_tag;
>>>
>>> =A0 =A0 =A0 =A0/*
>>> =A0 =A0 =A0 =A0 * Reliable writes are used to implement Forced Unit=
 Access and
>>> @@ -1157,16 +1344,6 @@ static void mmc_blk_rw_rq_prep(struct mmc_qu=
eue_req *mqrq,
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_apply_rel_rw(brq, card, req);
>>>
>>> =A0 =A0 =A0 =A0/*
>>> - =A0 =A0 =A0 =A0* Data tag is used only during writing meta data t=
o speed
>>> - =A0 =A0 =A0 =A0* up write and any subsequent read of this meta da=
ta
>>> - =A0 =A0 =A0 =A0*/
>>> - =A0 =A0 =A0 do_data_tag =3D (card->ext_csd.data_tag_unit_size) &&
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 (req->cmd_flags & REQ_META) &&
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 (rq_data_dir(req) =3D=3D WRITE) &&
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((brq->data.blocks * brq->data.blksz)=
 >=3D
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0card->ext_csd.data_tag_unit_size);
>>> -
>>> - =A0 =A0 =A0 /*
>>> =A0 =A0 =A0 =A0 * Pre-defined multi-block transfers are preferable =
to
>>> =A0 =A0 =A0 =A0 * open ended-ones (and necessary for reliable write=
s).
>>> =A0 =A0 =A0 =A0 * However, it is not sufficient to just send CMD23,
>>> @@ -1184,15 +1361,54 @@ static void mmc_blk_rw_rq_prep(struct mmc_q=
ueue_req *mqrq,
>>> =A0 =A0 =A0 =A0 * We'll avoid using CMD23-bounded multiblock writes=
 for
>>> =A0 =A0 =A0 =A0 * these, while retaining features like reliable wri=
tes.
>>> =A0 =A0 =A0 =A0 */
>>> - =A0 =A0 =A0 if ((md->flags & MMC_BLK_CMD23) && mmc_op_multi(brq->=
cmd.opcode) &&
>>> - =A0 =A0 =A0 =A0 =A0 (do_rel_wr || !(card->quirks & MMC_QUIRK_BLK_=
NO_CMD23) ||
>>> - =A0 =A0 =A0 =A0 =A0 =A0do_data_tag)) {
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 brq->sbc.opcode =3D MMC_SET_BLOCK_COU=
NT;
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 brq->sbc.arg =3D brq->data.blocks |
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (do_rel_wr ? (1 << 31=
) : 0) |
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (do_data_tag ? (1 << =
29) : 0);
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 brq->sbc.flags =3D MMC_RSP_R1 | MMC_C=
MD_AC;
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 brq->mrq.sbc =3D &brq->sbc;
>>> + =A0 =A0 =A0 if ((md->flags & MMC_BLK_CMD23) && mmc_op_multi(brq->=
cmd.opcode)) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Context ID is used for non-large=
 unit and non-reliable
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* write transfers provided the sta=
rt block number
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* sequentially follows any of the =
open contexts
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int context_id;
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Data tag is used only during wri=
ting meta data to speed
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* up write and any subsequent read=
 of this meta data
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bool do_data_tag =3D (card->ext_csd.d=
ata_tag_unit_size) &&
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (req->cmd_flags & REQ=
_META) &&
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (rq_data_dir(req) =3D=
=3D WRITE) &&
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((brq->data.blocks * =
brq->data.blksz) >=3D
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.data_ta=
g_unit_size);
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* During fsync, ensure that data i=
s committed to storage
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (req->cmd_flags & (REQ_FLUSH | REQ=
_SYNC))
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_force_close_all_w=
rite_context(mq, card);
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Context ID is used for non-large=
 unit and non-reliable
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* write transfers provided the sta=
rt block number
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* sequentially follows any of the =
open contexts
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 context_id =3D mmc_get_context_id(mq,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 blk_rq_pos(req),
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 brq->data.blocks,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (rq_data_dir(req) =3D=
=3D WRITE) ? MMC_CONTEXT_WRITE :
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MMC_C=
ONTEXT_READ,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 do_rel_wr);
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 if (do_rel_wr || !(card->quirks & MMC_QUIRK_B=
LK_NO_CMD23) ||
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 do_data_tag || (conte=
xt_id > 0)) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 brq->sbc.opcode =3D M=
MC_SET_BLOCK_COUNT;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 brq->sbc.arg =3D brq-=
>data.blocks |
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (do_r=
el_wr ? (1 << 31) : 0) |
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (do_d=
ata_tag ? (1 << 29) : 0) |
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (((co=
ntext_id > 0) && (!do_rel_wr)) ?
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 ((context_id & 0x0f) << 25) : 0);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 brq->sbc.flags =3D MM=
C_RSP_R1 | MMC_CMD_AC;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 brq->mrq.sbc =3D &brq=
->sbc;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>
> Can Data-tag & context-Id use together?

No. This is a mistake. I will rectify it in next version.

But overall, do we agree with this approach of context management
where we are trying to keep consecutive blocks within same context ?

>
> Best Regards,
> Jaehoon Chung
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
