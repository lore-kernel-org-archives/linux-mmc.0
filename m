From: merez@codeaurora.org
Subject: RE: [PATCH 2/2] mmc: core: Support packed command for eMMC4.5
     device
Date: Thu, 17 Nov 2011 05:45:30 -0800 (PST)
Message-ID: <bc8a36d67f74dfb0a516f5989849ccb8.squirrel@www.codeaurora.org>
References: <620ec9ffa6bdbba9ae5f76998e36f8dc.squirrel@www.codeaurora.org>
    <001001cca043$395dbfc0$ac193f40$%jun@samsung.com>
    <CANfBPZ-Zn+R4GosEL-RJxh8gduAr8e+qN876uPwDkHfiEpdERw@mail.gmail.com>
    <001d01cca2b1$f4921ff0$ddb65fd0$%jun@samsung.com>
    <4108533d3f51753179703e04299ecab7.squirrel@www.codeaurora.org>
    <004a01cca4cf$9081e840$b185b8c0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:6557 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757428Ab1KQNpb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Nov 2011 08:45:31 -0500
In-Reply-To: <004a01cca4cf$9081e840$b185b8c0$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: merez@codeaurora.org, "'S, Venkatraman'" <svenkatr@ti.com>, linux-mmc@vger.kernel.org, 'Chris Ball' <cjb@laptop.org>, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, dh.han@samsung.com

> Maya Erez wrote:
>> >> >> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 phys_segments +=3D =A0ne=
xt->nr_phys_segments;
>> >> >> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (phys_segments > max_=
phys_segs) {
>> >> >> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 blk_requ=
eue_request(q, next);
>> >> >> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> >> >> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> >> >> >> >> I mentioned this before - if the next request is not
>> packable
>> >> and
>> >> >> >> requeued,
>> >> >> >> >> blk_fetch_request will retrieve it again and this while =
loop
>> >> will
>> >> >> never terminate.
>> >> >> >> >>
>> >> >> >> > If next request is not packable, it is requeued and 'brea=
k'
>> >> >> terminates
>> >> >> >> this loop.
>> >> >> >> > So it not infinite.
>> >> >> >> Right !! But that doesn't help finding the commands that ar=
e
>> >> packable.
>> >> >> Ideally, you'd need to pack all neighbouring requests into one
>> packed
>> >> >> command.
>> >> >> >> The way CFQ works, it is not necessary that the fetch would
>> return
>> >> all
>> >> >> outstanding
>> >> >> >> requests that are packable (unless you invoke a forced
>> dispatch)
>> >> It
>> >> >> would be good to see some numbers on the number of pack hits /
>> >> >> misses
>> >> >> >> that
>> >> >> >> you would encounter with this logic, on a typical usecase.
>> >> >> > Is it considered only for CFQ scheduler? How about other I/O
>> >> scheduler?
>> >> >> If all requests are drained from scheduler queue forcedly,
>> >> >> > the number of candidate to be packed can be increased.
>> >> >> > However we may lose the unique CFQ's strength and MMC D/D ma=
y
>> take
>> >> the
>> >> >> CFQ's duty.
>> >> >> > Basically, this patch accommodates the origin order requests
>> from
>> >> I/O
>> >> >> scheduler.
>> >> >> >
>> >> >>
>> >> >> In order to better utilize the packed commands feature and ach=
ieve
>> >> the
>> >> >> best performance improvements I think that the command packing
>> should
>> >> be
>> >> >> done in the block layer, according to the scheduler policy.
>> >> >> That is, the scheduler should be aware of the capability of th=
e
>> >> device to
>> >> >> receive a request list and its constrains (such as maximum num=
ber
>> of
>> >> >> requests, max number of sectors etc) and use this information =
as a
>> >> =A0factor
>> >> >> to its algorithm.
>> >> >> This way you keep the decision making in the hands of the
>> scheduler
>> >> while
>> >> >> the MMC layer will only have to send this list as a packed
>> command.
>> >> >>
>> >> > Yes, it would be another interesting approach.
>> >> > Command packing you mentioned means gathering request among sam=
e
>> >> direction(read/write)?
>> >> > Currently I/O scheduler may know device constrains which MMC dr=
iver
>> >> informs
>> >> > with the exception of order information for packed command.
>> >> > But I think the dependency of I/O scheduler may be able to come=
 up.
>> >> > How can MMC layer treat packed command with I/O scheduler which
>> >> doesn't support this?
>> >>
>> >> The very act of packing presumes some sorting and re-ordering at =
the
>> >> I/O scheduler level.
>> >> When no such sorting is done (ex. noop), MMC should resort to
>> >> non-packed execution, respecting the system configuration choice.
>> >>
>> >> Looking deeper into this, I think a better approach would be to s=
et
>> >> the prep_rq_fn of the request_queue, with a custom mmc function t=
hat
>> >> decides if the requests are packable or not, and return a
>> >> BLKPREP_DEFER for those that can't be packed.
>> >
>> > MMC layer anticipates the favorable requests for packing from I/O
>> > scheduler.
>> > Obviously request order from I/O scheduler might be poor for packi=
ng
>> and
>> > requests can't be packed.
>> > But that doesn't mean mmc layer need to wait a better pack-case.
>> > BLKPREP_DEFER may give rise to I/O latency. Top of request will be
>> > deferred next time.
>> > If request can't be packed, it'd rather be sent at once than delay=
ed
>> > by returning a BLKPREP_DEFER for better responsiveness.
>> >
>> > Thanks.
>> > Seungwon Jeon.
>> The decision whether a request is packable or not should not be made=
 per
>> request, therefore I don't see the need for using req_prep_fn. The M=
MC
>> layer can peek each request and decide if to pack it or not when
>> preparing
>> the packed list (as suggested in this patch). The scheduler changes =
will
>> improve the probability of getting a list that can be packed.
>> My suggestion for the scheduler change is:
>> The block layer will be notified of the packing limits via new queue
>> limits (in blk-settings). We can make it generic to allow all kinds =
of
>> requests lists. Example for the new queue limits can be:
>> Is_reqs_list_supported
>> Max_num_of_read_reqs_in_list
>> Max_num_of_write_reqs_in_list
>> max_blk_cnt_in_list
>> Is_list_interleaved (optional - to support read and write requests t=
o be
>> linked together, not the case for eMMC4.5)
>> The scheduler, that will have all the required info in the queue lim=
its,
>> will be able to decide which requests can be in the same list and mo=
ve
>> all
>> of them to the dispatch queue (in one elevator_dispatch_fn call).
>
> If probability of packing gets higher, it would be nice.
> We need to think more.
>>
>> I see 2 options for preparing the list:
>>
>> Option 1. blk_fetch_request will prepare the list and return a list =
of
>> requests (will require a change in struct request to include the lis=
t
>> but
>> can be more generic).
>>
>> Option 2. The MMC layer will prepare the list. After fetching one
>> request
>> the MMC layer can call blk_peek_request and check if the next reques=
t is
>> packable or not. By keeping all the calls to blk_peek_request under =
the
>> same queue lock we can guarantee to get the requests that the schedu=
ler
>> pushed to the dispatch queue (this requires mmc_blk_chk_packable to =
move
>> to block.c). If the request is packable the MMC layer will call
>> blk_start_request to dequeue the request. This way there is no need =
to
>> re-queue the requests that cannot be packed.
>>
>> Going back to this patch - the usage of
>> blk_peek_request+blk_start_request
>> instead of blk_fetch_request can be done in mmc_blk_chk_packable in
>> order
>> to eliminate the need to requeue commands and loose performance.
>
> Do you think blk_requeue_request() is heavy work?
> Currently queue_lock was missed using blk_fetch_request. It will be f=
ixed.
> Anyway, if we use a set of blk_peek_request+blk_start_request,
> there is no necessity for requeuing the request.
> But during preparing several request for the list, queue_lock will be=
 held
> in mmc layer.
> Then queue_lock time of mmc layer might be more increased than before=
=2E
>
> Thank you for suggestion.
> Seungwon Jeon.
>>
Yes, I think that if we can avoid redundant dequeue and requeue it woul=
d
be better. Please note that the re-queue also requires locking the
queue_lock.
I agree that in case of preparing the packed list the queue_lock will b=
e
taken for a longer time but I don't see any way to avoid it.

Thanks,
Maya Erez
Consultant for Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum


