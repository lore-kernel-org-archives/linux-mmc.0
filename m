From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V9 00/11] mmc: mmc: Add Software Command Queuing
Date: Thu,  8 Dec 2016 10:44:27 +0200
Message-ID: <1481186678-6307-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:38669 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751064AbcLHIto (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 8 Dec 2016 03:49:44 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>

Hi

Here is an updated version of the Software Command Queuing patches,
re-based on next, with some changes - refer changes in V9 below.
The patches have been re-ordered to put tidy-ups first. The first 4
patches could be considered, but especially the first 2.

Performance results (not updated since V5):

Results can vary from run to run, but here are some results showing 1, 2 or 4
processes with 4k and 32k record sizes.  They show up to 40% improvement in
read performance when there are multiple processes.

iozone -s 8192k -r 4k -i 0 -i 1 -i 2 -i 8 -I -t 1 -F /mnt/mmc/iozone1.tmp

	Children see throughput for  1 initial writers 	=     27909.87 kB/sec     24204.14 kB/sec      -13.28 %
	Children see throughput for  1 rewriters 	=     28839.28 kB/sec     25531.92 kB/sec      -11.47 %
	Children see throughput for  1 readers 		=     25889.65 kB/sec     24883.23 kB/sec       -3.89 %
	Children see throughput for 1 re-readers 	=     25558.23 kB/sec     24679.89 kB/sec       -3.44 %
	Children see throughput for 1 random readers 	=     25571.48 kB/sec     24689.52 kB/sec       -3.45 %
	Children see throughput for 1 mixed workload 	=     25758.59 kB/sec     24487.52 kB/sec       -4.93 %
	Children see throughput for 1 random writers 	=     24787.51 kB/sec     19368.99 kB/sec      -21.86 %

iozone -s 8192k -r 32k -i 0 -i 1 -i 2 -i 8 -I -t 1 -F /mnt/mmc/iozone1.tmp

	Children see throughput for  1 initial writers 	=     91344.61 kB/sec    102008.56 kB/sec       11.67 %
	Children see throughput for  1 rewriters 	=     87932.36 kB/sec     96630.44 kB/sec        9.89 %
	Children see throughput for  1 readers 		=    134879.82 kB/sec    110292.79 kB/sec      -18.23 %
	Children see throughput for 1 re-readers 	=    147632.13 kB/sec    109053.33 kB/sec      -26.13 %
	Children see throughput for 1 random readers 	=     93547.37 kB/sec    112225.50 kB/sec       19.97 %
	Children see throughput for 1 mixed workload 	=     93560.04 kB/sec    110515.21 kB/sec       18.12 %
	Children see throughput for 1 random writers 	=     92841.84 kB/sec     81153.81 kB/sec      -12.59 %

iozone -s 8192k -r 4k -i 0 -i 1 -i 2 -i 8 -I -t 2 -F /mnt/mmc/iozone1.tmp /mnt/mmc/iozone2.tmp

	Children see throughput for  2 initial writers 	=     31145.43 kB/sec     33771.25 kB/sec        8.43 %
	Children see throughput for  2 rewriters 	=     30592.57 kB/sec     35916.46 kB/sec       17.40 %
	Children see throughput for  2 readers 		=     31669.83 kB/sec     37460.13 kB/sec       18.28 %
	Children see throughput for 2 re-readers 	=     32079.94 kB/sec     37373.33 kB/sec       16.50 %
	Children see throughput for 2 random readers 	=     27731.19 kB/sec     37601.65 kB/sec       35.59 %
	Children see throughput for 2 mixed workload 	=     13927.50 kB/sec     14617.06 kB/sec        4.95 %
	Children see throughput for 2 random writers 	=     31250.00 kB/sec     33106.72 kB/sec        5.94 %

iozone -s 8192k -r 32k -i 0 -i 1 -i 2 -i 8 -I -t 2 -F /mnt/mmc/iozone1.tmp /mnt/mmc/iozone2.tmp

	Children see throughput for  2 initial writers 	=    123255.84 kB/sec    131252.22 kB/sec        6.49 %
	Children see throughput for  2 rewriters 	=    115234.91 kB/sec    107225.74 kB/sec       -6.95 %
	Children see throughput for  2 readers 		=    128921.86 kB/sec    148562.71 kB/sec       15.23 %
	Children see throughput for 2 re-readers 	=    127815.24 kB/sec    149304.32 kB/sec       16.81 %
	Children see throughput for 2 random readers 	=    125600.46 kB/sec    148406.56 kB/sec       18.16 %
	Children see throughput for 2 mixed workload 	=     44006.94 kB/sec     50937.36 kB/sec       15.75 %
	Children see throughput for 2 random writers 	=    120623.95 kB/sec    103969.05 kB/sec      -13.81 %

iozone -s 8192k -r 4k -i 0 -i 1 -i 2 -i 8 -I -t 4 -F /mnt/mmc/iozone1.tmp /mnt/mmc/iozone2.tmp /mnt/mmc/iozone3.tmp /mnt/mmc/iozone4.tmp

	Children see throughput for  4 initial writers 	=     24100.96 kB/sec     33336.58 kB/sec       38.32 %
	Children see throughput for  4 rewriters 	=     31650.20 kB/sec     33091.53 kB/sec        4.55 %
	Children see throughput for  4 readers 		=     33276.92 kB/sec     41799.89 kB/sec       25.61 %
	Children see throughput for 4 re-readers 	=     31786.96 kB/sec     41501.74 kB/sec       30.56 %
	Children see throughput for 4 random readers 	=     31991.65 kB/sec     40973.93 kB/sec       28.08 %
	Children see throughput for 4 mixed workload 	=     15804.80 kB/sec     13581.32 kB/sec      -14.07 %
	Children see throughput for 4 random writers 	=     31231.42 kB/sec     34537.03 kB/sec       10.58 %

iozone -s 8192k -r 32k -i 0 -i 1 -i 2 -i 8 -I -t 4 -F /mnt/mmc/iozone1.tmp /mnt/mmc/iozone2.tmp /mnt/mmc/iozone3.tmp /mnt/mmc/iozone4.tmp

	Children see throughput for  4 initial writers 	=    116567.42 kB/sec    119280.35 kB/sec        2.33 %
	Children see throughput for  4 rewriters 	=    115010.96 kB/sec    120864.34 kB/sec        5.09 %
	Children see throughput for  4 readers 		=    130700.29 kB/sec    177834.21 kB/sec       36.06 %
	Children see throughput for 4 re-readers 	=    125392.58 kB/sec    175975.28 kB/sec       40.34 %
	Children see throughput for 4 random readers 	=    132194.57 kB/sec    176630.46 kB/sec       33.61 %
	Children see throughput for 4 mixed workload 	=     56464.98 kB/sec     54140.61 kB/sec       -4.12 %
	Children see throughput for 4 random writers 	=    109128.36 kB/sec     85359.80 kB/sec      -21.78 %


The current block driver supports 2 requests on the go at a time. Patches
3 - 8 make preparations for an arbitrary sized queue. Patches 9 - 12
introduce Command Queue definitions and helpers.  Patches 13 - 16
complete the job of making the block driver use a queue.  Patches 17 - 20
finally add Software Command Queuing.  Most of the Software Command Queuing
functionality is added in patch 19.

As noted below, the patches can also be found here:

	http://git.infradead.org/users/ahunter/linux-sdhci.git/shortlog/refs/heads/swcmdq
	
	which also includes a debug-only patch to help debug stuck queues:
	    mmc: block: Add debugfs state file for debugging stuck queues

Changes in V9:

  Re-based on next, dropping patches that have been applied:
      mmc: block: Restore line inadvertently removed with packed commands
      mmc: block: Fix 4K native sector check
      mmc: queue: Fix queue thread wake-up
      mmc: queue: Factor out mmc_queue_alloc_bounce_bufs()
      mmc: queue: Factor out mmc_queue_alloc_bounce_sgs()
      mmc: queue: Factor out mmc_queue_alloc_sgs()
      mmc: queue: Factor out mmc_queue_reqs_free_bufs()
      mmc: queue: Introduce queue depth and use it to allocate and free
      mmc: mmc: Add Command Queue definitions

  mmc: queue: Share mmc request array between partitions
    Change to allocate / free from mmc_blk_probe / mmc_blk_remove instead
    of using a reference count.

  mmc: block: Add Software Command Queuing
    Adjusted due to change in "mmc: queue: Share mmc request array between partitions"

Changes in V8:

  Re-based on next, dropping references to Packed Commands.

  mmc: block: Restore line inadvertently removed with packed commands
    New patch

  mmc: block: Fix 4K native sector check
    Moved to be the 2nd patch
    Added Reviewed-by: Linus Walleij

  mmc: queue: Fix queue thread wake-up
    Added Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
    Added Reviewed-by: Harjani Ritesh <riteshh@codeaurora.org>

  mmc: queue: Factor out mmc_queue_alloc_bounce_bufs()
    Added Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
    Added Reviewed-by: Harjani Ritesh <riteshh@codeaurora.org>

  mmc: queue: Factor out mmc_queue_alloc_bounce_sgs()
    Added Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
    Added Reviewed-by: Harjani Ritesh <riteshh@codeaurora.org>

  mmc: queue: Factor out mmc_queue_alloc_sgs()
    Added Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
    Added Reviewed-by: Harjani Ritesh <riteshh@codeaurora.org>

  mmc: queue: Factor out mmc_queue_reqs_free_bufs()
    Added Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
    Added Reviewed-by: Harjani Ritesh <riteshh@codeaurora.org>

  mmc: queue: Introduce queue depth
    Drop chunk referring to mmc_packed_init().
    Combined into new patch "mmc: queue: Introduce queue depth and use it to allocate and free"

  mmc: queue: Use queue depth to allocate and free
    Combined into new patch "mmc: queue: Introduce queue depth and use it to allocate and free"

  mmc: queue: Allocate queue of size qdepth
    Combined into new patch "mmc: queue: Introduce queue depth and use it to allocate and free"

  mmc: queue: Introduce queue depth and use it to allocate and free
    New patch from combining 3 patches above.

  mmc: mmc: Add Command Queue definitions
    Add comment about excluding qdepths of 1 or 2.

  mmc: mmc: Add functions to enable / disable the Command Queue
    Change mmc_cmdq_switch() 'enable' parameter from 'int' to 'bool'.

  mmc: mmc_test: Disable Command Queue while mmc_test is used
    Added Reviewed-by: Harjani Ritesh <riteshh@codeaurora.org>

  mmc: block: Disable Command Queue while RPMB is used
    As per Ritesh, assign 'ret' to 0 and return 'ret'.
    Added Reviewed-by: Harjani Ritesh <riteshh@codeaurora.org>

  mmc: core: Do not prepare a new request twice
    Added Reviewed-by: Harjani Ritesh <riteshh@codeaurora.org>

  mmc: core: Export mmc_retune_hold() and mmc_retune_release()
    Added Reviewed-by: Harjani Ritesh <riteshh@codeaurora.org>

  mmc: block: Factor out mmc_blk_requeue()
    Dropped because it only affected "packed commands" code.

  mmc: block: Use local var for mqrq_cur
    Dropped chucks referring to Packed Commands.
    Added Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

  mmc: block: Pass mqrq to mmc_blk_prep_packed_list()
    Dropped because it only affected "packed commands" code.

  mmc: block: Introduce queue semantics
    Add mmc_blk_requeue() lost from dropped patches.

  mmc: queue: Share mmc request array between partitions
    Dropped chucks referring to Packed Commands.
    Change mqrq_ref_cnt from 'int' to 'unsigned int'
    Add a comment about synchronisation of mqrq_ref_cnt.

  mmc: mmc: Enable Software Command Queuing
    Get rid of MMC_CAP_SWCMDQ and use MMC_CAP_CMD_DURING_TFR instead

  mmc: sdhci-pci: Enable Software Command Queuing for some Intel controllers
    Dropped because MMC_CAP_SWCMDQ removed.

  mmc: sdhci-acpi: Enable Software Command Queuing for some Intel controllers
    Dropped because MMC_CAP_SWCMDQ removed.

Changes in V7:

  Re-based on next.

  mmc: mmc: Add Command Queue definitions
    Remove cmdq_en flag and add Linus Walleij's Reviewed-by.

  mmc: mmc: Add functions to enable / disable the Command
    Add cmdq_en flag.

Changes in V6:

  mmc: core: Do not prepare a new request twice
    Ensure struct mmc_async_req is always initialized to zero

Changes in V5:

  Patches 1-5 dropped because they have been applied.
 
  Re-based on next.
 
  Fixed use of blk_end_request_cur() when it should have been
  blk_end_request_all() to error out requests during error recovery.

  Fixed unpaired retune_hold / retune_release in the error recovery path.

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

There wasn't much comment on the RFC so there have been few changes.
Venu Byravarasu commented that it may be more efficient to use Software
Command Queuing only when there is more than 1 request queued - it isn't
obvious how well that would work in practice, but it could be added later
if it could be shown to be beneficial.

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
generic change added in patches 1 - 5. [Those patches have now been applied]
In principle, that would also support SDIO's CMD52 during data transfer.

The original approach added multiple commands into the same request for
sending CMD44, CMD45 and CMD13. That is not strictly necessary and has
been omitted for now.

The original approach also called blk_end_request() from the mrq->done()
function, which means the upper layers learnt of completed requests
slightly earlier. That is not strictly related to Software Command Queuing
and is something that could potentially be done for all data requests.
That has been omitted for now.

The current block driver supports 2 requests on the go at a time. Patches
1 - 8 make preparations for an arbitrary sized queue. Patches 9 - 12
introduce Command Queue definitions and helpers.  Patches 13 - 19
complete the job of making the block driver use a queue.  Patches 20 - 23
finally add Software Command Queuing, and 24 - 25 enable it for Intel eMMC
controllers. Most of the Software Command Queuing functionality is added
in patch 22.

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


Adrian Hunter (11):
      mmc: block: Use local var for mqrq_cur
      mmc: queue: Share mmc request array between partitions
      mmc: block: Introduce queue semantics
      mmc: core: Do not prepare a new request twice
      mmc: mmc: Add functions to enable / disable the Command Queue
      mmc: mmc_test: Disable Command Queue while mmc_test is used
      mmc: block: Disable Command Queue while RPMB is used
      mmc: core: Export mmc_retune_hold() and mmc_retune_release()
      mmc: queue: Add a function to control wake-up on new requests
      mmc: block: Add Software Command Queuing
      mmc: mmc: Enable Software Command Queuing

 Documentation/mmc/mmc-dev-attrs.txt |   1 +
 drivers/mmc/card/block.c            | 706 ++++++++++++++++++++++++++++++++++--
 drivers/mmc/card/mmc_test.c         |  21 +-
 drivers/mmc/card/queue.c            | 331 ++++++++++-------
 drivers/mmc/card/queue.h            |  25 +-
 drivers/mmc/core/core.c             |  12 +-
 drivers/mmc/core/host.c             |   2 +
 drivers/mmc/core/host.h             |   2 -
 drivers/mmc/core/mmc.c              |  26 +-
 drivers/mmc/core/mmc_ops.c          |  28 ++
 include/linux/mmc/card.h            |   7 +
 include/linux/mmc/core.h            |   6 +
 include/linux/mmc/host.h            |   1 +
 13 files changed, 999 insertions(+), 169 deletions(-)


Regards
Adrian
