From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH RFC 2/4] mmc: sdio: Add capability to skip SDIO reset at scan
Date: Fri, 21 Apr 2017 13:08:06 +0300
Message-ID: <1492769288-7474-3-git-send-email-adrian.hunter@intel.com>
References: <1492769288-7474-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1492769288-7474-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, linux-pm <linux-pm@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-mmc@vger.kernel.org

The SDIO card state might be being preserved during hibernation, for
example a SDIO wifi card supporting WOWLAN. That state will be lost if an
SDIO reset is done. One way to avoid that would be to build mmc core as a
module and simply not load it until after attempting to restore the
hibernation image. However that won't work if the hibernation image is
stored on eMMC which, of course, requires mmc core.

It is assumed on such systems that the platform will power cycle the SDIO
card or not as necessary so that the SDIO reset is not needed. Add a
capability flag to reflect that and use it to skip the SDIO reset at scan
time.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/core.c  | 6 +++++-
 include/linux/mmc/host.h | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 6987976252ad..178e23bf0c30 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2639,8 +2639,12 @@ static int mmc_rescan_try_freq(struct mmc_host *host, unsigned freq)
 	 * if the card is being re-initialized, just send it.  CMD52
 	 * should be ignored by SD/eMMC cards.
 	 * Skip it if we already know that we do not support SDIO commands
+	 * Also skip it if we know this host controller has a SDIO card that
+	 * needs to be able to restore from hibernation without losing the card
+	 * state e.g. an SDIO wifi card supporting WOWLAN.
 	 */
-	if (!(host->caps2 & MMC_CAP2_NO_SDIO))
+	if (!(host->caps2 & MMC_CAP2_NO_SDIO) &&
+	    !(host->caps2 & MMC_CAP2_NO_SDIO_RESET))
 		sdio_reset(host);
 
 	mmc_go_idle(host);
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 78c544e296cd..187a7ba41364 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -281,6 +281,7 @@ struct mmc_host {
 	u32			caps2;		/* More host capabilities */
 
 #define MMC_CAP2_BOOTPART_NOACC	(1 << 0)	/* Boot partition no access */
+#define MMC_CAP2_NO_SDIO_RESET	(1 << 1)	/* Do not SDIO reset at scan */
 #define MMC_CAP2_FULL_PWR_CYCLE	(1 << 2)	/* Can do full power cycle */
 #define MMC_CAP2_HS200_1_8V_SDR	(1 << 5)        /* can support */
 #define MMC_CAP2_HS200_1_2V_SDR	(1 << 6)        /* can support */
-- 
1.9.1

