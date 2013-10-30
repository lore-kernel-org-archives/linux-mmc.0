From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH 1/2] mmc: sdhci: replace msleep with mdelay for tuning
Date: Wed, 30 Oct 2013 22:10:41 +0800
Message-ID: <1383142242-24989-2-git-send-email-b29396@freescale.com>
References: <1383142242-24989-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe004.messaging.microsoft.com ([216.32.180.14]:20138
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753167Ab3J3O3q (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Oct 2013 10:29:46 -0400
In-Reply-To: <1383142242-24989-1-git-send-email-b29396@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, cjb@laptop.org, shawn.guo@linaro.org, s.hauer@pengutronix.de, b29396@freescale.com, wsa@the-dreams.de

The former patch 404aceb may break the tuning process of SD3.0/eMMC4.5 cards.
It changed the mdelay in tuning process to msleep,
However, because the more delay of msleep(1) than mdelay(1), it will
easily lead to a 150ms timeout as limited by the spec.

We oberved tuning failed due to timeout on a Toshiba UHS and eMMC4.5 card
after this change. Thus, for the time sensitive tuning process, change it
back to mdelay as before.

The breaking patch is:
404aceb mmc: sdhci: Get rid of mdelay()s where it is safe and makes sense

Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 drivers/mmc/host/sdhci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 22eab3a..2ef5314 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1981,7 +1981,7 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 
 		ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
 		tuning_loop_counter--;
-		msleep(1);
+		mdelay(1);
 	} while (ctrl & SDHCI_CTRL_EXEC_TUNING);
 
 	/*
-- 
1.7.2.rc3


