From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH V3 0/6] mmc: sdhci: a few fixes on timeout and max_discard_to
Date: Wed, 27 Aug 2014 15:26:26 +0800
Message-ID: <1409124392-28899-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1blp0182.outbound.protection.outlook.com ([207.46.163.182]:22815
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751187AbaH0Hpq (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 27 Aug 2014 03:45:46 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, chris@printf.net, shawn.guo@linaro.org, b29396@freescale.com, linux-arm-kernel@lists.infradead.org

This series mainly is a rebase version due to it's somehow missed.
See the original one at here:
http://marc.info/?l=linux-mmc&m=138726995528304&w=2
The issue is still exist on latest kernel.

Comparing to V2, the old patch 5 is removed due to someone already pushed one
simalar patch in the tree.
Patch 5 and 6 in this series is newly added for a few clean up and make
timeout_clk calculate more common for other platforms.

Details patch description is as follows:
Patch 1~4 mainly fixes the issue that the max timeout counter for uSDHC is
1 << 28 rather than 1 << 27. 1~2 fix getting the max timeout counter
while 3~4 fix setting the max timeout.
Thus it introduces two new platform hook: get_max_timeout_count and set_timeout
for those platform which have different timeout setting.

This issue is firstly reported here by Ed Sutter:
http://www.spinics.net/lists/linux-mmc/msg23375.html
The root cause is the max_discard_to got from uSDHC is too small, only 677ms,
which cause the max_discard_bytes for eMMC is only 512, then the discard operation
of mkfs.ext3 for an eMMC card is too slow, just like dead.
With above patches, the issue can be fixed.

Originally the max_discard_to for a high speed sdhc card may be:
mmc1: new high speed SDHC card at address aaaa
mmc1: calculated max. discard sectors 49152 for timeout 1355 ms
After fix:
mmc1: new high speed SDHC card at address aaaa
mmc1: calculated max. discard sectors 712704 for timeout 5422 ms

It also improves the card discard performance a lot due to max_discard_sectors
increase a lot.

ChangeLog:
v2->v3:
 1. rebase to Ulf's latest mmc tree
 2. make timeout_clk calcuation common for SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK

ChangeLog:
v1->v2:
 1. change .get_max_timeout to .get_max_timeout_count to reuse some code
 2. some other minor changes based on Shawn's comment.
 3. patch 6 in v1 is dropped since not need anymore after change 1

Dong Aisheng (6):
  mmc: sdhci: add platfrom get_max_timeout_count hook
  mmc: sdhci-esdhc-imx: fix incorrect max timeout cout for uSDHC
  mmc: sdhci: add platform set_timeout hook
  mmc: sdhci-esdhc-imx: set the correct max timeout value for uSDHC
  mmc: sdhci: calculate timeout_clk conditionally in sdhci_add_host
  mmc: sdhci: move timeout_clk dynamically calculation code into common
    code

 drivers/mmc/host/sdhci-esdhc-imx.c |   20 ++++++++++
 drivers/mmc/host/sdhci.c           |   74 ++++++++++++++++++++++--------------
 drivers/mmc/host/sdhci.h           |    3 +
 3 files changed, 68 insertions(+), 29 deletions(-)

-- 
1.7.8

