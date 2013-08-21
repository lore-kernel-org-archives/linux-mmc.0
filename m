From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH 04/14] mmc: dw_mmc: add the capability to support hs200 mode
Date: Wed, 21 Aug 2013 22:50:08 +0900
Message-ID: <002901ce9e75$5919ac20$0b4d0460$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:44128 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751719Ab3HUNuJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Aug 2013 09:50:09 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MRV000U6VQZRHK0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 21 Aug 2013 22:50:08 +0900 (KST)
References: 
In-reply-to: 
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <cjb@laptop.org>, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Alim Akhtar' <alim.akhtar@samsung.com>

As host controller can support eMMC's HS200 mode at
1.8V or 1.2V, these capability will be added.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
---
 .../devicetree/bindings/mmc/synopsis-dw-mshc.txt   |    5 +++++
 drivers/mmc/host/dw_mmc.c                          |    6 ++++++
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/synopsis-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/synopsis-dw-mshc.txt
index cdcebea..ae5f8e8 100644
--- a/Documentation/devicetree/bindings/mmc/synopsis-dw-mshc.txt
+++ b/Documentation/devicetree/bindings/mmc/synopsis-dw-mshc.txt
@@ -66,6 +66,10 @@ Optional properties:
 
 * supports-highspeed: Enables support for high speed cards (up to 50MHz)
 
+* caps2-mmc-hs200-1_8v: Supports mmc HS200 SDR 1.8V mode
+
+* caps2-mmc-hs200-1_2v: Supports mmc HS200 SDR 1.2V mode
+
 * broken-cd: as documented in mmc core bindings.
 
 * vmmc-supply: The phandle to the regulator to use for vmmc.  If this is
@@ -95,6 +99,7 @@ board specific portions as listed below.
 		clock-frequency = <400000000>;
 		num-slots = <1>;
 		supports-highspeed;
+		caps2-mmc-hs200-1_8v;
 		broken-cd;
 		fifo-depth = <0x80>;
 		card-detect-delay = <200>;
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 5d1123f..e8396f9 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2186,6 +2186,12 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
 	if (of_find_property(np, "enable-sdio-wakeup", NULL))
 		pdata->pm_caps |= MMC_PM_WAKE_SDIO_IRQ;
 
+	if (of_find_property(np, "caps2-mmc-hs200-1_8v", NULL))
+		pdata->caps2 |= MMC_CAP2_HS200_1_8V_SDR;
+
+	if (of_find_property(np, "caps2-mmc-hs200-1_2v", NULL))
+		pdata->caps2 |= MMC_CAP2_HS200_1_2V_SDR;
+
 	return pdata;
 }
 
-- 
1.7.0.4


