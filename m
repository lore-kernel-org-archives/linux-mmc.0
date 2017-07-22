From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH V4 10/11] mmc: cqhci: support for command queue enabled
 host
Date: Sat, 22 Jul 2017 17:39:58 +0800
Message-ID: <533a8e13-38f4-278a-75cb-d22f554aa3b6@rock-chips.com>
References: <1500630584-22852-1-git-send-email-adrian.hunter@intel.com>
 <1500630584-22852-11-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.135]:34399 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752127AbdGVJkf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 22 Jul 2017 05:40:35 -0400
In-Reply-To: <1500630584-22852-11-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, shawn.lin@rock-chips.com, linux-mmc <linux-mmc@vger.kernel.org>, Bough Chen <haibo.chen@nxp.com>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>

Hi Adrian,

On 2017/7/21 17:49, Adrian Hunter wrote:
> From: Venkat Gopalakrishnan <venkatg@codeaurora.org>
>
> This patch adds CMDQ support for command-queue compatible
> hosts.
>
> Command queue is added in eMMC-5.1 specification. This
> enables the controller to process upto 32 requests at
> a time.
>
> Adrian Hunter contributed renaming to cqhci, recovery, suspend
> and resume, cqhci_off, cqhci_wait_for_idle, and external timeout
> handling.
>
> Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
> Signed-off-by: Sujit Reddy Thumma <sthumma@codeaurora.org>
> Signed-off-by: Konstantin Dorfman <kdorfman@codeaurora.org>
> Signed-off-by: Venkat Gopalakrishnan <venkatg@codeaurora.org>
> Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
> Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  drivers/mmc/host/Kconfig  |   13 +
>  drivers/mmc/host/Makefile |    1 +
>  drivers/mmc/host/cqhci.c  | 1146 +++++++++++++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/cqhci.h  |  240 ++++++++++
>  4 files changed, 1400 insertions(+)
>  create mode 100644 drivers/mmc/host/cqhci.c
>  create mode 100644 drivers/mmc/host/cqhci.h
>

[...]

> +
> +static void cqhci_prep_task_desc(struct mmc_request *mrq,
> +					u64 *data, bool intr)
> +{
> +	u32 req_flags = mrq->data->flags;
> +
> +	*data = CQHCI_VALID(1) |
> +		CQHCI_END(1) |
> +		CQHCI_INT(intr) |
> +		CQHCI_ACT(0x5) |
> +		CQHCI_FORCED_PROG(!!(req_flags & MMC_DATA_FORCED_PRG)) |
> +		CQHCI_DATA_TAG(!!(req_flags & MMC_DATA_DAT_TAG)) |
> +		CQHCI_DATA_DIR(!!(req_flags & MMC_DATA_READ)) |
> +		CQHCI_PRIORITY(!!(req_flags & MMC_DATA_PRIO)) |
> +		CQHCI_QBAR(!!(req_flags & MMC_DATA_QBR)) |
> +		CQHCI_REL_WRITE(!!(req_flags & MMC_DATA_REL_WR)) |
> +		CQHCI_BLK_COUNT(mrq->data->blocks) |
> +		CQHCI_BLK_ADDR((u64)mrq->data->blk_addr);
> +

I don't find where MMC_DATA_FORCED_PRG is set and MMC_DATA_QBR is set
only for DCMD(erase, flush etc). So I have some silly questions :)

(1) Should MMC_DATA_FORCED_PRG be used for secure erase/trim, etc?
(2) How could the overall code guarantee the read-after-write issue? for
instance, is it possible that two TDLs contain one read for LBA x and a
write for same LBA x, so how to make sure the devices' execute order?


> +int cqhci_resume(struct mmc_host *mmc);
> +
> +#endif
>


-- 
Best Regards
Shawn Lin

