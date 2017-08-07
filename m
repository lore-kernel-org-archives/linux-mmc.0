From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [RFC PATCH 1/7] mmc: sdhci: Add quirk to indicate no CRC stripping in MMC_RSP_136
Date: Mon, 7 Aug 2017 21:31:36 +0530
Message-ID: <20170807160142.12134-2-kishon@ti.com>
References: <20170807160142.12134-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170807160142.12134-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: kishon@ti.com, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

TI's implementation of sdhci controller used in DRA7 SoC's doesn't
strip CRC in responses with length 136 bits. Add quirk to indicate
the controller does not strip CRC in MMC_RSP_136. If this quirk is
set sdhci library shouldn't shift the response present in
SDHCI_RESPONSE register.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/mmc/host/sdhci.c | 27 +++++++++++++++++++--------
 drivers/mmc/host/sdhci.h |  2 ++
 2 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index ecd0d4350e8a..ece3751d2a25 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1182,14 +1182,25 @@ static void sdhci_finish_command(struct sdhci_host *host)
 
 	if (cmd->flags & MMC_RSP_PRESENT) {
 		if (cmd->flags & MMC_RSP_136) {
-			/* CRC is stripped so we need to do some shifting. */
-			for (i = 0;i < 4;i++) {
-				cmd->resp[i] = sdhci_readl(host,
-					SDHCI_RESPONSE + (3-i)*4) << 8;
-				if (i != 3)
-					cmd->resp[i] |=
-						sdhci_readb(host,
-						SDHCI_RESPONSE + (3-i)*4-1);
+			if (!(host->quirks2 & SDHCI_QUIRK2_NO_CRC_STRIPPING)) {
+				/*
+				 * CRC is stripped so we need to do some
+				 * shifting.
+				 */
+				for (i = 0; i < 4; i++) {
+					cmd->resp[i] =
+						sdhci_readl(host, SDHCI_RESPONSE
+							    + (3 - i) * 4) << 8;
+					if (i != 3)
+						cmd->resp[i] |=
+						sdhci_readb(host, SDHCI_RESPONSE
+							    + (3 - i) * 4 - 1);
+				}
+			} else {
+				for (i = 0; i < 4; i++)
+					cmd->resp[i] =
+					sdhci_readl(host, SDHCI_RESPONSE +
+						    (3 - i) * 4);
 			}
 		} else {
 			cmd->resp[0] = sdhci_readl(host, SDHCI_RESPONSE);
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 0469fa191493..6905131f603d 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -435,6 +435,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK2_ACMD23_BROKEN			(1<<14)
 /* Broken Clock divider zero in controller */
 #define SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN		(1<<15)
+/* Controller does not have CRC stripped in Command Response */
+#define SDHCI_QUIRK2_NO_CRC_STRIPPING			(1<<16)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
2.11.0
