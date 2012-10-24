From: =?ISO-8859-1?Q?Per_F=F6rlin?= <per.forlin@stericsson.com>
Subject: Re: [PATCH v1] mmc: fix async request mechanism for sequential read
 scenarios
Date: Wed, 24 Oct 2012 19:07:56 +0200
Message-ID: <5088206C.7080101@stericsson.com>
References: <f67543901d54b344c8bb401e363e6b80.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog103.obsmtp.com ([207.126.144.115]:57288 "EHLO
	eu1sys200aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756505Ab2JXRI7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 24 Oct 2012 13:08:59 -0400
In-Reply-To: <f67543901d54b344c8bb401e363e6b80.squirrel@www.codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Konstantin Dorfman <kdorfman@codeaurora.org>
Cc: Per Forlin <per.lkml@gmail.com>, "cjb@laptop.org" <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 10/24/2012 11:41 AM, Konstantin Dorfman wrote:
> Hello Per,
>
> On Mon, October 22, 2012 1:02 am, Per Forlin wrote:
>>> When mmcqt reports on completion of a request there should be
>>> a context switch to allow the insertion of the next read ahead BIOs
>>> to the block layer. Since the mmcqd tries to fetch another request
>>> immediately after the completion of the previous request it gets NULL
>>> and starts waiting for the completion of the previous request.
>>> This wait on completion gives the FS the opportunity to insert the next
>>> request but the MMC layer is already blocked on the previous request
>>> completion and is not aware of the new request waiting to be fetched.
>> I thought that I could trigger a context switch in order to give
>> execution time for FS to add the new request to the MMC queue.
>> I made a simple hack to call yield() in case the request gets NULL. I
>> thought it may give the FS layer enough time to add a new request to
>> the MMC queue. This would not delay the MMC transfer since the yield()
>> is done in parallel with an ongoing transfer. Anyway it was just meant
>> to be a simple test.
>>
>> One yield was not enough. Just for sanity check I added a msleep as
>> well and that was enough to let FS add a new request,
>> Would it be possible to gain throughput by delaying the fetch of new
>> request? Too avoid unnecessary NULL requests
>>
>> If (ongoing request is read AND size is max read ahead AND new request
>> is NULL) yield();
>>
>> BR
>> Per
> We did the same experiment and it will not give maximum possible
> performance. There is no guarantee that the context switch which was
> manually caused by the MMC layer comes just in time: when it was early
> then next fetch still results in NULL, when it was later, then we miss
> possibility to fetch/prepare new request.
>
> Any delay in fetch of the new request that comes after the new request has
> arrived hits throughput and latency.
>
> The solution we are talking about here will fix not only situation with FS
> read ahead mechanism, but also it will remove penalty of the MMC context
> waiting on completion while any new request arrives.
>
> Thanks,
>

It seems strange that the block layer cannot keep up with relatively slow flash media devices. There must be a limitation on number of outstanding request towards MMC.
I need to make up my mind if it's the best way to address this issue in the MMC framework or block layer. I have started to look into the block layer code but it will take some time to dig out the relevant parts.

BR
Per

