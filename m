From: Suneel Garapati <suneel.garapati@xilinx.com>
Subject: [PATCH] drivers: mmc: sdhci: update max frequency only if undefined
Date: Thu, 18 Jun 2015 12:57:07 +0530
Message-ID: <1434612427-1758-1-git-send-email-suneel.garapati@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, michals@xilinx.com, sorenb@xilinx.com, Adrian Hunter <adrian.hunter@intel.com>, Aisheng Dong <b29396@freescale.com>, Haibo Chen <haibo.chen@freescale.com>, Tim Kryger <tim.kryger@gmail.com>, Shawn Guo <shawn.guo@linaro.org>, Yi Sun <yi.y.sun@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, stripathi@apm.com, Suneel Garapati <suneel.garapati@xilinx.com>
List-Id: linux-mmc@vger.kernel.org

f_max parameter of mmc structure is updated unconditionally.
If dt property max-frequency is assigned, this update is
overwriting the dt property value which is undesired.

Signed-off-by: Suneel Garapati <suneel.garapati@xilinx.com>
---
 drivers/mmc/host/sdhci.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index bc14452..c2917d5 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3047,7 +3047,10 @@ int sdhci_add_host(struct sdhci_host *host)
	 * Set host parameters.
	 */
	mmc->ops = &sdhci_ops;
-	mmc->f_max = host->max_clk;
+
+	if(!mmc->f_max)
+		mmc->f_max = host->max_clk;
+
	if (host->ops->get_min_clock)
		mmc->f_min = host->ops->get_min_clock(host);
	else if (host->version >= SDHCI_SPEC_300) {
--
2.1.2
