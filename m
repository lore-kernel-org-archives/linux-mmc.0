From: Per Forlin <per.lkml@gmail.com>
Subject: Re: [PATCH v2] mmc: support BKOPS feature for eMMC
Date: Fri, 11 Nov 2011 09:32:12 +0100
Message-ID: <CAFEEs1nButHvQ7wLTAX6nO3MXyYfyBOJSK585pBrt9bbjRds5A@mail.gmail.com>
References: <4EB11B6B.2010909@samsung.com>
	<5D8008F58939784290FAB48F549751984E50599817@shsmsx502.ccr.corp.intel.com>
	<CAFEEs1nnXbin+R65LPVzDpmyOA0TCeAR_LwgKknys_9n6kcgoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:52977 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756576Ab1KKIcN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Nov 2011 03:32:13 -0500
Received: by vcbf1 with SMTP id f1so3199710vcb.19
        for <linux-mmc@vger.kernel.org>; Fri, 11 Nov 2011 00:32:12 -0800 (PST)
In-Reply-To: <CAFEEs1nnXbin+R65LPVzDpmyOA0TCeAR_LwgKknys_9n6kcgoA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Jae hoon Chung <jh80.chung@gmail.com>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Hanumath Prasad <hanumath.prasad@stericsson.com>, Sebastian Rasmussen <sebras@gmail.com>, "svenkatr@ti.com" <svenkatr@ti.com>

On Fri, Nov 11, 2011 at 8:48 AM, Per Forlin <per.lkml@gmail.com> wrote:
> On Fri, Nov 11, 2011 at 7:51 AM, Dong, Chuanxiao
> <chuanxiao.dong@intel.com> wrote:
>> Hi Jaehoon,
>>
>>> -----Original Message-----
>>> From: Jaehoon Chung [mailto:jh80.chung@samsung.com]
>>> Sent: Wednesday, November 02, 2011 6:29 PM
>>> To: linux-mmc
>>> Cc: Chris Ball; Kyungmin Park; Hanumath Prasad; Sebastian Rasmussen=
; Per Forlin;
>>> svenkatr@ti.com; Dong, Chuanxiao
>>> Subject: [PATCH v2] mmc: support BKOPS feature for eMMC
>>>
>>> Enable eMMC background operations (BKOPS) feature.
>>>
>>> If URGENT_BKOPS is set after a response, note that BKOPS
>>> are required. After all I/O requests are finished, run
>>> BKOPS if required. Should read/write operations be requested
>>> during BKOPS, first issue HPI to interrupt the ongoing BKOPS
>>> and then service the request.
>>>
>>> If you want to enable this feature, set MMC_CAP2_BKOPS.
>>>
>>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>>> CC: Hanumath Prasad <hanumath.prasad@stericsson.com>
>>>
>>> ---
>>> Changelog V2:
>>> =A0 =A0 =A0 - Use EXCEPTION_STATUS instead of URGENT_BKOPS
>>> =A0 =A0 =A0 - Add function to check Exception_status(for eMMC4.5)
>>> =A0 =A0 =A0 - remove unnecessary code.
>>>
>>> =A0drivers/mmc/card/block.c =A0 | =A0 =A09 +++++
>>> =A0drivers/mmc/card/queue.c =A0 | =A0 =A04 ++
>>> =A0drivers/mmc/core/core.c =A0 =A0| =A0 87
>>> ++++++++++++++++++++++++++++++++++++++++++++
>>> =A0drivers/mmc/core/mmc.c =A0 =A0 | =A0 =A09 ++++-
>>> =A0drivers/mmc/core/mmc_ops.c | =A0 =A04 ++
>>> =A0include/linux/mmc/card.h =A0 | =A0 12 ++++++
>>> =A0include/linux/mmc/core.h =A0 | =A0 =A03 ++
>>> =A0include/linux/mmc/host.h =A0 | =A0 =A01 +
>>> =A0include/linux/mmc/mmc.h =A0 =A0| =A0 14 +++++++
>>> =A09 files changed, 142 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>>> index a1cb21f..fbfb405 100644
>>> --- a/drivers/mmc/card/block.c
>>> +++ b/drivers/mmc/card/block.c
>>> @@ -1192,6 +1192,15 @@ static int mmc_blk_issue_rw_rq(struct mmc_qu=
eue
>>> *mq, struct request *rqc)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 case MMC_BLK_SUCCESS:
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 case MMC_BLK_PARTIAL:
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Check BKOPS urgency =
from each R1 response
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc_card_mmc(card) &&
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (brq->cmd=
=2Eresp[0] & R1_EXCEPTION_EVENT)) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc_i=
s_exception_event(card,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 EXT_CSD_URGENT_BKOPS))
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 mmc_card_set_need_bkops(card);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> Have you thought about moving this into mmc_wait_for_req_done()? We =
can check if the command is a R1 or R1B or not, and set BKOPS bit in th=
ere if needed. I was just thinking if we put such code here, we may onl=
y cover the successful scenario but not for the failed cases. Putting i=
n mmc_wait_for_req_done can cover all cases.
>>
> Good point! I'm in favor of this change.
Or, put the check before the switch-case.
