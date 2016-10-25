From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 4/4] mmc: core: Don't use ->card_busy() and CMD13 in
 combination when polling
Date: Tue, 25 Oct 2016 13:58:35 +0300
Message-ID: <1f507a74-430a-fe57-601d-660d2a609567@intel.com>
References: <1476951579-26125-1-git-send-email-ulf.hansson@linaro.org>
 <1476951579-26125-5-git-send-email-ulf.hansson@linaro.org>
 <e9e44d6e-f2a6-13f0-4938-3fa1757b40e8@intel.com>
 <CAPDyKFoMzDvjOvZmuNp7eKz3rx1-sSzhXO2oLAcVj9MHBfZdkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:45471 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965640AbcJYLD2 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 25 Oct 2016 07:03:28 -0400
In-Reply-To: <CAPDyKFoMzDvjOvZmuNp7eKz3rx1-sSzhXO2oLAcVj9MHBfZdkQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Linus Walleij <linus.walleij@linaro.org>, Chaotian Jing <chaotian.jing@mediatek.com>

On 25/10/16 11:45, Ulf Hansson wrote:
> On 21 October 2016 at 11:19, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> On 20/10/16 11:19, Ulf Hansson wrote:
>>> When polling for busy after sending a MMC_SWITCH command, both the optional
>>> ->card_busy() callback and CMD13 are being used in conjunction.
>>>
>>> This doesn't make sense. Instead it's more reasonable to rely solely on the
>>> ->card_busy() callback when it exists. Let's change that and instead use
>>> the CMD13 as a fall-back. In this way we avoid sending CMD13, unless it's
>>> really needed.
>>>
>>> Within this context, let's also take the opportunity to make some
>>> additional clean-ups and clarifications to the related code.
>>>
>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>> ---
>>>  drivers/mmc/core/mmc_ops.c | 30 ++++++++++++++----------------
>>>  1 file changed, 14 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
>>> index a84a880..481bbdb 100644
>>> --- a/drivers/mmc/core/mmc_ops.c
>>> +++ b/drivers/mmc/core/mmc_ops.c
>>> @@ -495,34 +495,32 @@ static int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
>>>       timeout = jiffies + msecs_to_jiffies(timeout_ms) + 1;
>>>       do {
>>>               /*
>>> -              * Due to the possibility of being preempted after
>>> -              * sending the status command, check the expiration
>>> -              * time first.
>>> +              * Due to the possibility of being preempted while polling,
>>> +              * check the expiration time first.
>>>                */
>>>               expired = time_after(jiffies, timeout);
>>> -             if (send_status) {
>>> +
>>> +             if (host->ops->card_busy) {
>>> +                     busy = host->ops->card_busy(host);
>>
>> I didn't really have time to look at these patches, sorry :-(.  But this
>> loop looks like it could use a cond_resched()
> 
> Yes, something like that is definitely needed! Although, I suggest we
> do that improvement on top of this change, if you are fine with that
> approach?

Sure

> 
> The reason is that I am also pondering over, whether it could make
> sense to poll with a dynamically increased interval. At least when
> using ->card_busy().
> Let's say by starting at 1 us interval, then at each poll attempt we
> double the interval time. We would then rather use a combination of
> udelay(), usleep_range() and msleep() to accomplish what you propose.
> Does that make sense to you?

That potentially doubles the operation time.  It might be nicer to limit the
worst case e.g. sleep 1/8th of the total time spent looping

s64 sleep_us;
ktime_t start_time = ktime_get();
do {
	...
	sleep_us = ktime_us_delta(ktime_get(), start_time) >> 3;
	sleep_us = sleep_us ? : 1;
	...
} while(busy);


