From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v2] mmc: block: prevent propagating R1_OUT_OF_RANGE for
 open-ending mode
Date: Tue, 15 Aug 2017 09:43:49 +0800
Message-ID: <f4f100a0-9edd-db13-1c21-9f986345c733@rock-chips.com>
References: <1502152045-150457-1-git-send-email-shawn.lin@rock-chips.com>
 <20170814175831.bgwr6hwc4tvbkmoc@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.134]:48949 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753521AbdHOBoH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Aug 2017 21:44:07 -0400
In-Reply-To: <20170814175831.bgwr6hwc4tvbkmoc@ninjato>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: shawn.lin@rock-chips.com, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Hi,

On 2017/8/15 1:58, Wolfram Sang wrote:
> Hi,
> 
> really sorry for the delay! But now, here are my thoughts:
> 
>> +	/*
>> +	 * Per the SD specification(physical layer version 4.10),
>> +	 * section 4.3.3, it explicitly states that "When the last
>> +	 * block of user area is read using CMD18, the host should
>> +	 * ignore OUT_OF_RANGE error that may occur even the sequence
> 
> missing "if"? ..."even if the sequence"... Yeah, it is missing in the
> specs, too, but still.
> 

Aha, yes.

>> +	 * is correct". And JESD84-B51 for eMMC also has a similar
>> +	 * statement on section 6.8.3. As CMD23 is optional for either
>> +	 * cards or hosts, so we need to check the MMC_BLK_CMD23 flag
>> +	 * to prevent the OUT_OF_RANGE error for open-ending multiple
>> +	 * block operations as it's normal behaviour.
>> +	 */
> 
> I really like adding this comment. Yet, I don't really get why you check
> for CMD23, though, since the SD specs say CMD18? As I understand it,
> this is true for all multiblock accesses, so we could also do something
> like this (only build tested)?

Nope, that is true only for open-ending mode.

Per the SD specification(physical layer version 4.10), section 4.15 Set
Block Count Command, it says"If illegal block count is set, out of range
error will be indicated during read/write operation (For example, data
transfer is stopped at user area boundary)." In another word, you could
expect a out of range error in the response for the following CMD18/25
if your argument of CMD23 + the argument of CMD18/25 exceed the max
number of blocks. So we have check the R1 of CMD18/25 for sure that
won't that happen.

And even if you ignore that out of range bit from CMD18/25, but you
could still get a -ETIMEDOUT or any error number from the host drivers
due to missing data response(for write)/data(for read), as the cards
will stop the data transfer by itself.

So that implies we only need to care about open-ending mode.

> 
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index f1bbfd389367ff..e83d8291ad4f99 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -1362,6 +1362,14 @@ static inline void mmc_apply_rel_rw(struct mmc_blk_request *brq,
>   	}
>   }
>   
> +#define STOP_ERRORS							\
> +	 (R1_ADDRESS_ERROR |	/* Misaligned address */		\
> +	 R1_BLOCK_LEN_ERROR |	/* Transferred block length incorrect */\
> +	 R1_WP_VIOLATION |	/* Tried to write to protected block */	\
> +	 R1_CARD_ECC_FAILED |	/* Card ECC failed */			\
> +	 R1_CC_ERROR |		/* Card controller error */		\
> +	 R1_ERROR)		/* General/unknown error */
> +
>   #define CMD_ERRORS							\
>   	(R1_OUT_OF_RANGE |	/* Command argument out of range */	\
>   	 R1_ADDRESS_ERROR |	/* Misaligned address */		\
> @@ -1371,9 +1379,9 @@ static inline void mmc_apply_rel_rw(struct mmc_blk_request *brq,
>   	 R1_CC_ERROR |		/* Card controller error */		\
>   	 R1_ERROR)		/* General/unknown error */
>   
> -static bool mmc_blk_has_cmd_err(struct mmc_command *cmd)
> +static bool mmc_blk_has_cmd_err(struct mmc_command *cmd, u32 err_mask)
>   {
> -	if (!cmd->error && cmd->resp[0] & CMD_ERRORS)
> +	if (!cmd->error && cmd->resp[0] & err_mask)
>   		cmd->error = -EIO;
>   
>   	return cmd->error;
> @@ -1400,7 +1408,7 @@ static enum mmc_blk_status mmc_blk_err_check(struct mmc_card *card,
>   	 * stop.error indicates a problem with the stop command.  Data
>   	 * may have been transferred, or may still be transferring.
>   	 */
> -	if (brq->sbc.error || brq->cmd.error || mmc_blk_has_cmd_err(&brq->stop) ||
> +	if (brq->sbc.error || brq->cmd.error || mmc_blk_has_cmd_err(&brq->stop, STOP_ERRORS) ||
>   	    brq->data.error) {
>   		switch (mmc_blk_cmd_recovery(card, req, brq, &ecc_err, &gen_err)) {
>   		case ERR_RETRY:
> 
> Note that I decided to not couple STOP_ERRORS and CMD_ERRORS in case we
> need more adjustments in the future. And your comment needs to be added
> somewhere, too. It is just to show what I mean.
> 

I don't have a hard opinion here if you insist on that. :)
I could fold in the description from the spec see explain why
we don't need to check this for the CMD23 cases.

Does all the above sound goot to you?


> Do you think this could work, too? Or am I missing something?
> 
> Thanks and kind regards,
> 
>     Wolfram
> 

