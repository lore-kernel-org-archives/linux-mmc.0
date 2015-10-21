From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH 05/19] mmc: core/host: enable support for the standard
 "wakeup-source" property
Date: Wed, 21 Oct 2015 11:10:02 +0100
Message-ID: <1445422216-29375-6-git-send-email-sudeep.holla@arm.com>
References: <1445422216-29375-1-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1445422216-29375-1-git-send-email-sudeep.holla@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-mmc@vger.kernel.org

Though the mmc core driver should/will continue to support the legacy
"enable-sdio-wakeup" property to enable SDIO as the wakeup source, we
need to add support for the new standard property "wakeup-source".

This patch adds support for "wakeup-source" property in addition to the
existing "enable-sdio-wakeup" property.

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/mmc/core/host.c        | 3 ++-
 drivers/mmc/host/sdhci-pltfm.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 5466f25f0281..85222bb56c73 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -513,7 +513,8 @@ int mmc_of_parse(struct mmc_host *host)
 		host->caps2 |= MMC_CAP2_FULL_PWR_CYCLE;
 	if (of_property_read_bool(np, "keep-power-in-suspend"))
 		host->pm_caps |= MMC_PM_KEEP_POWER;
-	if (of_property_read_bool(np, "enable-sdio-wakeup"))
+	if (of_property_read_bool(np, "wakeup-source") ||
+	    of_property_read_bool(np, "enable-sdio-wakeup")) /* legacy */
 		host->pm_caps |= MMC_PM_WAKE_SDIO_IRQ;
 	if (of_property_read_bool(np, "mmc-ddr-1_8v"))
 		host->caps |= MMC_CAP_1_8V_DDR;
diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index a207f5aaf62f..f00374bdafc9 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -108,7 +108,8 @@ void sdhci_get_of_property(struct platform_device *pdev)
 	if (of_find_property(np, "keep-power-in-suspend", NULL))
 		host->mmc->pm_caps |= MMC_PM_KEEP_POWER;
 
-	if (of_find_property(np, "enable-sdio-wakeup", NULL))
+	if (of_property_read_bool(np, "wakeup-source") ||
+	    of_property_read_bool(np, "enable-sdio-wakeup")) /* legacy */
 		host->mmc->pm_caps |= MMC_PM_WAKE_SDIO_IRQ;
 }
 #else
-- 
1.9.1
