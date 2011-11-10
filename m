From: Sujit Reddy Thumma <sthumma@codeaurora.org>
Subject: Re: [PATCH] mmc: core: Kill block requests if card is removed
Date: Thu, 10 Nov 2011 09:43:27 +0530
Message-ID: <4EBB4F67.1080406@codeaurora.org>
References: <1320813119-24383-1-git-send-email-sthumma@codeaurora.org> <4EBA4940.6030808@intel.com> <CAFEEs1nPe3=TFwdf8rbPk6AtWzMdfaKR=-Rv0OVJhnANX=3fUQ@mail.gmail.com> <CAFEEs1nQmKues-93zQe7uxNnNqJPEzvBc-2zGkrvUdgPvoGBKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <CAFEEs1nQmKues-93zQe7uxNnNqJPEzvBc-2zGkrvUdgPvoGBKw@mail.gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Per Forlin <per.lkml@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, cjb@laptop.org
List-Id: linux-mmc@vger.kernel.org

On 11/10/2011 3:35 AM, Per Forlin wrote:
> Hi Adrian,
>
>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>> index 5278ffb..91d7721 100644
>>> --- a/drivers/mmc/core/core.c
>>> +++ b/drivers/mmc/core/core.c
>>> @@ -259,7 +259,7 @@ static void mmc_wait_for_req_done(struct mmc_host *host,
>>>                 wait_for_completion(&mrq->completion);
>>>
>>>                 cmd = mrq->cmd;
>>> -               if (!cmd->error || !cmd->retries)
>>> +               if (!cmd->error || !cmd->retries || mmc_card_gone(host->card))
>> host->card will be NULL
>> static void mmc_remove(struct mmc_host *host)
>> {
>>         BUG_ON(!host);
>>         BUG_ON(!host->card);
>>
>>         mmc_remove_card(host->card);
>>         host->card = NULL;
>> }
>> card is not freed until later.
> Please ignore this part. I jumped to conclusions. I had another look
> and there can't be any incoming requests when host->card is NULL.
> I need to study device_del() further, in order to understand the details.

There can be incoming requests when the host->card is NULL. This happens 
when we are detecting the card for the first time. That is, in 
mmc_rescan() we send all the initialization commands with host->card 
being NULL.

We can do something like this:
#define mmc_card_gone(c) (c && ((c)->state & MMC_STATE_CARD_GONE))


>
> Regards,
> Per


-- 
Thanks & Regards,
Sujit Reddy Thumma

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
