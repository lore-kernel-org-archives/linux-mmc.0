From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V1 00/18] mmc: Add Command Queue support
Date: Wed, 8 Mar 2017 10:08:34 +0200
Message-ID: <9d57e64f-2c58-dc2b-8e23-9ae69fba8300@intel.com>
References: <CGME20170306091701epcas4p30ef050e2e5bd1616457a6347de9b6717@epcas4p3.samsung.com>
 <1488791473-24981-1-git-send-email-adrian.hunter@intel.com>
 <60109e5e-b1de-dc47-f6ce-d921d2a459ca@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:19724 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751941AbdCHJUh (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 8 Mar 2017 04:20:37 -0500
In-Reply-To: <60109e5e-b1de-dc47-f6ce-d921d2a459ca@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>

On 08/03/17 07:18, Jaehoon Chung wrote:
> Hi Adrian,
> 
> On 03/06/2017 06:10 PM, Adrian Hunter wrote:
>> Hi
>>
>> Here are the hardware command queue patches without the software command
>> queue patches or sdhci patches.
> 
> I don't see your patches fully yet, but after applied your patches, dwmmc host doesn't work.
> So I'm finding what happen in dwmmc controller.
> After finding problem, i will share it.
> Well,.. maybe i missed something...

Thanks for trying these patches.

With no host controller yet using CQE, there isn't much changing in this
patch set, but bisecting should reveal the first bad commit.

> 
> Best Regards,
> Jaehoon Chung
> 
>>
>>
>> Changes since RFC:
>>
>> 	Re-based on next.
>> 	Added comment about command queue priority.
>> 	Added some acks and reviews.
>>
>>
>> Adrian Hunter (17):
>>       mmc: queue: Share mmc request array between partitions
>>       mmc: mmc: Add functions to enable / disable the Command Queue
>>       mmc: mmc_test: Disable Command Queue while mmc_test is used
>>       mmc: block: Disable Command Queue while RPMB is used
>>       mmc: block: Change mmc_apply_rel_rw() to get block address from the request
>>       mmc: block: Factor out data preparation
>>       mmc: core: Factor out debug prints from mmc_start_request()
>>       mmc: core: Factor out mrq preparation from mmc_start_request()
>>       mmc: core: Add mmc_retune_hold_now()
>>       mmc: core: Add members to mmc_request and mmc_data for CQE's
>>       mmc: host: Add CQE interface
>>       mmc: core: Turn off CQE before sending commands
>>       mmc: core: Add support for handling CQE requests
>>       mmc: mmc: Enable Command Queuing
>>       mmc: mmc: Enable CQE's
>>       mmc: block: Prepare CQE data
>>       mmc: block: Add CQE support
>>
>> Venkat Gopalakrishnan (1):
>>       mmc: cqhci: support for command queue enabled host
>>
>>  Documentation/mmc/mmc-dev-attrs.txt |    1 +
>>  drivers/mmc/core/block.c            |  435 ++++++++++---
>>  drivers/mmc/core/block.h            |    7 +
>>  drivers/mmc/core/bus.c              |    7 +
>>  drivers/mmc/core/core.c             |  203 ++++++-
>>  drivers/mmc/core/host.c             |    6 +
>>  drivers/mmc/core/host.h             |    1 +
>>  drivers/mmc/core/mmc.c              |   39 +-
>>  drivers/mmc/core/mmc_ops.c          |   28 +
>>  drivers/mmc/core/mmc_ops.h          |    2 +
>>  drivers/mmc/core/mmc_test.c         |   14 +
>>  drivers/mmc/core/queue.c            |  535 +++++++++++++---
>>  drivers/mmc/core/queue.h            |   45 +-
>>  drivers/mmc/host/Kconfig            |   13 +
>>  drivers/mmc/host/Makefile           |    1 +
>>  drivers/mmc/host/cqhci.c            | 1148 +++++++++++++++++++++++++++++++++++
>>  drivers/mmc/host/cqhci.h            |  240 ++++++++
>>  include/linux/mmc/card.h            |    8 +
>>  include/linux/mmc/core.h            |   19 +-
>>  include/linux/mmc/host.h            |   24 +
>>  include/trace/events/mmc.h          |   17 +-
>>  21 files changed, 2585 insertions(+), 208 deletions(-)
>>  create mode 100644 drivers/mmc/host/cqhci.c
>>  create mode 100644 drivers/mmc/host/cqhci.h
>>
>>
>> Regards
>> Adrian
>>
>>
>>
> 
> 

