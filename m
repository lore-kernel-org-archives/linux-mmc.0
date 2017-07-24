From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH V4 00/11] mmc: Add Command Queue support
Date: Mon, 24 Jul 2017 17:17:55 +0800
Message-ID: <20fd5318-eeca-6c85-39fe-8b6a32321115@rock-chips.com>
References: <1500630584-22852-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:51047 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752355AbdGXJSQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Jul 2017 05:18:16 -0400
In-Reply-To: <1500630584-22852-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, shawn.lin@rock-chips.com, linux-mmc <linux-mmc@vger.kernel.org>, Bough Chen <haibo.chen@nxp.com>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>

Hi Adrian,

On 2017/7/21 17:49, Adrian Hunter wrote:
> Hi
> 
> Here is V4 of the hardware command queue patches without the software
> command queue patches.
> 

I see this log for the reboot test last weekend. One of my boards
seems to easily trigger this WARN_ONCE.

[   10.012778] mmc1: cqhci: spurious TCN for tag 31
[   10.013332] ------------[ cut here ]------------
[   10.013779] WARNING: CPU: 0 PID: 2596 at drivers/mmc/host/cqhci.c:721 
cqhci_irq+0x2cc/0x42c
[   10.014520] Modules linked in:
[   10.014837] CPU: 0 PID: 2596 Comm: sed Not tainted 
4.13.0-rc1-next-20170720-00012-g9d9bf45 #33
[   10.015595] Hardware name: Firefly-RK3399 Board (DT)
[   10.016043] task: ffff80007b510000 task.stack: ffff80007a160000
[   10.016575] PC is at cqhci_irq+0x2cc/0x42c
[   10.016946] LR is at cqhci_irq+0x2cc/0x42c
[   10.017321] pc : [<ffff0000087f7c3c>] lr : [<ffff0000087f7c3c>] 
pstate: 600001c5
[   10.017974] sp : ffff80007ef11db0
[   10.018275] x29: ffff80007ef11db0 x28: 0000000000000001
[   10.018759] x27: ffff80007ba7d600 x26: 0000000000000001
[   10.019242] x25: ffff000008d279a8 x24: ffff80007b8f4130
[   10.019725] x23: ffff000008fb0d00 x22: 0000000000000002
[   10.020208] x21: ffff80007ba7d000 x20: ffff80007b8f4118
[   10.020690] x19: 000000000000001f x18: 0000000000000000
[   10.021172] x17: 0000000000000000 x16: 0000000000000000
[   10.021654] x15: 0000000000000000 x14: 00000000f7b60065
[   10.022138] x13: 00000000ffc54040 x12: 0000000000000000
[   10.022624] x11: 000000000000081b x10: 0000000000000006
[   10.023105] x9 : 000000000000081c x8 : ffff00000853de20
[   10.023587] x7 : ffff000008ec9df8 x6 : ffff00000900651b
[   10.024070] x5 : 0000000000000000 x4 : 0000000000000000
[   10.024553] x3 : 0000000000000000 x2 : ffff80007ef19970
[   10.025035] x1 : ffff80007b510000 x0 : 0000000000000024
[   10.025519] Call trace:
[   10.025761] Exception stack(0xffff80007ef11be0 to 0xffff80007ef11d10)
[   10.026342] 1be0: 000000000000001f 0001000000000000 ffff80007ef11db0 
ffff0000087f7c3c
[   10.027040] 1c00: ffff000008d279a8 0000000000000001 ffff80007ba7d600 
0000000000000001
[   10.027738] 1c20: 0000000000000002 0000000000000000 ffff80007ef11db0 
ffff80007ef11db0
[   10.028437] 1c40: ffff80007ef11d70 00000000ffffffc8 ffff80007ef11c80 
ffff00000810f980
[   10.029135] 1c60: ffff80007ef11db0 ffff80007ef11db0 ffff80007ef11d70 
00000000ffffffc8
[   10.029833] 1c80: 0000000000000024 ffff80007b510000 ffff80007ef19970 
0000000000000000
[   10.030533] 1ca0: 0000000000000000 0000000000000000 ffff00000900651b 
ffff000008ec9df8
[   10.031230] 1cc0: ffff00000853de20 000000000000081c 0000000000000006 
000000000000081b
[   10.031928] 1ce0: 0000000000000000 00000000ffc54040 00000000f7b60065 
0000000000000000
[   10.032624] 1d00: 0000000000000000 0000000000000000
[   10.033068] [<ffff0000087f7c3c>] cqhci_irq+0x2cc/0x42c
[   10.033541] [<ffff0000087f2c90>] sdhci_arasan_cqhci_irq+0x44/0x58
[   10.034092] [<ffff0000087dec28>] sdhci_irq+0xb0/0xb74
[   10.034554] [<ffff00000811096c>] __handle_irq_event_percpu+0xa0/0x128
[   10.035133] [<ffff000008110a10>] handle_irq_event_percpu+0x1c/0x54
[   10.035687] [<ffff000008110a8c>] handle_irq_event+0x44/0x74
[   10.036192] [<ffff000008114040>] handle_fasteoi_irq+0x9c/0x154
[   10.036717] [<ffff00000810fa7c>] generic_handle_irq+0x24/0x38
[   10.037234] [<ffff0000081100fc>] __handle_domain_irq+0x60/0xac
[   10.037759] [<ffff00000808173c>] gic_handle_irq+0xd4/0x17c

> 
> Changes since V3:
> 	Adjusted ...blk_end_request...() for new block status codes
> 	Fixed CQHCI transaction descriptor for "no DCMD" case
> 
> Changes since V2:
> 	Dropped patches that have been applied.
> 	Re-based
> 	Added "mmc: sdhci-pci: Add CQHCI support for Intel GLK"
> 
> Changes since V1:
> 
> 	"Share mmc request array between partitions" is dependent
> 	on changes in "Introduce queue semantics", so added that
> 	and block fixes:
> 
> 	Added "Fix is_waiting_last_req set incorrectly"
> 	Added "Fix cmd error reset failure path"
> 	Added "Use local var for mqrq_cur"
> 	Added "Introduce queue semantics"
> 
> Changes since RFC:
> 
> 	Re-based on next.
> 	Added comment about command queue priority.
> 	Added some acks and reviews.
> 
> 
> Adrian Hunter (10):
>        mmc: core: Add mmc_retune_hold_now()
>        mmc: core: Add members to mmc_request and mmc_data for CQE's
>        mmc: host: Add CQE interface
>        mmc: core: Turn off CQE before sending commands
>        mmc: core: Add support for handling CQE requests
>        mmc: mmc: Enable Command Queuing
>        mmc: mmc: Enable CQE's
>        mmc: block: Prepare CQE data
>        mmc: block: Add CQE support
>        mmc: sdhci-pci: Add CQHCI support for Intel GLK
> 
> Venkat Gopalakrishnan (1):
>        mmc: cqhci: support for command queue enabled host
> 
>   drivers/mmc/core/block.c          |  240 +++++++-
>   drivers/mmc/core/block.h          |    7 +
>   drivers/mmc/core/bus.c            |    7 +
>   drivers/mmc/core/core.c           |  156 ++++-
>   drivers/mmc/core/host.c           |    6 +
>   drivers/mmc/core/host.h           |    1 +
>   drivers/mmc/core/mmc.c            |   30 +-
>   drivers/mmc/core/queue.c          |  273 ++++++++-
>   drivers/mmc/core/queue.h          |   42 +-
>   drivers/mmc/host/Kconfig          |   14 +
>   drivers/mmc/host/Makefile         |    1 +
>   drivers/mmc/host/cqhci.c          | 1146 +++++++++++++++++++++++++++++++++++++
>   drivers/mmc/host/cqhci.h          |  240 ++++++++
>   drivers/mmc/host/sdhci-pci-core.c |  153 ++++-
>   include/linux/mmc/core.h          |   18 +-
>   include/linux/mmc/host.h          |   24 +
>   include/trace/events/mmc.h        |   36 +-
>   17 files changed, 2354 insertions(+), 40 deletions(-)
>   create mode 100644 drivers/mmc/host/cqhci.c
>   create mode 100644 drivers/mmc/host/cqhci.h
> 
> 
> Regards
> Adrian
> 
> 
> 

