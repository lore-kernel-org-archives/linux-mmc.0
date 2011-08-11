From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [RFC PATCH] request: teach the device more intelligent
Date: Thu, 11 Aug 2011 09:36:04 +0900
Message-ID: <CAH9JG2XTOOS5GGO7howP+SLbTkj0xUJHPisFYPZfkJddWeKQ4Q@mail.gmail.com>
References: <20110809034724.GA22257@july>
	<4E4181E4.3090704@kernel.dk>
	<CAH9JG2X5yb9JEyO60YeLFHcuNp54m-xX8M-xSR7+DEY7FKQL1Q@mail.gmail.com>
	<4E423C83.9090209@kernel.dk>
	<CAH9JG2VhPg-mk36CO_Jh8D0O6SW3RnZyjnBRNH4UqT8SXXWULQ@mail.gmail.com>
	<CANejiEVW69ihzpMYqvTZ5iW+uz3jUA2y60vL7xzyZidhSxj-0g@mail.gmail.com>
	<4E424A0A.6090300@kernel.dk>
	<CANejiEU+gG9wWb+=zqASj1M-CmcDhXi2kft=FpFJ8K6Tb+whrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:38979 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750802Ab1HKAgG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Aug 2011 20:36:06 -0400
In-Reply-To: <CANejiEU+gG9wWb+=zqASj1M-CmcDhXi2kft=FpFJ8K6Tb+whrw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shaohua Li <shli@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, arnd@arndb.de, jh80.chung@samsung.com, linux-mmc@vger.kernel.org

On Thu, Aug 11, 2011 at 9:29 AM, Shaohua Li <shli@kernel.org> wrote:
> 2011/8/10 Jens Axboe <axboe@kernel.dk>:
>> On 2011-08-10 10:47, Shaohua Li wrote:
>>> 2011/8/10 Kyungmin Park <kmpark@infradead.org>:
>>>> On Wed, Aug 10, 2011 at 5:08 PM, Jens Axboe <axboe@kernel.dk> wrot=
e:
>>>>> On 2011-08-10 01:43, Kyungmin Park wrote:
>>>>>> On Wed, Aug 10, 2011 at 3:52 AM, Jens Axboe <axboe@kernel.dk> wr=
ote:
>>>>>>> On 2011-08-09 05:47, Kyungmin Park wrote:
>>>>>>>> Hi Jens
>>>>>>>>
>>>>>>>> Now eMMC device requires the upper layer information to improv=
e the data
>>>>>>>> performance and reliability.
>>>>>>>>
>>>>>>>> . Context ID
>>>>>>>> Using the context information, it can sort out the data intern=
ally and improve the performance.
>>>>>>>> The main problem is that it's needed to define "What's the con=
text".
>>>>>>>> Actually I expect cfq queue has own unique ID but it doesn't s=
o decide to use the pid instead
>>>>>>>>
>>>>>>>> . Data Tag
>>>>>>>> Using the Data Tag (1-bit information), It writes the data at =
SLC area when it's hot data. So it can make the chip more reliable.
>>>>>>>> First I expect the REQ_META but current ext4 doesn't pass the =
WRITE_META. only use the READ_META. so it needs to investigate it.
>>>>>>>>
>>>>>>>> With these characteristics, it's helpful to teach the device. =
After some consideration. it's needed to pass out these information at =
request data structure.
>>>>>>>>
>>>>>>>> Can you give your opinions and does it proper fields at reques=
ts?
>>>>>>>
>>>>>>> You need this to work on all IO schedulers, not just cfq.
>>>>>> Of course if the concept is acceptable, I'll add the other IO sc=
hedulers also.
>>>>>>
>>>>>>> And since that's the case, there's no need to add this field si=
nce you can just
>>>>>>> retrieve it if the driver asks for it. For CFQ, it could look l=
ike this:
>>>>>>>
>>>>>>> static int cfq_foo(struct request *rq)
>>>>>>> {
>>>>>>> =A0 =A0 =A0 =A0struct cfq_queue *cfqq =3D rq->elevator_private[=
1];
>>>>>>>
>>>>>>> =A0 =A0 =A0 =A0if (cfqq)
>>>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return cfqq->pid;
>>>>>>>
>>>>>>> =A0 =A0 =A0 =A0return -1;
>>>>>>> }
>>>>>>
>>>>>> The actual user of these information is device driver. e.g.,
>>>>>> drivers/mmc/card/block.c
>>>>>> So it's not good to use cfq data structure at D/D. some time lat=
er
>>>>>> these are also used at scsi device drivers.
>>>>>
>>>>> No, what I'm suggesting above is the CFQ implementation. You woul=
d need
>>>>> to wire up an elv_ops->get_foo() and have the IO schedulers fill =
it in.
>>>>> If you notice, the above function does not take or output anythin=
g
>>>>> related to CFQ in particular, it'll just return you the unique ke=
y you
>>>>> need.
>>>>>
>>>>> It's either the above, or a field in the request that the schedul=
ers
>>>>> fill out. However, it'd be somewhat annoying to grow struct reque=
st for
>>>>> something that has a narrow scope of use. Hence the suggestion to=
 add a
>>>>> strategy helper for this.
>>>> Okay, I'll add new elevator function one for getting context or mo=
re hints.
>>>> BTW, does it okay to call elevator function call at D/D?
>>>>
>>>> The quick-n-dirty call is like this at "drivers/mmc/card/block.c"
>>>>
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct elevator_queue *e =3D md->qu=
eue.queue->elevator;
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int context =3D -1;
>>>>
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (e->ops->elevator_get_req_hint_f=
n && req) {
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0context =3D e->ops-=
>elevator_get_req_hint_fn(req);
>>> I'm wondering how the driver deal with elevator switch. A context i=
d from
>>> one elevator might just be garbage for another elevator.
>>
>> Any request with sched private data is drained prior to switching ov=
er.
>> This problem isn't unique to this context id, we have other per-requ=
est
>> IO scheduler data structures associated with the request, too.
> what I'm afraid is the context id isn't consistent. Say in cfq, conte=
xt id
> for app1 is 1, app2 2. Then switching to deadline, context id for app=
1
> is 2, app2 1. Will the driver be confused about this?

No, no need to consistent. the context id id only valid when several
requests are request the I/O simultaneously
e.g.,
App1 requests A, B, C, D, ...
App2 requests a, b, c, d, ...
App2 requests 1, 2, 3, 4, 5, ...
with following order, A, B, a, 1, C, b, 2, ...

The current eMMC can't handle these operation.

Instead using context, it can teach the these operation comes from
using context ID. and finally can place the request in-order at card
internally.

Open Context ID operation, perform I/O with context Id, ...., and
Close Context ID operation until queue is empty.

Thank you,
Kyungmin Park


>
> Thanks,
> Shaohua
>
