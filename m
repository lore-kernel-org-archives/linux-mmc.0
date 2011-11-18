From: =?ISO-8859-1?Q?Per_F=F6rlin?= <per.forlin@stericsson.com>
Subject: Re: [PATCH] mmc: block: release host in case of error
Date: Fri, 18 Nov 2011 10:56:19 +0100
Message-ID: <4EC62BC3.30300@stericsson.com>
References: <1321269166-22128-1-git-send-email-per.forlin@stericsson.com> <4EC4D151.1030008@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog106.obsmtp.com ([207.126.144.121]:34407 "EHLO
	eu1sys200aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751917Ab1KRJ4g (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Nov 2011 04:56:36 -0500
In-Reply-To: <4EC4D151.1030008@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Chris Ball <cjb@laptop.org>

On 11/17/2011 10:18 AM, Adrian Hunter wrote:
> On 14/11/11 13:12, Per Forlin wrote:
>> Host is claimed as long as there are requests in the block queue
>> and all request are completed successfully. If an error occur release
>> the host in case someone else needs to claim it, for instance if the card
>> is removed during a transfer.
>>
>> Signed-off-by: Per Forlin <per.forlin@stericsson.com>
>> ---
>>  drivers/mmc/card/block.c |   37 +++++++++++++++++++++++++++++--------
>>  1 files changed, 29 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>> index c80bb6d..c21fd2c 100644
>> --- a/drivers/mmc/card/block.c
>> +++ b/drivers/mmc/card/block.c
>> @@ -1158,6 +1158,28 @@ static int mmc_blk_cmd_err(struct mmc_blk_data *md, struct mmc_card *card,
>>  	return ret;
>>  }
>>  
>> +/*
>> + * This function should be called to resend a request after failure.
>> + * Prepares and starts the request.
>> + */
>> +static inline struct mmc_async_req *mmc_blk_resend(struct mmc_card *card,
>> +						   struct mmc_queue *mq,
>> +						   struct mmc_queue_req *mqrq,
>> +						   int disable_multi,
>> +						   struct mmc_async_req *areq)
>> +{
>> +	/*
>> +	 * Release host after failure in case the host is needed
>> +	 * by someone else. For instance, if the card is removed the
>> +	 * worker thread needs to claim the host in order to do mmc_rescan.
>> +	 */
>> +	mmc_release_host(card->host);
>> +	mmc_claim_host(card->host);
> 
> Does this work?  Won't the current thread win the race
> to claim the host again?
> 
Good question. I've tested it and I haven't seen any cases where current has claimed the host again. Sujit has tested the patch as well.
But I can't say that your scenario can't happen. I will study the wake_up and wait_queue code to see if I can find the answer.

Thanks,
Per
