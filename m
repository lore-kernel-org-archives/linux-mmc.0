From: Konstantin Dorfman <kdorfman@codeaurora.org>
Subject: Re: [PATCH v1] mmc: fix async request mechanism for sequential read
 scenarios
Date: Mon, 19 Nov 2012 11:48:11 +0200
Message-ID: <50AA005B.8050903@codeaurora.org>
References: <f67543901d54b344c8bb401e363e6b80.squirrel@www.codeaurora.org> <5088206C.7080101@stericsson.com>	<50893E88.9000908@codeaurora.org> <5089549D.3060507@stericsson.com> <CAOyx1Lq9D2RN5KmvgxU+Z4W3aNHuyA2D5cdFJhz0sf+WU2ZZ=Q@mail.gmail.com> <508D2F2E.3020006@codeaurora.org> <CAFEEs1m6VwDO8N1Tc8J4Q+aXysgxd77+oZr=M7QK7rgycQuEFw@mail.gmail.com> <508FC5E4.8010906@codeaurora.org> <CAFEEs1=+xD+jkydx7O-MLcvbyNkZ7BQbi=Q10c_Ln0XyXdRPmQ@mail.gmail.com> <50A3B598.4030702@codeaurora.org> <50A51A9E.9020004@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:25285 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753146Ab2KSJsQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Nov 2012 04:48:16 -0500
In-Reply-To: <50A51A9E.9020004@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?ISO-8859-1?Q?Per_F=F6rlin?= <per.forlin@stericsson.com>
Cc: Per Forlin <per.lkml@gmail.com>, Venkatraman S <svenkatr@gmail.com>, "cjb@laptop.org" <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hello Per,

Thank you for giving me an example, below I'm trying to explain some
logic issues of it and asking you some questions about your vision of
the patch.

On 11/15/2012 06:38 PM, Per F=F6rlin wrote:
> On 11/14/2012 04:15 PM, Konstantin Dorfman wrote:
>> Hello Per,
>>
>> On 11/13/2012 11:10 PM, Per Forlin wrote:
>>> On Tue, Oct 30, 2012 at 1:19 PM, Konstantin Dorfman
>>> <kdorfman@codeaurora.org> wrote:
>>>> Hello,
>>>>
>>>> On 10/29/2012 11:40 PM, Per Forlin wrote:
>>>>> Hi,
>>>>>
>>>>> I would like to move the focus of my concerns from root cause ana=
lysis
>>>>> to the actual patch,
>>>>> My first reflection is that the patch is relatively complex and s=
ome
>>>>> of the code looks duplicated.
>>>>> Would it be possible to simplify it and re-use  the current execu=
tion flow.
>>>>>
>>>>> Is the following flow feasible?
>>>>>
>>>>> in mmc_start_req():
>>>>> --------------
>>>>> if (rqc =3D=3D NULL && not_resend)
>>>>>   wait_for_both_mmc_and_arrival_of_new_req
>>>>> else
>>>>>   wait_only_for_mmc
>>>>>
>>>>> if (arrival_of_new_req) {
>>>>>    set flag to indicate fetch-new_req
>>>>>   return NULL;
>>>>> }
>>>>> -----------------
>>>>>
>>>>> in queue.c:
>>>>> if (fetch-new_req)
>>>>>   don't overwrite previous req.
>>>>>
>>>>> BR
>>>>> Per
>>>>
>>>> You are talking about using both waiting mechanisms, old (wait on
>>>> completion) and new - wait_event_interruptible()? But how done()
>>>> callback, called on host controller irq context, will differentiat=
e
>>>> which one is relevant for the request?
>>>>
>>>> I think it is better to use single wait point for mmc thread.
>>>
>>> I have sketch a patch to better explain my point. It's not tested i=
t
>>> barely compiles :)
>>> The patch tries to introduce your feature and still keep the same c=
ode
>>> path. And it exposes an API that could be used by SDIO as well.
>>> The intention of my sketch patch is only to explain what I tried to
>>> visualize in the pseudo code previously in this thread.
>>> The out come of your final patch should be documented here I think:
>>> Documentation/mmc/mmc-async-req.txt
>> This document is ready, attaching it to this mail and will be includ=
ed
>> in next version of the patch (or RESEND).
>>>
>>> Here follows my patch sketch:
>>> ........................................................
>>> diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
>>> index e360a97..08036a1 100644
>>> --- a/drivers/mmc/card/queue.c
>>> +++ b/drivers/mmc/card/queue.c
>>> @@ -66,6 +66,8 @@ static int mmc_queue_thread(void *d)
>>>               spin_unlock_irq(q->queue_lock);
>>>
>>>               if (req || mq->mqrq_prev->req) {
>>> +                     if (!req)
>>> +                             mmc_prefetch_start(&mq->mqrq_prev->mm=
c_active, true);
>>>                       set_current_state(TASK_RUNNING);
>>>                       mq->issue_fn(mq, req);
>>>               } else {
>>> @@ -79,11 +81,13 @@ static int mmc_queue_thread(void *d)
>>>               }
>>>
>>>               /* Current request becomes previous request and vice =
versa. */
>>> -             mq->mqrq_prev->brq.mrq.data =3D NULL;
>>> -             mq->mqrq_prev->req =3D NULL;
>>> -             tmp =3D mq->mqrq_prev;
>>> -             mq->mqrq_prev =3D mq->mqrq_cur;
>>> -             mq->mqrq_cur =3D tmp;
>>> +             if (!mmc_prefetch_pending(&mq->mqrq_prev->mmc_active)=
) {
>>> +                     mq->mqrq_prev->brq.mrq.data =3D NULL;
>>> +                     mq->mqrq_prev->req =3D NULL;
>>> +                     tmp =3D mq->mqrq_prev;
>>> +                     mq->mqrq_prev =3D mq->mqrq_cur;
>>> +                     mq->mqrq_cur =3D tmp;
>>> +             }
>>>       } while (1);
>>>       up(&mq->thread_sem);
>>>
>>> @@ -109,10 +113,44 @@ static void mmc_request_fn(struct request_que=
ue *q)
>>>               return;
>>>       }
>>>
>>> +     if (mq->prefetch_enable) {
>>> +             spin_lock(&mq->prefetch_lock);
>>> +             if (mq->prefetch_completion)
>>> +                     complete(mq->prefetch_completion);
Since mq->prefetch_completion init happens only in core.c after
mmc_start_req(NULL), we can miss all new request notifications coming
from fetching NULL request until then.
>>> +             mq->prefetch_pending =3D true;
>>> +             spin_unlock(&mq->prefetch_lock);
>>> +     }
>>> +
>>>       if (!mq->mqrq_cur->req && !mq->mqrq_prev->req)
>>>               wake_up_process(mq->thread);
>>>  }
>>>
>>> +static void mmc_req_init(struct mmc_async_req *areq, struct comple=
tion *compl)
>>> +{
>>> +     struct mmc_queue *mq =3D
>>> +             container_of(areq->prefetch, struct mmc_queue, prefet=
ch);
>>> +
>>> +     spin_lock(&mq->prefetch_lock);
>>> +     mq->prefetch_completion =3D compl;
>>> +     if (mq->prefetch_pending)
>>> +             complete(mq->prefetch_completion);
>>> +     spin_unlock(&mq->prefetch_lock);
>>> +}
>>> +
>>> +static void mmc_req_start(struct mmc_async_req *areq, bool enable)
>>> +{
>>> +     struct mmc_queue *mq =3D
>>> +             container_of(areq->prefetch, struct mmc_queue, prefet=
ch);
>>> +     mq->prefetch_enable =3D enable;
>>> +}
>>> +
>>> +static bool mmc_req_pending(struct mmc_async_req *areq)
>>> +{
>>> +     struct mmc_queue *mq =3D
>>> +             container_of(areq->prefetch, struct mmc_queue, prefet=
ch);
>>> +     return mq->prefetch_pending;
>>> +}
>>> +
>>>  static struct scatterlist *mmc_alloc_sg(int sg_len, int *err)
>>>  {
>>>       struct scatterlist *sg;
>>> @@ -166,6 +204,12 @@ int mmc_init_queue(struct mmc_queue *mq, struc=
t
>>> mmc_card *card,
>>>       int ret;
>>>       struct mmc_queue_req *mqrq_cur =3D &mq->mqrq[0];
>>>       struct mmc_queue_req *mqrq_prev =3D &mq->mqrq[1];
>>> +     spin_lock_init(&mq->prefetch_lock);
>>> +     mq->prefetch.wait_req_init =3D mmc_req_init;
>>> +     mq->prefetch.wait_req_start =3D mmc_req_start;
>>> +     mq->prefetch.wait_req_pending =3D mmc_req_pending;
>>> +     mqrq_cur->mmc_active.prefetch =3D &mq->prefetch;
>>> +     mqrq_prev->mmc_active.prefetch =3D &mq->prefetch;
>>>
>>>       if (mmc_dev(host)->dma_mask && *mmc_dev(host)->dma_mask)
>>>               limit =3D *mmc_dev(host)->dma_mask;
>>> diff --git a/drivers/mmc/card/queue.h b/drivers/mmc/card/queue.h
>>> index d2a1eb4..5afd467 100644
>>> --- a/drivers/mmc/card/queue.h
>>> +++ b/drivers/mmc/card/queue.h
>>> @@ -33,6 +33,12 @@ struct mmc_queue {
>>>       struct mmc_queue_req    mqrq[2];
>>>       struct mmc_queue_req    *mqrq_cur;
>>>       struct mmc_queue_req    *mqrq_prev;
>>> +
>>> +     struct mmc_async_prefetch prefetch;
>>> +     spinlock_t              prefetch_lock;
>>> +     struct completion       *prefetch_completion;
>>> +     bool                    prefetch_enable;
>>> +     bool                    prefetch_pending;
>>>  };
>>>
>>>  extern int mmc_init_queue(struct mmc_queue *, struct mmc_card *, s=
pinlock_t *,
>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>> index 9503cab..06fc036 100644
>>> --- a/drivers/mmc/core/core.c
>>> +++ b/drivers/mmc/core/core.c
>>> @@ -352,7 +352,15 @@ struct mmc_async_req *mmc_start_req(struct mmc=
_host *host,
>>>               mmc_pre_req(host, areq->mrq, !host->areq);
>>>
>>>       if (host->areq) {
>>> +             if (!areq)
>>> +                     mmc_prefetch_init(host->areq,
>>> +                                       &host->areq->mrq->completio=
n);
>>>               mmc_wait_for_req_done(host, host->areq->mrq);
>>> +             if (!areq) {
>>> +                     mmc_prefetch_start(host->areq, false);
>>> +                     if (mmc_prefetch_pending(host->areq))
>>> +                             return NULL;
In this case, mmc thread may be unblocked because done() arrived for
current request and not because new request notification. In such a cas=
e
we would like the done request to be handled before fetching the new
request. In my code is_done_rcv flag used along with is_new_req flag in
order to differentiate the reason for mmc thread awake.

>>> +             }
>>>               err =3D host->areq->err_check(host->card, host->areq)=
;
>>>       }
>>>
>>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
>>> index 65c64ee..ce5d03f 100644
>>> --- a/include/linux/mmc/host.h
>>> +++ b/include/linux/mmc/host.h
>>> @@ -15,6 +15,7 @@
>>>  #include <linux/sched.h>
>>>  #include <linux/device.h>
>>>  #include <linux/fault-inject.h>
>>> +#include <linux/completion.h>
>>>
>>>  #include <linux/mmc/core.h>
>>>  #include <linux/mmc/pm.h>
>>> @@ -140,6 +141,13 @@ struct mmc_host_ops {
>>>
>>>  struct mmc_card;
>>>  struct device;
>>> +struct mmc_async_req;
>>> +
>>> +struct mmc_async_prefetch {
>>> +     void (*wait_req_init)(struct mmc_async_req *, struct completi=
on *);
>>> +     void (*wait_req_start)(struct mmc_async_req *, bool);
>>> +     bool (*wait_req_pending)(struct mmc_async_req *);
>>> +};
>>>
>>>  struct mmc_async_req {
>>>       /* active mmc request */
>>> @@ -149,8 +157,33 @@ struct mmc_async_req {
>>>        * Returns 0 if success otherwise non zero.
>>>        */
>>>       int (*err_check) (struct mmc_card *, struct mmc_async_req *);
>>> +     struct mmc_async_prefetch *prefetch;
>>>  };
>>>
>>> +/* set completion variable, complete =3D=3D NULL to reset completi=
on */
>>> +static inline void mmc_prefetch_init(struct mmc_async_req *areq,
>>> +                                  struct completion *complete)
>>> +{
>>> +     if (areq->prefetch && areq->prefetch->wait_req_init)
>>> +             areq->prefetch->wait_req_init(areq, complete);
>>> +}
>>> +
>>> +/* enable or disable prefetch feature */
>>> +static inline void mmc_prefetch_start(struct mmc_async_req *areq, =
bool enable)
>>> +{
>>> +     if (areq->prefetch && areq->prefetch->wait_req_start)
>>> +             areq->prefetch->wait_req_start(areq, enable);
>>> +}
>>> +
>>> +/* return true if new request is pending otherwise false */
>>> +static inline bool mmc_prefetch_pending(struct mmc_async_req *areq=
)
>>> +{
>>> +     if (areq->prefetch && areq->prefetch->wait_req_pending)
>>> +             return areq->prefetch->wait_req_pending(areq);
>>> +     else
>>> +             return false;
>>> +}
>>> +
>>>  /**
>>>   * struct mmc_slot - MMC slot functions
>>>   *
>>> ...................................................................=
=2E
>>>
>>>
>>> BR
>>> Per
>> I understand your motivation and idea for re-structure the patch. It=
 is
>> still not clear for me how exactly mmc thread will be awaken on new
>> request notification in your version, but I have another problem:
>>
> mmc_request_fn() is called and it calls complete(mq->prefetch_complet=
ion) which wakes up the current thread.
> My patch is just an example. The intention is to make the patch clean=
er. But I may have missed some of the HPI aspects.

Is it the lack of functions wrappers that you are using in your example=
?
As I understand your example, you mean to implement generic logic on
core/core.c level by using wrapper functions and leave final
implementation for MMC to card/queue.c and for SDIO layer to
card/..sdio.. (I'm not too familiar with sdio protocol implementation).
Well, it is make a lot of sense.

But the devil is in details - there is a lot of work in
mmc_wait_for_data_req_done(), done() callback and also error handling
changes for card/block.c

Do you think, that wait_event() API used not suits the same semantic as
completion API?

We would like to have a generic capability to handle additional events,
such as HPI/stop flow, in addition to the NEW_REQUEST notification.
Therefore, an event mechanism seems to be a better design than completi=
on.

I've looked at SDIO code and from what I can understand, right now SDIO
is not using async request mechanism and works from 'wait_for_cmd()`
level. This means that such work as exposing MMC core API's is major
change and definitely should be separate design and implementation
effort, while my current patch right now will fix mmc thread behavior
and give better performance for upper layers.


>=20
> If the API is not implemented the mmc core shall simply ignore it.
>=20
>> We want to expand this event based mechanism (unblock mmc thread fro=
m
>> waiting for the running request) by adding another reason/event. Thi=
s is
>> URGENT_REQUEST event. When block layer has Urgent request to execute=
, it
>> notifies mmc layer (similar to mmc_request() notification) and mmc l=
ayer
>> handles this urgent request notification by correctly stopping runni=
ng
>> request, re-inserting back to I/O scheduler all not yet performed pa=
rts
>> and fetching & starting the urgent request.
>> The reasoning and general idea are documented together with "New eve=
nt"
>> and will be submitted soon. The patch itself will be submitted in a =
week
>> or so.
> I have not consider use of HPI in my proposal. If the NEW_REQ is firs=
t in line in the mmc queue it will be fetched as the NEW_REQ.
> Then the current request must be interrupted and returned to mmc-queu=
e or io-scheduler.
>=20
> I don't see a direct contradiction between the two designs.
>=20
> The main point is to make the NEW_REQ API more simple clear.
> My example is just an example.
>=20
>>
>> As for our discussion - to handle both events mmc layer should be
>> capable to be awaken not only in case of no mmc_prefetch_pending() (=
in
>> your patch terms), but also when we have perfect case of async reque=
sts:
>> one running on the bus and second prepared and waiting for the first=
=2E
>>
>> I think, that in case SDIO protocol driver need such functionality a=
s
>> NEW_REQUEST, one need to implement notification to the mmc layer sim=
ilar
>> to mmc_request() code in my patch.
> SDIO needs to implement the new NEW_REQ API, but the API needs to be =
clean.
>=20
> BR
> Per
>=20
Best regards,
--=20
Konstantin Dorfman,
QUALCOMM ISRAEL, on behalf of Qualcomm Innovation Center,
Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
