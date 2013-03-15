From: Doug Anderson <dianders@chromium.org>
Subject: [PATCH] RFC: mmc: dw_mmc: Don't clear errors we aren't handling
Date: Fri, 15 Mar 2013 14:30:47 -0700
Message-ID: <1363383047-15285-1-git-send-email-dianders@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Will Newton <will.newton@gmail.com>, Seungwon Jeon <tgih.jun@samsung.com>, Bing Zhao <bzhao@marvell.com>, Jaehoon Chung <jh80.chung@samsung.com>, Ashok Nagarajan <asnagarajan@chromium.org>, Paul Stewart <pstew@chromium.org>, Olof Johansson <olof@lixom.net>, Doug Anderson <dianders@chromium.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Although there are no known cases of this being a problem (and it may
be technically impossible for the hardware to report more errors once
already in the error state), it seems unwise for us to be clearing
error interrupts that we didn't actually read.

Signed-off-by: Doug Anderson <dianders@chromium.org>
---
 drivers/mmc/host/dw_mmc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 9834221..84ae704 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1583,7 +1583,8 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
 			break;
 
 		if (pending & DW_MCI_CMD_ERROR_FLAGS) {
-			mci_writel(host, RINTSTS, DW_MCI_CMD_ERROR_FLAGS);
+			mci_writel(host, RINTSTS,
+				   pending & DW_MCI_CMD_ERROR_FLAGS);
 			host->cmd_status = pending;
 			smp_wmb();
 			set_bit(EVENT_CMD_COMPLETE, &host->pending_events);
@@ -1591,7 +1592,8 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
 
 		if (pending & DW_MCI_DATA_ERROR_FLAGS) {
 			/* if there is an error report DATA_ERROR */
-			mci_writel(host, RINTSTS, DW_MCI_DATA_ERROR_FLAGS);
+			mci_writel(host, RINTSTS,
+				   pending & DW_MCI_DATA_ERROR_FLAGS);
 			host->data_status = pending;
 			smp_wmb();
 			set_bit(EVENT_DATA_ERROR, &host->pending_events);
-- 
1.8.1.3
