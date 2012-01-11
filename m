From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v5] mmc: support BKOPS feature for eMMC
Date: Wed, 11 Jan 2012 14:32:57 -0500
Message-ID: <m2r4z6dogm.fsf@bob.laptop.org>
References: <4F04F512.1020909@samsung.com>
	<CANfBPZ_b0ypRUrhJH4izFUOJmxg4fh5u1NM5ED6eSiKeVibyAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:35539 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932414Ab2AKTdU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Jan 2012 14:33:20 -0500
In-Reply-To: <CANfBPZ_b0ypRUrhJH4izFUOJmxg4fh5u1NM5ED6eSiKeVibyAg@mail.gmail.com>
	(Venkatraman S.'s message of "Wed, 11 Jan 2012 19:01:06 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "S, Venkatraman" <svenkatr@ti.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, Hanumath Prasad <hanumath.prasad@stericsson.com>, per.forlin@stericsson.com, Sebastian Rasmussen <sebras@gmail.com>, "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, Konstantin Dorfman <kdorfman@codeaurora.org>

Hi,

On Wed, Jan 11 2012, S, Venkatraman wrote:
> On Thu, Jan 5, 2012 at 6:25 AM, Jaehoon Chung <jh80.chung@samsung.com=
> wrote:
>>
>> Enable eMMC background operations (BKOPS) feature.
>>
>> If URGENT_BKOPS is set after a response, note that BKOPS
>> are required. After all I/O requests are finished, run
>> BKOPS if required. Should read/write operations be requested
>> during BKOPS, first issue HPI to interrupt the ongoing BKOPS
>> and then service the request.
>>
>> If you want to enable this feature, set MMC_CAP2_BKOPS.
>>
>> Future considerations
>> =C2=A0* Check BKOPS_LEVEL=3D1 and start BKOPS in a preventive manner=
=2E
>> =C2=A0* Interrupt ongoing BKOPS before powering off the card.
>> =C2=A0* How get BKOPS_STATUS value.(periodically send ext_csd comman=
d?)
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>> Changelog V5:
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0- Rebase based on the latest mmc-next.
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0- modify codes based-on Chris's comment
>> Changelog V4:
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0- Add mmc_read_bkops_status
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0- When URGENT_BKOPS(level2-3), didn't use=
 HPI command.
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0- In mmc_switch(), use R1B/R1 according t=
o level.
>> Changelog V3:
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0- move the bkops setting's location in mm=
c_blk_issue_rw_rq
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0- modify condition checking
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0- bkops_en is assigned ext_csd[EXT_CSD_BK=
OPS_EN] instead of "1"
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0- remove the unused code
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0- change pr_debug instead of pr_warn in m=
mc_send_hpi_cmd
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0- Add the Future consideration suggested =
by Per
>> Changelog V2:
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0- Use EXCEPTION_STATUS instead of URGENT_=
BKOPS
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0- Add function to check Exception_status(=
for eMMC4.5)
>>
>> =C2=A0drivers/mmc/card/block.c =C2=A0 | =C2=A0 11 +++++
>> =C2=A0drivers/mmc/card/queue.c =C2=A0 | =C2=A0 =C2=A03 +
>> =C2=A0drivers/mmc/core/core.c =C2=A0 =C2=A0| =C2=A0105
>> ++++++++++++++++++++++++++++++++++++++++++++
>> =C2=A0drivers/mmc/core/mmc.c =C2=A0 =C2=A0 | =C2=A0 =C2=A08 +++
>> =C2=A0drivers/mmc/core/mmc_ops.c | =C2=A0 12 +++++-
>> =C2=A0include/linux/mmc/card.h =C2=A0 | =C2=A0 13 +++++
>> =C2=A0include/linux/mmc/core.h =C2=A0 | =C2=A0 =C2=A04 ++
>> =C2=A0include/linux/mmc/host.h =C2=A0 | =C2=A0 =C2=A01 +
>> =C2=A0include/linux/mmc/mmc.h =C2=A0 =C2=A0| =C2=A0 19 ++++++++
>> =C2=A09 files changed, 175 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>> index 0cad48a..5e3c580 100644
>> --- a/drivers/mmc/card/block.c
>> +++ b/drivers/mmc/card/block.c
>> @@ -1273,6 +1273,17 @@ static int mmc_blk_issue_rw_rq(struct
>> mmc_queue *mq, struct request *rqc)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0type =3D rq_d=
ata_dir(req) =3D=3D READ ? MMC_BLK_READ : MMC_BLK_WRITE;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mmc_queue_bou=
nce_post(mq_rq);
>>
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Check BKO=
PS urgency from each R1 response
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (mmc_card_mmc(=
card) &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (brq->cmd.flags =3D=3D MMC_RSP_R1B ||
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0brq->cmd.flags =3D=3D MMC_RSP_R1) &&
>
> I tested this patch on my setup and this condition never hit, as othe=
r
> flags are also set in cmd.flags
> It should have been
> (brq->cmd.flags & MMC_RSP_R1B ||
>  brq->cmd.flags & MMC_RSP_R1)
>
>
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (brq->cmd.resp[0] & R1_EXCEPTION_EVENT)) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (mmc_is_exception_event(card,
>> EXT_CSD_URGENT_BKOPS))
>
> This causes a crash on my test setup. The next req is already given t=
o
> the controller (see the mmc_start_req call a few lines above) and a
> parallel request to read BKOPS_STATUS is interfering with it. This
> won't work with any host controller driver which implements async_req
> functions.
>
> But there is no need to read BKOPS_STATUS at this stage anyway. By
> checking R1_EXCEPTION_EVENT and the BKOPS bit inside the response, th=
e
> need to do BKOPS can be determined (as only a urgen_bkops state would
> trigger a R1_EXCEPTION_EVENT in the first place)

Thanks very much for testing!  I'll drop this from my 3.3 queue --
we can try it again for 3.4.

- Chris.
--=20
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
