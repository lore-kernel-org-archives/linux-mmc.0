From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: block: disable the reliable write If the card does
 not support CMD23
Date: Thu, 27 Aug 2015 15:22:44 +0200
Message-ID: <CAPDyKFpVN8aK6aF2Fk9UNgFfJU5W1CT4v4YBtJDF6t57cwXsKg@mail.gmail.com>
References: <1439537446-7713-1-git-send-email-sdliyong@gmail.com>
	<CAPDyKFp51gzyNaGkGWDXs0ATX2hom2yfcLHXT4o=dzw2=AbWNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:37566 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752681AbbH0NWp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Aug 2015 09:22:45 -0400
Received: by widdq5 with SMTP id dq5so45068561wid.0
        for <linux-mmc@vger.kernel.org>; Thu, 27 Aug 2015 06:22:44 -0700 (PDT)
In-Reply-To: <CAPDyKFp51gzyNaGkGWDXs0ATX2hom2yfcLHXT4o=dzw2=AbWNw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yong Li <sdliyong@gmail.com>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 25 August 2015 at 14:06, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 14 August 2015 at 09:30,  <sdliyong@gmail.com> wrote:
>> From: Yong Li <sdliyong@gmail.com>
>>
>> Signed-off-by: Yong Li <sdliyong@gmail.com>
>> ---
>>  drivers/mmc/card/block.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>> index 452782b..d9e3c45 100644
>> --- a/drivers/mmc/card/block.c
>> +++ b/drivers/mmc/card/block.c
>> @@ -1366,7 +1366,8 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
>>         bool do_rel_wr = ((req->cmd_flags & REQ_FUA) ||
>>                           (req->cmd_flags & REQ_META)) &&
>>                 (rq_data_dir(req) == WRITE) &&
>> -               (md->flags & MMC_BLK_REL_WR);
>> +               (md->flags & MMC_BLK_REL_WR) &&
>> +               !(card->quirks & MMC_QUIRK_BLK_NO_CMD23);
>
> Further down in mmc_blk_rw_rq_prep() we check for
> MMC_QUIRK_BLK_NO_CMD23. That check becomes redundant after this
> change, please remove that check as a part of this patch as well.
>
>>
>>         memset(brq, 0, sizeof(struct mmc_blk_request));
>>         brq->mrq.cmd = &brq->cmd;
>> --
>> 2.1.0
>>
>

Please ignore my previous answer. MMC_QUIRK_BLK_NO_CMD23 is intended
to indicate to the mmc block layer whether using CMD23 for regular
block IO request could have a performance impact for some cards. If
that's the case we don't use it - except when using reliable write!

So this patch is just plain wrong.

Kind regards
Uffe
