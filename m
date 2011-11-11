From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH 2/2] mmc: core: Support packed command for eMMC4.5 device
Date: Fri, 11 Nov 2011 16:26:26 +0900
Message-ID: <001001cca043$395dbfc0$ac193f40$%jun@samsung.com>
References: <620ec9ffa6bdbba9ae5f76998e36f8dc.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <620ec9ffa6bdbba9ae5f76998e36f8dc.squirrel@www.codeaurora.org>
Content-language: ko
Sender: linux-kernel-owner@vger.kernel.org
To: merez@codeaurora.org
Cc: "'S, Venkatraman'" <svenkatr@ti.com>, linux-mmc@vger.kernel.org, 'Chris Ball' <cjb@laptop.org>, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, dh.han@samsung.com
List-Id: linux-mmc@vger.kernel.org

Maya Erez wrote:
> On Thu, Nov 10, 2011 Maya Erez wrote:
> > S, Venkatraman <svenkatr@ti.com> wrote:
> >> On Thu, Nov 3, 2011 at 7:23 AM, Seungwon Jeon <tgih.jun@samsung.co=
m>
> wrote:
> >> >> > +static u8 mmc_blk_chk_packable(struct mmc_queue *mq, struct
> >> request *req)
>=20
> The function prepares the checkable list and not only checks if packi=
ng is
> possible, therefore I think its name should change to reflect its rea=
l
> action
I labored at naming. Isn't it proper? :)
Do you have any recommendation?
group_pack_req?

>=20
> >> >> > + =A0 =A0 =A0 if (!(md->flags & MMC_BLK_CMD23) &&
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !card->ext_csd.=
packed_event_en)
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto no_packed;
>=20
> Having the condition with a && can lead to cases where CMD23 is not
> supported and we send packed commands. Therfore the condition should =
be
> changed to || or be splitted to 2 separate checks.
> Also, according to the standard the generic error flag in
> PACKED_COMMAND_STATUS is set in case of any error and having
> PACKED_EVENT_EN is only optional. Therefore, I don't think that setti=
ng
> the packed_event_en should be a mandatory condition for using packed
> coammnds.
=2E.. cases where CMD23 is not supported and we send packed commands?
Packed command must not be allowed in such a case.
It works only with predefined mode which is essential fator.
And spec doesn't mentioned PACKED_EVENT_EN must be set.
So Packed command can be sent regardless PACKED_EVENT_EN,
but it's not complete without reporting of error.
Then host driver may suffer error recovery.
Why packed command is used without error reporting?

>=20
> >> >> > + =A0 =A0 =A0 if (mmc_req_rel_wr(cur) &&
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (md->flags & MM=
C_BLK_REL_WR) &&
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !en_rel_wr) {
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto no_packed;
> >> >> > + =A0 =A0 =A0 }
>=20
> Can you please explain this condition and its purpose?
>=20
In the case where reliable write is request but enhanced reliable write
is not supported, write access must be partial according to
reliable write sector count. Because even a single request can be split=
,
packed command is not allowed in this case.

> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 phys_segments +=3D =A0next->nr_=
phys_segments;
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (phys_segments > max_phys_se=
gs) {
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 blk_requeue_req=
uest(q, next);
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> >> >> I mentioned this before - if the next request is not packable a=
nd
> >> requeued,
> >> >> blk_fetch_request will retrieve it again and this while loop wi=
ll
> never terminate.
> >> >>
> >> > If next request is not packable, it is requeued and 'break'
> terminates
> >> this loop.
> >> > So it not infinite.
> >> Right !! But that doesn't help finding the commands that are packa=
ble.
> Ideally, you'd need to pack all neighbouring requests into one packed
> command.
> >> The way CFQ works, it is not necessary that the fetch would return=
 all
> outstanding
> >> requests that are packable (unless you invoke a forced dispatch) I=
t
> would be good to see some numbers on the number of pack hits /
> misses
> >> that
> >> you would encounter with this logic, on a typical usecase.
> > Is it considered only for CFQ scheduler? How about other I/O schedu=
ler?
> If all requests are drained from scheduler queue forcedly,
> > the number of candidate to be packed can be increased.
> > However we may lose the unique CFQ's strength and MMC D/D may take =
the
> CFQ's duty.
> > Basically, this patch accommodates the origin order requests from I=
/O
> scheduler.
> >
>=20
> In order to better utilize the packed commands feature and achieve th=
e
> best performance improvements I think that the command packing should=
 be
> done in the block layer, according to the scheduler policy.
> That is, the scheduler should be aware of the capability of the devic=
e to
> receive a request list and its constrains (such as maximum number of
> requests, max number of sectors etc) and use this information as a  f=
actor
> to its algorithm.
> This way you keep the decision making in the hands of the scheduler w=
hile
> the MMC layer will only have to send this list as a packed command.
>=20
Yes, it would be another interesting approach.
Command packing you mentioned means gathering request among same direct=
ion(read/write)?
Currently I/O scheduler may know device constrains which MMC driver inf=
orms
with the exception of order information for packed command.
But I think the dependency of I/O scheduler may be able to come up.
How can MMC layer treat packed command with I/O scheduler which doesn't=
 support this?

> >> >> > + =A0 =A0 =A0 if (rqc)
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reqs =3D mmc_blk_chk_packable(m=
q, rqc);
>=20
> It would be best to keep all the calls to blk_fetch_request in the sa=
me
> location. Therefore, I suggest to move the call to mmc_blk_chk_packab=
le to
> mmc/card/queue.c after the first request is fetched.

At the first time, I considered that way.
I'll do more, if possible.
>=20
> >> >> > =A0cmd_abort:
> >> >> > - =A0 =A0 =A0 spin_lock_irq(&md->lock);
> >> >> > - =A0 =A0 =A0 while (ret)
> >> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D __blk_end_request(req, =
-EIO,
> >> blk_rq_cur_bytes(req));
> >> >> > - =A0 =A0 =A0 spin_unlock_irq(&md->lock);
> >> >> > + =A0 =A0 =A0 if (mq_rq->packed_cmd !=3D MMC_PACKED_NONE) {
>=20
> This should be the case for MMC_PACKED_NONE.
Right, I missed it.
>=20
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irq(&md->lock);
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (ret)
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D __blk_e=
nd_request(req, -EIO,
> >> blk_rq_cur_bytes(req));
>=20
> Do we need the while or should it be an if? In other cases where
> __blk_end_request is called there is no such while.
This part is not only the new but also origin code which is moved in th=
is patch.
Maybe...,'If' case is used  for a whole of remained bytes and
'while' case is used for partial report of remained bytes.

Thank you for review.

Best regards,
Seugwon Jeon.
>=20
> Thanks,
> Maya Erez
> Consultant for Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
>=20
>=20
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
