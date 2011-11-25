From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: block: release host in case of error
Date: Fri, 25 Nov 2011 14:03:29 +0200
Message-ID: <4ECF8411.4080409@intel.com>
References: <1321269166-22128-1-git-send-email-per.forlin@stericsson.com> <4EC4D151.1030008@intel.com> <4EC62BC3.30300@stericsson.com> <CAFEEs1kSwOF21Gn5XEL5QMrC2TWBMA+K2xAchtTALfV4STZXPw@mail.gmail.com> <CAFEEs1koxLhwKf2HHaO4qEWe+JzDtJqYf94HK5Z2gCVv3KCM7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:23290 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754734Ab1KYMDc (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 25 Nov 2011 07:03:32 -0500
In-Reply-To: <CAFEEs1koxLhwKf2HHaO4qEWe+JzDtJqYf94HK5Z2gCVv3KCM7g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Per Forlin <per.lkml@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Chris Ball <cjb@laptop.org>, Linus Walleij <linus.walleij@linaro.org>

On 24/11/11 20:58, Per Forlin wrote:
> On Sun, Nov 20, 2011 at 9:50 PM, Per Forlin <per.lkml@gmail.com> wrot=
e:
>> Hi Adrian,
>>
>> On Fri, Nov 18, 2011 at 10:56 AM, Per F=F6rlin <per.forlin@stericsso=
n.com> wrote:
>>> On 11/17/2011 10:18 AM, Adrian Hunter wrote:
>>>> On 14/11/11 13:12, Per Forlin wrote:
>>>>> Host is claimed as long as there are requests in the block queue
>>>>> and all request are completed successfully. If an error occur rel=
ease
>>>>> the host in case someone else needs to claim it, for instance if =
the card
>>>>> is removed during a transfer.
>>>>>
>>>>> Signed-off-by: Per Forlin <per.forlin@stericsson.com>
>>>>> ---
>>>>>  drivers/mmc/card/block.c |   37 +++++++++++++++++++++++++++++---=
-----
>>>>>  1 files changed, 29 insertions(+), 8 deletions(-)
>>>>>
>>>>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>>>>> index c80bb6d..c21fd2c 100644
>>>>> --- a/drivers/mmc/card/block.c
>>>>> +++ b/drivers/mmc/card/block.c
>>>>> @@ -1158,6 +1158,28 @@ static int mmc_blk_cmd_err(struct mmc_blk_=
data *md, struct mmc_card *card,
>>>>>      return ret;
>>>>>  }
>>>>>
>>>>> +/*
>>>>> + * This function should be called to resend a request after fail=
ure.
>>>>> + * Prepares and starts the request.
>>>>> + */
>>>>> +static inline struct mmc_async_req *mmc_blk_resend(struct mmc_ca=
rd *card,
>>>>> +                                               struct mmc_queue =
*mq,
>>>>> +                                               struct mmc_queue_=
req *mqrq,
>>>>> +                                               int disable_multi=
,
>>>>> +                                               struct mmc_async_=
req *areq)
>>>>> +{
>>>>> +    /*
>>>>> +     * Release host after failure in case the host is needed
>>>>> +     * by someone else. For instance, if the card is removed the
>>>>> +     * worker thread needs to claim the host in order to do mmc_=
rescan.
>>>>> +     */
>>>>> +    mmc_release_host(card->host);
>>>>> +    mmc_claim_host(card->host);
>>>>
>>>> Does this work?  Won't the current thread win the race
>>>> to claim the host again?
>>>>
>>> Good question. I've tested it and I haven't seen any cases where cu=
rrent has claimed the host again. Sujit has tested the patch as well.
>>> But I can't say that your scenario can't happen. I will study the w=
ake_up and wait_queue code to see if I can find the answer.
>>>
>>
>> mmc_release_host() -> wake_up() -> schedule(). If the waking process
>> has higher prio than current it will preempt current on NOSMP. If SM=
P,
>> current and waking process may be on separate CPUs and in that case
>> it's difficult to guarantee that the waking process will win the rac=
e.
>> I'm proposing to add yield() in order to give the waking process
>> better chances to win the race.
>> Here's a patch:
>> --------------------------------
>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>> index c21fd2c..add1c38 100644
>> --- a/drivers/mmc/card/block.c
>> +++ b/drivers/mmc/card/block.c
>> @@ -1173,8 +1173,11 @@ static inline struct mmc_async_req
>> *mmc_blk_resend(struct mmc_card *card,
>>         * by someone else. For instance, if the card is removed the
>>         * worker thread needs to claim the host in order to do mmc_r=
escan.
>>         */
>> -       mmc_release_host(card->host);
>> -       mmc_claim_host(card->host);
>> +       if (mmc_card_rescan(card)) {
>> +               mmc_release_host(card->host);
>> +               yield();
>> +               mmc_claim_host(card->host);
>> +       }
>>
>>        mmc_blk_rw_rq_prep(mqrq, card, disable_multi, mq);
>>        return mmc_start_req(card->host, areq, NULL);
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> index 271efea..83f03a3 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -2059,6 +2059,8 @@ void mmc_rescan(struct work_struct *work)
>>        if (host->rescan_disable)
>>                return;
>>
>> +       mmc_card_set_rescan(host->card);
>> +
>>
>>
>>        /*
>> @@ -2101,6 +2103,7 @@
>>
>>
>>  out:
>> +       mmc_card_clr_rescan(host->card);
>>
>>
>>  }
>> -----------------------
> I'm not sure if this patch-extension is really needed, it may only
> make the patch more complex. If the race condition Adrian refers to i=
s
> unlikely, there may be a few extra retries before mmc_rescan get the
> chance to claim the host.
> I'm in favor of skipping my proposed extension and staying with the
> original v1 patch.
> Adrian, what do you say?

As far as I can see, if mmc block is checking / setting whether the
card has been removed, then mmc_blk_resend would not be needed.
