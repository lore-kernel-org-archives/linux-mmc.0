From: Maya Erez <merez@codeaurora.org>
Subject: [PATCH v5 0/3] Add support for periodic BKOPS
Date: Thu, 10 Jan 2013 22:15:18 +0200
Message-ID: <1357848921-9596-1-git-send-email-merez@codeaurora.org>
References: <n>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <n>
Sender: linux-arm-msm-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, Maya Erez <merez@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

Devices have various maintenance operations need to perform internally.
In order to reduce latencies during time critical operations like read
and write, it is better to execute maintenance operations in other
times - when the host is not being serviced. Such operations are called
Background operations (BKOPS).
The device notifies the status of the BKOPS need by updating BKOPS_STATUS
(EXT_CSD byte [246]).

According to the standard a host that supports BKOPS shall check the
status periodically and start background operations as needed, so that
the device has enough time for its maintenance operations.

This patch adds support for this periodic check of the BKOPS status.
Since foreground operations are of higher priority than background
operations the host will check the need for BKOPS when it is idle,
and in case of an incoming request the BKOPS operation will be
interrupted.

When the mmcqd thread is idle, a delayed work is created to check the
need for BKOPS. The time to start the delayed work can be set by the host
controller. If this time is not set, a default time is used.
If the card raised an exception with need for urgent BKOPS (level 2/3)
a flag will be set to indicate MMC to start the BKOPS activity when it
becomes idle.

Since running the BKOPS too often can impact the eMMC endurance, the card
need for BKOPS is not checked every time MMC is idle (despite of cases of
exception raised). In order to estimate when is the best time to check
for BKOPS need the host will take into account the card capacity and
percentages of changed sectors in the card. A future enhancement can be to
check the card need for BKOPS only in case of random activity.

This patch is based on the periodic BKOPS implementation in version 8 of "support BKOPS feature for eMMC" patch.
The patch was modified to answer the following issues:
- Since mmc_start_bkops is called from two contexts now, mmc_claim_host was moved to the beginning of the function
- Also, the check of doing_bkops should be protected when determing if an HPI is needed due to the same reason.

Changes in v5:
    - Do not allow BKOPS operation in all levels to be blocking
    - Change the periodic check for BKOPS need to be based on percentage of changed sector
    - Add BKOPS statistics

Changes in v4:
    - Separate the polling for BKOPS completion to a different patch
    - add a flag to indicate if polling for card completion is required

Changes in v3:
    - Move the call to stop_bkops to block.c. 
      This allows us to remove the mmc_claim_host from inside the function and doesn't cause additional degradation 
      due to un-neccessary calim host operation

Changes in v2:
    - Check the number of written / discarded sectors as the trigger for checking the BKOPS need.
    - Code review fixes

Maya Erez (3):
  mmc: core: Add support for idle time BKOPS
  mmc: allow the host controller to poll for BKOPS completion
  mmc: core: Add MMC BKOPS statistics and debugfs ability to print them

 Documentation/mmc/mmc-dev-attrs.txt |    9 +
 drivers/mmc/card/block.c            |   96 ++++++++++++-
 drivers/mmc/card/queue.c            |    2 +
 drivers/mmc/core/bus.c              |    2 +
 drivers/mmc/core/core.c             |  286 +++++++++++++++++++++++++++++++----
 drivers/mmc/core/debugfs.c          |  114 ++++++++++++++
 drivers/mmc/core/mmc.c              |   20 +++
 include/linux/mmc/card.h            |   64 ++++++++-
 include/linux/mmc/core.h            |    5 +
 include/linux/mmc/host.h            |    2 +-
 10 files changed, 563 insertions(+), 37 deletions(-)

-- 
1.7.3.3
-- 
QUALCOMM ISRAEL, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
