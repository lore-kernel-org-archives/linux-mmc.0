From: Venkatraman S <svenkatr@gmail.com>
Subject: Re: [PATCH v1] mmc: fix async request mechanism for sequential read scenarios
Date: Fri, 26 Oct 2012 17:37:20 +0530
Message-ID: <CAOyx1Lq9D2RN5KmvgxU+Z4W3aNHuyA2D5cdFJhz0sf+WU2ZZ=Q@mail.gmail.com>
References: <f67543901d54b344c8bb401e363e6b80.squirrel@www.codeaurora.org>
	<5088206C.7080101@stericsson.com>
	<50893E88.9000908@codeaurora.org>
	<5089549D.3060507@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:47691 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932469Ab2JZMHW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 26 Oct 2012 08:07:22 -0400
Received: by mail-wi0-f170.google.com with SMTP id hm2so345127wib.1
        for <linux-mmc@vger.kernel.org>; Fri, 26 Oct 2012 05:07:20 -0700 (PDT)
In-Reply-To: <5089549D.3060507@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?ISO-8859-1?Q?Per_F=F6rlin?= <per.forlin@stericsson.com>
Cc: Konstantin Dorfman <kdorfman@codeaurora.org>, Per Forlin <per.lkml@gmail.com>, "cjb@laptop.org" <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Thu, Oct 25, 2012 at 8:32 PM, Per F=F6rlin <per.forlin@stericsson.co=
m> wrote:
> On 10/25/2012 03:28 PM, Konstantin Dorfman wrote:
>> On 10/24/2012 07:07 PM, Per F=F6rlin wrote:
>>> On 10/24/2012 11:41 AM, Konstantin Dorfman wrote:
>>>> Hello Per,
>>>>
>>>> On Mon, October 22, 2012 1:02 am, Per Forlin wrote:
>>>>>> When mmcqt reports on completion of a request there should be
>>>>>> a context switch to allow the insertion of the next read ahead B=
IOs
>>>>>> to the block layer. Since the mmcqd tries to fetch another reque=
st
>>>>>> immediately after the completion of the previous request it gets=
 NULL
>>>>>> and starts waiting for the completion of the previous request.
>>>>>> This wait on completion gives the FS the opportunity to insert t=
he next
>>>>>> request but the MMC layer is already blocked on the previous req=
uest
>>>>>> completion and is not aware of the new request waiting to be fet=
ched.
>>>>> I thought that I could trigger a context switch in order to give
>>>>> execution time for FS to add the new request to the MMC queue.
>>>>> I made a simple hack to call yield() in case the request gets NUL=
L. I
>>>>> thought it may give the FS layer enough time to add a new request=
 to
>>>>> the MMC queue. This would not delay the MMC transfer since the yi=
eld()
>>>>> is done in parallel with an ongoing transfer. Anyway it was just =
meant
>>>>> to be a simple test.
>>>>>
>>>>> One yield was not enough. Just for sanity check I added a msleep =
as
>>>>> well and that was enough to let FS add a new request,
>>>>> Would it be possible to gain throughput by delaying the fetch of =
new
>>>>> request? Too avoid unnecessary NULL requests
>>>>>
>>>>> If (ongoing request is read AND size is max read ahead AND new re=
quest
>>>>> is NULL) yield();
>>>>>
>>>>> BR
>>>>> Per
>>>> We did the same experiment and it will not give maximum possible
>>>> performance. There is no guarantee that the context switch which w=
as
>>>> manually caused by the MMC layer comes just in time: when it was e=
arly
>>>> then next fetch still results in NULL, when it was later, then we =
miss
>>>> possibility to fetch/prepare new request.
>>>>
>>>> Any delay in fetch of the new request that comes after the new req=
uest has
>>>> arrived hits throughput and latency.
>>>>
>>>> The solution we are talking about here will fix not only situation=
 with FS
>>>> read ahead mechanism, but also it will remove penalty of the MMC c=
ontext
>>>> waiting on completion while any new request arrives.
>>>>
>>>> Thanks,
>>>>
>>> It seems strange that the block layer cannot keep up with relativel=
y slow flash media devices. There must be a limitation on number of out=
standing request towards MMC.
>>> I need to make up my mind if it's the best way to address this issu=
e in the MMC framework or block layer. I have started to look into the =
block layer code but it will take some time to dig out the relevant par=
ts.
>>>
>>> BR
>>> Per
>>>
>> The root cause of the issue in incompletion of the current design wi=
th
>> well known producer-consumer problem solution (producer is block lay=
er,
>> consumer is mmc layer).
>> Classic definitions states that the buffer is fix size, in our case =
we
>> have queue, so Producer always capable to put new request into the q=
ueue.
>> Consumer context blocked when both buffers (curr and prev) are busy
>> (first started its execution on the bus, second is fetched and waiti=
ng
>> for the first).
> This happens but I thought that the block layer would continue to add=
 request to the MMC queue while the consumer is busy.
> When consumer fetches request from the queue again there should be se=
veral requests available in the queue, but there is only one.
>
>> Producer context considered to be blocked when FS (or others bio
>> sources) has no requests to put into queue.
> Does the block layer ever wait for outstanding request to finish? Cou=
ld this be another reason why the producer doesn't add new requests on =
the MMC queue?
>

Actually there could a lot of reasons why block layer or CFQ would not =
have
inserted the request into the queue. i.e. you can see a lot of exit pat=
hs
where blk_peek_request returns NULL, even though there could be any req=
uest
pending in one of the CFQ requests queues.

Essentially you need to check what makes blk_fetch_request
(cfq_dispatch_requests() ) return NULL when there is an element in
queue, if at all.

>> To maximize performance there are 2 notifications should be used:
>> 1. Producer notifies Consumer about new item to proceed.
>> 2. Consumer notifies Producer about free place.
>>
>> In our case 2nd notification not need since as I said before - it is
>> always free space in the queue.
>> There is no such notification as 1st, i.e. block layer has no way to
>> notify mmc layer about new request arrived.
>>
>> What you suggesting is to resolve specific case, when FS READ_AHEAD
>> mechanism behavior causes delays in producing new requests.
>> Probably you can resolve this specific case, but do you have guarant=
ee
>> that this is only case that causes delays between new requests event=
s?
>> Flash memory devices these days constantly improved on all levels: N=
AND,
>> firmware, bus speed and host controller capabilities, this makes any
>> yield/sleep/timeouts solution only temporary hacks.
> I never meant yield or sleep to be a permanent fix. I was only curiou=
s of how if would affect the performance in order to gain a better know=
ledge of the root cause.
> My impression is that even if the SD card is very slow you will see t=
he same affect. The behavior of the block layer in this case is not rel=
ated to the speed for the flash memory.
> On a slow card the MMC-queue runs empty just like it does for a fast =
eMMC.
> According to you the block layer should have a better chance to feed =
the MMC queue if the card is slow (more time for the block layer to pre=
pare next requests).
>
> BR
> Per
