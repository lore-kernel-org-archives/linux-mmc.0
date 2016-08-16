From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V4 00/30] mmc: mmc: Add Software Command Queuing
Date: Tue, 16 Aug 2016 13:44:10 +0300
Message-ID: <1471344280-16663-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:14127 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753181AbcHPKti (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 16 Aug 2016 06:49:38 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>

Hi

Here is an updated version of the Software Command Queuing patches,
re-based on next + v4.8-rc2 + "block: Fix secure erase" patch, otherwise no
changes since V3.

Ulf, as before, if you accept the "Command during Transfer" API introduced
in patch 1, then you could take patches 1-5 in advance of the rest.

I have begun going through the hardware Command Queuing patches.  They are
still some way from ready, and as a consequence I believe they should
consider re-basing on top of these patches which are ready to go.  I will
go into more details when I reply to the hardware Command Queuing patches.
However it would be reasonable to aim to have both software and hardware
command queuing ready for v4.9.

As noted below, the patches can also be found here:

	http://git.infradead.org/users/ahunter/linux-sdhci.git/shortlog/refs/heads/swcmdq

There wasn't much comment on the RFC so there have been few changes.
Venu Byravarasu commented that it may be more efficient to use Software
Command Queuing only when there is more than 1 request queued - it isn't
obvious how well that would work in practice, but it could be added later
if it could be shown to be beneficial.

Changes in V4:

  Re-based on next + v4.8-rc2 + "block: Fix secure erase" patch

Changes in V3:

  Patches 1-25 dropped because they have been applied.

  Re-based on next.

  mmc: queue: Allocate queue of size qdepth
    Free queue during cleanup

  mmc: mmc: Add Command Queue definitions
    Add cmdq_en to mmc-dev-attrs.txt documentation

  mmc: queue: Share mmc request array between partitions
    New patch

Changes in V2:

  Added 5 patches already sent here:

    http://marc.info/?l=linux-mmc&m=146712062816835

  Added 3 more new patches:

    mmc: sdhci-pci: Do not runtime suspend at the end of sdhci_pci_probe()
    mmc: sdhci: Avoid STOP cmd triggering warning in sdhci_send_command()
    mmc: sdhci: sdhci_execute_tuning() must delete timer

  Carried forward the V2 fix to:

    mmc: mmc_test: Disable Command Queue while mmc_test is used

  Also reset the cmd circuit for data timeout if it is processing the data
  cmd, in patch:

    mmc: sdhci: Do not reset cmd or data circuits that are in use

Original Cover Letter:

Chuanxiao Dong sent some patches last year relating to eMMC 5.1 Software
Command Queuing.  He did not follow-up but I have contacted him and he says
it is OK if I take over upstreaming the patches.

eMMC Command Queuing is a feature added in version 5.1.  The card maintains
a queue of up to 32 data transfers.  Commands CMD45/CMD45 are sent to queue
up transfers in advance, and then one of the transfers is selected to
"execute" by CMD46/CMD47 at which point data transfer actually begins.

The advantage of command queuing is that the card can prepare for transfers
in advance.  That makes a big difference in the case of random reads because
the card can start reading into its cache in advance.

A v5.1 host controller can manage the command queue itself, but it is also
possible for software to manage the queue using an non-v5.1 host controller
- that is what Software Command Queuing is.

Refer to the JEDEC (http://www.jedec.org/) eMMC v5.1 Specification for more
information about Command Queuing.

While these patches are heavily based on Dong's patches, there are some
changes:

SDHCI has been amended to support commands during transfer. That is a
generic change added in patches 1 - 5. In principle, that would also
support SDIO's CMD52 during data transfer.

The original approach added multiple commands into the same request for
sending CMD44, CMD45 and CMD13. That is not strictly necessary and has
been omitted for now.

The original approach also called blk_end_request() from the mrq->done()
function, which means the upper layers learnt of completed requests
slightly earlier. That is not strictly related to Software Command Queuing
and is something that could potentially be done for all data requests.
That has been omitted for now.

The current block driver supports 2 requests on the go at a time. Patches
6 - 13 make preparations for an arbitrary sized queue. Patches 14 - 17
introduce Command Queue definitions and helpers.  Patches 18 - 24
complete the job of making the block driver use a queue.  Patches 25 - 28
finally add Software Command Queuing, and 29 - 30 enable it for Intel eMMC
controllers. Most of the Software Command Queuing functionality is added
in patch 27.

The patches can also be found here:

	http://git.infradead.org/users/ahunter/linux-sdhci.git/shortlog/refs/heads/swcmdq

The patches have only had basic testing so far. Ad-hoc testing shows a
degradation in sequential read performance of about 10% but an increase in
throughput for mixed workload of multiple processes of about 90%. The
reduction in sequential performance is due to the need to read the Queue
Status register between each transfer.

These patches should not conflict with Hardware Command Queuing which
handles the queue in a completely different way and thus does not need
to share code with Software Command Queuing. The exceptions being the
Command Queue definitions and queue allocation which should be able to be
used.


Adrian Hunter (30):
      mmc: core: Add support for sending commands during data transfer
      mmc: mmc_test: Add tests for sending commands during transfer
      mmc: sdhci: Support cap_cmd_during_tfr requests
      mmc: sdhci-pci: Set MMC_CAP_CMD_DURING_TFR for Intel eMMC controllers
      mmc: sdhci-acpi: Set MMC_CAP_CMD_DURING_TFR for Intel eMMC controllers
      mmc: queue: Fix queue thread wake-up
      mmc: queue: Factor out mmc_queue_alloc_bounce_bufs()
      mmc: queue: Factor out mmc_queue_alloc_bounce_sgs()
      mmc: queue: Factor out mmc_queue_alloc_sgs()
      mmc: queue: Factor out mmc_queue_reqs_free_bufs()
      mmc: queue: Introduce queue depth
      mmc: queue: Use queue depth to allocate and free
      mmc: queue: Allocate queue of size qdepth
      mmc: mmc: Add Command Queue definitions
      mmc: mmc: Add functions to enable / disable the Command Queue
      mmc: mmc_test: Disable Command Queue while mmc_test is used
      mmc: block: Disable Command Queue while RPMB is used
      mmc: core: Do not prepare a new request twice
      mmc: core: Export mmc_retune_hold() and mmc_retune_release()
      mmc: block: Factor out mmc_blk_requeue()
      mmc: block: Fix 4K native sector check
      mmc: block: Use local var for mqrq_cur
      mmc: block: Pass mqrq to mmc_blk_prep_packed_list()
      mmc: block: Introduce queue semantics
      mmc: queue: Share mmc request array between partitions
      mmc: queue: Add a function to control wake-up on new requests
      mmc: block: Add Software Command Queuing
      mmc: mmc: Enable Software Command Queuing
      mmc: sdhci-pci: Enable Software Command Queuing for some Intel controllers
      mmc: sdhci-acpi: Enable Software Command Queuing for some Intel controllers

 Documentation/mmc/mmc-dev-attrs.txt |   1 +
 drivers/mmc/card/block.c            | 740 +++++++++++++++++++++++++++++++++---
 drivers/mmc/card/mmc_test.c         | 321 ++++++++++++++++
 drivers/mmc/card/queue.c            | 332 ++++++++++------
 drivers/mmc/card/queue.h            |  27 +-
 drivers/mmc/core/core.c             | 113 +++++-
 drivers/mmc/core/host.c             |   2 +
 drivers/mmc/core/host.h             |   2 -
 drivers/mmc/core/mmc.c              |  43 ++-
 drivers/mmc/core/mmc_ops.c          |  27 ++
 drivers/mmc/host/sdhci-acpi.c       |   4 +-
 drivers/mmc/host/sdhci-pci-core.c   |   1 +
 drivers/mmc/host/sdhci.c            |  21 +-
 include/linux/mmc/card.h            |   9 +
 include/linux/mmc/core.h            |  12 +
 include/linux/mmc/host.h            |   9 +-
 include/linux/mmc/mmc.h             |  17 +
 17 files changed, 1476 insertions(+), 205 deletions(-)


Regards
Adrian

