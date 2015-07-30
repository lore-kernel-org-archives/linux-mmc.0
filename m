From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 08/11] mmc: host: omap_hsmmc: Workaround for errata id i802
Date: Thu, 30 Jul 2015 13:16:31 +0530
Message-ID: <1438242394-25599-9-git-send-email-kishon@ti.com>
References: <1438242394-25599-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438242394-25599-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, ulf.hansson@linaro.org, afenkart@gmail.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: nsekhar@ti.com, kishon@ti.com, mugunthanvnm@ti.com
List-Id: linux-mmc@vger.kernel.org

According to errata i802, DCRC error interrupts
(MMCHS_STAT[21] DCRC=0x1) can occur during the tuning procedure.

The DCRC interrupt, occurs when the last tuning block fails
(the last ratio tested). The delay from CRC check until the
interrupt is asserted is bigger than the delay until assertion
of the tuning end flag. Assertion of tuning end flag is what
masks the interrupts. Because of this race, an erroneous DCRC
interrupt occurs.

The suggested  workaround is to disable DCRC interrupts during
the tuning procedure which is implemented here.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index dcfa92e..96dd406 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -656,8 +656,17 @@ static void omap_hsmmc_enable_irq(struct omap_hsmmc_host *host,
 	is_tuning = (cmd->opcode == MMC_SEND_TUNING_BLOCK) ||
 		    (cmd->opcode == MMC_SEND_TUNING_BLOCK_HS200);
 
-	if (!is_tuning && host->use_dma)
+	if (is_tuning) {
+		/*
+		 * OMAP5/DRA74X/DRA72x Errata i802:
+		 * DCRC error interrupts (MMCHS_STAT[21] DCRC=0x1) can occur
+		 * during the tuning procedure. So disable it during the
+		 * tuning procedure.
+		 */
+		irq_mask &= ~DCRC_EN;
+	} else if (host->use_dma) {
 		irq_mask &= ~(BRR_EN | BWR_EN);
+	}
 
 	/* Disable timeout for erases */
 	if (cmd->opcode == MMC_ERASE)
-- 
1.7.9.5
