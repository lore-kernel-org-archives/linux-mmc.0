From: Shaohua Li <shli@kernel.org>
Subject: Re: [RFC PATCH v2] Add new elevator ops for request hint
Date: Thu, 11 Aug 2011 09:14:43 +0800
Message-ID: <CANejiEUSU_hfex5i5znjAUU9Te2o-fgKuO=uD0UW+a4eaiU4Bw@mail.gmail.com>
References: <20110811004216.GA24810@july>
	<CANejiEXgsVW4qk3hwHvd6YzgRsZueAB3ZSh3Rvx3fz9tM7KHPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:57112 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755343Ab1HKBOo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Aug 2011 21:14:44 -0400
In-Reply-To: <CANejiEXgsVW4qk3hwHvd6YzgRsZueAB3ZSh3Rvx3fz9tM7KHPw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kyungmin Park <kmpark@infradead.org>
Cc: jaxboe@fusionio.com, linux-kernel@vger.kernel.org, arnd@arndb.de, jh80.chung@samsung.com, linux-mmc@vger.kernel.org

2011/8/11 Shaohua Li <shli@kernel.org>:
> 2011/8/11 Kyungmin Park <kmpark@infradead.org>:
>> Hi Jens
>>
>> Now eMMC device requires the upper layer information to improve the =
data
>> performance and reliability.
>>
>> . Context ID
>> Using the context information, it can sort out the data internally a=
nd improve the performance.
>> The main problem is that it's needed to define "What's the context".
>> Actually I expect cfq queue has own unique ID but it doesn't so deci=
de to use the pid instead
>>
>> . Data Tag
>> Using the Data Tag (1-bit information), It writes the data at SLC ar=
ea when it's hot data. So it can make the chip more reliable.
>> First I expect the REQ_META but current ext4 doesn't pass the WRITE_=
META. only use the READ_META. so it needs to investigate it.
>>
>> With these characteristics, it's helpful to teach the device. After =
some consideration. it's needed to pass out these information at reques=
t data structure.
>>
>> Sample usage is following in drivers/mmc/card/block.c
>>
>> =A0 =A0 =A0 =A0struct elevator_queue *e =3D md->queue.queue->elevato=
r;
>> =A0 =A0 =A0 =A0struct request_hint hint;
>> =A0 =A0 =A0 =A0int ret;
>>
>> =A0 =A0 =A0 =A0if (e->ops->elevator_get_req_hint_fn && req)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D e->ops->elevator_get_req_hint=
_fn(req, &hint);
> please put this to blkdev.h or similar. directly using it here
> is abnormal.
BTW, we can add a (rq->cmd_flags & REQ_ELVPRIV) check here to make
sure the request is at io scheduler.
