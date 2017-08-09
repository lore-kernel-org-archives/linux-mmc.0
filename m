From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V4 09/11] mmc: block: Add CQE support
Date: Wed, 9 Aug 2017 11:30:56 +0300
Message-ID: <b273977b-dcb7-1c0b-aef5-c7c835d9d50f@intel.com>
References: <1500630584-22852-1-git-send-email-adrian.hunter@intel.com>
 <1500630584-22852-10-git-send-email-adrian.hunter@intel.com>
 <AM4PR0401MB2324BC179C08C1CF2A2013E8908A0@AM4PR0401MB2324.eurprd04.prod.outlook.com>
 <36302399-374a-424e-0a20-940174e92e60@rock-chips.com>
 <d75f784a-bdb2-8eb6-c23f-c74f0585c3f8@intel.com>
 <AM4PR0401MB23240F1551DA4B2F0BB36B51908B0@AM4PR0401MB2324.eurprd04.prod.outlook.com>
 <dae0fb15-a55b-e1c4-c968-075e3e95285b@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:7015 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752324AbdHIIhY (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 9 Aug 2017 04:37:24 -0400
In-Reply-To: <dae0fb15-a55b-e1c4-c968-075e3e95285b@intel.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Bough Chen <haibo.chen@nxp.com>, Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>

On 09/08/17 11:16, Adrian Hunter wrote:
> On 09/08/17 10:57, Bough Chen wrote:
>>> -----Original Message-----
>>> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
>>> owner@vger.kernel.org] On Behalf Of Adrian Hunter
>>> Sent: Wednesday, August 09, 2017 1:58 PM
>>> To: Shawn Lin <shawn.lin@rock-chips.com>; Bough Chen
>>> <haibo.chen@nxp.com>
>>> Cc: Ulf Hansson <ulf.hansson@linaro.org>; linux-mmc <linux-
>>> mmc@vger.kernel.org>; Alex Lemberg <alex.lemberg@sandisk.com>; Mateusz
>>> Nowak <mateusz.nowak@intel.com>; Yuliy Izrailov
>>> <Yuliy.Izrailov@sandisk.com>; Jaehoon Chung <jh80.chung@samsung.com>;
>>> Dong Aisheng <dongas86@gmail.com>; Das Asutosh
>>> <asutoshd@codeaurora.org>; Zhangfei Gao <zhangfei.gao@gmail.com>;
>>> Dorfman Konstantin <kdorfman@codeaurora.org>; Sahitya Tummala
>>> <stummala@codeaurora.org>; Harjani Ritesh <riteshh@codeaurora.org>; Venu
>>> Byravarasu <vbyravarasu@nvidia.com>; Linus Walleij <linus.walleij@linaro.org>
>>> Subject: Re: [PATCH V4 09/11] mmc: block: Add CQE support
>>>
>>> On 09/08/17 03:55, Shawn Lin wrote:
>>>> Hi,
>>>>
>>>> On 2017/8/8 20:07, Bough Chen wrote:
>>>>>> -----Original Message-----
>>>>>> From: Adrian Hunter [mailto:adrian.hunter@intel.com]
>>>>>> Sent: Friday, July 21, 2017 5:50 PM
>>>>>> To: Ulf Hansson <ulf.hansson@linaro.org>
>>>>>> Cc: linux-mmc <linux-mmc@vger.kernel.org>; Bough Chen
>>>>>> <haibo.chen@nxp.com>; Alex Lemberg <alex.lemberg@sandisk.com>;
>>>>>> Mateusz Nowak <mateusz.nowak@intel.com>; Yuliy Izrailov
>>>>>> <Yuliy.Izrailov@sandisk.com>; Jaehoon Chung
>>>>>> <jh80.chung@samsung.com>; Dong Aisheng <dongas86@gmail.com>; Das
>>>>>> Asutosh <asutoshd@codeaurora.org>; Zhangfei Gao
>>>>>> <zhangfei.gao@gmail.com>; Dorfman Konstantin
>>>>>> <kdorfman@codeaurora.org>; David Griego <david.griego@linaro.org>;
>>>>>> Sahitya Tummala <stummala@codeaurora.org>; Harjani Ritesh
>>>>>> <riteshh@codeaurora.org>; Venu Byravarasu <vbyravarasu@nvidia.com>;
>>>>>> Linus Walleij <linus.walleij@linaro.org>; Shawn Lin
>>>>>> <shawn.lin@rock-chips.com>
>>>>>> Subject: [PATCH V4 09/11] mmc: block: Add CQE support
>>>>>>
>>>>>> Add CQE support to the block driver, including:
>>>>>>     - optionally using DCMD for flush requests
>>>>>>     - manually issuing discard requests
>>>>>>     - issuing read / write requests to the CQE
>>>>>>     - supporting block-layer timeouts
>>>>>>     - handling recovery
>>>>>>     - supporting re-tuning
>>>>>>
>>>>>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>>>>>> ---
>>>>>>   drivers/mmc/core/block.c | 195
>>> ++++++++++++++++++++++++++++++++-
>>>>>>   drivers/mmc/core/block.h |   7 ++
>>>>>>   drivers/mmc/core/queue.c | 273
>>>>>> ++++++++++++++++++++++++++++++++++++++++++++++-
>>>>>>   drivers/mmc/core/queue.h |  42 +++++++-
>>>>>>   4 files changed, 510 insertions(+), 7 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
>>>>>> index
>>>>>> 915290c74363..2d25115637b7 100644
>>>>>> --- a/drivers/mmc/core/block.c
>>>>>> +++ b/drivers/mmc/core/block.c
>>>>>> @@ -109,6 +109,7 @@ struct mmc_blk_data {
>>>>>>   #define MMC_BLK_WRITE        BIT(1)
>>>>>>   #define MMC_BLK_DISCARD        BIT(2)
>>>>>>   #define MMC_BLK_SECDISCARD    BIT(3)
>>>>>> +#define MMC_BLK_CQE_RECOVERY    BIT(4)
>>>>>>
>>>>>>       /*
>>>>>>        * Only set in main mmc_blk_data associated @@ -1612,6
>>>>>> +1613,198 @@ static void mmc_blk_data_prep(struct mmc_queue *mq,
>>>>>> struct mmc_queue_req *mqrq,
>>>>>>           *do_data_tag_p = do_data_tag;
>>>>>>   }
>>>>>>
>>>>>> +#define MMC_CQE_RETRIES 2
>>>>
>>>>
>>>>>> +        blk_queue_rq_timed_out(mq->queue, mmc_cqe_timed_out);
>>>>>> +        blk_queue_rq_timeout(mq->queue, 60 * HZ);
>>>>>
>>>>
>>>> ------8<-------
>>>>
>>>>> Hi Adrian,
>>>>>
>>>>> These days I'm doing CMDQ stress test, and find one issue.
>>>>> On our i.MX8QXP-ARM2 board, the RAM is 3GB. eMMC is 32GB.
>>>>> I use command 'free -m' get the total memory is 2800M, and the free
>>>>> memory is 2500M.
>>>>>
>>>>> I use 'mkfs.ext4' to format ext4 file system on the eMMC under
>>>>> HS400ES CMDQ mode, works fine.
>>>>>
>>>>> When I use the following command to stress test CMDQ, it works fine.
>>>>> bonnie++ -d /run/media/mmcblk0p1/ -u 0:0 -s 2048 -r 1024
>>>>>
>>>>> But when I change to use a large file size to do the same stress
>>>>> test, using
>>>>> bonnie++ -d /run/media/mmcblk0p1/ -u 0:0 -s 4096 -r 2048
>>>>> or
>>>>> bonnie++ -d /run/media/mmcblk0p1/ -u 0:0 -s 5600
>>>>>
>>>>> I get the following dump message.  According to the log,
>>>>> mmc_cqe_timed_out() was trigged.
>>>>> Seems mmc was blocked in somewhere.
>>>>> Then I try to debug this issue, and open MMC_DEBUG in config, do the
>>>>> same test, print the detail Command sending information on the
>>>>> console, but finally can't reproduce.
>>>
>>> mmc_cqe_timed_out() is a 60 second timeout provided by the block layer.
>>> Refer "blk_queue_rq_timeout(mq->queue, 60 * HZ)" in mmc_init_queue().
>>> 60s is quite a long time so I would first want to determine if the task was really
>>> queued that long.  I would instrument some code into cqhci_request() to
>>> record the start time on struct mmc_request, and then print the time taken
>>> when there is a problem.
>>>
>>
>> Hi Adrian, 
>>
>> According to your suggestion, I add the following code to print the time.
>> When issue happens, seems the request really pending for over 60s!
>>
>> done
>> Writing intelligently...[  689.209548] mmc0: cqhci: timeout for tag 9
>> [  689.213658] the mrq all use 62123742 us
>> [  689.217487] mmc0: cqhci: ============ CQHCI REGISTER DUMP ===========
>> [  689.223927] mmc0: cqhci: Caps:      0x0000310a | Version:  0x00000510
>> [  689.230363] mmc0: cqhci: Config:    0x00001001 | Control:  0x00000000
>> [  689.236800] mmc0: cqhci: Int stat:  0x00000000 | Int enab: 0x00000006
>> [  689.243238] mmc0: cqhci: Int sig:   0x00000006 | Int Coal: 0x00000000
>> [  689.249675] mmc0: cqhci: TDL base:  0x90079000 | TDL up32: 0x00000000
>> [  689.256113] mmc0: cqhci: Doorbell:  0x1fffffff | TCN:      0x00000000
>> [  689.262550] mmc0: cqhci: Dev queue: 0x1fffefff | Dev Pend: 0x1fff7fff
>> [  689.268988] mmc0: cqhci: Task clr:  0x00000000 | SSC1:     0x00011000
>> [  689.275425] mmc0: cqhci: SSC2:      0x00000001 | DCMD rsp: 0x00000800
>> [  689.281862] mmc0: cqhci: RED mask:  0xfdf9a080 | TERRI:    0x00000000
>> [  689.288300] mmc0: cqhci: Resp idx:  0x0000002f | Resp arg: 0x00000900
>> [  689.294737] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
>> [  689.301176] mmc0: sdhci: Sys addr:  0xb602f000 | Version:  0x00000002
>> [  689.307612] mmc0: sdhci: Blk size:  0x00000200 | Blk cnt:  0x00000400
>> [  689.314050] mmc0: sdhci: Argument:  0x000f0400 | Trn mode: 0x00000023
>> [  689.320487] mmc0: sdhci: Present:   0x01fd858f | Host ctl: 0x00000030
>> [  689.326925] mmc0: sdhci: Power:     0x00000002 | Blk gap:  0x00000080
>> [  689.333362] mmc0: sdhci: Wake-up:   0x00000008 | Clock:    0x0000000f
>> [  689.339800] mmc0: sdhci: Timeout:   0x0000008f | Int stat: 0x00000000
>> [  689.346237] mmc0: sdhci: Int enab:  0x107f4000 | Sig enab: 0x107f4000
>> [  689.352674] mmc0: sdhci: AC12 err:  0x00000000 | Slot int: 0x00000502
>> [  689.359113] mmc0: sdhci: Caps:      0x07eb0000 | Caps_1:   0x8000b407
>> [  689.365549] mmc0: sdhci: Cmd:       0x00002c1a | Max curr: 0x00ffffff
>> [  689.371987] mmc0: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0xffffffff
>> [  689.378424] mmc0: sdhci: Resp[2]:   0x328f5903 | Resp[3]:  0x00d02700
>> [  689.384861] mmc0: sdhci: Host ctl2: 0x00000008
>> [  689.389302] mmc0: sdhci: ADMA Err:  0x00000009 | ADMA Ptr: 0x9009a400
>> [  689.395737] mmc0: sdhci: ============================================
>> [  689.402212] mmc0: running CQE recovery
> 
> Tag 9 has been queued (bit set in Dev Pend) which means it is up to the eMMC
> to select it for execution.  You should dump the times for the other mrq's
> to see how long they have been waiting and try to determine if anything is
> being processed.
> 
> If the eMMC is just taking a really long time to process tasks we could
> extend the timeout, but it is hard to see how that is acceptable to a final
> product.  At this point it looks like the eMMC may have a flaw in the way it
> selects tasks for execution.

No, that is wrong sorry, the task is in the QSR (Dev queue) so it is the CQE
that has not selected it.
