From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [RFC PATCH] request: teach the device more intelligent
Date: Wed, 10 Aug 2011 17:42:45 +0900
Message-ID: <CAH9JG2VhPg-mk36CO_Jh8D0O6SW3RnZyjnBRNH4UqT8SXXWULQ@mail.gmail.com>
References: <20110809034724.GA22257@july>
	<4E4181E4.3090704@kernel.dk>
	<CAH9JG2X5yb9JEyO60YeLFHcuNp54m-xX8M-xSR7+DEY7FKQL1Q@mail.gmail.com>
	<4E423C83.9090209@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:51677 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751921Ab1HJImp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Aug 2011 04:42:45 -0400
In-Reply-To: <4E423C83.9090209@kernel.dk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, jh80.chung@samsung.com, linux-mmc@vger.kernel.org

On Wed, Aug 10, 2011 at 5:08 PM, Jens Axboe <axboe@kernel.dk> wrote:
> On 2011-08-10 01:43, Kyungmin Park wrote:
>> On Wed, Aug 10, 2011 at 3:52 AM, Jens Axboe <axboe@kernel.dk> wrote:
>>> On 2011-08-09 05:47, Kyungmin Park wrote:
>>>> Hi Jens
>>>>
>>>> Now eMMC device requires the upper layer information to improve th=
e data
>>>> performance and reliability.
>>>>
>>>> . Context ID
>>>> Using the context information, it can sort out the data internally=
 and improve the performance.
>>>> The main problem is that it's needed to define "What's the context=
".
>>>> Actually I expect cfq queue has own unique ID but it doesn't so de=
cide to use the pid instead
>>>>
>>>> . Data Tag
>>>> Using the Data Tag (1-bit information), It writes the data at SLC =
area when it's hot data. So it can make the chip more reliable.
>>>> First I expect the REQ_META but current ext4 doesn't pass the WRIT=
E_META. only use the READ_META. so it needs to investigate it.
>>>>
>>>> With these characteristics, it's helpful to teach the device. Afte=
r some consideration. it's needed to pass out these information at requ=
est data structure.
>>>>
>>>> Can you give your opinions and does it proper fields at requests?
>>>
>>> You need this to work on all IO schedulers, not just cfq.
>> Of course if the concept is acceptable, I'll add the other IO schedu=
lers also.
>>
>>> And since that's the case, there's no need to add this field since =
you can just
>>> retrieve it if the driver asks for it. For CFQ, it could look like =
this:
>>>
>>> static int cfq_foo(struct request *rq)
>>> {
>>> =A0 =A0 =A0 =A0struct cfq_queue *cfqq =3D rq->elevator_private[1];
>>>
>>> =A0 =A0 =A0 =A0if (cfqq)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return cfqq->pid;
>>>
>>> =A0 =A0 =A0 =A0return -1;
>>> }
>>
>> The actual user of these information is device driver. e.g.,
>> drivers/mmc/card/block.c
>> So it's not good to use cfq data structure at D/D. some time later
>> these are also used at scsi device drivers.
>
> No, what I'm suggesting above is the CFQ implementation. You would ne=
ed
> to wire up an elv_ops->get_foo() and have the IO schedulers fill it i=
n.
> If you notice, the above function does not take or output anything
> related to CFQ in particular, it'll just return you the unique key yo=
u
> need.
>
> It's either the above, or a field in the request that the schedulers
> fill out. However, it'd be somewhat annoying to grow struct request f=
or
> something that has a narrow scope of use. Hence the suggestion to add=
 a
> strategy helper for this.
Okay, I'll add new elevator function one for getting context or more hi=
nts.
BTW, does it okay to call elevator function call at D/D?

The quick-n-dirty call is like this at "drivers/mmc/card/block.c"

                struct elevator_queue *e =3D md->queue.queue->elevator;
                int context =3D -1;

                if (e->ops->elevator_get_req_hint_fn && req) {
                        context =3D e->ops->elevator_get_req_hint_fn(re=
q);

>
>>> As to the hot part, I think that would be better as just a request =
flag
>>> like eg the meta flag.
>> Yes it can use the JBD_flags at cfq. but same reason it's not proper
>> reference at device drivers. that's reason to make a filed at reques=
t.
>>
>> Device driver should or must see the request data structure and don'=
t
>> refer the upper layer data structures.
>
> The device driver sees the struct request, which is where this flag e=
nds
> up.
It's ext{3,4} series specific detection method. if user use the
another filesystem, it's difficult to detect hot/cold.
I'll more think about it.

Thank you for suggestion.
Kyungmin Park
>
> --
> Jens Axboe
>
>
