From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [RFC PATCH 1/1] dw_mmc: add quirk about using only one slot
Date: Fri, 25 Mar 2011 15:00:35 +0900
Message-ID: <4D8C2F83.4040403@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:35426 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753492Ab1CYGBg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Mar 2011 02:01:36 -0400
Received: from epmmp1 (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LIL002KWNEK9H90@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 25 Mar 2011 15:01:32 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LIL00440NEK9N@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 25 Mar 2011 15:01:32 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: will.newton@imgtec.com, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>

If assume only using one slot, i think that dw_mci_queue_request() need not.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com
---
 drivers/mmc/host/dw_mmc.c  |    9 +++++++--
 include/linux/mmc/dw_mmc.h |    3 ++-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 882d004..e3f26ea 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -673,8 +673,13 @@ static void dw_mci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		return;
 	}
 
-	/* We don't support multiple blocks of weird lengths. */
-	dw_mci_queue_request(host, slot, mrq);
+	if (host->quirks & DW_MCI_QUIRK_FORCE_ONE_SLOT) {
+		slot->mrq = mrq;
+		host->state = STATE_SENDING_CMD;
+		dw_mci_start_request(host, slot);
+	} else
+		/* We don't support multiple blocks of weird lengths. */
+		dw_mci_queue_request(host, slot, mrq);
 }
 
 static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
index c0207a7..82f59c2 100644
--- a/include/linux/mmc/dw_mmc.h
+++ b/include/linux/mmc/dw_mmc.h
@@ -176,7 +176,8 @@ struct dw_mci_dma_ops {
 #define DW_MCI_QUIRK_HIGHSPEED			BIT(2)
 /* Unreliable card detection */
 #define DW_MCI_QUIRK_BROKEN_CARD_DETECTION	BIT(3)
-
+/* Force using only one slot */
+#define DW_MCI_QUIRK_FORCE_ONE_SLOT		BIT(4)
 
 struct dma_pdata;
 
