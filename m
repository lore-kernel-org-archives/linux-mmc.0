From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v2] mmc: block: prevent propagating R1_OUT_OF_RANGE for
 open-ending mode
Date: Tue, 15 Aug 2017 17:30:54 +0800
Message-ID: <574e282f-ae83-9a6b-c5e5-86d374f7a984@rock-chips.com>
References: <1502152045-150457-1-git-send-email-shawn.lin@rock-chips.com>
 <20170814175831.bgwr6hwc4tvbkmoc@ninjato>
 <f4f100a0-9edd-db13-1c21-9f986345c733@rock-chips.com>
 <20170815091618.ydnwlqx5ahwvn33e@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:36529 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752497AbdHOJbI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Aug 2017 05:31:08 -0400
In-Reply-To: <20170815091618.ydnwlqx5ahwvn33e@ninjato>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: shawn.lin@rock-chips.com, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Hi Wolfram,

On 2017/8/15 17:16, Wolfram Sang wrote:
> Hi Shawn,
> 
>> So that implies we only need to care about open-ending mode.
> 
> I see. Thanks for the explanation.
> 
>> I could fold in the description from the spec see explain why
>> we don't need to check this for the CMD23 cases.
> 
> That would be great.
> 
>> Does all the above sound goot to you?
> 
> Basically, yes. If we need to check for CMD23 then, I wonder if why we
> really need to do (md->flags & MMC_BLK_CMD23) or if we can't simply
> check the presence of brq->mrq.sbc? That could then lead to the
> following refactorization which is a lot easier to read IMO (but only
> compile tested, just to give you an idea what I had in mind):
> 

Ok, I get your point and it looks good to me as I also plan to introduce
ACMD23 for SD card and your suggestion also inspire me there to simplify
the patch.

Great, I will respin v3 then. :)

Thanks for sharing your thought!

> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index f1bbfd389367ff..1cf905d0e88e77 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -1371,12 +1371,17 @@ static inline void mmc_apply_rel_rw(struct mmc_blk_request *brq,
>   	 R1_CC_ERROR |		/* Card controller error */		\
>   	 R1_ERROR)		/* General/unknown error */
>   
> -static bool mmc_blk_has_cmd_err(struct mmc_command *cmd)
> +/* Map R1 errors to error codes */
> +static void mmc_blk_eval_resp_error(struct mmc_blk_request *brq)
>   {
> -	if (!cmd->error && cmd->resp[0] & CMD_ERRORS)
> -		cmd->error = -EIO;
> +	u32 val;
>   
> -	return cmd->error;
> +	/* If there is no error yet, check R1 response */
> +	if (!brq->stop.error) {
> +		val = brq->stop.resp[0] & CMD_ERRORS;
> +		if (val && !(val & R1_OUT_OF_RANGE && brq->mrq.sbc))
> +			brq->stop.error = -EIO;
> +	}
>   }
>   
>   static enum mmc_blk_status mmc_blk_err_check(struct mmc_card *card,
> @@ -1400,8 +1405,10 @@ static enum mmc_blk_status mmc_blk_err_check(struct mmc_card *card,
>   	 * stop.error indicates a problem with the stop command.  Data
>   	 * may have been transferred, or may still be transferring.
>   	 */
> -	if (brq->sbc.error || brq->cmd.error || mmc_blk_has_cmd_err(&brq->stop) ||
> -	    brq->data.error) {
> +
> +	mmc_blk_eval_resp_error(brq);
> +
> +	if (brq->sbc.error || brq->cmd.error || brq->stop.error || brq->data.error) {
>   		switch (mmc_blk_cmd_recovery(card, req, brq, &ecc_err, &gen_err)) {
>   		case ERR_RETRY:
>   			return MMC_BLK_RETRY;
> 
> Regards,
> 
>     Wolfram
> 

