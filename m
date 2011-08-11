From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [RFC PATCH v2] Add new elevator ops for request hint
Date: Thu, 11 Aug 2011 17:56:22 +0900
Message-ID: <CAH9JG2WOrB5HTh2JiuVfPsXN2Z+R0gDGQeEoecxrrj9FpGSR+g@mail.gmail.com>
References: <20110811004216.GA24810@july>
	<CANejiEXgsVW4qk3hwHvd6YzgRsZueAB3ZSh3Rvx3fz9tM7KHPw@mail.gmail.com>
	<CANejiEUSU_hfex5i5znjAUU9Te2o-fgKuO=uD0UW+a4eaiU4Bw@mail.gmail.com>
	<4E439189.1030905@fusionio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:53845 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753875Ab1HKI4X convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 11 Aug 2011 04:56:23 -0400
In-Reply-To: <4E439189.1030905@fusionio.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jens Axboe <jaxboe@fusionio.com>
Cc: Shaohua Li <shli@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "jh80.chung@samsung.com" <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Thu, Aug 11, 2011 at 5:23 PM, Jens Axboe <jaxboe@fusionio.com> wrote=
:
> On 2011-08-11 03:14, Shaohua Li wrote:
>> 2011/8/11 Shaohua Li <shli@kernel.org>:
>>> 2011/8/11 Kyungmin Park <kmpark@infradead.org>:
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
>>>> Sample usage is following in drivers/mmc/card/block.c
>>>>
>>>> =A0 =A0 =A0 =A0struct elevator_queue *e =3D md->queue.queue->eleva=
tor;
>>>> =A0 =A0 =A0 =A0struct request_hint hint;
>>>> =A0 =A0 =A0 =A0int ret;
>>>>
>>>> =A0 =A0 =A0 =A0if (e->ops->elevator_get_req_hint_fn && req)
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D e->ops->elevator_get_req_hi=
nt_fn(req, &hint);
>>> please put this to blkdev.h or similar. directly using it here
>>> is abnormal.
>> BTW, we can add a (rq->cmd_flags & REQ_ELVPRIV) check here to make
>> sure the request is at io scheduler.
>
> Yep, that should all go inside elv_get_request_context() or whatever =
is
> a good name. I don't want the hint structure, the caller can just che=
ck
> the request flags himself.
Okay I see, it has to modify the filesystem to send the meta request,
REQ_META flags to know it from device drivers.
>
> So something like:
>
> int elv_get_request_context(struct request_queue *q, struct request *=
rq)
> {
> =A0 =A0 =A0 =A0struct elevator_queue *e =3D q->elevator;
>
> =A0 =A0 =A0 =A0if (!(rq->cmd_flags & REQ_ELVPRIV))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -1;
Also need to check the !rq case, mmc send the NULL request to wait the
previous request wait.
>
> =A0 =A0 =A0 =A0if (e->ops->elevator_get_req_context_fn)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return e->ops->elevator_get_req_contex=
t_fn(q, rq);
>
> =A0 =A0 =A0 =A0return -1;
> }
>
> and then cfq/others adding that helper to provide the mapping.
>
> Context is a bad name, but so is hint. Perhaps app_key would be bette=
r,
> as it more direcly infers what is being returned.

I'll send the new version as you suggested.

Thank you,
Kyungmin Park
>
> --
> Jens Axboe
>
>
