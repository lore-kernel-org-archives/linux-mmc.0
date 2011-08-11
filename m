From: Jens Axboe <jaxboe@fusionio.com>
Subject: Re: [RFC PATCH v2] Add new elevator ops for request hint
Date: Thu, 11 Aug 2011 11:01:22 +0200
Message-ID: <4E439A62.8080201@fusionio.com>
References: <20110811004216.GA24810@july> <CANejiEXgsVW4qk3hwHvd6YzgRsZueAB3ZSh3Rvx3fz9tM7KHPw@mail.gmail.com> <CANejiEUSU_hfex5i5znjAUU9Te2o-fgKuO=uD0UW+a4eaiU4Bw@mail.gmail.com> <4E439189.1030905@fusionio.com> <CAH9JG2WOrB5HTh2JiuVfPsXN2Z+R0gDGQeEoecxrrj9FpGSR+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.fusionio.com ([66.114.96.30]:35993 "EHLO mx1.fusionio.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752041Ab1HKJB1 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 11 Aug 2011 05:01:27 -0400
In-Reply-To: <CAH9JG2WOrB5HTh2JiuVfPsXN2Z+R0gDGQeEoecxrrj9FpGSR+g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kyungmin Park <kmpark@infradead.org>
Cc: Shaohua Li <shli@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "jh80.chung@samsung.com" <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 2011-08-11 10:56, Kyungmin Park wrote:
> On Thu, Aug 11, 2011 at 5:23 PM, Jens Axboe <jaxboe@fusionio.com> wrote:
>> On 2011-08-11 03:14, Shaohua Li wrote:
>>> 2011/8/11 Shaohua Li <shli@kernel.org>:
>>>> 2011/8/11 Kyungmin Park <kmpark@infradead.org>:
>>>>> Hi Jens
>>>>>
>>>>> Now eMMC device requires the upper layer information to improve the data
>>>>> performance and reliability.
>>>>>
>>>>> . Context ID
>>>>> Using the context information, it can sort out the data internally and improve the performance.
>>>>> The main problem is that it's needed to define "What's the context".
>>>>> Actually I expect cfq queue has own unique ID but it doesn't so decide to use the pid instead
>>>>>
>>>>> . Data Tag
>>>>> Using the Data Tag (1-bit information), It writes the data at SLC area when it's hot data. So it can make the chip more reliable.
>>>>> First I expect the REQ_META but current ext4 doesn't pass the WRITE_META. only use the READ_META. so it needs to investigate it.
>>>>>
>>>>> With these characteristics, it's helpful to teach the device. After some consideration. it's needed to pass out these information at request data structure.
>>>>>
>>>>> Sample usage is following in drivers/mmc/card/block.c
>>>>>
>>>>>        struct elevator_queue *e = md->queue.queue->elevator;
>>>>>        struct request_hint hint;
>>>>>        int ret;
>>>>>
>>>>>        if (e->ops->elevator_get_req_hint_fn && req)
>>>>>                ret = e->ops->elevator_get_req_hint_fn(req, &hint);
>>>> please put this to blkdev.h or similar. directly using it here
>>>> is abnormal.
>>> BTW, we can add a (rq->cmd_flags & REQ_ELVPRIV) check here to make
>>> sure the request is at io scheduler.
>>
>> Yep, that should all go inside elv_get_request_context() or whatever is
>> a good name. I don't want the hint structure, the caller can just check
>> the request flags himself.
> Okay I see, it has to modify the filesystem to send the meta request,
> REQ_META flags to know it from device drivers.

Right, the submitter if the IO is the one that has to decide what is hot
or not.

>> So something like:
>>
>> int elv_get_request_context(struct request_queue *q, struct request *rq)
>> {
>>        struct elevator_queue *e = q->elevator;
>>
>>        if (!(rq->cmd_flags & REQ_ELVPRIV))
>>                return -1;
> Also need to check the !rq case, mmc send the NULL request to wait the
> previous request wait.

No, that would be a usage bug.

-- 
Jens Axboe

