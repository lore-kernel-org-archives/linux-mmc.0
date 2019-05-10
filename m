From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH v2 2/3] mmc: sdhci_am654: Print error message if the DLL fails to lock
Date: Fri, 10 May 2019 09:12:27 +0530
Message-ID: <20190510034228.32211-3-faiz_abbas@ti.com>
References: <20190510034228.32211-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190510034228.32211-1-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, adrian.hunter@intel.com, faiz_abbas@ti.com
List-Id: linux-mmc@vger.kernel.org

Print an error message and return if DLL fails to lock.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/mmc/host/sdhci_am654.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index 337c24b8f4a8..3ff949925127 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -137,6 +137,11 @@ static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
 		ret = regmap_read_poll_timeout(sdhci_am654->base, PHY_STAT1,
 					       val, val & DLLRDY_MASK, 1000,
 					       1000000);
+		if (ret) {
+			dev_err(mmc_dev(host->mmc), "DLL failed to relock\n");
+			return;
+		}
+
 		sdhci_am654->dll_on = true;
 	}
 }
-- 
2.19.2
