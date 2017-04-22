From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V2 00/22] mmc: Add Command Queue support
Date: Sat, 22 Apr 2017 10:45:23 +0300
Message-ID: <faa2a3d8-e045-8bd1-06c9-e5cf64713035@intel.com>
References: <1489408613-26915-1-git-send-email-adrian.hunter@intel.com>
 <CAPDyKFp=rrQbSAGMx=UF2abcLmzWjO4syq7eLAmChT_EQNvDgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:5942 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1042861AbdDVHxP (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sat, 22 Apr 2017 03:53:15 -0400
In-Reply-To: <CAPDyKFp=rrQbSAGMx=UF2abcLmzWjO4syq7eLAmChT_EQNvDgg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>

On 04/10/2017 04:53 PM, Ulf Hansson wrote:
> On 13 March 2017 at 13:36, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> Hi
>>
>> Here are the hardware command queue patches without the software command
>> queue patches or sdhci patches.
>>
>> Changes since V1:
>>
>>         "Share mmc request array between partitions" is dependent
>>         on changes in "Introduce queue semantics", so added that
>>         and block fixes:
>>
>>         Added "Fix is_waiting_last_req set incorrectly"
>>         Added "Fix cmd error reset failure path"
>>         Added "Use local var for mqrq_cur"
>>         Added "Introduce queue semantics"
>>
>> Changes since RFC:
>>
>>         Re-based on next.
>>         Added comment about command queue priority.
>>         Added some acks and reviews.
>>
>>
>> Adrian Hunter (21):
>>       mmc: block: Fix is_waiting_last_req set incorrectly
>>       mmc: block: Fix cmd error reset failure path
>>       mmc: block: Use local var for mqrq_cur
>>       mmc: block: Introduce queue semantics
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
>>  drivers/mmc/core/block.c            |  527 ++++++++++++----
>>  drivers/mmc/core/block.h            |    7 +
>>  drivers/mmc/core/bus.c              |    7 +
>>  drivers/mmc/core/core.c             |  203 ++++++-
>>  drivers/mmc/core/host.c             |    6 +
>>  drivers/mmc/core/host.h             |    1 +
>>  drivers/mmc/core/mmc.c              |   39 +-
>>  drivers/mmc/core/mmc_ops.c          |   28 +
>>  drivers/mmc/core/mmc_ops.h          |    2 +
>>  drivers/mmc/core/mmc_test.c         |   14 +
>>  drivers/mmc/core/queue.c            |  607 ++++++++++++++----
>>  drivers/mmc/core/queue.h            |   55 +-
>>  drivers/mmc/host/Kconfig            |   13 +
>>  drivers/mmc/host/Makefile           |    1 +
>>  drivers/mmc/host/cqhci.c            | 1148 +++++++++++++++++++++++++++++++++++
>>  drivers/mmc/host/cqhci.h            |  240 ++++++++
>>  include/linux/mmc/card.h            |    8 +
>>  include/linux/mmc/core.h            |   19 +-
>>  include/linux/mmc/host.h            |   24 +
>>  include/trace/events/mmc.h          |   17 +-
>>  21 files changed, 2694 insertions(+), 273 deletions(-)
>>  create mode 100644 drivers/mmc/host/cqhci.c
>>  create mode 100644 drivers/mmc/host/cqhci.h
>>
>>
>> Regards
>> Adrian
> 
> Sorry for the delay!
> 
> I have looked through parts of the new version of the series, just
> reached to patch12. Before I continue, but also to move forward, I
> have picked up patch 3 -> 12 (including 12). Patch 1 and 2, went as
> fixes earlier.

Ulf and Linus have been doing a great job of keeping this moving, but it
would be nice to see some others taking more interest.  The first command
queue patches were posted in February 2014, over 3 years ago!

