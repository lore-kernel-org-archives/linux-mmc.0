From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH V4 09/11] mmc: block: Add CQE support
Date: Wed, 9 Aug 2017 08:55:57 +0800
Message-ID: <36302399-374a-424e-0a20-940174e92e60@rock-chips.com>
References: <1500630584-22852-1-git-send-email-adrian.hunter@intel.com>
 <1500630584-22852-10-git-send-email-adrian.hunter@intel.com>
 <AM4PR0401MB2324BC179C08C1CF2A2013E8908A0@AM4PR0401MB2324.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:41354 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751229AbdHIA4T (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Aug 2017 20:56:19 -0400
In-Reply-To: <AM4PR0401MB2324BC179C08C1CF2A2013E8908A0@AM4PR0401MB2324.eurprd04.prod.outlook.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Bough Chen <haibo.chen@nxp.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, shawn.lin@rock-chips.com, linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>

Hi,

On 2017/8/8 20:07, Bough Chen wrote:
>> -----Original Message-----
>> From: Adrian Hunter [mailto:adrian.hunter@intel.com]
>> Sent: Friday, July 21, 2017 5:50 PM
>> To: Ulf Hansson <ulf.hansson@linaro.org>
>> Cc: linux-mmc <linux-mmc@vger.kernel.org>; Bough Chen
>> <haibo.chen@nxp.com>; Alex Lemberg <alex.lemberg@sandisk.com>;
>> Mateusz Nowak <mateusz.nowak@intel.com>; Yuliy Izrailov
>> <Yuliy.Izrailov@sandisk.com>; Jaehoon Chung <jh80.chung@samsung.com>;
>> Dong Aisheng <dongas86@gmail.com>; Das Asutosh
>> <asutoshd@codeaurora.org>; Zhangfei Gao <zhangfei.gao@gmail.com>;
>> Dorfman Konstantin <kdorfman@codeaurora.org>; David Griego
>> <david.griego@linaro.org>; Sahitya Tummala <stummala@codeaurora.org>;
>> Harjani Ritesh <riteshh@codeaurora.org>; Venu Byravarasu
>> <vbyravarasu@nvidia.com>; Linus Walleij <linus.walleij@linaro.org>; Shawn Lin
>> <shawn.lin@rock-chips.com>
>> Subject: [PATCH V4 09/11] mmc: block: Add CQE support
>>
>> Add CQE support to the block driver, including:
>> 	- optionally using DCMD for flush requests
>> 	- manually issuing discard requests
>> 	- issuing read / write requests to the CQE
>> 	- supporting block-layer timeouts
>> 	- handling recovery
>> 	- supporting re-tuning
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> ---
>>   drivers/mmc/core/block.c | 195 ++++++++++++++++++++++++++++++++-
>>   drivers/mmc/core/block.h |   7 ++
>>   drivers/mmc/core/queue.c | 273
>> ++++++++++++++++++++++++++++++++++++++++++++++-
>>   drivers/mmc/core/queue.h |  42 +++++++-
>>   4 files changed, 510 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c index
>> 915290c74363..2d25115637b7 100644
>> --- a/drivers/mmc/core/block.c
>> +++ b/drivers/mmc/core/block.c
>> @@ -109,6 +109,7 @@ struct mmc_blk_data {
>>   #define MMC_BLK_WRITE		BIT(1)
>>   #define MMC_BLK_DISCARD		BIT(2)
>>   #define MMC_BLK_SECDISCARD	BIT(3)
>> +#define MMC_BLK_CQE_RECOVERY	BIT(4)
>>
>>   	/*
>>   	 * Only set in main mmc_blk_data associated @@ -1612,6 +1613,198
>> @@ static void mmc_blk_data_prep(struct mmc_queue *mq, struct
>> mmc_queue_req *mqrq,
>>   		*do_data_tag_p = do_data_tag;
>>   }
>>
>> +#define MMC_CQE_RETRIES 2


>> +		blk_queue_rq_timed_out(mq->queue, mmc_cqe_timed_out);
>> +		blk_queue_rq_timeout(mq->queue, 60 * HZ);
> 

------8<-------

> Hi Adrian,
> 
> These days I'm doing CMDQ stress test, and find one issue.
> On our i.MX8QXP-ARM2 board, the RAM is 3GB. eMMC is 32GB.
> I use command 'free -m' get the total memory is 2800M, and the free memory is 2500M.
> 
> I use 'mkfs.ext4' to format ext4 file system on the eMMC under HS400ES CMDQ mode, works fine.
> 
> When I use the following command to stress test CMDQ, it works fine.
> bonnie++ -d /run/media/mmcblk0p1/ -u 0:0 -s 2048 -r 1024
> 
> But when I change to use a large file size to do the same stress test, using
> bonnie++ -d /run/media/mmcblk0p1/ -u 0:0 -s 4096 -r 2048
> or
> bonnie++ -d /run/media/mmcblk0p1/ -u 0:0 -s 5600
> 
> I get the following dump message.  According to the log, mmc_cqe_timed_out() was trigged.
> Seems mmc was blocked in somewhere.
> Then I try to debug this issue, and open MMC_DEBUG in config, do the same test, print the detail
> Command sending information on the console, but finally can't reproduce.
> 
> Shawn,
> Can you have a try on your side?
> 

I think bonnie++ is almost the same disk test tool as iozone or fio. I
didn't saw this when testing CMDQ by fio, but I will try bonnie++ late
this week.


> 
> [  738.385610] mmc0: cqhci: timeout for tag 1
> [  738.389719] mmc0: cqhci: ============ CQHCI REGISTER DUMP ===========
> [  738.396164] mmc0: cqhci: Caps:      0x0000310a | Version:  0x00000510
> [  738.402601] mmc0: cqhci: Config:    0x00001001 | Control:  0x00000000
> [  738.409038] mmc0: cqhci: Int stat:  0x00000000 | Int enab: 0x00000006
> [  738.415475] mmc0: cqhci: Int sig:   0x00000006 | Int Coal: 0x00000000
> [  738.421913] mmc0: cqhci: TDL base:  0x9007a000 | TDL up32: 0x00000000
> [  738.428350] mmc0: cqhci: Doorbell:  0x1fffffff | TCN:      0x00000000
> [  738.434788] mmc0: cqhci: Dev queue: 0x1f7fffff | Dev Pend: 0x1fffefff
> [  738.441226] mmc0: cqhci: Task clr:  0x00000000 | SSC1:     0x00011000
> [  738.447663] mmc0: cqhci: SSC2:      0x00000001 | DCMD rsp: 0x00000800
> [  738.454100] mmc0: cqhci: RED mask:  0xfdf9a080 | TERRI:    0x00000000
> [  738.460538] mmc0: cqhci: Resp idx:  0x0000002f | Resp arg: 0x00000900
> [  738.466975] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
> [  738.473414] mmc0: sdhci: Sys addr:  0xb6512000 | Version:  0x00000002
> [  738.479850] mmc0: sdhci: Blk size:  0x00000200 | Blk cnt:  0x00000400
> [  738.486288] mmc0: sdhci: Argument:  0x000c0400 | Trn mode: 0x00000023
> [  738.492725] mmc0: sdhci: Present:   0x01fd858f | Host ctl: 0x00000030
> [  738.499162] mmc0: sdhci: Power:     0x00000002 | Blk gap:  0x00000080
> [  738.505600] mmc0: sdhci: Wake-up:   0x00000008 | Clock:    0x0000000f
> [  738.512037] mmc0: sdhci: Timeout:   0x0000008f | Int stat: 0x00000000
> [  738.518475] mmc0: sdhci: Int enab:  0x107f4000 | Sig enab: 0x107f4000
> [  738.524912] mmc0: sdhci: AC12 err:  0x00000000 | Slot int: 0x00000502
> [  738.531350] mmc0: sdhci: Caps:      0x07eb0000 | Caps_1:   0x8000b407
> [  738.537787] mmc0: sdhci: Cmd:       0x00002c1a | Max curr: 0x00ffffff
> [  738.544225] mmc0: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0xffffffff
> [  738.550662] mmc0: sdhci: Resp[2]:   0x328f5903 | Resp[3]:  0x00d02700
> [  738.557099] mmc0: sdhci: Host ctl2: 0x00000008
> [  738.561540] mmc0: sdhci: ADMA Err:  0x00000009 | ADMA Ptr: 0x90098400
> [  738.567975] mmc0: sdhci: ============================================
> [  738.574449] mmc0: running CQE recovery
> [  738.593643] mmc0: Unexpected interrupt 0x00004000.
> [  738.598436] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
> [  738.604881] mmc0: sdhci: Sys addr:  0x00000000 | Version:  0x00000002
> [  738.611318] mmc0: sdhci: Blk size:  0x00000200 | Blk cnt:  0x00000400
> [  738.617756] mmc0: sdhci: Argument:  0x01af6800 | Trn mode: 0x00000023
> [  738.624193] mmc0: sdhci: Present:   0x01fd8009 | Host ctl: 0x00000031
> [  738.630630] mmc0: sdhci: Power:     0x00000002 | Blk gap:  0x00000080
> [  738.637068] mmc0: sdhci: Wake-up:   0x00000008 | Clock:    0x0000000f
> [  738.643505] mmc0: sdhci: Timeout:   0x0000008f | Int stat: 0x00004000
> [  738.649943] mmc0: sdhci: Int enab:  0x007f1003 | Sig enab: 0x007f1003
> [  738.656380] mmc0: sdhci: AC12 err:  0x00000000 | Slot int: 0x00000502
> [  738.662818] mmc0: sdhci: Caps:      0x07eb0000 | Caps_1:   0x8000b407
> [  738.669255] mmc0: sdhci: Cmd:       0x00002d12 | Max curr: 0x00ffffff
> [  738.675693] mmc0: sdhci: Resp[0]:   0x00000c00 | Resp[1]:  0xffffffff
> [  738.682130] mmc0: sdhci: Resp[2]:   0x328f5903 | Resp[3]:  0x00d02700
> [  738.688566] mmc0: sdhci: Host ctl2: 0x00000008
> [  738.693008] mmc0: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0x00000000
> [  738.699443] mmc0: sdhci: ============================================
> [  738.715999] mmc0: Controller never released inhibit bit(s).
> [  738.721573] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
> [  738.728018] mmc0: sdhci: Sys addr:  0x00000000 | Version:  0x00000002
> [  738.734455] mmc0: sdhci: Blk size:  0x00000200 | Blk cnt:  0x00000400
> [  738.740892] mmc0: sdhci: Argument:  0x01af6800 | Trn mode: 0x00000023
> [  738.747330] mmc0: sdhci: Present:   0x01fd8009 | Host ctl: 0x00000031
> [  738.753767] mmc0: sdhci: Power:     0x00000002 | Blk gap:  0x00000080
> [  738.760204] mmc0: sdhci: Wake-up:   0x00000008 | Clock:    0x0000000f
> [  738.766642] mmc0: sdhci: Timeout:   0x0000008f | Int stat: 0x00004000
> [  738.773079] mmc0: sdhci: Int enab:  0x007f1003 | Sig enab: 0x007f1003
> [  738.779517] mmc0: sdhci: AC12 err:  0x00000000 | Slot int: 0x00000502
> [  738.785955] mmc0: sdhci: Caps:      0x07eb0000 | Caps_1:   0x8000b407
> [  738.792392] mmc0: sdhci: Cmd:       0x00002d12 | Max curr: 0x00ffffff
> [  738.798829] mmc0: sdhci: Resp[0]:   0x00000c00 | Resp[1]:  0xffffffff
> [  738.805266] mmc0: sdhci: Resp[2]:   0x328f5903 | Resp[3]:  0x00d02700
> [  738.811703] mmc0: sdhci: Host ctl2: 0x00000008
> [  738.816144] mmc0: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0x00000000
> [  738.822579] mmc0: sdhci: ============================================
> [  748.881580] mmc0: Timeout waiting for hardware interrupt.
> ......
> 
> 
>> +
>> +		host->cqe_recovery_notifier = mmc_cqe_recovery_notifier;
>> +	}
>> +
>>   	blk_queue_prep_rq(mq->queue, mmc_prep_request);
>>   	queue_flag_set_unlocked(QUEUE_FLAG_NONROT, mq->queue);
>>   	queue_flag_clear_unlocked(QUEUE_FLAG_ADD_RANDOM, mq-
>>> queue); @@ -280,9 +543,9 @@ int mmc_init_queue(struct mmc_queue *mq,
>> struct mmc_card *card,
>>
>>   	sema_init(&mq->thread_sem, 1);
>>
>> -	mq->thread = kthread_run(mmc_queue_thread, mq, "mmcqd/%d%s",
>> -		host->index, subname ? subname : "");
>> -
>> +	mq->thread = kthread_run(use_cqe ? mmc_cqe_thread :
>> mmc_queue_thread,
>> +				 mq, "mmcqd/%d%s", host->index,
>> +				 subname ? subname : "");
>>   	if (IS_ERR(mq->thread)) {
>>   		ret = PTR_ERR(mq->thread);
>>   		goto cleanup_queue;
>> diff --git a/drivers/mmc/core/queue.h b/drivers/mmc/core/queue.h index
>> 361b46408e0f..8e9273d977c0 100644
>> --- a/drivers/mmc/core/queue.h
>> +++ b/drivers/mmc/core/queue.h
>> @@ -7,6 +7,20 @@
>>   #include <linux/mmc/core.h>
>>   #include <linux/mmc/host.h>
>>
>> +enum mmc_issued {
>> +	MMC_REQ_STARTED,
>> +	MMC_REQ_BUSY,
>> +	MMC_REQ_FAILED_TO_START,
>> +	MMC_REQ_FINISHED,
>> +};
>> +
>> +enum mmc_issue_type {
>> +	MMC_ISSUE_SYNC,
>> +	MMC_ISSUE_DCMD,
>> +	MMC_ISSUE_ASYNC,
>> +	MMC_ISSUE_MAX,
>> +};
>> +
>>   static inline struct mmc_queue_req *req_to_mmc_queue_req(struct request
>> *rq)  {
>>   	return blk_mq_rq_to_pdu(rq);
>> @@ -53,6 +67,7 @@ struct mmc_queue_req {
>>   	int			drv_op_result;
>>   	struct mmc_blk_ioc_data	**idata;
>>   	unsigned int		ioc_count;
>> +	int			retries;
>>   };
>>
>>   struct mmc_queue {
>> @@ -70,10 +85,17 @@ struct mmc_queue {
>>   	 * associated mmc_queue_req data.
>>   	 */
>>   	int			qcnt;
>> +	/* Following are defined for a Command Queue Engine */
>> +	int			cqe_in_flight[MMC_ISSUE_MAX];
>> +	unsigned int		cqe_busy;
>> +	bool			cqe_recovery_needed;
>> +	bool			cqe_in_recovery;
>> +#define MMC_CQE_DCMD_BUSY	BIT(0)
>> +#define MMC_CQE_QUEUE_FULL	BIT(1)
>>   };
>>
>>   extern int mmc_init_queue(struct mmc_queue *, struct mmc_card *,
>> spinlock_t *,
>> -			  const char *);
>> +			  const char *, int);
>>   extern void mmc_cleanup_queue(struct mmc_queue *);  extern void
>> mmc_queue_suspend(struct mmc_queue *);  extern void
>> mmc_queue_resume(struct mmc_queue *); @@ -85,4 +107,22 @@ extern
>> unsigned int mmc_queue_map_sg(struct mmc_queue *,
>>
>>   extern int mmc_access_rpmb(struct mmc_queue *);
>>
>> +void mmc_cqe_kick_queue(struct mmc_queue *mq);
>> +
>> +enum mmc_issue_type mmc_cqe_issue_type(struct mmc_host *host,
>> +				       struct request *req);
>> +
>> +static inline int mmc_cqe_tot_in_flight(struct mmc_queue *mq) {
>> +	return mq->cqe_in_flight[MMC_ISSUE_SYNC] +
>> +	       mq->cqe_in_flight[MMC_ISSUE_DCMD] +
>> +	       mq->cqe_in_flight[MMC_ISSUE_ASYNC];
>> +}
>> +
>> +static inline int mmc_cqe_qcnt(struct mmc_queue *mq) {
>> +	return mq->cqe_in_flight[MMC_ISSUE_DCMD] +
>> +	       mq->cqe_in_flight[MMC_ISSUE_ASYNC];
>> +}
>> +
>>   #endif
>> --
>> 1.9.1
> 
> 
> 
> 

