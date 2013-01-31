From: Subhash Jadavani <subhashj@codeaurora.org>
Subject: Re: [PATCH 1/2] mmc: core: fix permanent sleep of mmcqd during card
 removal
Date: Thu, 31 Jan 2013 12:23:35 +0530
Message-ID: <510A14EF.5010103@codeaurora.org>
References: <n@samsung.com> <1356513966-24945-1-git-send-email-kdorfman@codeaurora.org> <001201cdfeb3$3e628ee0$bb27aca0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:59890 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751045Ab3AaGxi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 31 Jan 2013 01:53:38 -0500
In-Reply-To: <001201cdfeb3$3e628ee0$bb27aca0$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: 'Konstantin Dorfman' <kdorfman@codeaurora.org>, 'Chris Ball' <cjb@laptop.org>, linux-mmc@vger.kernel.org

Looks good to me.
Reviewed-by: Subhash Jadavani <subhashj@codeaurora.org>


On 1/30/2013 12:00 PM, Seungwon Jeon wrote:
> Hi Konstantin.
>
> Could you check this patch with [2/2]?
> [PATCH 2/2] mmc: block: don't start new request when the card is removed
>
> mmcqd is often sleeping with acquiring the claim(mmc_claim_host) when a card is removed.
> As a result, mmc_rescan can be blocked for the insertion of a card newly. It's a dead lock.
>
> Thanks,
> Seungwon Jeon
>
> On Tuesday, January 22, 2013, Seungwon Jeon wrote:
>> This patch is derived from 'mmc: fix async request mechanism ...'.
>> According as async transfer, a request is handled with twice mmc_start_req.
>> When the card is removed, the request is actually not issued in the first
>> mmc_start_req [__mmc_start_data_req]. And then mmc_wait_for_data_req_done
>> will come in the next mmc_start_req. But there is no event for completions.
>> wake_up_interruptible is needed in __mmc_start_data_req for the case of
>> removed card.
>>
>> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
>> ---
>>  drivers/mmc/core/core.c |    1 +
>>  1 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> index 8b3a122..997b257 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -350,6 +350,7 @@ static int __mmc_start_data_req(struct mmc_host *host, struct mmc_request *mrq)
>>  	mrq->host = host;
>>  	if (mmc_card_removed(host->card)) {
>>  		mrq->cmd->error = -ENOMEDIUM;
>> +		mmc_wait_data_done(mrq);
>>  		return -ENOMEDIUM;
>>  	}
>>  	mmc_start_request(host, mrq);
>> --
>> 1.7.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

