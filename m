From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: [PATCH] mmc: sdhci-msm: Do not reset the controller if no card in the slot
Date: Fri, 24 Jun 2016 19:24:59 +0300
Message-ID: <1466785499-7563-1-git-send-email-georgi.djakov@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: adrian.hunter@intel.com, iivanov.xz@gmail.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org
List-Id: linux-mmc@vger.kernel.org

The controller does not clear the "reset bit" when it is reset without
a card in the slot. Because of this, the following error message is seen
while booting with no plugged SD card.

mmc1: Reset 0x1 never completed.

Add the SDHCI_QUIRK_NO_CARD_NO_RESET quirk to avoid this.

Signed-off-by: Ivan T. Ivanov <ivan.ivanov@linaro.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/mmc/host/sdhci-msm.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index ac5700233e12..c613137ae91e 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -477,6 +477,7 @@ static const struct sdhci_ops sdhci_msm_ops = {
 
 static const struct sdhci_pltfm_data sdhci_msm_pdata = {
 	.quirks = SDHCI_QUIRK_BROKEN_CARD_DETECTION |
+		  SDHCI_QUIRK_NO_CARD_NO_RESET |
 		  SDHCI_QUIRK_SINGLE_POWER_WRITE,
 	.ops = &sdhci_msm_ops,
 };
