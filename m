From: Suneel Garapati <suneel.garapati@xilinx.com>
Subject: [PATCH 1/2] drivers: mmc: add quirk SDHCI_QUIRK_CLOCK_DIV_ZERO_BROKEN
Date: Tue, 9 Jun 2015 13:01:50 +0530
Message-ID: <1433835111-32522-2-git-send-email-suneel.garapati@xilinx.com>
References: <1433835111-32522-1-git-send-email-suneel.garapati@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2on0093.outbound.protection.outlook.com ([207.46.100.93]:7264
	"EHLO na01-BY2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932400AbbFIHrf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 9 Jun 2015 03:47:35 -0400
In-Reply-To: <1433835111-32522-1-git-send-email-suneel.garapati@xilinx.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, michals@xilinx.com, sorenb@xilinx.com, Adrian Hunter <adrian.hunter@intel.com>, Aisheng Dong <b29396@freescale.com>, Haibo Chen <haibo.chen@freescale.com>, Tim Kryger <tim.kryger@gmail.com>, Shawn Guo <shawn.guo@linaro.org>, Yi Sun <yi.y.sun@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, stripathi@apm.com, Suneel Garapati <suneel.garapati@xilinx.com>

adds quirk for controllers whose clock divider zero is broken,
sdhci_set_clock function will incorporate this modification.

Signed-off-by: Suneel Garapati <suneel.garapati@xilinx.com>
---
 drivers/mmc/host/sdhci.c | 4 ++++
 drivers/mmc/host/sdhci.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 1b4861d..087327e 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1210,6 +1210,10 @@ void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
			}
			real_div = div;
			div >>= 1;
+			if ((host->quirks2 & SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN)
+				&& !div && host->max_clk <= 25000000) {
+				div = 1;
+			}
		}
	} else {
		/* Version 2.00 divisors must be a power of 2. */
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 5521d29..67046ca 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -409,6 +409,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK2_SUPPORT_SINGLE			(1<<13)
 /* Controller broken with using ACMD23 */
 #define SDHCI_QUIRK2_ACMD23_BROKEN			(1<<14)
+/* Broken Clock divider zero in controller */
+#define SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN		(1<<15)

	int irq;		/* Device IRQ */
	void __iomem *ioaddr;	/* Mapped address */
--
2.1.2
