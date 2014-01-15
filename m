From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH 3/5] mmc: step power class after final selection of bus mode
Date: Wed, 15 Jan 2014 23:14:32 +0900
Message-ID: <002901cf11fc$1cd81df0$568859d0$%jun@samsung.com>
References: <1383653403-10049-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:57381 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751964AbaAOOOe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Jan 2014 09:14:34 -0500
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MZG007Y94W9XE50@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 15 Jan 2014 23:14:33 +0900 (KST)
In-reply-to: 
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Chris Ball' <chris@printf.net>, 'Ulf Hansson' <ulf.hansson@linaro.org>, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Jackey Shen' <jackey.shen@amd.com>, 'Alim Akhtar' <alim.akhtar@samsung.com>
Cc: linux-mmc@vger.kernel.org

Power class is changed once only after selection of bus modes
including speed and bus-width finishes finally.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
---
 drivers/mmc/core/mmc.c |   77 +++++++++++++++++++++++++++++++----------------
 1 files changed, 51 insertions(+), 26 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 1ea155a..92aa004 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -737,8 +737,8 @@ static inline unsigned int mmc_snoop_ddr(struct mmc_card *card)
  * extended CSD register, select it by executing the
  * mmc_switch command.
  */
-static int mmc_select_powerclass(struct mmc_card *card,
-		unsigned int bus_width)
+static int __mmc_select_powerclass(struct mmc_card *card,
+				   unsigned int bus_width, u8 *ext_csd)
 {
 	int err = 0;
 	unsigned int pwrclass_val = 0;
@@ -759,13 +759,13 @@ static int mmc_select_powerclass(struct mmc_card *card,
 
 	switch (1 << host->ios.vdd) {
 	case MMC_VDD_165_195:
-		if (host->ios.clock <= 26000000)
+		if (host->ios.clock <= MMC_HIGH_26_MAX_DTR)
 			pwrclass_val = card->ext_csd.raw_pwr_cl_26_195;
-		else if	(host->ios.clock <= 52000000)
+		else if	(host->ios.clock <= MMC_HIGH_52_MAX_DTR)
 			pwrclass_val = (bus_width <= EXT_CSD_BUS_WIDTH_8) ?
 				card->ext_csd.raw_pwr_cl_52_195 :
 				card->ext_csd.raw_pwr_cl_ddr_52_195;
-		else if (host->ios.clock <= 200000000)
+		else if (host->ios.clock <= MMC_HS200_MAX_DTR)
 			pwrclass_val = card->ext_csd.raw_pwr_cl_200_195;
 		break;
 	case MMC_VDD_27_28:
@@ -777,13 +777,13 @@ static int mmc_select_powerclass(struct mmc_card *card,
 	case MMC_VDD_33_34:
 	case MMC_VDD_34_35:
 	case MMC_VDD_35_36:
-		if (host->ios.clock <= 26000000)
+		if (host->ios.clock <= MMC_HIGH_26_MAX_DTR)
 			pwrclass_val = card->ext_csd.raw_pwr_cl_26_360;
-		else if	(host->ios.clock <= 52000000)
+		else if	(host->ios.clock <= MMC_HIGH_52_MAX_DTR)
 			pwrclass_val = (bus_width <= EXT_CSD_BUS_WIDTH_8) ?
 				card->ext_csd.raw_pwr_cl_52_360 :
 				card->ext_csd.raw_pwr_cl_ddr_52_360;
-		else if (host->ios.clock <= 200000000)
+		else if (host->ios.clock <= MMC_HS200_MAX_DTR)
 			pwrclass_val = card->ext_csd.raw_pwr_cl_200_360;
 		break;
 	default:
@@ -810,6 +810,44 @@ static int mmc_select_powerclass(struct mmc_card *card,
 	return err;
 }
 
+static int mmc_select_powerclass(struct mmc_card *card, u8 *ext_csd)
+{
+	int err, ddr;
+	u32 bus_width, ext_csd_bits;
+	struct mmc_host *host;
+
+	BUG_ON(!card);
+
+	host = card->host;
+
+	if (!ext_csd)
+		return 0;
+
+	/* Power class selection is supported for versions >= 4.0 */
+	if (card->csd.mmca_vsn < CSD_SPEC_VER_4)
+		return 0;
+
+	bus_width = host->ios.bus_width;
+	/* Power class values are defined only for 4/8 bit bus */
+	if (bus_width == MMC_BUS_WIDTH_1)
+		return 0;
+
+	ddr = mmc_snoop_ddr(card);
+	if (ddr)
+		ext_csd_bits = (bus_width == MMC_BUS_WIDTH_8) ?
+			EXT_CSD_DDR_BUS_WIDTH_8 : EXT_CSD_DDR_BUS_WIDTH_4;
+	else
+		ext_csd_bits = (bus_width == MMC_BUS_WIDTH_8) ?
+			EXT_CSD_BUS_WIDTH_8 :  EXT_CSD_BUS_WIDTH_4;
+
+	err = __mmc_select_powerclass(card, ext_csd_bits, ext_csd);
+	if (err)
+		pr_warn("%s: power class selection to bus width %d ddr %d failed\n",
+			mmc_hostname(host), 1 << bus_width, ddr);
+
+	return err;
+}
+
 /*
  * Selects the desired buswidth and switch to the HS200 mode
  * if bus width set without error
@@ -1168,11 +1206,6 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 
 		ext_csd_bits = (bus_width == MMC_BUS_WIDTH_8) ?
 				EXT_CSD_BUS_WIDTH_8 : EXT_CSD_BUS_WIDTH_4;
-		err = mmc_select_powerclass(card, ext_csd_bits);
-		if (err)
-			pr_warning("%s: power class selection to bus width %d"
-				   " failed\n", mmc_hostname(card->host),
-				   1 << bus_width);
 	}
 
 	/*
@@ -1201,12 +1234,6 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 			bus_width = bus_widths[idx];
 			if (bus_width == MMC_BUS_WIDTH_1)
 				ddr = 0; /* no DDR for 1-bit width */
-			err = mmc_select_powerclass(card, ext_csd_bits[idx][0]);
-			if (err)
-				pr_warning("%s: power class selection to "
-					   "bus width %d failed\n",
-					   mmc_hostname(card->host),
-					   1 << bus_width);
 
 			err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 					 EXT_CSD_BUS_WIDTH,
@@ -1231,13 +1258,6 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 		}
 
 		if (!err && ddr) {
-			err = mmc_select_powerclass(card, ext_csd_bits[idx][1]);
-			if (err)
-				pr_warning("%s: power class selection to "
-					   "bus width %d ddr %d failed\n",
-					   mmc_hostname(card->host),
-					   1 << bus_width, ddr);
-
 			err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 					 EXT_CSD_BUS_WIDTH,
 					 ext_csd_bits[idx][1],
@@ -1275,6 +1295,11 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	}
 
 	/*
+	 * Choose the power calss with selected bus interface
+	 */
+	mmc_select_powerclass(card, ext_csd);
+
+	/*
 	 * Enable HPI feature (if supported)
 	 */
 	if (card->ext_csd.hpi) {
-- 
1.7.0.4


