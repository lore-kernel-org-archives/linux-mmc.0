From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V4 10/11] mmc: cqhci: support for command queue enabled
 host
Date: Mon, 24 Jul 2017 10:36:16 +0300
Message-ID: <79449496-1106-34ea-3fee-f2336ae0c083@intel.com>
References: <1500630584-22852-1-git-send-email-adrian.hunter@intel.com>
 <1500630584-22852-11-git-send-email-adrian.hunter@intel.com>
 <533a8e13-38f4-278a-75cb-d22f554aa3b6@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:38615 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751743AbdGXHmh (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 24 Jul 2017 03:42:37 -0400
In-Reply-To: <533a8e13-38f4-278a-75cb-d22f554aa3b6@rock-chips.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Bough Chen <haibo.chen@nxp.com>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>

On 22/07/17 12:39, Shawn Lin wrote:
> Hi Adrian,
> 
> On 2017/7/21 17:49, Adrian Hunter wrote:
>> From: Venkat Gopalakrishnan <venkatg@codeaurora.org>
>>
>> This patch adds CMDQ support for command-queue compatible
>> hosts.
>>
>> Command queue is added in eMMC-5.1 specification. This
>> enables the controller to process upto 32 requests at
>> a time.
>>
>> Adrian Hunter contributed renaming to cqhci, recovery, suspend
>> and resume, cqhci_off, cqhci_wait_for_idle, and external timeout
>> handling.
>>
>> Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
>> Signed-off-by: Sujit Reddy Thumma <sthumma@codeaurora.org>
>> Signed-off-by: Konstantin Dorfman <kdorfman@codeaurora.org>
>> Signed-off-by: Venkat Gopalakrishnan <venkatg@codeaurora.org>
>> Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
>> Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> ---
>>  drivers/mmc/host/Kconfig  |   13 +
>>  drivers/mmc/host/Makefile |    1 +
>>  drivers/mmc/host/cqhci.c  | 1146
>> +++++++++++++++++++++++++++++++++++++++++++++
>>  drivers/mmc/host/cqhci.h  |  240 ++++++++++
>>  4 files changed, 1400 insertions(+)
>>  create mode 100644 drivers/mmc/host/cqhci.c
>>  create mode 100644 drivers/mmc/host/cqhci.h
>>
> 
> [...]
> 
>> +
>> +static void cqhci_prep_task_desc(struct mmc_request *mrq,
>> +                    u64 *data, bool intr)
>> +{
>> +    u32 req_flags = mrq->data->flags;
>> +
>> +    *data = CQHCI_VALID(1) |
>> +        CQHCI_END(1) |
>> +        CQHCI_INT(intr) |
>> +        CQHCI_ACT(0x5) |
>> +        CQHCI_FORCED_PROG(!!(req_flags & MMC_DATA_FORCED_PRG)) |
>> +        CQHCI_DATA_TAG(!!(req_flags & MMC_DATA_DAT_TAG)) |
>> +        CQHCI_DATA_DIR(!!(req_flags & MMC_DATA_READ)) |
>> +        CQHCI_PRIORITY(!!(req_flags & MMC_DATA_PRIO)) |
>> +        CQHCI_QBAR(!!(req_flags & MMC_DATA_QBR)) |
>> +        CQHCI_REL_WRITE(!!(req_flags & MMC_DATA_REL_WR)) |
>> +        CQHCI_BLK_COUNT(mrq->data->blocks) |
>> +        CQHCI_BLK_ADDR((u64)mrq->data->blk_addr);
>> +
> 
> I don't find where MMC_DATA_FORCED_PRG is set and MMC_DATA_QBR is set

Forced Programming is not used at present.  FUA results in Reliable Write
requests, at least because Reliable Write pre-dates Forced Programming.
Refer mmc_blk_data_prep().  Note CQE is the same as non-CQE in this regard.

WRT QBR, the block layer does not support the concept of barriers.  However
the code is setting QBR always for DCMD, refer cqhci_prep_dcmd_desc().  That
is just because it feels safer and more predictable for flushes but it might
be more efficient to take it off.

> only for DCMD(erase, flush etc). So I have some silly questions :)

DCMD is not used for erase.  It is only used for flush.  That is because
erase requires 3 commands so it is non-trivial to put it into DCMD.  Also it
is not clear whether there would be a benefit from using DCMD for erase.

> 
> (1) Should MMC_DATA_FORCED_PRG be used for secure erase/trim, etc?

Forced Programming applies only to write requests.  Also it is not a
CQE-only feature - refer CMD23.

> (2) How could the overall code guarantee the read-after-write issue? for
> instance, is it possible that two TDLs contain one read for LBA x and a
> write for same LBA x, so how to make sure the devices' execute order?

That issue is the responsibility of the upper layers.  Typically file
systems make use of the page cache where pages are locked during update.
