From: =?ISO-8859-1?Q?Per_F=F6rlin?= <per.forlin@stericsson.com>
Subject: Re: [PATCH v1] mmc: fix async request mechanism for sequential read
 scenarios
Date: Thu, 25 Oct 2012 17:02:53 +0200
Message-ID: <5089549D.3060507@stericsson.com>
References: <f67543901d54b344c8bb401e363e6b80.squirrel@www.codeaurora.org> <5088206C.7080101@stericsson.com> <50893E88.9000908@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog112.obsmtp.com ([207.126.144.133]:45674 "EHLO
	eu1sys200aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933842Ab2JYPDU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 25 Oct 2012 11:03:20 -0400
In-Reply-To: <50893E88.9000908@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Konstantin Dorfman <kdorfman@codeaurora.org>
Cc: Per Forlin <per.lkml@gmail.com>, "cjb@laptop.org" <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 10/25/2012 03:28 PM, Konstantin Dorfman wrote:
> On 10/24/2012 07:07 PM, Per F=F6rlin wrote:
>> On 10/24/2012 11:41 AM, Konstantin Dorfman wrote:
>>> Hello Per,
>>>
>>> On Mon, October 22, 2012 1:02 am, Per Forlin wrote:
>>>>> When mmcqt reports on completion of a request there should be
>>>>> a context switch to allow the insertion of the next read ahead BI=
Os
>>>>> to the block layer. Since the mmcqd tries to fetch another reques=
t
>>>>> immediately after the completion of the previous request it gets =
NULL
>>>>> and starts waiting for the completion of the previous request.
>>>>> This wait on completion gives the FS the opportunity to insert th=
e next
>>>>> request but the MMC layer is already blocked on the previous requ=
est
>>>>> completion and is not aware of the new request waiting to be fetc=
hed.
>>>> I thought that I could trigger a context switch in order to give
>>>> execution time for FS to add the new request to the MMC queue.
>>>> I made a simple hack to call yield() in case the request gets NULL=
=2E I
>>>> thought it may give the FS layer enough time to add a new request =
to
>>>> the MMC queue. This would not delay the MMC transfer since the yie=
ld()
>>>> is done in parallel with an ongoing transfer. Anyway it was just m=
eant
>>>> to be a simple test.
>>>>
>>>> One yield was not enough. Just for sanity check I added a msleep a=
s
>>>> well and that was enough to let FS add a new request,
>>>> Would it be possible to gain throughput by delaying the fetch of n=
ew
>>>> request? Too avoid unnecessary NULL requests
>>>>
>>>> If (ongoing request is read AND size is max read ahead AND new req=
uest
>>>> is NULL) yield();
>>>>
>>>> BR
>>>> Per
>>> We did the same experiment and it will not give maximum possible
>>> performance. There is no guarantee that the context switch which wa=
s
>>> manually caused by the MMC layer comes just in time: when it was ea=
rly
>>> then next fetch still results in NULL, when it was later, then we m=
iss
>>> possibility to fetch/prepare new request.
>>>
>>> Any delay in fetch of the new request that comes after the new requ=
est has
>>> arrived hits throughput and latency.
>>>
>>> The solution we are talking about here will fix not only situation =
with FS
>>> read ahead mechanism, but also it will remove penalty of the MMC co=
ntext
>>> waiting on completion while any new request arrives.
>>>
>>> Thanks,
>>>
>> It seems strange that the block layer cannot keep up with relatively=
 slow flash media devices. There must be a limitation on number of outs=
tanding request towards MMC.
>> I need to make up my mind if it's the best way to address this issue=
 in the MMC framework or block layer. I have started to look into the b=
lock layer code but it will take some time to dig out the relevant part=
s.
>>
>> BR
>> Per
>>
> The root cause of the issue in incompletion of the current design wit=
h
> well known producer-consumer problem solution (producer is block laye=
r,
> consumer is mmc layer).
> Classic definitions states that the buffer is fix size, in our case w=
e
> have queue, so Producer always capable to put new request into the qu=
eue.
> Consumer context blocked when both buffers (curr and prev) are busy
> (first started its execution on the bus, second is fetched and waitin=
g
> for the first).
This happens but I thought that the block layer would continue to add r=
equest to the MMC queue while the consumer is busy.
When consumer fetches request from the queue again there should be seve=
ral requests available in the queue, but there is only one.

> Producer context considered to be blocked when FS (or others bio
> sources) has no requests to put into queue.
Does the block layer ever wait for outstanding request to finish? Could=
 this be another reason why the producer doesn't add new requests on th=
e MMC queue?

> To maximize performance there are 2 notifications should be used:
> 1. Producer notifies Consumer about new item to proceed.
> 2. Consumer notifies Producer about free place.
>=20
> In our case 2nd notification not need since as I said before - it is
> always free space in the queue.
> There is no such notification as 1st, i.e. block layer has no way to
> notify mmc layer about new request arrived.
>=20
> What you suggesting is to resolve specific case, when FS READ_AHEAD
> mechanism behavior causes delays in producing new requests.
> Probably you can resolve this specific case, but do you have guarante=
e
> that this is only case that causes delays between new requests events=
?
> Flash memory devices these days constantly improved on all levels: NA=
ND,
> firmware, bus speed and host controller capabilities, this makes any
> yield/sleep/timeouts solution only temporary hacks.
I never meant yield or sleep to be a permanent fix. I was only curious =
of how if would affect the performance in order to gain a better knowle=
dge of the root cause.
My impression is that even if the SD card is very slow you will see the=
 same affect. The behavior of the block layer in this case is not relat=
ed to the speed for the flash memory.
On a slow card the MMC-queue runs empty just like it does for a fast eM=
MC.
According to you the block layer should have a better chance to feed th=
e MMC queue if the card is slow (more time for the block layer to prepa=
re next requests).

BR
Per

