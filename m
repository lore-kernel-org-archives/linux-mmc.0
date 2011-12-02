From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH v2 0/2] mmc: core: Support packed command feature of eMMC4.5
Date: Fri, 02 Dec 2011 18:38:51 +0900
Message-ID: <003301ccb0d6$338c3ba0$9aa4b2e0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <cjb@laptop.org>, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, dh.han@samsung.com
List-Id: linux-mmc@vger.kernel.org

This patch-set adds support of packed command feature
for eMMC4.5 devices.

Changes in v2:
	- Fixed the packed read sequence and error handling.
	- Applied checking the exception status for all cases with
	   the comments from Maya Erez and Sahitya Tummala.
	- Fixed preparing the packed list with the comment from Maya Erez and Venkatraman.

Seungwon Jeon (2):
      mmc: core: Add packed command feature of eMMC4.5
      mmc: core: Support packed command for eMMC4.5 device

 drivers/mmc/card/block.c   |  454 ++++++++++++++++++++++++++++++++++++++++++--
 drivers/mmc/card/queue.c   |   48 +++++-
 drivers/mmc/card/queue.h   |   13 ++
 drivers/mmc/core/mmc.c     |   24 +++
 drivers/mmc/core/mmc_ops.c |    1 +
 include/linux/mmc/card.h   |    3 +
 include/linux/mmc/core.h   |    3 +
 include/linux/mmc/host.h   |    1 +
 include/linux/mmc/mmc.h    |   15 ++
 9 files changed, 538 insertions(+), 24 deletions(-)

Best regards,
Seungwon Jeon.
--
1.7.2.3
