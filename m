From: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>
Subject: RE: [PATCH v2] mmc: support BKOPS feature for eMMC
Date: Fri, 11 Nov 2011 14:51:49 +0800
Message-ID: <5D8008F58939784290FAB48F549751984E50599817@shsmsx502.ccr.corp.intel.com>
References: <4EB11B6B.2010909@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:23403 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751231Ab1KKGwn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Nov 2011 01:52:43 -0500
In-Reply-To: <4EB11B6B.2010909@samsung.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Jae hoon Chung <jh80.chung@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Hanumath Prasad <hanumath.prasad@stericsson.com>, Sebastian Rasmussen <sebras@gmail.com>, Per Forlin <per.lkml@gmail.com>, "svenkatr@ti.com" <svenkatr@ti.com>

Hi Jaehoon,

> -----Original Message-----
> From: Jaehoon Chung [mailto:jh80.chung@samsung.com]
> Sent: Wednesday, November 02, 2011 6:29 PM
> To: linux-mmc
> Cc: Chris Ball; Kyungmin Park; Hanumath Prasad; Sebastian Rasmussen; Per Forlin;
> svenkatr@ti.com; Dong, Chuanxiao
> Subject: [PATCH v2] mmc: support BKOPS feature for eMMC
> 
> Enable eMMC background operations (BKOPS) feature.
> 
> If URGENT_BKOPS is set after a response, note that BKOPS
> are required. After all I/O requests are finished, run
> BKOPS if required. Should read/write operations be requested
> during BKOPS, first issue HPI to interrupt the ongoing BKOPS
> and then service the request.
> 
> If you want to enable this feature, set MMC_CAP2_BKOPS.
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> CC: Hanumath Prasad <hanumath.prasad@stericsson.com>
> 
> ---
> Changelog V2:
> 	- Use EXCEPTION_STATUS instead of URGENT_BKOPS
> 	- Add function to check Exception_status(for eMMC4.5)
> 	- remove unnecessary code.
> 
>  drivers/mmc/card/block.c   |    9 +++++
>  drivers/mmc/card/queue.c   |    4 ++
>  drivers/mmc/core/core.c    |   87
> ++++++++++++++++++++++++++++++++++++++++++++
>  drivers/mmc/core/mmc.c     |    9 ++++-
>  drivers/mmc/core/mmc_ops.c |    4 ++
>  include/linux/mmc/card.h   |   12 ++++++
>  include/linux/mmc/core.h   |    3 ++
>  include/linux/mmc/host.h   |    1 +
>  include/linux/mmc/mmc.h    |   14 +++++++
>  9 files changed, 142 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index a1cb21f..fbfb405 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -1192,6 +1192,15 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue
> *mq, struct request *rqc)
>  		case MMC_BLK_SUCCESS:
>  		case MMC_BLK_PARTIAL:
>  			/*
> +			 * Check BKOPS urgency from each R1 response
> +			 */
> +			if (mmc_card_mmc(card) &&
> +				(brq->cmd.resp[0] & R1_EXCEPTION_EVENT)) {
> +				if (mmc_is_exception_event(card,
> +						EXT_CSD_URGENT_BKOPS))
> +					mmc_card_set_need_bkops(card);
> +			}
> +			/*
Have you thought about moving this into mmc_wait_for_req_done()? We can check if the command is a R1 or R1B or not, and set BKOPS bit in there if needed. I was just thinking if we put such code here, we may only cover the successful scenario but not for the failed cases. Putting in mmc_wait_for_req_done can cover all cases.

Thanks
Chuanxiao
