From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [RFC PATCH 3/7] mmc: sdhci: Add callback to set bus mode
Date: Mon, 7 Aug 2017 21:31:38 +0530
Message-ID: <20170807160142.12134-4-kishon@ti.com>
References: <20170807160142.12134-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170807160142.12134-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: kishon@ti.com, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Add callback to set bus mode in sdhci library so that the
controller driver can perform any bus mode specific configurations
in the callback function.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/mmc/host/sdhci.c | 3 +++
 drivers/mmc/host/sdhci.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index fff0baadbc3e..d5050ec42481 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1747,6 +1747,9 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	if (host->quirks & SDHCI_QUIRK_RESET_CMD_DATA_ON_IOS)
 		sdhci_do_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
 
+	if (host->ops->set_bus_mode)
+		host->ops->set_bus_mode(host, ios->bus_mode);
+
 	mmiowb();
 }
 EXPORT_SYMBOL_GPL(sdhci_set_ios);
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index d778034e324d..39c7a2723906 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -583,6 +583,7 @@ struct sdhci_ops {
 	void    (*adma_workaround)(struct sdhci_host *host, u32 intmask);
 	void    (*card_event)(struct sdhci_host *host);
 	void	(*voltage_switch)(struct sdhci_host *host);
+	void	(*set_bus_mode)(struct sdhci_host *host, unsigned int mode);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
2.11.0
