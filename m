From: Per Forlin <per.lkml@gmail.com>
Subject: Re: [PATCH v2] mmc: support BKOPS feature for eMMC
Date: Fri, 11 Nov 2011 08:48:44 +0100
Message-ID: <CAFEEs1nnXbin+R65LPVzDpmyOA0TCeAR_LwgKknys_9n6kcgoA@mail.gmail.com>
References: <4EB11B6B.2010909@samsung.com>
	<5D8008F58939784290FAB48F549751984E50599817@shsmsx502.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:41425 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751596Ab1KKHso convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Nov 2011 02:48:44 -0500
Received: by vws1 with SMTP id 1so3184425vws.19
        for <linux-mmc@vger.kernel.org>; Thu, 10 Nov 2011 23:48:44 -0800 (PST)
In-Reply-To: <5D8008F58939784290FAB48F549751984E50599817@shsmsx502.ccr.corp.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Jae hoon Chung <jh80.chung@gmail.com>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Hanumath Prasad <hanumath.prasad@stericsson.com>, Sebastian Rasmussen <sebras@gmail.com>, "svenkatr@ti.com" <svenkatr@ti.com>

On Fri, Nov 11, 2011 at 7:51 AM, Dong, Chuanxiao
<chuanxiao.dong@intel.com> wrote:
> Hi Jaehoon,
>
>> -----Original Message-----
>> From: Jaehoon Chung [mailto:jh80.chung@samsung.com]
>> Sent: Wednesday, November 02, 2011 6:29 PM
>> To: linux-mmc
>> Cc: Chris Ball; Kyungmin Park; Hanumath Prasad; Sebastian Rasmussen;=
 Per Forlin;
>> svenkatr@ti.com; Dong, Chuanxiao
>> Subject: [PATCH v2] mmc: support BKOPS feature for eMMC
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
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> CC: Hanumath Prasad <hanumath.prasad@stericsson.com>
>>
>> ---
>> Changelog V2:
>> =A0 =A0 =A0 - Use EXCEPTION_STATUS instead of URGENT_BKOPS
>> =A0 =A0 =A0 - Add function to check Exception_status(for eMMC4.5)
>> =A0 =A0 =A0 - remove unnecessary code.
>>
>> =A0drivers/mmc/card/block.c =A0 | =A0 =A09 +++++
>> =A0drivers/mmc/card/queue.c =A0 | =A0 =A04 ++
>> =A0drivers/mmc/core/core.c =A0 =A0| =A0 87
>> ++++++++++++++++++++++++++++++++++++++++++++
>> =A0drivers/mmc/core/mmc.c =A0 =A0 | =A0 =A09 ++++-
>> =A0drivers/mmc/core/mmc_ops.c | =A0 =A04 ++
>> =A0include/linux/mmc/card.h =A0 | =A0 12 ++++++
>> =A0include/linux/mmc/core.h =A0 | =A0 =A03 ++
>> =A0include/linux/mmc/host.h =A0 | =A0 =A01 +
>> =A0include/linux/mmc/mmc.h =A0 =A0| =A0 14 +++++++
>> =A09 files changed, 142 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>> index a1cb21f..fbfb405 100644
>> --- a/drivers/mmc/card/block.c
>> +++ b/drivers/mmc/card/block.c
>> @@ -1192,6 +1192,15 @@ static int mmc_blk_issue_rw_rq(struct mmc_que=
ue
>> *mq, struct request *rqc)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 case MMC_BLK_SUCCESS:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 case MMC_BLK_PARTIAL:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Check BKOPS urgency f=
rom each R1 response
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc_card_mmc(card) &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (brq->cmd.=
resp[0] & R1_EXCEPTION_EVENT)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc_is=
_exception_event(card,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 EXT_CSD_URGENT_BKOPS))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 mmc_card_set_need_bkops(card);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> Have you thought about moving this into mmc_wait_for_req_done()? We c=
an check if the command is a R1 or R1B or not, and set BKOPS bit in the=
re if needed. I was just thinking if we put such code here, we may only=
 cover the successful scenario but not for the failed cases. Putting in=
 mmc_wait_for_req_done can cover all cases.
>
Good point! I'm in favor of this change.

Thanks,
Per
