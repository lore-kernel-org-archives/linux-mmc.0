From: Saugata Das <saugata.das@linaro.org>
Subject: Re: [PATCH] [MMC 4.5] Fix for checking block numbers in disable
 emulation mode
Date: Fri, 29 Jun 2012 18:22:46 +0530
Message-ID: <CAKLKtzf15D8ipjVy1XeRe-yfbK2afnkN5x258Md19V0GCLjvQw@mail.gmail.com>
References: <1340951554-29504-1-git-send-email-saugata.das@stericsson.com>
	<008d01cd55df$b7bbab50$273301f0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:50044 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754304Ab2F2Mwr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Jun 2012 08:52:47 -0400
Received: by ghrr11 with SMTP id r11so2652728ghr.19
        for <linux-mmc@vger.kernel.org>; Fri, 29 Jun 2012 05:52:47 -0700 (PDT)
In-Reply-To: <008d01cd55df$b7bbab50$273301f0$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: Saugata Das <saugata.das@stericsson.com>, linux-mmc@vger.kernel.org, patches@linaro.org

On 29 June 2012 15:42, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> Hi Saugata,
>
> Could you check the comment below?
>
> Friday, June 29, 2012, Saugata Das <saugata.das@linaro.org> wrote:
>> From: Saugata Das <saugata.das@linaro.org>
>>
>> In 512B disable emulation patch, a check is done to ensure that size
>> of the data is multiple of 4KB. However, the check is done with
>> brq->data.blocks, which is not initialized at the point of check.
>> This is now changed to blk_rq_sectors.
>>
>> Signed-off-by: Saugata Das <saugata.das@linaro.org>
>> ---
>> =A0drivers/mmc/card/block.c | =A0 =A02 +-
>> =A01 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>> index d628c5d..ee8b3d6 100644
>> --- a/drivers/mmc/card/block.c
>> +++ b/drivers/mmc/card/block.c
>> @@ -1296,7 +1296,7 @@ static int mmc_blk_issue_rw_rq(struct mmc_queu=
e *mq, struct request *rqc)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* When 4KB native sec=
tor is enabled, only 8 blocks
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* multiple read or wr=
ite is allowed
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((brq->data.blocks & 0x=
07) &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((blk_rq_sectors(req) &=
 0x07) &&
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (card->e=
xt_csd.data_sector_size =3D=3D 4096)) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("=
%s: Transfer size is not 4KB sector size aligned\n",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 req->rq_disk->disk_name);
>
> In current error handling, multiple block read can be retried using s=
ingle block read
> with disable_multi. Then 4KB alignment will be broken.

True. I shall change to something like,

 		if (disable_multi)
-			brq->data.blocks =3D 1;
+			brq->data.blocks =3D
+				(card->ext_csd.data_sector_size =3D=3D 4096) ?
+					8 : 1;


> Also, =A0there is some conditions to modify the number of blocks in m=
mc_blk_rw_rq_prep.
> That means the alignment of blocks can be changed after mmc_blk_rw_rq=
_prep.
> It needs to be considered.

I think you are referring to possibilities where host is not able to
transfer in multiple of 4KB (MMC_CAP2_NO_MULTI_READ is enabled or
host->max_blk_count is not multiple of 8). I shall add a check in
mmc_read_ext_csd.


-		if (ext_csd[EXT_CSD_DATA_SECTOR_SIZE] =3D=3D 1)
+		if (ext_csd[EXT_CSD_DATA_SECTOR_SIZE] =3D=3D 1) {
+			if ((card->host->caps2 & MMC_CAP2_NO_MULTI_READ) ||
+				(card->host->max_blk_count & 0x07)) {
+				err =3D -EINVAL;
+				goto out;
+			}


>
> And I have a question.
> Spec mentioned that arguments for read commands (CMD17/18) shall alwa=
ys be aligned to 8(4KB)
> in Native 4KB sector. In current implementation CMD17/18 is only used=
 when data.blocks is 1.
> If data.blocks is 8 in Native 4KB sector, then CMD17/18 should be tak=
en instead of CMD24/25?

In native sector mode, only CMD18 and CMD25 will be used for read and w=
rite.


>
> Thanks,
> Seungwon Jeon
>> --
>> 1.7.4.3
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
