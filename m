From: merez@codeaurora.org
Subject: RE: [PATCH 2/2] mmc: core: Support packed command for eMMC4.5      
     device
Date: Thu, 10 Nov 2011 05:41:17 -0800 (PST)
Message-ID: <620ec9ffa6bdbba9ae5f76998e36f8dc.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:33798 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932540Ab1KJNlS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Nov 2011 08:41:18 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: "'S, Venkatraman'" <svenkatr@ti.com>, linux-mmc@vger.kernel.org, 'Chris Ball' <cjb@laptop.org>, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, dh.han@samsung.com

On Thu, Nov 10, 2011 Maya Erez wrote:
> S, Venkatraman <svenkatr@ti.com> wrote:
>> On Thu, Nov 3, 2011 at 7:23 AM, Seungwon Jeon <tgih.jun@samsung.com>
wrote:
>> >> > +static u8 mmc_blk_chk_packable(struct mmc_queue *mq, struct
>> request *req)

The function prepares the checkable list and not only checks if packing=
 is
possible, therefore I think its name should change to reflect its real
action.

>> >> > + =A0 =A0 =A0 if (!(md->flags & MMC_BLK_CMD23) &&
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !card->ext_csd.pa=
cked_event_en)
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto no_packed;

Having the condition with a && can lead to cases where CMD23 is not=20
supported and we send packed commands. Therfore the condition should be
changed to || or be splitted to 2 separate checks.
Also, according to the standard the generic error flag in
PACKED_COMMAND_STATUS is set in case of any error and having
PACKED_EVENT_EN is only optional. Therefore, I don't think that setting
the packed_event_en should be a mandatory condition for using packed
coammnds.

>> >> > + =A0 =A0 =A0 if (mmc_req_rel_wr(cur) &&
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (md->flags & MMC_=
BLK_REL_WR) &&
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !en_rel_wr) {
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto no_packed;
>> >> > + =A0 =A0 =A0 }

Can you please explain this condition and its purpose?

>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 phys_segments +=3D =A0next->nr_ph=
ys_segments;
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (phys_segments > max_phys_segs=
) {
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 blk_requeue_reque=
st(q, next);
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> >> I mentioned this before - if the next request is not packable and
>> requeued,
>> >> blk_fetch_request will retrieve it again and this while loop will
never terminate.
>> >>
>> > If next request is not packable, it is requeued and 'break'
terminates
>> this loop.
>> > So it not infinite.
>> Right !! But that doesn't help finding the commands that are packabl=
e.
Ideally, you'd need to pack all neighbouring requests into one packed
command.
>> The way CFQ works, it is not necessary that the fetch would return a=
ll
outstanding
>> requests that are packable (unless you invoke a forced dispatch) It
would be good to see some numbers on the number of pack hits /
misses
>> that
>> you would encounter with this logic, on a typical usecase.
> Is it considered only for CFQ scheduler? How about other I/O schedule=
r?
If all requests are drained from scheduler queue forcedly,
> the number of candidate to be packed can be increased.
> However we may lose the unique CFQ's strength and MMC D/D may take th=
e
CFQ's duty.
> Basically, this patch accommodates the origin order requests from I/O
scheduler.
>

In order to better utilize the packed commands feature and achieve the
best performance improvements I think that the command packing should b=
e
done in the block layer, according to the scheduler policy.
That is, the scheduler should be aware of the capability of the device =
to
receive a request list and its constrains (such as maximum number of
requests, max number of sectors etc) and use this information as a  fac=
tor
to its algorithm.
This way you keep the decision making in the hands of the scheduler whi=
le
the MMC layer will only have to send this list as a packed command.

>> >> > + =A0 =A0 =A0 if (rqc)
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reqs =3D mmc_blk_chk_packable(mq,=
 rqc);

It would be best to keep all the calls to blk_fetch_request in the same
location. Therefore, I suggest to move the call to mmc_blk_chk_packable=
 to
mmc/card/queue.c after the first request is fetched.

>> >> > =A0cmd_abort:
>> >> > - =A0 =A0 =A0 spin_lock_irq(&md->lock);
>> >> > - =A0 =A0 =A0 while (ret)
>> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D __blk_end_request(req, -E=
IO,
>> blk_rq_cur_bytes(req));
>> >> > - =A0 =A0 =A0 spin_unlock_irq(&md->lock);
>> >> > + =A0 =A0 =A0 if (mq_rq->packed_cmd !=3D MMC_PACKED_NONE) {

This should be the case for MMC_PACKED_NONE.

>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irq(&md->lock);
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (ret)
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D __blk_end=
_request(req, -EIO,
>> blk_rq_cur_bytes(req));

Do we need the while or should it be an if? In other cases where
__blk_end_request is called there is no such while.

Thanks,
Maya Erez
Consultant for Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum




