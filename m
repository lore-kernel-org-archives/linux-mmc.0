From: Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v3 2/2] mmc: core: Add sd discard timeout
Date: Tue, 26 Feb 2019 17:10:25 +0200
Message-ID: <1551193825-31074-3-git-send-email-avri.altman@wdc.com>
References: <1551193825-31074-1-git-send-email-avri.altman@wdc.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1551193825-31074-1-git-send-email-avri.altman@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, Shawn Lin <shawn.lin@rock-chips.com>, Avi Shchislowski <avi.shchislowski@wdc.com>, Alex Lemberg <alex.lemberg@wdc.com>, linux-kernel@vger.kernel.org, Avri Altman <avri.altman@wdc.com>
List-Id: linux-mmc@vger.kernel.org

The busy timeout is 250msec per discard command.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/mmc/core/core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index b7367ac..4979d4e 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -51,6 +51,7 @@
 
 /* The max erase timeout, used when host->max_busy_timeout isn't specified */
 #define MMC_ERASE_TIMEOUT_MS	(60 * 1000) /* 60 s */
+#define SD_DISCARD_TIMEOUT_MS	(250)
 
 static const unsigned freqs[] = { 400000, 300000, 200000, 100000 };
 
@@ -1619,6 +1620,12 @@ static unsigned int mmc_sd_erase_timeout(struct mmc_card *card,
 {
 	unsigned int erase_timeout;
 
+	/* for DISCARD none of the below calculation applies.
+	 * the busy timeout is 250msec per discard command.
+	 */
+	if (arg == SD_DISCARD_ARG)
+		return SD_DISCARD_TIMEOUT_MS;
+
 	if (card->ssr.erase_timeout) {
 		/* Erase timeout specified in SD Status Register (SSR) */
 		erase_timeout = card->ssr.erase_timeout * qty +
-- 
1.9.1
