From: Subhash Jadavani <subhashj@codeaurora.org>
Subject: [PATCH v1 2/3] mmc: sdio: Fix SDIO 3.0 UHS-I initialization sequence
Date: Tue,  4 Dec 2012 17:06:19 +0530
Message-ID: <1354620980-23764-3-git-send-email-subhashj@codeaurora.org>
References: <1354620980-23764-1-git-send-email-subhashj@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1354620980-23764-1-git-send-email-subhashj@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, Sujit Reddy Thumma <sthumma@codeaurora.org>, Subhash Jadavani <subhashj@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

From: Sujit Reddy Thumma <sthumma@codeaurora.org>

According to UHS-I initialization sequence for SDIO 3.0 cards,
the host must set bit[24] (S18R) of OCR register during OCR
handshake to know whether the SDIO card is capable of doing
1.8V I/O.

Signed-off-by: Sujit Reddy Thumma <sthumma@codeaurora.org>
Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
---
 drivers/mmc/core/sdio.c  |   22 +++++++++++-----------
 include/linux/mmc/host.h |    8 ++++++++
 2 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 34ad4c8..9565d38 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -157,10 +157,7 @@ static int sdio_read_cccr(struct mmc_card *card, u32 ocr)
 			if (ret)
 				goto out;
 
-			if (card->host->caps &
-				(MMC_CAP_UHS_SDR12 | MMC_CAP_UHS_SDR25 |
-				 MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_SDR104 |
-				 MMC_CAP_UHS_DDR50)) {
+			if (mmc_host_uhs(card->host)) {
 				if (data & SDIO_UHS_DDR50)
 					card->sw_caps.sd3_bus_mode
 						|= SD_MODE_UHS_DDR50;
@@ -478,8 +475,7 @@ static int sdio_set_bus_speed_mode(struct mmc_card *card)
 	 * If the host doesn't support any of the UHS-I modes, fallback on
 	 * default speed.
 	 */
-	if (!(card->host->caps & (MMC_CAP_UHS_SDR12 | MMC_CAP_UHS_SDR25 |
-	    MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_SDR104 | MMC_CAP_UHS_DDR50)))
+	if (!mmc_host_uhs(card->host))
 		return 0;
 
 	bus_speed = SDIO_SPEED_SDR12;
@@ -645,11 +641,7 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
 	 * systems that claim 1.8v signalling in fact do not support
 	 * it.
 	 */
-	if ((ocr & R4_18V_PRESENT) &&
-		(host->caps &
-			(MMC_CAP_UHS_SDR12 | MMC_CAP_UHS_SDR25 |
-			 MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_SDR104 |
-			 MMC_CAP_UHS_DDR50))) {
+	if ((ocr & R4_18V_PRESENT) && mmc_host_uhs(host)) {
 		err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180,
 				true);
 		if (err) {
@@ -1022,6 +1014,10 @@ static int mmc_sdio_power_restore(struct mmc_host *host)
 		goto out;
 	}
 
+	if (mmc_host_uhs(host))
+		/* to query card if 1.8V signalling is supported */
+		host->ocr |= R4_18V_PRESENT;
+
 	ret = mmc_sdio_init_card(host, host->ocr, host->card,
 				mmc_card_keep_power(host));
 	if (!ret && host->sdio_irqs)
@@ -1087,6 +1083,10 @@ int mmc_attach_sdio(struct mmc_host *host)
 	/*
 	 * Detect and init the card.
 	 */
+	if (mmc_host_uhs(host))
+		/* to query card if 1.8V signalling is supported */
+		host->ocr |= R4_18V_PRESENT;
+
 	err = mmc_sdio_init_card(host, host->ocr, NULL, 0);
 	if (err) {
 		if (err == -EAGAIN) {
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 23df21e..9be0440 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -433,6 +433,14 @@ static inline int mmc_boot_partition_access(struct mmc_host *host)
 	return !(host->caps2 & MMC_CAP2_BOOTPART_NOACC);
 }
 
+static inline int mmc_host_uhs(struct mmc_host *host)
+{
+	return host->caps &
+		(MMC_CAP_UHS_SDR12 | MMC_CAP_UHS_SDR25 |
+		 MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_SDR104 |
+		 MMC_CAP_UHS_DDR50);
+}
+
 #ifdef CONFIG_MMC_CLKGATE
 void mmc_host_clk_hold(struct mmc_host *host);
 void mmc_host_clk_release(struct mmc_host *host);
-- 
--
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
