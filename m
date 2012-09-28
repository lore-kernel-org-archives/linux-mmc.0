From: Johan Rudholm <jrudholm@gmail.com>
Subject: Re: mmc: queue: amend buffer swap for non-blocking transfer
Date: Fri, 28 Sep 2012 13:31:45 +0200
Message-ID: <CA+20K0A=v4d=pfWzUmyxxbvHEUExC9J0X3_aDcn6E6cxofXysQ@mail.gmail.com>
References: <00fe01cd9d61$d2f6f180$78e4d480$%jun@samsung.com>
	<CAFEEs1=R6zMykxxybkSaWOx2eVhQE+eEcZUzdkrT9qYyoZENiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:43402 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751404Ab2I1Lbq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Sep 2012 07:31:46 -0400
Received: by ieak13 with SMTP id k13so6992525iea.19
        for <linux-mmc@vger.kernel.org>; Fri, 28 Sep 2012 04:31:46 -0700 (PDT)
In-Reply-To: <CAFEEs1=R6zMykxxybkSaWOx2eVhQE+eEcZUzdkrT9qYyoZENiw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Per Forlin <per.lkml@gmail.com>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

Hi,

Tested-by: Johan Rudholm <johan.rudholm@stericsson.com>

//Johan

2012/9/28 Per Forlin <per.lkml@gmail.com>:
> Hi,
>
> This is really a micro optimization. Still the patch looks correct.
> CUR and PREV will have the same values before and after this patch.
> Before this patch, NULL was assigned to NULL which is not necessary of course.
>
> Reviewed-by: Per Forlin <per.forlin@stericsson.com>
>
> Thanks,
> Per
>
> On Fri, Sep 28, 2012 at 12:12 PM, Seungwon Jeon <tgih.jun@samsung.com> wrote:
>> In case both 'req' and 'mq->mqrq_prev->req' are null, there is no request
>> to be processed. That means there is no need to switch buffer.
>> Switching buffer is required only after finishing 'issue_fn'.
>>
>> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
>> ---
>>  drivers/mmc/card/queue.c |   17 ++++++++++-------
>>  1 files changed, 10 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
>> index e360a97..fadf52e 100644
>> --- a/drivers/mmc/card/queue.c
>> +++ b/drivers/mmc/card/queue.c
>> @@ -68,6 +68,16 @@ static int mmc_queue_thread(void *d)
>>                 if (req || mq->mqrq_prev->req) {
>>                         set_current_state(TASK_RUNNING);
>>                         mq->issue_fn(mq, req);
>> +
>> +                       /*
>> +                        * Current request becomes previous request
>> +                        * and vice versa.
>> +                        */
>> +                       mq->mqrq_prev->brq.mrq.data = NULL;
>> +                       mq->mqrq_prev->req = NULL;
>> +                       tmp = mq->mqrq_prev;
>> +                       mq->mqrq_prev = mq->mqrq_cur;
>> +                       mq->mqrq_cur = tmp;
>>                 } else {
>>                         if (kthread_should_stop()) {
>>                                 set_current_state(TASK_RUNNING);
>> @@ -77,13 +87,6 @@ static int mmc_queue_thread(void *d)
>>                         schedule();
>>                         down(&mq->thread_sem);
>>                 }
>> -
>> -               /* Current request becomes previous request and vice versa. */
>> -               mq->mqrq_prev->brq.mrq.data = NULL;
>> -               mq->mqrq_prev->req = NULL;
>> -               tmp = mq->mqrq_prev;
>> -               mq->mqrq_prev = mq->mqrq_cur;
>> -               mq->mqrq_cur = tmp;
>>         } while (1);
>>         up(&mq->thread_sem);
>>
>> --
>> 1.7.0.4
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
