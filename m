From: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>
Subject: RE: [PATCH v2] mmc: support BKOPS feature for eMMC
Date: Fri, 11 Nov 2011 16:42:53 +0800
Message-ID: <5D8008F58939784290FAB48F549751984E505998DB@shsmsx502.ccr.corp.intel.com>
References: <4EB11B6B.2010909@samsung.com>
	<5D8008F58939784290FAB48F549751984E50599817@shsmsx502.ccr.corp.intel.com>
	<CAFEEs1nnXbin+R65LPVzDpmyOA0TCeAR_LwgKknys_9n6kcgoA@mail.gmail.com>
 <CAFEEs1nButHvQ7wLTAX6nO3MXyYfyBOJSK585pBrt9bbjRds5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:1454 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751083Ab1KKInT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Nov 2011 03:43:19 -0500
In-Reply-To: <CAFEEs1nButHvQ7wLTAX6nO3MXyYfyBOJSK585pBrt9bbjRds5A@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Per Forlin <per.lkml@gmail.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Jae hoon Chung <jh80.chung@gmail.com>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Hanumath Prasad <hanumath.prasad@stericsson.com>, Sebastian Rasmussen <sebras@gmail.com>, "svenkatr@ti.com" <svenkatr@ti.com>



> -----Original Message-----
> From: Per Forlin [mailto:per.lkml@gmail.com]
> Sent: Friday, November 11, 2011 4:32 PM
> To: Dong, Chuanxiao
> Cc: Jaehoon Chung; linux-mmc; Jae hoon Chung; Chris Ball; Kyungmin Pa=
rk;
> Hanumath Prasad; Sebastian Rasmussen; svenkatr@ti.com
> Subject: Re: [PATCH v2] mmc: support BKOPS feature for eMMC
>=20
> On Fri, Nov 11, 2011 at 8:48 AM, Per Forlin <per.lkml@gmail.com> wrot=
e:
> > On Fri, Nov 11, 2011 at 7:51 AM, Dong, Chuanxiao
> > <chuanxiao.dong@intel.com> wrote:
> >> Hi Jaehoon,
> >>
> >>> -----Original Message-----
> >>> From: Jaehoon Chung [mailto:jh80.chung@samsung.com]
> >>> Sent: Wednesday, November 02, 2011 6:29 PM
> >>> To: linux-mmc
> >>> Cc: Chris Ball; Kyungmin Park; Hanumath Prasad; Sebastian Rasmuss=
en; Per
> Forlin;
> >>> svenkatr@ti.com; Dong, Chuanxiao
> >>> Subject: [PATCH v2] mmc: support BKOPS feature for eMMC
> >>>
> >>> Enable eMMC background operations (BKOPS) feature.
> >>>
> >>> If URGENT_BKOPS is set after a response, note that BKOPS
> >>> are required. After all I/O requests are finished, run
> >>> BKOPS if required. Should read/write operations be requested
> >>> during BKOPS, first issue HPI to interrupt the ongoing BKOPS
> >>> and then service the request.
> >>>
> >>> If you want to enable this feature, set MMC_CAP2_BKOPS.
> >>>
> >>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> >>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> >>> CC: Hanumath Prasad <hanumath.prasad@stericsson.com>
> >>>
> >>> ---
> >>> Changelog V2:
> >>> =A0 =A0 =A0 - Use EXCEPTION_STATUS instead of URGENT_BKOPS
> >>> =A0 =A0 =A0 - Add function to check Exception_status(for eMMC4.5)
> >>> =A0 =A0 =A0 - remove unnecessary code.
> >>>
> >>> =A0drivers/mmc/card/block.c =A0 | =A0 =A09 +++++
> >>> =A0drivers/mmc/card/queue.c =A0 | =A0 =A04 ++
> >>> =A0drivers/mmc/core/core.c =A0 =A0| =A0 87
> >>> ++++++++++++++++++++++++++++++++++++++++++++
> >>> =A0drivers/mmc/core/mmc.c =A0 =A0 | =A0 =A09 ++++-
> >>> =A0drivers/mmc/core/mmc_ops.c | =A0 =A04 ++
> >>> =A0include/linux/mmc/card.h =A0 | =A0 12 ++++++
> >>> =A0include/linux/mmc/core.h =A0 | =A0 =A03 ++
> >>> =A0include/linux/mmc/host.h =A0 | =A0 =A01 +
> >>> =A0include/linux/mmc/mmc.h =A0 =A0| =A0 14 +++++++
> >>> =A09 files changed, 142 insertions(+), 1 deletions(-)
> >>>
> >>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> >>> index a1cb21f..fbfb405 100644
> >>> --- a/drivers/mmc/card/block.c
> >>> +++ b/drivers/mmc/card/block.c
> >>> @@ -1192,6 +1192,15 @@ static int mmc_blk_issue_rw_rq(struct
> mmc_queue
> >>> *mq, struct request *rqc)
> >>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 case MMC_BLK_SUCCESS:
> >>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 case MMC_BLK_PARTIAL:
> >>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> >>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Check BKOPS urgenc=
y from each R1 response
> >>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> >>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc_card_mmc(card) =
&&
> >>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (brq->c=
md.resp[0] &
> R1_EXCEPTION_EVENT)) {
> >>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc=
_is_exception_event(card,
> >>>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 EXT_CSD_URGENT_BK
> OPS))
> >>>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 mmc_card_set_need_bkops(card
> );
> >>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> >>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> >> Have you thought about moving this into mmc_wait_for_req_done()? W=
e can
> check if the command is a R1 or R1B or not, and set BKOPS bit in ther=
e if needed. I
> was just thinking if we put such code here, we may only cover the suc=
cessful
> scenario but not for the failed cases. Putting in mmc_wait_for_req_do=
ne can cover
> all cases.
> >>
> > Good point! I'm in favor of this change.
> Or, put the check before the switch-case.
If we put in mmc_wait_for_req_done, then we can catch all R1 response c=
ommand result not only for the READ/WRITE command, right? ERASE command=
 is also using R1 response. However, I am not sure whether ERASE comman=
d can set the BKOPS Urgent bit for us. Anyway, I agree putting before s=
witch-case is another good point.

Thanks
Chuanxiao
