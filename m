From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v3 02/11] mmc: sdhci-omap: Remove setting ADMA capability in
 driver
Date: Wed, 7 Mar 2018 18:50:11 +0530
Message-ID: <20180307132020.30951-3-kishon@ti.com>
References: <20180307132020.30951-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180307132020.30951-1-kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Tony Lindgren <tony@atomide.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Russell King <linux@armlinux.org.uk>, kishon@ti.com, Rob Herring <robh+dt@kernel.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

sdhci can directly get ADMA capability from MMCHS_CAPA register.
Remove explicitly setting ADMA here as some instances might not have
ADMA enabled. (sdhci_read_caps() is also removed from here since
sdhci_setup_host() invokes it).

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/mmc/host/sdhci-omap.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index 3cce30584d2f..0c40b13fb67d 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -923,9 +923,6 @@ static int sdhci_omap_probe(struct platform_device *pdev)
 	host->mmc_host_ops.card_busy = sdhci_omap_card_busy;
 	host->mmc_host_ops.execute_tuning = sdhci_omap_execute_tuning;
 
-	sdhci_read_caps(host);
-	host->caps |= SDHCI_CAN_DO_ADMA2;
-
 	ret = sdhci_setup_host(host);
 	if (ret)
 		goto err_put_sync;
-- 
2.11.0
