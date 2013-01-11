From: Doug Anderson <dianders@chromium.org>
Subject: [PATCH v4 5/5] mmc: dw_mmc: Remove DW_MCI_QUIRK_NO_WRITE_PROTECT
Date: Fri, 11 Jan 2013 09:03:54 -0800
Message-ID: <1357923834-31641-5-git-send-email-dianders@chromium.org>
References: <1357842269-15062-1-git-send-email-dianders@chromium.org>
 <1357923834-31641-1-git-send-email-dianders@chromium.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1357923834-31641-1-git-send-email-dianders@chromium.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-samsung-soc@vger.kernel.org, Thomas Abraham <thomas.abraham@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, Will Newton <will.newton@imgtec.com>, Chris Ball <cjb@laptop.org>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, Kyungmin Park <kyungmin.park@samsung.com>
List-Id: linux-mmc@vger.kernel.org

The original quirk was added in the change 'mmc: dw_mmc: add quirk to
indicate missing write protect line'.  The original quirk was added at
a controller level even though each slot has its own write protect (so
the quirk should be at the slot level).  A recent change (mmc: dw_mmc:
Add "disable-wp" device tree property) added a slot-level quirk and
support for the quirk directly to dw_mmc.

Signed-off-by: Doug Anderson <dianders@chromium.org>
---
Changes in v4:
- New for this version; addresses comments from Olof Johansson about
  the fact that we shouldn't have both a slot and controller level
  quirk for the same thing.

 drivers/mmc/host/dw_mmc.c  |    8 +-------
 include/linux/mmc/dw_mmc.h |    7 -------
 2 files changed, 1 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index df62079..60063cc 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -831,13 +831,7 @@ static int dw_mci_get_ro(struct mmc_host *mmc)
 	struct dw_mci_board *brd = slot->host->pdata;
 
 	/* Use platform get_ro function, else try on board write protect */
-
-	/*
-	 * NOTE: DW_MCI_QUIRK_NO_WRITE_PROTECT will be removed in a future
-	 * patch in the series once reference to it is removed.
-	 */
-	if ((brd->quirks & DW_MCI_QUIRK_NO_WRITE_PROTECT) ||
-	    (slot->quirks & DW_MCI_SLOT_QUIRK_NO_WRITE_PROTECT))
+	if (slot->quirks & DW_MCI_SLOT_QUIRK_NO_WRITE_PROTECT)
 		read_only = 0;
 	else if (brd->get_ro)
 		read_only = brd->get_ro(slot->id);
diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
index de61de5..198f0fa 100644
--- a/include/linux/mmc/dw_mmc.h
+++ b/include/linux/mmc/dw_mmc.h
@@ -210,13 +210,6 @@ struct dw_mci_dma_ops {
 /* Unreliable card detection */
 #define DW_MCI_QUIRK_BROKEN_CARD_DETECTION	BIT(3)
 
-/* Write Protect detection not available */
-/*
- * NOTE: DW_MCI_QUIRK_NO_WRITE_PROTECT will be removed in a future
- * patch in the series once reference to it is removed.
- */
-#define DW_MCI_QUIRK_NO_WRITE_PROTECT		BIT(4)
-
 /* Slot level quirks */
 /* This slot has no write protect */
 #define DW_MCI_SLOT_QUIRK_NO_WRITE_PROTECT	BIT(0)
-- 
1.7.7.3
