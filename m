From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH v2 1/1] mmc: block: Add write packing control
Date: Mon, 11 Jun 2012 20:09:18 +0530
Message-ID: <CANfBPZ8m9AHJfZ8DOCA_Qz36hBa9-Vo-uyAT+H1OFeKUmLfmtA@mail.gmail.com>
References: <1338576911-17089-1-git-send-email-merez@codeaurora.org>
 <1338576911-17089-2-git-send-email-merez@codeaurora.org> <007c01cd455a$56392050$02ab60f0$%jun@samsung.com>
 <780c1dad11fe08de17a3ff41b22ba3b8.squirrel@www.codeaurora.org>
 <000a01cd47b2$05982420$10c86c60$%jun@samsung.com> <453f08411c87367450f544d288745bee.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <453f08411c87367450f544d288745bee.squirrel@www.codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: merez@codeaurora.org
Cc: Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, DOCUMENTATION' <linux-doc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Mon, Jun 11, 2012 at 7:25 PM,  <merez@codeaurora.org> wrote:
>
>> Maya Erez <merez@codeaurora.org> wrote:
>>>
>>> > Hi,
>>> >
>>> > How can we check the effect?
>>> > Do you have any result?
>>> We ran parallel lmdd read and write operations and found out that t=
he
>>> write packing causes the read throughput to drop from 24MB/s to 12M=
B/s.
>>> The write packing control managed to increase the read throughput b=
ack
>>> to
>>> the original value.
>>> We also examined "real life" scenarios, such as performing a big pu=
sh
>>> operation in parallel to launching several applications. We measure=
d the
>>> read latency and found out that with the write packing control the =
worst
>>> case of the read latency was smaller.
>>>
>>> > Please check the several comment below.
>>> >
>>> > Maya Erez <merez@codeaurora.org> wrote:
>>> >> The write packing control will ensure that read requests latency=
 is
>>> >> not increased due to long write packed commands.
>>> >>
>>> >> The trigger for enabling the write packing is managing to pack
>>> several
>>> >> write requests. The number of potential packed requests that wil=
l
>>> >> trigger
>>> >> the packing can be configured via sysfs by writing the required =
value
>>> >> to:
>>> >> /sys/block/<block_dev_name>/num_wr_reqs_to_start_packing.
>>> >> The trigger for disabling the write packing is fetching a read
>>> request.
>>> >>
>>> >> ---
>>> >> =A0Documentation/mmc/mmc-dev-attrs.txt | =A0 17 ++++++
>>> >> =A0drivers/mmc/card/block.c =A0 =A0 =A0 =A0 =A0 =A0| =A0100
>>> >> ++++++++++++++++++++++++++++++++++-
>>> >> =A0drivers/mmc/card/queue.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A08 ++=
+
>>> >> =A0drivers/mmc/card/queue.h =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A03 +
>>> >> =A0include/linux/mmc/host.h =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A01 +
>>> >> =A05 files changed, 128 insertions(+), 1 deletions(-)
>>> >>
>>> >> diff --git a/Documentation/mmc/mmc-dev-attrs.txt
>>> >> b/Documentation/mmc/mmc-dev-attrs.txt
>>> >> index 22ae844..08f7312 100644
>>> >> --- a/Documentation/mmc/mmc-dev-attrs.txt
>>> >> +++ b/Documentation/mmc/mmc-dev-attrs.txt
>>> >> @@ -8,6 +8,23 @@ The following attributes are read/write.
>>> >>
>>> >> =A0 force_ro =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Enforce read-only ac=
cess even if write protect switch is
>>> >> off.
>>> >>
>>> >> + num_wr_reqs_to_start_packing =A0 =A0This attribute is used to =
determine
>>> >> + the trigger for activating the write packing, in case the writ=
e
>>> >> + packing control feature is enabled.
>>> >> +
>>> >> + When the MMC manages to reach a point where
>>> >> num_wr_reqs_to_start_packing
>>> >> + write requests could be packed, it enables the write packing
>>> feature.
>>> >> + This allows us to start the write packing only when it is
>>> beneficial
>>> >> + and has minimum affect on the read latency.
>>> >> +
>>> >> + The number of potential packed requests that will trigger the
>>> packing
>>> >> + can be configured via sysfs by writing the required value to:
>>> >> + /sys/block/<block_dev_name>/num_wr_reqs_to_start_packing.
>>> >> +
>>> >> + The default value of num_wr_reqs_to_start_packing was determin=
ed by
>>> >> + running parallel lmdd write and lmdd read operations and
>>> calculating
>>> >> + the max number of packed writes requests.
>>> >> +
>>> >> =A0SD and MMC Device Attributes
>>> >> =A0=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>>> >>
>>> >> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>>> >> index 2785fd4..ef192fb 100644
>>> >> --- a/drivers/mmc/card/block.c
>>> >> +++ b/drivers/mmc/card/block.c
>>> >> @@ -114,6 +114,7 @@ struct mmc_blk_data {
>>> >> =A0 struct device_attribute force_ro;
>>> >> =A0 struct device_attribute power_ro_lock;
>>> >> =A0 int =A0 =A0 area_type;
>>> >> + struct device_attribute num_wr_reqs_to_start_packing;
>>> >> =A0};
>>> >>
>>> >> =A0static DEFINE_MUTEX(open_lock);
>>> >> @@ -281,6 +282,38 @@ out:
>>> >> =A0 return ret;
>>> >> =A0}
>>> >>
>>> >> +static ssize_t
>>> >> +num_wr_reqs_to_start_packing_show(struct device *dev,
>>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct dev=
ice_attribute *attr, char *buf)
>>> >> +{
>>> >> + struct mmc_blk_data *md =3D mmc_blk_get(dev_to_disk(dev));
>>> >> + int num_wr_reqs_to_start_packing;
>>> >> + int ret;
>>> >> +
>>> >> + num_wr_reqs_to_start_packing =3D
>>> md->queue.num_wr_reqs_to_start_packing;
>>> >> +
>>> >> + ret =3D snprintf(buf, PAGE_SIZE, "%d\n",
>>> num_wr_reqs_to_start_packing);
>>> >> +
>>> >> + mmc_blk_put(md);
>>> >> + return ret;
>>> >> +}
>>> >> +
>>> >> +static ssize_t
>>> >> +num_wr_reqs_to_start_packing_store(struct device *dev,
>>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct devi=
ce_attribute *attr,
>>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const char =
*buf, size_t count)
>>> >> +{
>>> >> + int value;
>>> >> + struct mmc_blk_data *md =3D mmc_blk_get(dev_to_disk(dev));
>>> >> +
>>> >> + sscanf(buf, "%d", &value);
>>> >> + if (value >=3D 0)
>>> >> + =A0 =A0 =A0 =A0 md->queue.num_wr_reqs_to_start_packing =3D val=
ue;
>>> >> +
>>> >> + mmc_blk_put(md);
>>> >> + return count;
>>> >> +}
>>> >> +
>>> >> =A0static int mmc_blk_open(struct block_device *bdev, fmode_t mo=
de)
>>> >> =A0{
>>> >> =A0 struct mmc_blk_data *md =3D mmc_blk_get(bdev->bd_disk);
>>> >> @@ -1313,6 +1346,48 @@ static void mmc_blk_rw_rq_prep(struct
>>> >> mmc_queue_req *mqrq,
>>> >> =A0 mmc_queue_bounce_pre(mqrq);
>>> >> =A0}
>>> >>
>>> >> +static void mmc_blk_write_packing_control(struct mmc_queue *mq,
>>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 struct request *req)
>>> >> +{
>>> >> + struct mmc_host *host =3D mq->card->host;
>>> >> + int data_dir;
>>> >> +
>>> >> + if (!(host->caps2 & MMC_CAP2_PACKED_WR))
>>> >> + =A0 =A0 =A0 =A0 return;
>>> >> +
>>> >> + /*
>>> >> + =A0* In case the packing control is not supported by the host,=
 it
>>> should
>>> >> + =A0* not have an effect on the write packing. Therefore we hav=
e to
>>> >> enable
>>> >> + =A0* the write packing
>>> >> + =A0*/
>>> >> + if (!(host->caps2 & MMC_CAP2_PACKED_WR_CONTROL)) {
>>> >> + =A0 =A0 =A0 =A0 mq->wr_packing_enabled =3D true;
>>> >> + =A0 =A0 =A0 =A0 return;
>>> >> + }
>>> >> +
>>> >> + if (!req || (req && (req->cmd_flags & REQ_FLUSH))) {
>>> >> + =A0 =A0 =A0 =A0 if (mq->num_of_potential_packed_wr_reqs >
>>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mq->num_wr_req=
s_to_start_packing)
>>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mq->wr_packing_enabled =3D tru=
e;
>>> >> + =A0 =A0 =A0 =A0 return;
>>> >> + }
>>> >> +
>>> >> + data_dir =3D rq_data_dir(req);
>>> >> +
>>> >> + if (data_dir =3D=3D READ) {
>>> >> + =A0 =A0 =A0 =A0 mq->num_of_potential_packed_wr_reqs =3D 0;
>>> >> + =A0 =A0 =A0 =A0 mq->wr_packing_enabled =3D false;
>>> >> + =A0 =A0 =A0 =A0 return;
>>> >> + } else if (data_dir =3D=3D WRITE) {
>>> >> + =A0 =A0 =A0 =A0 mq->num_of_potential_packed_wr_reqs++;
>>> >> + }
>>> >> +
>>> >> + if (mq->num_of_potential_packed_wr_reqs >
>>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mq->num_wr_reqs_to_start_packi=
ng)
>>> >> + =A0 =A0 =A0 =A0 mq->wr_packing_enabled =3D true;
>>> > Write Packing is available only if continuing write requests are =
over
>>> > num_wr_reqs_to_start_packing?
>>> > That means individual request(1...17) will be issued with non-pac=
king.
>>> > Could you explain your policy more?
>>> We try to identify the case where there is parallel read and write
>>> operations. In our experiments we found out that the number of writ=
e
>>> requests between read requests in parallel read and write operation=
s
>>> doesn't exceed 17 requests. Therefore, we can assume that fetching =
more
>>> than 17 write requests without hitting a read request can indicate =
that
>>> there is no read activity.
>> We can apply this experiment regardless I/O scheduler?
>> Which I/O scheduler was used with this experiment?
> The experiment was performed with the CFQ scheduler. Since the deadli=
ne
> uses a batch of 16 requests it should also fit the deadline scheduler=
=2E
> In case another value is required, this value can be changed via sysf=
s.
>>
>>> You are right that this affects the write throughput a bit but the =
goal
>>> of
>>> this algorithm is to make sure the read throughput and latency are =
not
>>> decreased due to write. If this is not the desired result, this
>>> algorithm
>>> can be disabled.
>>> >> +
>>> >> +}
>>> >> +
>>> >> =A0static u8 mmc_blk_prep_packed_list(struct mmc_queue *mq, stru=
ct
>>> request
>>> >> *req)
>>> >> =A0{
>>> >> =A0 struct request_queue *q =3D mq->queue;
>>> >> @@ -1332,6 +1407,9 @@ static u8 mmc_blk_prep_packed_list(struct
>>> >> mmc_queue *mq, struct request *req)
>>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !card->ext_csd.packed_event_=
en)
>>> >> =A0 =A0 =A0 =A0 =A0 goto no_packed;
>>> >>
>>> >> + if (!mq->wr_packing_enabled)
>>> >> + =A0 =A0 =A0 =A0 goto no_packed;
>>> > If wr_packing_enabled is set to true, several write requests can =
be
>>> > packed.
>>> > We don't need to consider read request since packed write?
>>> I'm not sure I understand the question. We check if there was a rea=
d
>>> request in the mmc_blk_write_packing_control, and in such a case se=
t
>>> mq->wr_packing_enabled to false.
>>> If I didn't answer the question, please explain it again.
>> Packed write can be possible after exceeding 17 requests.
>> Is it assured that read request doesn't follow immediately after pac=
ked
>> write?
>> I wonder this case.
> Currently in such a case we will send the packed command followed by =
the
> read request. The latency of this read request will be high due to wa=
iting
> for the completion of the packed write. However, since we will disabl=
e the
> write packing, the latency of the following read requests will be low=
=2E
> We are working on a solution where the read request will bypass the w=
rite
> requests in such a case. This change requires modification of the
> scheduler in order to re-insert the write requests to the scheduler.
>>

Thats the precise reason for using foreground HPI (shameless plug :-))
I understand the intent of write packing control, but using the number
of requests
as a metric is too coarse. Some writes could be for only one sector
(512B) and others
could be in 512KB or more, giving a 1000x variance.

=46oreground HPI solves this problem by interrupting only on a wait thr=
eshold.

Another aspect is that if a packed write is in progress, and you have
a read request,
you will most likely disable packing for the _next_ write, not the
ongoing one, right ?
That's too late an intervention IMHO.
