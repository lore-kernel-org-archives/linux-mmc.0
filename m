From: Konstantin Dorfman <kdorfman@codeaurora.org>
Subject: Re: [PATCH v1] mmc: fix async request mechanism for sequential read
 scenarios
Date: Thu, 25 Oct 2012 15:28:40 +0200
Message-ID: <50893E88.9000908@codeaurora.org>
References: <f67543901d54b344c8bb401e363e6b80.squirrel@www.codeaurora.org> <5088206C.7080101@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:59620 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759057Ab2JYN2o (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 25 Oct 2012 09:28:44 -0400
In-Reply-To: <5088206C.7080101@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?ISO-8859-1?Q?Per_F=F6rlin?= <per.forlin@stericsson.com>
Cc: Per Forlin <per.lkml@gmail.com>, "cjb@laptop.org" <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 10/24/2012 07:07 PM, Per F=F6rlin wrote:
> On 10/24/2012 11:41 AM, Konstantin Dorfman wrote:
>> Hello Per,
>>
>> On Mon, October 22, 2012 1:02 am, Per Forlin wrote:
>>>> When mmcqt reports on completion of a request there should be
>>>> a context switch to allow the insertion of the next read ahead BIO=
s
>>>> to the block layer. Since the mmcqd tries to fetch another request
>>>> immediately after the completion of the previous request it gets N=
ULL
>>>> and starts waiting for the completion of the previous request.
>>>> This wait on completion gives the FS the opportunity to insert the=
 next
>>>> request but the MMC layer is already blocked on the previous reque=
st
>>>> completion and is not aware of the new request waiting to be fetch=
ed.
>>> I thought that I could trigger a context switch in order to give
>>> execution time for FS to add the new request to the MMC queue.
>>> I made a simple hack to call yield() in case the request gets NULL.=
 I
>>> thought it may give the FS layer enough time to add a new request t=
o
>>> the MMC queue. This would not delay the MMC transfer since the yiel=
d()
>>> is done in parallel with an ongoing transfer. Anyway it was just me=
ant
>>> to be a simple test.
>>>
>>> One yield was not enough. Just for sanity check I added a msleep as
>>> well and that was enough to let FS add a new request,
>>> Would it be possible to gain throughput by delaying the fetch of ne=
w
>>> request? Too avoid unnecessary NULL requests
>>>
>>> If (ongoing request is read AND size is max read ahead AND new requ=
est
>>> is NULL) yield();
>>>
>>> BR
>>> Per
>> We did the same experiment and it will not give maximum possible
>> performance. There is no guarantee that the context switch which was
>> manually caused by the MMC layer comes just in time: when it was ear=
ly
>> then next fetch still results in NULL, when it was later, then we mi=
ss
>> possibility to fetch/prepare new request.
>>
>> Any delay in fetch of the new request that comes after the new reque=
st has
>> arrived hits throughput and latency.
>>
>> The solution we are talking about here will fix not only situation w=
ith FS
>> read ahead mechanism, but also it will remove penalty of the MMC con=
text
>> waiting on completion while any new request arrives.
>>
>> Thanks,
>>
> It seems strange that the block layer cannot keep up with relatively =
slow flash media devices. There must be a limitation on number of outst=
anding request towards MMC.
> I need to make up my mind if it's the best way to address this issue =
in the MMC framework or block layer. I have started to look into the bl=
ock layer code but it will take some time to dig out the relevant parts=
=2E
>
> BR
> Per
>
The root cause of the issue in incompletion of the current design with
well known producer-consumer problem solution (producer is block layer,
consumer is mmc layer).
Classic definitions states that the buffer is fix size, in our case we
have queue, so Producer always capable to put new request into the queu=
e.
Consumer context blocked when both buffers (curr and prev) are busy
(first started its execution on the bus, second is fetched and waiting
for the first).
Producer context considered to be blocked when FS (or others bio
sources) has no requests to put into queue.
To maximize performance there are 2 notifications should be used:
1. Producer notifies Consumer about new item to proceed.
2. Consumer notifies Producer about free place.

In our case 2nd notification not need since as I said before - it is
always free space in the queue.
There is no such notification as 1st, i.e. block layer has no way to
notify mmc layer about new request arrived.

What you suggesting is to resolve specific case, when FS READ_AHEAD
mechanism behavior causes delays in producing new requests.
Probably you can resolve this specific case, but do you have guarantee
that this is only case that causes delays between new requests events?
=46lash memory devices these days constantly improved on all levels: NA=
ND,
firmware, bus speed and host controller capabilities, this makes any
yield/sleep/timeouts solution only temporary hacks.

Thanks
--=20

Konstantin Dorfman,
QUALCOMM ISRAEL, on behalf of Qualcomm Innovation Center,
Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation

