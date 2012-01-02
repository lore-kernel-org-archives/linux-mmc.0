From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH] mmc: dw_mmc: Clear the DDR mode for non-DDR
Date: Mon, 02 Jan 2012 16:00:02 +0900
Message-ID: <000b01ccc91c$26cf0330$746d0990$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
References: 
In-reply-to: 
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <cjb@laptop.org>, linux-samsung-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

UHS_REG should be cleared for non-DDR mode. But currently there is
no way to clear DDR mode, if it is already set once. This patch adds
clearing DDR mode for non-DDD mode.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index c583b94..94e2238 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -707,12 +707,15 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		break;
 	}
 
+	regs = mci_readl(slot->host, UHS_REG);
+
 	/* DDR mode set */
-	if (ios->timing == MMC_TIMING_UHS_DDR50) {
-		regs = mci_readl(slot->host, UHS_REG);
+	if (ios->timing == MMC_TIMING_UHS_DDR50)
 		regs |= (0x1 << slot->id) << 16;
-		mci_writel(slot->host, UHS_REG, regs);
-	}
+	else
+		regs &= ~(0x1 << slot->id) << 16;
+
+	mci_writel(slot->host, UHS_REG, regs);
 
 	if (ios->clock) {
 		/*
-- 
1.7.0.4
