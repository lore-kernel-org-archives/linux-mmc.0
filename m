From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v4 05/12] mmc: sdhci: Disable HS200/HS400 mode if controller can't support 1.8v
Date: Wed, 25 Apr 2018 17:39:30 +0530
Message-ID: <20180425120937.29867-6-kishon@ti.com>
References: <20180425120937.29867-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180425120937.29867-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: kishon@ti.com, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-mmc@vger.kernel.org

Though MMC controller can indicate HS200/HS400 mode capability (by
using "mmc-hs200-1_8v"/"mmc-hs400-1_8v" dt property), if the IO lines
in the board is connected to 3.3v supply, HS200/HS400 mode cannot be
supported. Such boards have "no-1-8-v" property in their dts file.
Disable HS200/HS400 mode for boards which have "no-1-8-v" set.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 drivers/mmc/host/sdhci.c | 1 +
 include/linux/mmc/host.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 2ededa7f43df..b5f047b5f3ae 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3672,6 +3672,7 @@ int sdhci_setup_host(struct sdhci_host *host)
 	if (host->quirks2 & SDHCI_QUIRK2_NO_1_8_V) {
 		host->caps1 &= ~(SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_SDR50 |
 				 SDHCI_SUPPORT_DDR50);
+		mmc->caps2 &= ~MMC_CAP2_HSX00_1_8V;
 	}
 
 	/* Any UHS-I mode in caps implies SDR12 and SDR25 support. */
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 7c6eaf63f5ce..58832451767b 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -345,6 +345,7 @@ struct mmc_host {
 #define MMC_CAP2_HS400_1_2V	(1 << 16)	/* Can support HS400 1.2V */
 #define MMC_CAP2_HS400		(MMC_CAP2_HS400_1_8V | \
 				 MMC_CAP2_HS400_1_2V)
+#define MMC_CAP2_HSX00_1_8V	(MMC_CAP2_HS200_1_8V_SDR | MMC_CAP2_HS400_1_8V)
 #define MMC_CAP2_HSX00_1_2V	(MMC_CAP2_HS200_1_2V_SDR | MMC_CAP2_HS400_1_2V)
 #define MMC_CAP2_SDIO_IRQ_NOTHREAD (1 << 17)
 #define MMC_CAP2_NO_WRITE_PROTECT (1 << 18)	/* No physical write protect pin, assume that card is always read-write */
-- 
2.17.0
