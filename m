From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v3 1/3] mmc: sdhci: use WP GPIO in sdhci_check_ro()
Date: Tue, 12 Feb 2019 15:07:35 +0100
Message-ID: <20190212140737.8668-2-thomas.petazzoni@bootlin.com>
References: <20190212140737.8668-1-thomas.petazzoni@bootlin.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190212140737.8668-1-thomas.petazzoni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Kishon Vijay Abraham I <kishon@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, Gregory Clement <gregory.clement@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
List-Id: linux-mmc@vger.kernel.org

Even though SDHCI controllers may have a dedicated WP pin that can be
queried using the SDHCI_PRESENT_STATE register, some platforms may
chose to use a separate regular GPIO to route the WP signal. Such a
GPIO is typically represented using the wp-gpios property in the
Device Tree.

Unfortunately, the current sdhci_check_ro() function does not make use
of such GPIO when available: it either uses a host controller specific
->get_ro() operation, or uses the SDHCI_PRESENT_STATE. Several host
controller specific ->get_ro() functions are implemented just to check
a WP GPIO state.

Instead of pushing this to more controller-specific implementations,
let's handle this in the core SDHCI code, just like it is already done
for the CD GPIO in sdhci_get_cd().

The below patch simply changes sdhci_check_ro() to use the value of
the WP GPIO if available.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
Changes since v2:

 - As suggested by Adrian Hunter, keep the argument of
   sdhci_check_ro() as it is: a "struct sdhci_host*"

Changes since v1:

 - As suggested by Adrian Hunter, call the ->get_ro() if it exists
   before falling back to using mmc_gpio_get_ro(). Indeed, if the
   controller-specific code has implemented a ->get_ro() callback, it
   should take precedence over what the SDHCI core does.

   Due to this change, I have not added Thierry Redding Reviewed-by.

 - Fix typo in the commit log noticed by Thierry Redding.
---
 drivers/mmc/host/sdhci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index df05352b6a4a..b3444d12c8c8 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2033,6 +2033,8 @@ static int sdhci_check_ro(struct sdhci_host *host)
 		is_readonly = 0;
 	else if (host->ops->get_ro)
 		is_readonly = host->ops->get_ro(host);
+	else if (mmc_can_gpio_ro(host->mmc))
+		is_readonly = mmc_gpio_get_ro(host->mmc);
 	else
 		is_readonly = !(sdhci_readl(host, SDHCI_PRESENT_STATE)
 				& SDHCI_WRITE_PROTECT);
-- 
2.20.1
