From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH] mmc: block: disable the reliable write If the card does
 not support CMD23
Date: Wed, 26 Aug 2015 15:20:11 +0800
Message-ID: <55DD68AB.30006@rock-chips.com>
References: <1439537446-7713-1-git-send-email-sdliyong@gmail.com>
 <CAPDyKFp51gzyNaGkGWDXs0ATX2hom2yfcLHXT4o=dzw2=AbWNw@mail.gmail.com>
 <BLU168-W65065971596DEBF42F841D6600@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.130]:60315 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751951AbbHZHUT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 26 Aug 2015 03:20:19 -0400
In-Reply-To: <BLU168-W65065971596DEBF42F841D6600@phx.gbl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: LIYONG <sdliyong@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: shawn.lin@rock-chips.com, Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 2015/8/26 14:15, LIYONG wrote:
> Hi Uffe,
>
> The bool variable do_rel_wr is used on line 1408 and line 1436:
> if (brq->data.blocks> 1 || do_rel_wr) {
> 		/* SPI multiblock writes terminate using a special
> 		 * token, not a STOP_TRANSMISSION request.
> 		 */
>
> 	if (do_rel_wr)
> 		mmc_apply_rel_rw(brq, card, req);
>
> If a card does not support CMD23, I think we need to set the do_rel_wr to false at the beginning of this mmc_blk_rw_rq_prep function

Hi Yong,

You miss the point, Ulf means you should remove
"(do_rel_wr || !(card->quirks & MMC_QUIRK_BLK_NO_CMD23)" as well.

No need to check card->quirks & MMC_QUIRK_BLK_NO_CMD23 twice, you have 
did it while checking do_rel_wr, right?

bool do_rel_wr = ((req->cmd_flags & REQ_FUA) ||
(req->cmd_flags & REQ_META)) &&
(rq_data_dir(req) == WRITE) &&
- (md->flags & MMC_BLK_REL_WR);
+ (md->flags & MMC_BLK_REL_WR) &&
+ !(card->quirks & MMC_QUIRK_BLK_NO_CMD23);

>
> Thanks,
> Yong Li
> ----------------------------------------
>> Date: Tue, 25 Aug 2015 14:06:43 +0200
>> Subject: Re: [PATCH] mmc: block: disable the reliable write If the card does not support CMD23
>> From: ulf.hansson@linaro.org
>> To: sdliyong@gmail.com
>> CC: chris@printf.net; linux-mmc@vger.kernel.org; linux-kernel@vger.kernel.org
>>
>> On 14 August 2015 at 09:30, <sdliyong@gmail.com> wrote:
>>> From: Yong Li <sdliyong@gmail.com>
>>>
>>> Signed-off-by: Yong Li <sdliyong@gmail.com>
>>> ---
>>> drivers/mmc/card/block.c | 3 ++-
>>> 1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>>> index 452782b..d9e3c45 100644
>>> --- a/drivers/mmc/card/block.c
>>> +++ b/drivers/mmc/card/block.c
>>> @@ -1366,7 +1366,8 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
>>> bool do_rel_wr = ((req->cmd_flags & REQ_FUA) ||
>>> (req->cmd_flags & REQ_META)) &&
>>> (rq_data_dir(req) == WRITE) &&
>>> - (md->flags & MMC_BLK_REL_WR);
>>> + (md->flags & MMC_BLK_REL_WR) &&
>>> + !(card->quirks & MMC_QUIRK_BLK_NO_CMD23);
>>
>> Further down in mmc_blk_rw_rq_prep() we check for
>> MMC_QUIRK_BLK_NO_CMD23. That check becomes redundant after this
>> change, please remove that check as a part of this patch as well.
>>
>>>
>>> memset(brq, 0, sizeof(struct mmc_blk_request));
>>> brq->mrq.cmd = &brq->cmd;
>>> --
>>> 2.1.0
>>>
>>
>> Kind regards
>> Uffe
>   		 	   		  --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>


-- 
Best Regards
Shawn Lin

