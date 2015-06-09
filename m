From: Suneel Garapati <suneel.garapati@xilinx.com>
Subject: [PATCH 2/2] drivers: mmc: add quirks for broken clock base
Date: Tue, 9 Jun 2015 13:01:51 +0530
Message-ID: <1433835111-32522-3-git-send-email-suneel.garapati@xilinx.com>
References: <1433835111-32522-1-git-send-email-suneel.garapati@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1433835111-32522-1-git-send-email-suneel.garapati@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, michals@xilinx.com, sorenb@xilinx.com, Adrian Hunter <adrian.hunter@intel.com>, Aisheng Dong <b29396@freescale.com>, Haibo Chen <haibo.chen@freescale.com>, Tim Kryger <tim.kryger@gmail.com>, Shawn Guo <shawn.guo@linaro.org>, Yi Sun <yi.y.sun@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, stripathi@apm.com, Suneel Garapati <suneel.garapati@xilinx.com>
List-Id: linux-mmc@vger.kernel.org

adding SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,SDHCI_QUIRK2_PRESET_VALUE_BROKEN
flags for arasan sdhc.

Signed-off-by: Suneel Garapati <suneel.garapati@xilinx.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 21c0c08..ef5a7d2 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -63,6 +63,9 @@ static struct sdhci_ops sdhci_arasan_ops = {

 static struct sdhci_pltfm_data sdhci_arasan_pdata = {
	.ops = &sdhci_arasan_ops,
+	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
+			SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
 };

 #ifdef CONFIG_PM_SLEEP
--
2.1.2
