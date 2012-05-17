From: Saugata Das <saugata.das@linaro.org>
Subject: Re: [PATCH v2 1/2] [MMC-4.5] Disable emulation
Date: Thu, 17 May 2012 18:45:22 +0530
Message-ID: <CAKLKtzfCYu19XhaKRRsUa8pDuFcdyAvsSEUTsO7QrCT=TG0=kw@mail.gmail.com>
References: <1337252542-25795-1-git-send-email-saugata.das@stericsson.com>
	<000601cd3422$4733c540$d59b4fc0$@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:45261 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932645Ab2EQNPY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 May 2012 09:15:24 -0400
Received: by qcro28 with SMTP id o28so1178630qcr.19
        for <linux-mmc@vger.kernel.org>; Thu, 17 May 2012 06:15:23 -0700 (PDT)
In-Reply-To: <000601cd3422$4733c540$d59b4fc0$@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Saugata Das <saugata.das@stericsson.com>, linux-mmc@vger.kernel.org, patches@linaro.org, arnd.bergmann@linaro.org, venkat@linaro.org, lporzio@micron.com, linkinjeon@gmail.com, Subhash Jadavani <subhashj@codeaurora.org>

On 17 May 2012 17:13, Subhash Jadavani <subhashj@codeaurora.org> wrote:
> Looks good to me.
> Reviewed-by: Subhash Jadavani <subhashj@codeaurora.org>
>

Thanks Subhash, Namjae Jeon.

Chris, will you please merge this patch for your next release.


> Regards,
> Subhash
>
>> -----Original Message-----
>> From: Saugata Das [mailto:saugata.das@stericsson.com]
>> Sent: Thursday, May 17, 2012 4:32 PM
>> To: linux-mmc@vger.kernel.org
>> Cc: patches@linaro.org; saugata.das@linaro.org; subhashj@codeaurora.=
org;
>> arnd.bergmann@linaro.org; venkat@linaro.org; lporzio@micron.com;
>> linkinjeon@gmail.com
>> Subject: [PATCH v2 1/2] [MMC-4.5] Disable emulation
>>
>> From: Saugata Das <saugata.das@linaro.org>
>>
>> This patch adds the support for large sector size of 4KB by disablin=
g
>> emulation.
>> This patch passes eMMC DATA_SECTOR_SIZE as the logical block size du=
ring
>> mmc_blk_alloc_req.
>>
>> In order to use this patch for 4KB sector size, ensure that
>> USE_NATIVE_SECTOR is enabled, partition table is 4KB sector size ali=
gned
> and
>> file system block and sector size are 4KB multiples.
>>
>> Signed-off-by: Saugata Das <saugata.das@linaro.org>
>>
>> changes in v2:
>> =A0 =A0 =A0 Updated description, added pr_err based on review feedba=
ck
>> ---
>> =A0drivers/mmc/card/block.c | =A0 18 ++++++++++++++++--
>> =A0drivers/mmc/core/mmc.c =A0 | =A0 =A02 ++
>> =A02 files changed, 18 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c ind=
ex
>> 91cda75..d628c5d 100644
>> --- a/drivers/mmc/card/block.c
>> +++ b/drivers/mmc/card/block.c
>> @@ -1284,7 +1284,7 @@ static int mmc_blk_issue_rw_rq(struct mmc_queu=
e
>> *mq, struct request *rqc)
>> =A0 =A0 =A0 int ret =3D 1, disable_multi =3D 0, retry =3D 0, type;
>> =A0 =A0 =A0 enum mmc_blk_status status;
>> =A0 =A0 =A0 struct mmc_queue_req *mq_rq;
>> - =A0 =A0 struct request *req;
>> + =A0 =A0 struct request *req =3D rqc;
>> =A0 =A0 =A0 struct mmc_async_req *areq;
>>
>> =A0 =A0 =A0 if (!rqc && !mq->mqrq_prev->req)
>> @@ -1292,6 +1292,16 @@ static int mmc_blk_issue_rw_rq(struct
>> mmc_queue *mq, struct request *rqc)
>>
>> =A0 =A0 =A0 do {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (rqc) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* When 4KB native secto=
r is enabled, only 8 blocks
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* multiple read or writ=
e is allowed
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((brq->data.blocks & 0x=
07) &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (card->ext=
_csd.data_sector_size =3D=3D 4096)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s=
: Transfer size is not 4KB sector
>> size aligned\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 req->rq_disk->disk_name);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto cmd_a=
bort;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_blk_rw_rq_prep(mq->m=
qrq_cur, card, 0, mq);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 areq =3D &mq->mqrq_cur->=
mmc_active;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else
>> @@ -1539,7 +1549,11 @@ static struct mmc_blk_data
>> *mmc_blk_alloc_req(struct mmc_card *card,
>> =A0 =A0 =A0 snprintf(md->disk->disk_name, sizeof(md->disk->disk_name=
),
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"mmcblk%d%s", md->name_idx, subname ?=
 subname : "");
>>
>> - =A0 =A0 blk_queue_logical_block_size(md->queue.queue, 512);
>> + =A0 =A0 if (mmc_card_mmc(card))
>> + =A0 =A0 =A0 =A0 =A0 =A0 blk_queue_logical_block_size(md->queue.que=
ue,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.data_sector_=
size);
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 blk_queue_logical_block_size(md->queue.que=
ue, 512);
>> =A0 =A0 =A0 set_capacity(md->disk, size);
>>
>> =A0 =A0 =A0 if (mmc_host_cmd23(card->host)) {
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c index
>> 7268c26..11444c6 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -516,6 +516,8 @@ static int mmc_read_ext_csd(struct mmc_card *car=
d,
>> u8 *ext_csd)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.data_tag_u=
nit_size =3D 0;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.data_sector_size =3D 512;
>> =A0 =A0 =A0 }
>>
>> =A0out:
>> --
>> 1.7.4.3
>
>
