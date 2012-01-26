From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH v4 0/2] mmc: core: Support packed command feature of eMMC4.5
Date: Thu, 26 Jan 2012 18:04:56 +0900
Message-ID: <000901ccdc09$92daf020$b890d060$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: ko
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <cjb@laptop.org>, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

This patch-set adds support of packed command feature
for eMMC4.5 devices.

Changes in v4:
	- Add Data-tag as CMD23 argument for packed header.
	- Separate the capability of MMC_CAP2_PACKED_CMD into read and write.
	- remove unnecessary initial value.

Changes in v3:
	- Add a variable member in mmc_host for minimum number of packed entries.
	  This value can be overridden by host.
	- Fix a handling of error sequence.

Changes in v2:
	- Fix the packed read sequence and error handling.
	- Apply checking the exception status for all cases with
	  the comments from Maya Erez and Sahitya Tummala.
	- Fix preparing the packed list with the comment from Maya Erez and Venkatraman.


Seungwon Jeon (2):
      mmc: core: Add packed command feature of eMMC4.5
      mmc: core: Support packed command for eMMC4.5 device

 drivers/mmc/card/block.c   |  475 +++++++++++++++++++++++++++++++++++++++++---
 drivers/mmc/card/queue.c   |   48 ++++-
 drivers/mmc/card/queue.h   |   13 ++
 drivers/mmc/core/host.c    |    2 +
 drivers/mmc/core/mmc.c     |   24 +++
 drivers/mmc/core/mmc_ops.c |    1 +
 include/linux/mmc/card.h   |    3 +
 include/linux/mmc/core.h   |    4 +
 include/linux/mmc/host.h   |    4 +
 include/linux/mmc/mmc.h    |   15 ++
 10 files changed, 562 insertions(+), 27 deletions(-)

Best regards,
Seungwon Jeon.
--
1.7.2.3
