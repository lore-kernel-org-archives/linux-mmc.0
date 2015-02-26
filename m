From: Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH v2 6/8] mmc: sdhci-st: Update the quirks for this controller.
Date: Thu, 26 Feb 2015 13:10:25 +0000
Message-ID: <1424956227-18258-7-git-send-email-peter.griffin@linaro.org>
References: <1424956227-18258-1-git-send-email-peter.griffin@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424956227-18258-1-git-send-email-peter.griffin@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, maxime.coquelin@st.com, patrice.chotard@st.com, srinivas.kandagatla@gmail.com, chris@printf.net, ulf.hansson@linaro.org
Cc: peter.griffin@linaro.org, lee.jones@linaro.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, peppe.cavallaro@st.com
List-Id: linux-mmc@vger.kernel.org

Some additional quirks need to be enabled now we support UHS
modes. This avoids some spurious warnings like

"Got data interrupt 0x00000002 even though no data operation was in progress"

Testing on stih410-b2120 board achieves the following speeds
with HS200 eMMC card.

max-frequency = 200Mhz
/dev/mmcblk0p1:
 Timing buffered disk reads: 270 MB in  3.02 seconds =  89.54 MB/sec

max-frequency = 100Mhz
root@debian-armhf:~# hdparm -t /dev/mmcblk0p1
/dev/mmcblk0p1:
 Timing buffered disk reads: 210 MB in  3.00 seconds =  70.00 MB/sec

max-frequency = 50Mhz
root@debian-armhf:~# hdparm -t /dev/mmcblk0p1
/dev/mmcblk0p1:
 Timing buffered disk reads: 118 MB in  3.00 seconds =  39.28 MB/sec

This is better than the 3.10 kernel which achieves 77.59 MB/sec
at 200Mhz clock (same board/soc/eMMC).

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
---
 drivers/mmc/host/sdhci-st.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-st.c b/drivers/mmc/host/sdhci-st.c
index d53bc82..c6957b8 100644
--- a/drivers/mmc/host/sdhci-st.c
+++ b/drivers/mmc/host/sdhci-st.c
@@ -338,7 +338,10 @@ static const struct sdhci_ops sdhci_st_ops = {
 static const struct sdhci_pltfm_data sdhci_st_pdata = {
 	.ops = &sdhci_st_ops,
 	.quirks = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC |
-	    SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
+		SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
+		SDHCI_QUIRK_NO_HISPD_BIT,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
+		SDHCI_QUIRK2_STOP_WITH_TC,
 };
 
 
-- 
1.9.1
