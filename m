From: J Freyensee <james_p_freyensee@linux.intel.com>
Subject: Re: [RFC PATCH] mmc: support background operation
Date: Wed, 17 Aug 2011 09:13:58 -0700
Message-ID: <4E4BE8C6.5040106@linux.intel.com>
References: <4E450B21.8040502@samsung.com> <4E4A9C40.3000708@linux.intel.com> <4E4B3D76.1030506@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:25517 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752923Ab1HQQMq (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 17 Aug 2011 12:12:46 -0400
In-Reply-To: <4E4B3D76.1030506@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Chuanxiao Dong <chuanxiao.dong@intel.com>, Hanumath Prasad <hanumath.prasad@stericsson.com>

On 08/16/2011 09:03 PM, Jaehoon Chung wrote:
> Hi,
>
> J Freyensee wrote:
>> On 08/12/2011 04:14 AM, Jaehoon Chung wrote:
>>> Hi mailing.
>>>
>>> This RFC patch is supported background operation(BKOPS).
>>> And if you want to test this patch, must apply "[PATCH v3] mmc:
>>> support HPI send command"
>>>
>>> This patch is based on Hanumath Prasad's patch "mmc: enable background
>>> operations for emmc4.41 with HPI support"
>>> Hanumath's patch is implemented before applied per forlin's patch "use
>>> nonblock mmc request...".
>>> This patch is based on 3.1.0-rc1 in mmc-next.
>>
>> I'm a little confused by this statement.  Was this patch done before Per
>> Forlin's work, or is this patch the implementation of the infrastructure
>> Per Forlin worked on to do non-blocking requests to the host controller?
>>
>
> This feature(BKOPS) is defined in eMMC4.41 spec.(differ with Per Forlins's non-blocking patch)
> Hanumath Prasad's patch is sent before Per Forlin's patch.
> so need to rebase for applied patch.
>
>>>
>>> Background operations is run when set the URGENT_BKOPS in response.
>>>
>>> if set the URGENT_BKOPS in response, we can notify that card need the
>>> BKOPS.
>>> (URGENT_BKOPS is used in eMMC4.41 spec, but in eMMC4.5 changed to
>>> EXCEPTION_EVENT bit.
>>>    maybe, we need to change this point).
>>>
>>> And all request is done, then run background operation.
>>> if request read/write operation when running BKOPS, issue HPI interrupt
>>>
>>> This patch is just RFC patch (not to merge), because i want to use
>>> BKOPS in userspace.
>>> (using ioctl).
>>>
>>> I want to get mailing's review for this patch.
>>>
>>>
>>> Signed-off-by: Jaehoon Chung<jh80.chung@samsung.com>
>>> Signed-off-by: Kyungmin Park<kyungmin.park@samsung.com>
>>> CC: Hanumath Prasad<hanumath.prasad@stericsson.com>
>>>
>>> ---
>>>    drivers/mmc/card/block.c   |    4 ++++
>>>    drivers/mmc/card/queue.c   |   10 ++++++++++
>>>    drivers/mmc/core/core.c    |   35 +++++++++++++++++++++++++++++++++++
>>>    drivers/mmc/core/mmc.c     |   28 ++++++++++++++++++++++++++++
>>>    drivers/mmc/core/mmc_ops.c |    3 +++
>>>    include/linux/mmc/card.h   |   11 +++++++++++
>>>    include/linux/mmc/core.h   |    1 +
>>>    include/linux/mmc/mmc.h    |    4 ++++
>>>    8 files changed, 96 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>>> index 1ff5486..ff72c4a 100644
>>> --- a/drivers/mmc/card/block.c
>>> +++ b/drivers/mmc/card/block.c
>>> @@ -1078,6 +1078,10 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue
>>> *mq, struct request *rqc)
>>>            switch (status) {
>>>            case MMC_BLK_SUCCESS:
>>>            case MMC_BLK_PARTIAL:
>>> +            if (mmc_card_mmc(card)&&
>>> +                (brq->cmd.resp[0]&   R1_URGENT_BKOPS)) {
>>> +                mmc_card_set_need_bkops(card);
>>> +            }
>>>                /*
>>>                 * A block was successfully transferred.
>>>                 */
>>> diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
>>> index 45fb362..52b1293 100644
>>> --- a/drivers/mmc/card/queue.c
>>> +++ b/drivers/mmc/card/queue.c
>>> @@ -46,6 +46,8 @@ static int mmc_queue_thread(void *d)
>>>    {
>>>        struct mmc_queue *mq = d;
>>>        struct request_queue *q = mq->queue;
>>> +    struct mmc_card *card = mq->card;
>>> +    unsigned long flags;
>>>
>>>        current->flags |= PF_MEMALLOC;
>>>
>>> @@ -61,6 +63,13 @@ static int mmc_queue_thread(void *d)
>>>            spin_unlock_irq(q->queue_lock);
>>>
>>>            if (req || mq->mqrq_prev->req) {
>>> +            if (mmc_card_doing_bkops(card)) {
>>> +                mmc_interrupt_hpi(card);
>>> +                spin_lock_irqsave(&card->host->lock, flags);
>>> +                mmc_card_clr_doing_bkops(card);
>>> +                spin_unlock_irqrestore(&card->host->lock,
>>> +                        flags);
>>> +            }
>>>                set_current_state(TASK_RUNNING);
>>>                mq->issue_fn(mq, req);
>>>            } else {
>>> @@ -68,6 +77,7 @@ static int mmc_queue_thread(void *d)
>>>                    set_current_state(TASK_RUNNING);
>>>                    break;
>>>                }
>>> +            mmc_start_bkops(mq->card);
>>>                up(&mq->thread_sem);
>>>                schedule();
>>>                down(&mq->thread_sem);
>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>> index 7c1ab06..b6de0e5 100644
>>> --- a/drivers/mmc/core/core.c
>>> +++ b/drivers/mmc/core/core.c
>>> @@ -347,6 +347,41 @@ int mmc_wait_for_cmd(struct mmc_host *host,
>>> struct mmc_command *cmd, int retries
>>>
>>>    EXPORT_SYMBOL(mmc_wait_for_cmd);
>>>
>>> +/* Start background operation */
>>> +void mmc_start_bkops(struct mmc_card *card)
>>
>> Is it possible to follow the kernel documentation standard for comment
>> function headers (I believe Randy Dunlap has given links to this in the
>> past)? You can see in this patch that after this function the next
>> function is using a function comment header per kernel guidelines.
>
> You're right.
> But this patch is the RFC patch (i mentioned this patch is not to merge).
> So i didn't add the comment for this function.
> If this patch should be merge, i will add the comment for function.
> (at next time, if i send the other RFC patch, i will also add the comment)
>
>>
>>> +{
>>> +    int err;
>>> +    unsigned long flags;
>>> +
>>> +    BUG_ON(!card);
>>> +
>>> +    if (!card->ext_csd.bkops_en) {
>>> +        printk(KERN_INFO "Didn't set BKOPS enable bit!\n");
>>
>> I know that if new drivers are added to the kernel, maintainers will
>> reject the work if it's using printk()'s.  If this code is getting new
>> functions, is it a good idea to start using the more modern, accepted
>> coding functions like pr_info()?
>
> No problem..using pr_info or pr_debug..
>
>>
>>> +        return;
>>> +    }
>>> +
>>> +    if (mmc_card_doing_bkops(card) ||
>>> +            !mmc_card_need_bkops(card)) {
>>
>> This code wouldn't pass the checkpatch.pl tool; I've been burned by the
>> Linux community of having brackets around a single line of code.
>
> I used the checkpatch.pl tool..but i didn't find message about this line.
> If you point out the brackets {}, i will removed that and make a single line.
>
>>
>>> +        return;
>>> +    }
>>> +
>>> +    mmc_claim_host(card->host);
>>> +    err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>>> +        EXT_CSD_BKOPS_START, 1, 0);
>>> +    if (err) {
>>> +        mmc_card_clr_need_bkops(card);
>>> +        goto out;
>>> +    }
>>> +
>>> +    spin_lock_irqsave(&card->host->lock, flags);
>>> +    mmc_card_clr_need_bkops(card);
>>> +    mmc_card_set_doing_bkops(card);
>>> +    spin_unlock_irqrestore(&card->host->lock, flags);
>>> +out:
>>> +    mmc_release_host(card->host);
>>> +}
>>> +EXPORT_SYMBOL(mmc_start_bkops);
>>> +
>>>    /**
>>>     *    mmc_interrupt_hpi - Issue for High priority Interrupt
>>>     *    @card: the MMC card associated with the HPI transfer
>>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>>> index ef10bfd..0372414 100644
>>> --- a/drivers/mmc/core/mmc.c
>>> +++ b/drivers/mmc/core/mmc.c
>>> @@ -421,6 +421,17 @@ static int mmc_read_ext_csd(struct mmc_card
>>> *card, u8 *ext_csd)
>>>                    ext_csd[EXT_CSD_OUT_OF_INTERRUPT_TIME] * 10;
>>>            }
>>>
>>> +        /*
>>> +         * check whether the eMMC card support BKOPS.
>>> +         * if set BKOPS_SUPPORT bit,
>>> +         * BKOPS_STATUS, BKOPS_EN,,BKOPS_START and
>>> +         * URGENT_BKOPS are supported.(default)
>>> +         */
>>> +        if (ext_csd[EXT_CSD_BKOPS_SUPPORT]&   0x1) {
>>
>> That is kind of an ugly if() statement; a bit further down I explain my
>> reasons for making if() statements like this more readable.
>
> I didn't understand this comment...how do you change this statement?
>
>>
>>> +            card->ext_csd.bkops = 1;
>>> +            card->ext_csd.bkops_en = ext_csd[EXT_CSD_BKOPS_EN];
>>> +        }
>>> +
>>>            card->ext_csd.rel_param = ext_csd[EXT_CSD_WR_REL_PARAM];
>>>        }
>>>
>>> @@ -762,6 +773,23 @@ static int mmc_init_card(struct mmc_host *host,
>>> u32 ocr,
>>>        }
>>>
>>>        /*
>>> +     * Enable HPI feature (if supported)
>>> +     */
>>> +    if (card->ext_csd.hpi) {
>>
>> I know some people prefer doing things like
>>
>> A.'if (x)'
>> instead of
>> B.'if (x != NULL)
>>
>> because A. is supposed to be some type of 'expert way' of doing things.
>> However, B. is a whole lot more readable and easier for people to
>> decipher precisely what is going on, especially newer people that may
>> not be as familiar with this part of the Linux kernel as others.  Just
>> looking at this patch, I can't tell if 'card->ext_csd.hpi' is supposed
>> to be a number value or a pointer.  And if you use Linus's tool 'sparse'
>> to check your kernel code before submitting, there is a difference
>> between statements like 'if (x == 0)' and 'if (x == NULL)', even though
>> they could evaluate to the same result in this if() statement.
>>
>> So I suggest adding the equality or inequality sign to this if() as well
>> as any other if() to make the code a bit easier to understand.
>
> Right..i will modify this point..
>
> Thanks for your comments..
> Any other opinion about this feature (BKOPS)..??

Unfortunately, I am still a little new to this area of the Linux kernel 
so I don't quite have the background to give an intelligent answer 
w/respect to eMMC 4.41 and BKOPS.  I just have 3 device driver accepts 
in the TTY space, so my contributions to patches are mainly basic code 
functionality and Linux kernel/device-driver gotchas.

Do you know the tool 'sparse'?  It's a good thing to try once, before 
submitting upstream, if you haven't done it.

>
> Regards,
> Jaehoon Chung
>
>
>


-- 
J (James/Jay) Freyensee
Storage Technology Group
Intel Corporation
