From: Shaohua Li <shli@kernel.org>
Subject: Re: [RFC PATCH v2] Add new elevator ops for request hint
Date: Thu, 11 Aug 2011 09:10:49 +0800
Message-ID: <CANejiEXgsVW4qk3hwHvd6YzgRsZueAB3ZSh3Rvx3fz9tM7KHPw@mail.gmail.com>
References: <20110811004216.GA24810@july>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110811004216.GA24810@july>
Sender: linux-kernel-owner@vger.kernel.org
To: Kyungmin Park <kmpark@infradead.org>
Cc: jaxboe@fusionio.com, linux-kernel@vger.kernel.org, arnd@arndb.de, jh80.chung@samsung.com, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

2011/8/11 Kyungmin Park <kmpark@infradead.org>:
> Hi Jens
>
> Now eMMC device requires the upper layer information to improve the d=
ata
> performance and reliability.
>
> . Context ID
> Using the context information, it can sort out the data internally an=
d improve the performance.
> The main problem is that it's needed to define "What's the context".
> Actually I expect cfq queue has own unique ID but it doesn't so decid=
e to use the pid instead
>
> . Data Tag
> Using the Data Tag (1-bit information), It writes the data at SLC are=
a when it's hot data. So it can make the chip more reliable.
> First I expect the REQ_META but current ext4 doesn't pass the WRITE_M=
ETA. only use the READ_META. so it needs to investigate it.
>
> With these characteristics, it's helpful to teach the device. After s=
ome consideration. it's needed to pass out these information at request=
 data structure.
>
> Sample usage is following in drivers/mmc/card/block.c
>
> =A0 =A0 =A0 =A0struct elevator_queue *e =3D md->queue.queue->elevator=
;
> =A0 =A0 =A0 =A0struct request_hint hint;
> =A0 =A0 =A0 =A0int ret;
>
> =A0 =A0 =A0 =A0if (e->ops->elevator_get_req_hint_fn && req)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D e->ops->elevator_get_req_hint_=
fn(req, &hint);
please put this to blkdev.h or similar. directly using it here
is abnormal.

> Thank you,
> Kyungmin Park
> ---
> Changelog v2
> - Don't add the request member. instead add new elevator ops
>
> ---
> diff --git a/block/cfq-iosched.c b/block/cfq-iosched.c
> index 1f96ad6..5089f67 100644
> --- a/block/cfq-iosched.c
> +++ b/block/cfq-iosched.c
> @@ -3800,6 +3800,18 @@ queue_fail:
> =A0 =A0 =A0 =A0return 1;
> =A0}
>
> +static int cfq_get_request_hint(struct request *rq, struct request_h=
int *hint)
> +{
> + =A0 =A0 =A0 struct cfq_queue *cfqq =3D RQ_CFQQ(rq);
> +
> + =A0 =A0 =A0 if (cfqq) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hint->context =3D cfqq->pid;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hint->hot =3D !!(rq->cmd_flags & REQ_ME=
TA);
> + =A0 =A0 =A0 }
if the rq is in cfq, the cfqq is always valid, so don't need the check.

Thanks,
Shaohua
