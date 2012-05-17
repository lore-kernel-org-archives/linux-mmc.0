From: Saugata Das <saugata.das@linaro.org>
Subject: Re: [PATCH 1/2] [MMC-4.5] Disable emulation
Date: Thu, 17 May 2012 08:42:07 +0530
Message-ID: <CAKLKtzeZaOJ7vKqLgj5HYJF18ww+=C5LwWkU_i-77D0Xz6EVSQ@mail.gmail.com>
References: <1337185615-17202-1-git-send-email-saugata.das@stericsson.com>
	<CAKYAXd8PsrTjTvfM3y4PFg-oHGZs2ayUFrFAG1=_7NXvYRngfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:53834 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760477Ab2EQDMJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 May 2012 23:12:09 -0400
Received: by qcro28 with SMTP id o28so958473qcr.19
        for <linux-mmc@vger.kernel.org>; Wed, 16 May 2012 20:12:08 -0700 (PDT)
In-Reply-To: <CAKYAXd8PsrTjTvfM3y4PFg-oHGZs2ayUFrFAG1=_7NXvYRngfg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Namjae Jeon <linkinjeon@gmail.com>
Cc: Saugata Das <saugata.das@stericsson.com>, linux-mmc@vger.kernel.org, venkat@linaro.org, patches@linaro.org, arnd.bergmann@linaro.org, lporzio@micron.com

On 17 May 2012 06:35, Namjae Jeon <linkinjeon@gmail.com> wrote:
> 2012/5/17, Saugata Das <saugata.das@stericsson.com>:
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
>> USE_NATIVE_SECTOR
>> is enabled, partition table is 4KB sector size aligned and file syst=
em
>> block
>> size is 4KB.
> If you change native 4K from 512B emulation, filesystem sector size i=
s
> also 4KB align as well block size.
> because default block size of most of filesystem is 4KB, but
> filesystem sector size is 512B,
> So filesystem corruption can be occured on native 4K device.
>>

I have tested ext4 with 4KB block size and I did not see an instance
where it requested 512B.
=46or sure, if someone is using file system with 512B sector on eMMC
then the USE_NATIVE_SECTOR should not be enabled.

The idea behind the patch is, MMC driver should notify the sector size
information in a generic manner to file system. So, we depend here on
ext_csd.data_sector_size, which should work in both 512B and 4KB case.


>> Signed-off-by: Saugata Das <saugata.das@linaro.org>
>> ---
>> =A0drivers/mmc/card/block.c | =A0 16 ++++++++++++++--
>> =A0drivers/mmc/core/mmc.c =A0 | =A0 =A02 ++
>> =A02 files changed, 16 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>> index 91cda75..b4d0eb1 100644
>> --- a/drivers/mmc/card/block.c
>> +++ b/drivers/mmc/card/block.c
>> @@ -1284,7 +1284,7 @@ static int mmc_blk_issue_rw_rq(struct mmc_queu=
e *mq,
>> struct request *rqc)
>> =A0 =A0 =A0 int ret =3D 1, disable_multi =3D 0, retry =3D 0, type;
>> =A0 =A0 =A0 enum mmc_blk_status status;
>> =A0 =A0 =A0 struct mmc_queue_req *mq_rq;
>> - =A0 =A0 struct request *req;
>> + =A0 =A0 struct request *req =3D rqc;
>> =A0 =A0 =A0 struct mmc_async_req *areq;
>>
>> =A0 =A0 =A0 if (!rqc && !mq->mqrq_prev->req)
>> @@ -1292,6 +1292,14 @@ static int mmc_blk_issue_rw_rq(struct mmc_que=
ue *mq,
>> struct request *rqc)
>>
>> =A0 =A0 =A0 do {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (rqc) {
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * When 4KB native sect=
or is enabled, single block
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * read or write is not=
 allowed
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((brq->data.blocks =3D=3D=
 1) &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (card->ext=
_csd.data_sector_size =3D=3D 4096))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto cmd_a=
bort;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 Why did you add this
> code in any case ?
>

This was pointed during the previous review that with 4KB sector mode,
512B transfer is not allowed. So, this check has been added here.

>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_blk_rw_rq_prep(mq->m=
qrq_cur, card, 0, mq);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 areq =3D &mq->mqrq_cur->=
mmc_active;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else
>> @@ -1539,7 +1547,11 @@ static struct mmc_blk_data *mmc_blk_alloc_req=
(struct
>> mmc_card *card,
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
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index 7268c26..11444c6 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -516,6 +516,8 @@ static int mmc_read_ext_csd(struct mmc_card *car=
d, u8
>> *ext_csd)
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
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
