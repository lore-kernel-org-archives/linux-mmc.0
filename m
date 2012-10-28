From: Konstantin Dorfman <kdorfman@codeaurora.org>
Subject: Re: [PATCH v1] mmc: fix async request mechanism for sequential read
 scenarios
Date: Sun, 28 Oct 2012 14:43:24 +0200
Message-ID: <508D286C.9020802@codeaurora.org>
References: <f67543901d54b344c8bb401e363e6b80.squirrel@www.codeaurora.org> <5088206C.7080101@stericsson.com> <50893E88.9000908@codeaurora.org> <5089549D.3060507@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:56393 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751532Ab2J1Mno (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 28 Oct 2012 08:43:44 -0400
In-Reply-To: <5089549D.3060507@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?ISO-8859-1?Q?Per_F=F6rlin?= <per.forlin@stericsson.com>
Cc: Per Forlin <per.lkml@gmail.com>, "cjb@laptop.org" <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Venkatraman S <svenkatr@gmail.com>, Maya Erez <merez@codeaurora.org>

On 10/25/2012 05:02 PM, Per F=F6rlin wrote:
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

MMC layer tries to fetch next request immediately after starting prev
request, but block layer has no context to submit new request, after
fetching NULL request MMC layer goes to be blocked and has no chance to
repeat the fetch until current request not completed.

>=20
>> Producer context considered to be blocked when FS (or others bio
>> sources) has no requests to put into queue.
> Does the block layer ever wait for outstanding request to finish? Cou=
ld this be another reason why the producer doesn't add new requests on =
the MMC queue?
>=20
In the case with sequence read request, only after request complete
returned to the FS/read ahead layer, it will generate next read request=
=2E
It may depend on READ_AHEAD : mmc_req_size ratio, also it may depend on
other layers (above FS) and user space access patterns. You can't expec=
t
always "good" access patterns coming to the MMC layer

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
>=20
I understand that yield/sleep is not a solution, this is not important
what are reasons for block layer behaviour, but what is really importan=
t
- MMC layer should always be able to fetch the new arrived request ASAP
after block layer notification (mmc_request() ) and this is what my fix
goes to implement. And the fix is not changing block layer behavior.

Thanks,
--=20
Konstantin Dorfman,
QUALCOMM ISRAEL, on behalf of Qualcomm Innovation Center,
Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
