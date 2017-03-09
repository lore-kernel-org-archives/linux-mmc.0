From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH V1 00/18] mmc: Add Command Queue support
Date: Thu, 9 Mar 2017 10:47:57 +0800
Message-ID: <a778fb51-1fe0-5985-5459-6a5d90bbef2b@rock-chips.com>
References: <CGME20170306091701epcas4p30ef050e2e5bd1616457a6347de9b6717@epcas4p3.samsung.com>
 <1488791473-24981-1-git-send-email-adrian.hunter@intel.com>
 <60109e5e-b1de-dc47-f6ce-d921d2a459ca@samsung.com>
 <9d57e64f-2c58-dc2b-8e23-9ae69fba8300@intel.com>
 <9ca26b16-ffda-dc95-5a5c-958817e23f58@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:50718 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751826AbdCIDIK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Mar 2017 22:08:10 -0500
In-Reply-To: <9ca26b16-ffda-dc95-5a5c-958817e23f58@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: shawn.lin@rock-chips.com, linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>

On 2017/3/8 21:27, Jaehoon Chung wrote:
> On 03/08/2017 05:08 PM, Adrian Hunter wrote:
>> On 08/03/17 07:18, Jaehoon Chung wrote:
>>> Hi Adrian,
>>>
>>> On 03/06/2017 06:10 PM, Adrian Hunter wrote:
>>>> Hi
>>>>
>>>> Here are the hardware command queue patches without the software command
>>>> queue patches or sdhci patches.
>>>
>>> I don't see your patches fully yet, but after applied your patches, dwmmc host doesn't work.
>>> So I'm finding what happen in dwmmc controller.
>>> After finding problem, i will share it.
>>> Well,.. maybe i missed something...
>>
>> Thanks for trying these patches.
>>
>> With no host controller yet using CQE, there isn't much changing in this
>> patch set, but bisecting should reveal the first bad commit.
>
> https://patchwork.kernel.org/patch/9605315/
>
> It seems that this patch has a problem...Tomorrow i will check in more detail.
> Because I saw the different error logs..
> Sometime occurred the NULL pointer dereference or I/O error..
>
> Didn't other guys see these problem?

I was running linux-next with this pachset, but it can't boot up my
Debain system, and mostly the log looks like

[    4.137331] Hardware name: Rockchip (Device Tree)
[    4.142585] task: ee753180 task.stack: ee7ca000
[    4.142593] PC is at mmc_blk_rw_rq_prep+0x2c/0x3b0
[    4.142595] LR is at mmc_blk_issue_rw_rq+0x64/0x340
[    4.142599] pc : [<c0a85b74>]    lr : [<c0a86844>]    psr: 8001001

so the first argument, namely mqrq is freed somehow.

c0a85b48 <mmc_blk_rw_rq_prep>:
c0a85b48:       e92d4ff0        push    {r4, r5, r6, r7, r8, r9, sl, fp, lr}
c0a85b4c:       e1a0a003        mov     sl, r3
c0a85b50:       e593301c        ldr     r3, [r3, #28]
c0a85b54:       e24dd00c        sub     sp, sp, #12
c0a85b58:       e2909004        adds    r9, r0, #4
c0a85b5c:       e1a04000        mov     r4, r0
c0a85b60:       e1a05001        mov     r5, r1
c0a85b64:       e1a0b002        mov     fp, r2
c0a85b68:       e5906000        ldr     r6, [r0]
c0a85b6c:       e58d3004        str     r3, [sp, #4]
c0a85b70:       0a0000d8        beq     c0a85ed8 <mmc_blk_rw_rq_prep+0x390>
/* we trap here for fetching r6, and it was from [r0], the mqrq */
c0a85b74:       e5968024        ldr     r8, [r6, #36]   ; 0x24
c0a85b78:       e3a02802        mov     r2, #131072     ; 0x20000


>
> Best Regards,
> Jaehoon Chung
>
>>
>>>
>>> Best Regards,
>>> Jaehoon Chung
>>>
>>>>
>>>>
>>>> Changes since RFC:
>>>>
>>>> 	Re-based on next.
>>>> 	Added comment about command queue priority.
>>>> 	Added some acks and reviews.
>>>>
>>>>
>>>> Adrian Hunter (17):
>>>>       mmc: queue: Share mmc request array between partitions
>>>>       mmc: mmc: Add functions to enable / disable the Command Queue
>>>>       mmc: mmc_test: Disable Command Queue while mmc_test is used
>>>>       mmc: block: Disable Command Queue while RPMB is used
>>>>       mmc: block: Change mmc_apply_rel_rw() to get block address from the request
>>>>       mmc: block: Factor out data preparation
>>>>       mmc: core: Factor out debug prints from mmc_start_request()
>>>>       mmc: core: Factor out mrq preparation from mmc_start_request()
>>>>       mmc: core: Add mmc_retune_hold_now()
>>>>       mmc: core: Add members to mmc_request and mmc_data for CQE's
>>>>       mmc: host: Add CQE interface
>>>>       mmc: core: Turn off CQE before sending commands
>>>>       mmc: core: Add support for handling CQE requests
>>>>       mmc: mmc: Enable Command Queuing
>>>>       mmc: mmc: Enable CQE's
>>>>       mmc: block: Prepare CQE data
>>>>       mmc: block: Add CQE support
>>>>
>>>> Venkat Gopalakrishnan (1):
>>>>       mmc: cqhci: support for command queue enabled host
>>>>
>>>>  Documentation/mmc/mmc-dev-attrs.txt |    1 +
>>>>  drivers/mmc/core/block.c            |  435 ++++++++++---
>>>>  drivers/mmc/core/block.h            |    7 +
>>>>  drivers/mmc/core/bus.c              |    7 +
>>>>  drivers/mmc/core/core.c             |  203 ++++++-
>>>>  drivers/mmc/core/host.c             |    6 +
>>>>  drivers/mmc/core/host.h             |    1 +
>>>>  drivers/mmc/core/mmc.c              |   39 +-
>>>>  drivers/mmc/core/mmc_ops.c          |   28 +
>>>>  drivers/mmc/core/mmc_ops.h          |    2 +
>>>>  drivers/mmc/core/mmc_test.c         |   14 +
>>>>  drivers/mmc/core/queue.c            |  535 +++++++++++++---
>>>>  drivers/mmc/core/queue.h            |   45 +-
>>>>  drivers/mmc/host/Kconfig            |   13 +
>>>>  drivers/mmc/host/Makefile           |    1 +
>>>>  drivers/mmc/host/cqhci.c            | 1148 +++++++++++++++++++++++++++++++++++
>>>>  drivers/mmc/host/cqhci.h            |  240 ++++++++
>>>>  include/linux/mmc/card.h            |    8 +
>>>>  include/linux/mmc/core.h            |   19 +-
>>>>  include/linux/mmc/host.h            |   24 +
>>>>  include/trace/events/mmc.h          |   17 +-
>>>>  21 files changed, 2585 insertions(+), 208 deletions(-)
>>>>  create mode 100644 drivers/mmc/host/cqhci.c
>>>>  create mode 100644 drivers/mmc/host/cqhci.h
>>>>
>>>>
>>>> Regards
>>>> Adrian
>>>>
>>>>
>>>>
>>>
>>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Best Regards
Shawn Lin

