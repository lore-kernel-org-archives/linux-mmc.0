From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH 14/22] mmc: dw_mmc: set the supported max/min frequency
Date: Sat, 31 Aug 2013 00:13:31 +0900
Message-ID: <001101cea593$7cddf6a0$7699e3e0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:20248 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756321Ab3H3PNc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Aug 2013 11:13:32 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MSC00C2HNMJXNF0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Sat, 31 Aug 2013 00:13:31 +0900 (KST)
References: 
In-reply-to: 
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <cjb@laptop.org>, 'Jaehoon Chung' <jh80.chung@samsung.com>

Both f_max and f_min will be informed for core layer to request
valid clock rate. But current setting from 'host->bus_hz' may
not represent the max/min frequency properly. Even if host can
actually support high speed than bus_hz, core layer will not
request clock rate over bus_hz. Basically, f_max/f_min can be set
with the values according to spec. And then host will make its best
effort to meet the rate.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
Tested-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 .../devicetree/bindings/mmc/synopsis-dw-mshc.txt   |    4 ++++
 drivers/mmc/host/dw_mmc.c                          |   14 ++++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/synopsis-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/synopsis-dw-mshc.txt
index ae5f8e8..fdbf686 100644
--- a/Documentation/devicetree/bindings/mmc/synopsis-dw-mshc.txt
+++ b/Documentation/devicetree/bindings/mmc/synopsis-dw-mshc.txt
@@ -52,6 +52,9 @@ Optional properties:
   is specified and the ciu clock is specified then we'll try to set the ciu
   clock to this at probe time.
 
+* clock-freq-min-max: Minimum and Maximum clock frequency for card output
+  clock(cclk_out). If it's not specified, max is 200MHZ and min is 400KHz by default.
+
 * num-slots: specifies the number of slots supported by the controller.
   The number of physical slots actually used could be equal or less than the
   value specified by num-slots. If this property is not specified, the value
@@ -97,6 +100,7 @@ board specific portions as listed below.
 
 	dwmmc0@12200000 {
 		clock-frequency = <400000000>;
+		clock-freq-min-max = <400000 200000000>;
 		num-slots = <1>;
 		supports-highspeed;
 		caps2-mmc-hs200-1_8v;
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 7c7cfa2..29deeba 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -50,6 +50,9 @@
 #define DW_MCI_RECV_STATUS	2
 #define DW_MCI_DMA_THRESHOLD	16
 
+#define DW_MCI_FREQ_MAX	200000000	/* unit: HZ */
+#define DW_MCI_FREQ_MIN	400000		/* unit: HZ */
+
 #ifdef CONFIG_MMC_DW_IDMAC
 #define IDMAC_INT_CLR		(SDMMC_IDMAC_INT_AI | SDMMC_IDMAC_INT_NI | \
 				 SDMMC_IDMAC_INT_CES | SDMMC_IDMAC_INT_DU | \
@@ -1936,6 +1939,7 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 	struct dw_mci_slot *slot;
 	const struct dw_mci_drv_data *drv_data = host->drv_data;
 	int ctrl_id, ret;
+	u32 freq[2];
 	u8 bus_width;
 
 	mmc = mmc_alloc_host(sizeof(struct dw_mci_slot), host->dev);
@@ -1951,8 +1955,14 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 	slot->quirks = dw_mci_of_get_slot_quirks(host->dev, slot->id);
 
 	mmc->ops = &dw_mci_ops;
-	mmc->f_min = DIV_ROUND_UP(host->bus_hz, 510);
-	mmc->f_max = host->bus_hz;
+	if (of_property_read_u32_array(host->dev->of_node,
+				       "clock-freq-min-max", freq, 2)) {
+		mmc->f_min = DW_MCI_FREQ_MIN;
+		mmc->f_max = DW_MCI_FREQ_MAX;
+	} else {
+		mmc->f_min = freq[0];
+		mmc->f_max = freq[1];
+	}
 
 	if (host->pdata->get_ocr)
 		mmc->ocr_avail = host->pdata->get_ocr(id);
-- 
1.7.0.4


