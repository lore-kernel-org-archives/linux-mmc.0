From: "Konstantin Dorfman" <kdorfman@codeaurora.org>
Subject: Re: [PATCH v1] mmc: fix async request mechanism for sequential
     read scenarios
Date: Tue, 20 Nov 2012 20:57:53 +0200 (IST)
Message-ID: <217a4161d51eae6375fa518c1d19e41e.squirrel@www.codeaurora.org>
References: <f67543901d54b344c8bb401e363e6b80.squirrel@www.codeaurora.org>
    <5088206C.7080101@stericsson.com> <50893E88.9000908@codeaurora.org>
    <5089549D.3060507@stericsson.com>
    <CAOyx1Lq9D2RN5KmvgxU+Z4W3aNHuyA2D5cdFJhz0sf+WU2ZZ=Q@mail.gmail.com>
    <508D2F2E.3020006@codeaurora.org>
    <CAFEEs1m6VwDO8N1Tc8J4Q+aXysgxd77+oZr=M7QK7rgycQuEFw@mail.gmail.com>
    <508FC5E4.8010906@codeaurora.org>
    <CAFEEs1=+xD+jkydx7O-MLcvbyNkZ7BQbi=Q10c_Ln0XyXdRPmQ@mail.gmail.com>
    <50A3B598.4030702@codeaurora.org> <50A51A9E.9020004@stericsson.com>
    <50AA005B.8050903@codeaurora.org> <50AA4312.5000703@stericsson.com>
    <50AAA5F2.6000200@stericsson.com> <50ABAF25.7010708@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:24640 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752564Ab2KTS5y (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Nov 2012 13:57:54 -0500
In-Reply-To: <50ABAF25.7010708@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Konstantin Dorfman <kdorfman@codeaurora.org>
Cc: Per =?iso-8859-1?Q?F=F6rlin?= <per.forlin@stericsson.com>, Per Forlin <per.lkml@gmail.com>, Venkatraman S <svenkatr@gmail.com>, "cjb@laptop.org" <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Correction inside
On Tue, November 20, 2012 6:26 pm, Konstantin Dorfman wrote:
> Hello,
>
> On 11/19/2012 11:34 PM, Per F=F6rlin wrote:
>
>>>>>>>        if (host->areq) {
>>>>>>> +             if (!areq)
>>>>>>> +                     mmc_prefetch_init(host->areq,
>>>>>>> +
>>>>>>> &host->areq->mrq->completion);
>>>>>>>                mmc_wait_for_req_done(host, host->areq->mrq);
>>>>>>> +             if (!areq) {
>>>>>>> +                     mmc_prefetch_start(host->areq, false);
>>>>>>> +                     if (mmc_prefetch_pending(host->areq))
>>>>>>> +                             return NULL;
>>>> In this case, mmc thread may be unblocked because done() arrived f=
or
>>>> current request and not because new request notification. In such =
a
>>>> case
>>>> we would like the done request to be handled before fetching the n=
ew
>>>> request.
>>> I agree. We wake up and there is no pending new request execution
>>> should proceed normally by handling the completed request.
>>>
>>>> In my code is_done_rcv flag used along with is_new_req flag in
>>>> order to differentiate the reason for mmc thread awake.
>>> In my patch the return value of "mmc_prefetch_pending()" specifies =
if
>>> thee is a pending request.what should happen.
>>> If both current request is done and mmc_prefetch_pending is done at=
 the
>>> same time I see there is a problem with my patch. There needs to be=
 a
>>> flag to indicate if current request is done.
> There is race between done() and NEW_REQUEST events, also when we got
> both of them, the order is to complete current and then to fetch new.
>
>
>>>>>> I understand your motivation and idea for re-structure the patch=
=2E It
>>>>>> is
>>>>>> still not clear for me how exactly mmc thread will be awaken on =
new
>>>>>> request notification in your version, but I have another problem=
:
>>>>>>
>>>>> mmc_request_fn() is called and it calls
>>>>> complete(mq->prefetch_completion) which wakes up the current thre=
ad.
>>>>> My patch is just an example. The intention is to make the patch
>>>>> cleaner. But I may have missed some of the HPI aspects.
>>>>
>>>> Is it the lack of functions wrappers that you are using in your
>>>> example?
>>> It's fine to skip the functions wrappers if it makes no sense.
>>> What I want to avoid is to create new functions for data_req_start =
and
>>> data_req_wait.
>>> I would rather add this to the existing functions in core.c and kee=
p
>>> changes in block.c and the flow minimal.
>>>
>>>> As I understand your example, you mean to implement generic logic =
on
>>>> core/core.c level by using wrapper functions and leave final
>>>> implementation for MMC to card/queue.c and for SDIO layer to
>>>> card/..sdio.. (I'm not too familiar with sdio protocol
>>>> implementation).
>>>> Well, it is make a lot of sense.
>>>>
>>> I still have "plans" to add pre/post/async support in the SDIO
>>> framework too but I have not got to it.
>>> I would be nice to add your NEW_REQ feature along with the other
>>> mmc-async features, to make it usable from SDIO.
>>>
>>>
>>>> But the devil is in details - there is a lot of work in
>>>> mmc_wait_for_data_req_done(), done() callback and also error handl=
ing
>>>> changes for card/block.c
>>> Things in core.c could be re-used in the SDIO case. In block.c ther=
e
>>> are only FS specific implementation not relevant for SDIO.
>>>
>>>>
>>>> Do you think, that wait_event() API used not suits the same semant=
ic
>>>> as
>>>> completion API?
>>> The waiting mechanims may be wait_event or completion.
>>> I'm not in favor of using both. Better to replace completion with
>>> wait_event if you prefer.
>>>
>> I'm fine with wait_event() (block request transfers) combined with
>> completion (for other transfer), as long as the core.c API is intact=
=2E I
>> don't see a reason for a new start_data_req()
>>
>> mmc_start_req() is only used by the mmc block transfers.
> The main idea is to change start_req() waiting point
> (mmc_wait_for_data_req_done() function) in such way that external eve=
nts
> (in the MMC case it is coming from block layer) may awake MMC context
> from waiting for current request. This is done by change the original
> mmc_start_req() function and not changing its signature of
> mmc_start_req().
>
> May I ask you to see [PATCH v2] patch? I think that is is no change i=
n
> core.c API (by core.c API you mean all functions from core.h?).
>
[PATCH v3] mmc: fix async request mechanism for sequential read scenari=
os

> Also to use new request feature of core.c one need to implement
> notification similar to mmc_request_fn() and I do not see difficultie=
s
> to do it from SDIO.
>
>
>> Making a test case in mmc_test.c is a good way to stress test the
>> feature (e.g. random timing of incoming new requests) and it will sh=
ow
>> how the API works too.
>>
>> BR
>> Per
>>
>>> My main concern is to avoid adding new API to core.c in order to ad=
d
>>> the NEW_REQ feature. My patch is an example of changes to be done i=
n
>>> core.c without adding new functions.
>>>
>>>>
>>>> We would like to have a generic capability to handle additional
>>>> events,
>>>> such as HPI/stop flow, in addition to the NEW_REQUEST notification=
=2E
>>>> Therefore, an event mechanism seems to be a better design than
>>>> completion.
>>>>
>>>> I've looked at SDIO code and from what I can understand, right now
>>>> SDIO
>>>> is not using async request mechanism and works from 'wait_for_cmd(=
)`
>>>> level. This means that such work as exposing MMC core API's is maj=
or
>>>> change and definitely should be separate design and implementation
>>>> effort, while my current patch right now will fix mmc thread behav=
ior
>>>> and give better performance for upper layers.
>>> You are right. There is no support in the SDIO implementation for
>>> pre/post/async feature. Still I had it in mind design the "struct
>>> mmc_async". It's possible to re-use the mmc core parts in order to
>>> utilize this support in the SDIO case. I'm not saying we should des=
ign
>>> for SDIO but at least keep the API in a way that it's potential usa=
ble
>>> from SDIO too. The API of core.c (start/wait of requests) should ma=
ke
>>> sense without the existence of MMC block driver (block/queue).
>>>
>>> One way to test the design is to add a test in mmc_test.c for pengi=
ng
>>> NEW_REQ. In mmc_test.c there is not block.c or queue.c.
>>> If the test case if simple to write in mmc_test.c it's means that t=
he
>>> API is on a good level.
> I have plans to implement new test in mmc_test.c, but current patch w=
as
> tested using special test I/O scheduler, that is used instead of cfq =
I/O
> scheduler: "[PATCH v5 1/3] block: Add test-iosched scheduler"
>
> This gives us great power to create any ut scenarios.
>
> --
> Konstantin Dorfman,
> QUALCOMM ISRAEL, on behalf of Qualcomm Innovation Center,
> Inc. is a member of Code Aurora Forum,
> hosted by The Linux Foundation
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


--=20
Konstantin Dorfman,
QUALCOMM ISRAEL, on behalf of Qualcomm Innovation Center, Inc. is a mem=
ber
of Code Aurora Forum, hosted by The Linux Foundation

