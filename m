From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: Remove some redundant debug prints
Date: Thu, 07 Apr 2016 10:40:42 +0900
Message-ID: <5705BA9A.6050300@samsung.com>
References: <5cddc2f870eccf8cf50d463c72d2908dad9e1017.1459942344.git.baolin.wang@linaro.org>
 <20160406195732.67430c96@xhacker>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:38766 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752901AbcDGBkq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Apr 2016 21:40:46 -0400
In-reply-to: <20160406195732.67430c96@xhacker>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jisheng Zhang <jszhang@marvell.com>, Baolin Wang <baolin.wang@linaro.org>
Cc: ulf.hansson@linaro.org, adrian.hunter@intel.com, rmk+kernel@arm.linux.org.uk, shawn.lin@rock-chips.com, dianders@chromium.org, david@protonic.nl, broonie@kernel.org, linus.walleij@linaro.org, takahiro.akashi@linaro.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org

On 04/06/2016 08:57 PM, Jisheng Zhang wrote:
> 
> 
> On Wed,  6 Apr 2016 19:38:30 +0800 Baolin Wang wrote:
> 
>> This patch removes some redundant debug prints, since we have added some
>> tracepoints to help with performance analysis of MMC subsystem.
> 
> I think the debug prints you removed are useful for debugging mmc err, how is
> this purpose achieved by tracepoints? From another side, why should I enable
> tracepoints to debug mmc err?

I agreed Jisheng's opinion. tracepoint is helpful for analyzing performance and debugging something.
But I think it's more easier to check the mmc error at booting time or some time.

Best Regards,
Jaehoon Chung

> 
> Thanks
> 
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>> ---
>>  drivers/mmc/core/core.c |   52 -----------------------------------------------
>>  1 file changed, 52 deletions(-)
>>
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> index f80b3ab..3f1362a 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -157,33 +157,6 @@ void mmc_request_done(struct mmc_host *host, struct mmc_request *mrq)
>>  
>>  		led_trigger_event(host->led, LED_OFF);
>>  
>> -		if (mrq->sbc) {
>> -			pr_debug("%s: req done <CMD%u>: %d: %08x %08x %08x %08x\n",
>> -				mmc_hostname(host), mrq->sbc->opcode,
>> -				mrq->sbc->error,
>> -				mrq->sbc->resp[0], mrq->sbc->resp[1],
>> -				mrq->sbc->resp[2], mrq->sbc->resp[3]);
>> -		}
>> -
>> -		pr_debug("%s: req done (CMD%u): %d: %08x %08x %08x %08x\n",
>> -			mmc_hostname(host), cmd->opcode, err,
>> -			cmd->resp[0], cmd->resp[1],
>> -			cmd->resp[2], cmd->resp[3]);
>> -
>> -		if (mrq->data) {
>> -			pr_debug("%s:     %d bytes transferred: %d\n",
>> -				mmc_hostname(host),
>> -				mrq->data->bytes_xfered, mrq->data->error);
>> -		}
>> -
>> -		if (mrq->stop) {
>> -			pr_debug("%s:     (CMD%u): %d: %08x %08x %08x %08x\n",
>> -				mmc_hostname(host), mrq->stop->opcode,
>> -				mrq->stop->error,
>> -				mrq->stop->resp[0], mrq->stop->resp[1],
>> -				mrq->stop->resp[2], mrq->stop->resp[3]);
>> -		}
>> -
>>  		if (mrq->done)
>>  			mrq->done(mrq);
>>  	}
>> @@ -236,31 +209,6 @@ static int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
>>  	if (mmc_card_removed(host->card))
>>  		return -ENOMEDIUM;
>>  
>> -	if (mrq->sbc) {
>> -		pr_debug("<%s: starting CMD%u arg %08x flags %08x>\n",
>> -			 mmc_hostname(host), mrq->sbc->opcode,
>> -			 mrq->sbc->arg, mrq->sbc->flags);
>> -	}
>> -
>> -	pr_debug("%s: starting CMD%u arg %08x flags %08x\n",
>> -		 mmc_hostname(host), mrq->cmd->opcode,
>> -		 mrq->cmd->arg, mrq->cmd->flags);
>> -
>> -	if (mrq->data) {
>> -		pr_debug("%s:     blksz %d blocks %d flags %08x "
>> -			"tsac %d ms nsac %d\n",
>> -			mmc_hostname(host), mrq->data->blksz,
>> -			mrq->data->blocks, mrq->data->flags,
>> -			mrq->data->timeout_ns / 1000000,
>> -			mrq->data->timeout_clks);
>> -	}
>> -
>> -	if (mrq->stop) {
>> -		pr_debug("%s:     CMD%u arg %08x flags %08x\n",
>> -			 mmc_hostname(host), mrq->stop->opcode,
>> -			 mrq->stop->arg, mrq->stop->flags);
>> -	}
>> -
>>  	WARN_ON(!host->claimed);
>>  
>>  	mrq->cmd->error = 0;
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

