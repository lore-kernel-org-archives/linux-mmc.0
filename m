From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v3 05/11] mmc: sdhci: Disable HS200 mode if controller can't support 1.8v
Date: Wed, 7 Mar 2018 18:50:14 +0530
Message-ID: <20180307132020.30951-6-kishon@ti.com>
References: <20180307132020.30951-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180307132020.30951-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Tony Lindgren <tony@atomide.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, kishon@ti.com, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Though MMC controller can indicate HS200 mode capability (by
using "mmc-hs200-1_8v" dt property), if the IO lines in the board
is connected to 3.3v supply, HS200 mode cannot be supported.
Such boards have "no-1-8-v" property in their dts file. Disable HS200
mode for boards which have "no-1-8-v" set.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/mmc/host/sdhci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 2ededa7f43df..aa8b5ca0d1b0 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3672,6 +3672,7 @@ int sdhci_setup_host(struct sdhci_host *host)
 	if (host->quirks2 & SDHCI_QUIRK2_NO_1_8_V) {
 		host->caps1 &= ~(SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_SDR50 |
 				 SDHCI_SUPPORT_DDR50);
+		mmc->caps2 &= ~MMC_CAP2_HS200;
 	}
 
 	/* Any UHS-I mode in caps implies SDR12 and SDR25 support. */
-- 
2.11.0
