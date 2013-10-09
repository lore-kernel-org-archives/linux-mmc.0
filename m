From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH 05/10] mmc: sdhci: report error once the maximum tuning loops exhausted or timeout
Date: Wed, 9 Oct 2013 19:20:11 +0800
Message-ID: <1381317616-1229-6-git-send-email-b29396@freescale.com>
References: <1381317616-1229-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe010.messaging.microsoft.com ([216.32.180.30]:24562
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751707Ab3JILe6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Oct 2013 07:34:58 -0400
In-Reply-To: <1381317616-1229-1-git-send-email-b29396@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, cjb@laptop.org, shawn.guo@linaro.org, anton@enomsg.org, s.hauer@pengutronix.de, w.sang@pengutronix.de, b29396@freescale.com, john.tobias.ph@gmail.com

The original code missed to report an error when the maximum tuning loops exhausted
or timeout, it will cause the upper layer to wrongly think the tuning process
is passed.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 drivers/mmc/host/sdhci.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 66bce7a..cbde17d 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1989,6 +1989,7 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	if (!tuning_loop_counter || !timeout) {
 		ctrl &= ~SDHCI_CTRL_TUNED_CLK;
 		sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
+		err = -EIO;
 	} else {
 		if (!(ctrl & SDHCI_CTRL_TUNED_CLK)) {
 			pr_info(DRIVER_NAME ": Tuning procedure"
-- 
1.7.2.rc3


