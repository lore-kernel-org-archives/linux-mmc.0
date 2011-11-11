From: merez@codeaurora.org
Subject: Re: [PATCH 2/2] mmc: core: Support packed command for eMMC4.5
     device
Date: Fri, 11 Nov 2011 11:01:22 -0800 (PST)
Message-ID: <ea21d88d904af165cb911354e3f51ea6.squirrel@www.codeaurora.org>
References: <620ec9ffa6bdbba9ae5f76998e36f8dc.squirrel@www.codeaurora.org>
    <001001cca043$395dbfc0$ac193f40$%jun@samsung.com>
    <CANfBPZ-Zn+R4GosEL-RJxh8gduAr8e+qN876uPwDkHfiEpdERw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CANfBPZ-Zn+R4GosEL-RJxh8gduAr8e+qN876uPwDkHfiEpdERw@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: "S, Venkatraman" <svenkatr@ti.com>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, merez@codeaurora.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, dh.han@samsung.com
List-Id: linux-mmc@vger.kernel.org

> On Fri, Nov 11, 2011 at 12:56 PM, Seungwon Jeon <tgih.jun@samsung.com=
>
> wrote:
>> Maya Erez wrote:
>>> On Thu, Nov 10, 2011 Maya Erez wrote:
>>> > S, Venkatraman <svenkatr@ti.com> wrote:
>>> >> On Thu, Nov 3, 2011 at 7:23 AM, Seungwon Jeon <tgih.jun@samsung.=
com>
>>> wrote:
>>> >> >> > +static u8 mmc_blk_chk_packable(struct mmc_queue *mq, struc=
t
>>> >> request *req)
>>>
>>> The function prepares the checkable list and not only checks if pac=
king
>>> is
>>> possible, therefore I think its name should change to reflect its r=
eal
>>> action
>> I labored at naming. Isn't it proper? :)
>> Do you have any recommendation?
>> group_pack_req?
>>
>>>
>>> >> >> > + =A0 =A0 =A0 if (!(md->flags & MMC_BLK_CMD23) &&
>>> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !card->ext_cs=
d.packed_event_en)
>>> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto no_packed;
>>>
>>> Having the condition with a && can lead to cases where CMD23 is not
>>> supported and we send packed commands. Therfore the condition shoul=
d be
>>> changed to || or be splitted to 2 separate checks.
>>> Also, according to the standard the generic error flag in
>>> PACKED_COMMAND_STATUS is set in case of any error and having
>>> PACKED_EVENT_EN is only optional. Therefore, I don't think that set=
ting
>>> the packed_event_en should be a mandatory condition for using packe=
d
>>> coammnds.
>> ... cases where CMD23 is not supported and we send packed commands?
>> Packed command must not be allowed in such a case.
>> It works only with predefined mode which is essential fator.
>> And spec doesn't mentioned PACKED_EVENT_EN must be set.
>> So Packed command can be sent regardless PACKED_EVENT_EN,
>> but it's not complete without reporting of error.
>> Then host driver may suffer error recovery.
>> Why packed command is used without error reporting?
Let me better explain my comment:
If the first condition (!(md->flags & MMC_BLK_CMD23) is 1 (meaning
MMC_BLK_CMD23 flag is not set), then in case card->ext_csd.packed_event=
_en
is 1 the second condition will be 0 and we won't "goto no_packed;". In
this case, CMD_23 is not supported but we don't exit the function.
If you want both conditions to be mandatory you need to use here an ||.
>>
>>>
>>> >> >> > + =A0 =A0 =A0 if (mmc_req_rel_wr(cur) &&
>>> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (md->flags & =
MMC_BLK_REL_WR) &&
>>> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !en_rel_wr) {
>>> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto no_packed;
>>> >> >> > + =A0 =A0 =A0 }
>>>
>>> Can you please explain this condition and its purpose?
>>>
>> In the case where reliable write is request but enhanced reliable wr=
ite
>> is not supported, write access must be partial according to
>> reliable write sector count. Because even a single request can be sp=
lit,
>> packed command is not allowed in this case.
>>
>>> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 phys_segments +=3D =A0next->n=
r_phys_segments;
>>> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (phys_segments > max_phys_=
segs) {
>>> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 blk_requeue_r=
equest(q, next);
>>> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>>> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>> >> >> I mentioned this before - if the next request is not packable=
 and
>>> >> requeued,
>>> >> >> blk_fetch_request will retrieve it again and this while loop =
will
>>> never terminate.
>>> >> >>
>>> >> > If next request is not packable, it is requeued and 'break'
>>> terminates
>>> >> this loop.
>>> >> > So it not infinite.
>>> >> Right !! But that doesn't help finding the commands that are
>>> packable.
>>> Ideally, you'd need to pack all neighbouring requests into one pack=
ed
>>> command.
>>> >> The way CFQ works, it is not necessary that the fetch would retu=
rn
>>> all
>>> outstanding
>>> >> requests that are packable (unless you invoke a forced dispatch)=
 It
>>> would be good to see some numbers on the number of pack hits /
>>> misses
>>> >> that
>>> >> you would encounter with this logic, on a typical usecase.
>>> > Is it considered only for CFQ scheduler? How about other I/O
>>> scheduler?
>>> If all requests are drained from scheduler queue forcedly,
>>> > the number of candidate to be packed can be increased.
>>> > However we may lose the unique CFQ's strength and MMC D/D may tak=
e
>>> the
>>> CFQ's duty.
>>> > Basically, this patch accommodates the origin order requests from=
 I/O
>>> scheduler.
>>> >
>>>
>>> In order to better utilize the packed commands feature and achieve =
the
>>> best performance improvements I think that the command packing shou=
ld
>>> be
>>> done in the block layer, according to the scheduler policy.
>>> That is, the scheduler should be aware of the capability of the dev=
ice
>>> to
>>> receive a request list and its constrains (such as maximum number o=
f
>>> requests, max number of sectors etc) and use this information as a
>>> =A0factor
>>> to its algorithm.
>>> This way you keep the decision making in the hands of the scheduler
>>> while
>>> the MMC layer will only have to send this list as a packed command.
>>>
>> Yes, it would be another interesting approach.
>> Command packing you mentioned means gathering request among same
>> direction(read/write)?
>> Currently I/O scheduler may know device constrains which MMC driver
>> informs
>> with the exception of order information for packed command.
>> But I think the dependency of I/O scheduler may be able to come up.
>> How can MMC layer treat packed command with I/O scheduler which does=
n't
>> support this?
>
> The very act of packing presumes some sorting and re-ordering at the
> I/O scheduler level.
> When no such sorting is done (ex. noop), MMC should resort to
> non-packed execution, respecting the system configuration choice.
>
> Looking deeper into this, I think a better approach would be to set
> the prep_rq_fn of the request_queue, with a custom mmc function that
> decides if the requests are packable or not, and return a
> BLKPREP_DEFER for those that can't be packed.
>
>>
>>> >> >> > + =A0 =A0 =A0 if (rqc)
>>> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reqs =3D mmc_blk_chk_packable=
(mq, rqc);
>>>
>>> It would be best to keep all the calls to blk_fetch_request in the =
same
>>> location. Therefore, I suggest to move the call to mmc_blk_chk_pack=
able
>>> to
>>> mmc/card/queue.c after the first request is fetched.
>>
>> At the first time, I considered that way.
>> I'll do more, if possible.
>>>
>>> >> >> > =A0cmd_abort:
>>> >> >> > - =A0 =A0 =A0 spin_lock_irq(&md->lock);
>>> >> >> > - =A0 =A0 =A0 while (ret)
>>> >> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D __blk_end_request(req=
, -EIO,
>>> >> blk_rq_cur_bytes(req));
>>> >> >> > - =A0 =A0 =A0 spin_unlock_irq(&md->lock);
>>> >> >> > + =A0 =A0 =A0 if (mq_rq->packed_cmd !=3D MMC_PACKED_NONE) {
>>>
>>> This should be the case for MMC_PACKED_NONE.
>> Right, I missed it.
>>>
>>> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irq(&md->lock);
>>> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (ret)
>>> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D __blk=
_end_request(req, -EIO,
>>> >> blk_rq_cur_bytes(req));
>>>
>>> Do we need the while or should it be an if? In other cases where
>>> __blk_end_request is called there is no such while.
>> This part is not only the new but also origin code which is moved in
>> this patch.
>> Maybe...,'If' case is used =A0for a whole of remained bytes and
>> 'while' case is used for partial report of remained bytes.
>>
>> Thank you for review.
>>
>> Best regards,
>> Seugwon Jeon.
>>>
>>> Thanks,
>>> Maya Erez
>>> Consultant for Qualcomm Innovation Center, Inc.
>>> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
>>>
>>>
>>>
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc=
" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l
>>
>>
>
Thanks,
Maya Erez
Consultant for Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
