From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2] mmc: core: Do not set mmc voltage to 1.8V when 'no-1-8-v' is present
Date: Sat, 13 Jun 2015 17:24:27 -0300
Message-ID: <1434227067-9600-1-git-send-email-festevam@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f178.google.com ([209.85.220.178]:34319 "EHLO
	mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751125AbbFMUZE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 13 Jun 2015 16:25:04 -0400
Received: by qkdm188 with SMTP id m188so12432147qkd.1
        for <linux-mmc@vger.kernel.org>; Sat, 13 Jun 2015 13:25:03 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: aisheng.dong@freescale.com, kevin.lemoi@savant.com, otavio@ossystems.com.br, kernel@pengutronix.de, linux@arm.linux.org.uk, chuanxiao.dong@intel.com, linux-mmc@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com>

Since commit 312449efd16bb06 ("mmc: core: Fix sequence for I/O voltage
in DDR mode for eMMC") the mmc voltage is set to 1.8V inside 
mmc_select_hs_ddr(), even if 'no-1-8-v' property is present.

This causes the following error on a mx6sl board with the 'no-1-8-v' 
property passed in the device tree:

mmc0: power class selection to bus width 8 ddr 4 failed
mmc0: error -110 whilst initialising MMC card

Fix this problem by only setting the mmc voltage to 1.8V if the 
'no-1-8-v' property is absent.

Reported-by: Kevin Lemoi <kevin.lemoi@savant.com>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Fix it in the core code instead of doing it inside the sdhci imx code

 drivers/mmc/core/host.c  | 2 ++
 drivers/mmc/core/mmc.c   | 8 +++++++-
 include/linux/mmc/host.h | 1 +
 include/linux/mmc/mmc.h  | 1 +
 4 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 01fa1ed..736c985 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -527,6 +527,8 @@ int mmc_of_parse(struct mmc_host *host)
 		host->caps2 |= MMC_CAP2_HS400_1_8V | MMC_CAP2_HS200_1_8V_SDR;
 	if (of_find_property(np, "mmc-hs400-1_2v", &len))
 		host->caps2 |= MMC_CAP2_HS400_1_2V | MMC_CAP2_HS200_1_2V_SDR;
+	if (of_find_property(np, "no-1-8-v", &len))
+		host->caps2 |= MMC_CAP_3_3V_ONLY_DDR;
 
 	host->dsr_req = !of_property_read_u32(np, "dsr", &host->dsr);
 	if (host->dsr_req && (host->dsr & ~0xffff)) {
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index e726903..e76b9af 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -205,6 +205,10 @@ static void mmc_select_card_type(struct mmc_card *card)
 		avail_type |= EXT_CSD_CARD_TYPE_DDR_1_8V;
 	}
 
+	if (caps2 & MMC_CAP_3_3V_ONLY_DDR &&
+	    card_type & EXT_CSD_CARD_TYPE_DDR_1_8V)
+		avail_type |= EXT_CSD_CARD_TYPE_DDR_3_3V_ONLY;
+
 	if (caps & MMC_CAP_1_2V_DDR &&
 	    card_type & EXT_CSD_CARD_TYPE_DDR_1_2V) {
 		hs_max_dtr = MMC_HIGH_DDR_MAX_DTR;
@@ -1028,7 +1032,9 @@ static int mmc_select_hs_ddr(struct mmc_card *card)
 		err = __mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_120);
 
 	if (err && (card->mmc_avail_type & EXT_CSD_CARD_TYPE_DDR_1_8V))
-		err = __mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180);
+		if (!(card->mmc_avail_type & EXT_CSD_CARD_TYPE_DDR_3_3V_ONLY))
+			err = __mmc_set_signal_voltage(host,
+						       MMC_SIGNAL_VOLTAGE_180);
 
 	/* make sure vccq is 3.3v after switching disaster */
 	if (err)
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 1369e54..5aa999f 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -289,6 +289,7 @@ struct mmc_host {
 #define MMC_CAP2_HSX00_1_2V	(MMC_CAP2_HS200_1_2V_SDR | MMC_CAP2_HS400_1_2V)
 #define MMC_CAP2_SDIO_IRQ_NOTHREAD (1 << 17)
 #define MMC_CAP2_NO_WRITE_PROTECT (1 << 18)	/* No physical write protect pin, assume that card is always read-write */
+#define MMC_CAP_3_3V_ONLY_DDR	(1 << 19)	/* Only supports 3.3V DDR */
 
 	mmc_pm_flag_t		pm_caps;	/* supported pm features */
 
diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index 15f2c4a..b3cbd3c 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -380,6 +380,7 @@ struct _mmc_csd {
 #define EXT_CSD_CARD_TYPE_HS400_1_2V	(1<<7)	/* Card can run at 200MHz DDR, 1.2V */
 #define EXT_CSD_CARD_TYPE_HS400		(EXT_CSD_CARD_TYPE_HS400_1_8V | \
 					 EXT_CSD_CARD_TYPE_HS400_1_2V)
+#define EXT_CSD_CARD_TYPE_DDR_3_3V_ONLY	(1<<8)
 
 #define EXT_CSD_BUS_WIDTH_1	0	/* Card is in 1 bit mode */
 #define EXT_CSD_BUS_WIDTH_4	1	/* Card is in 4 bit mode */
-- 
1.9.1

