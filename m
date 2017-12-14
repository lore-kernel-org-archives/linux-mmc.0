From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 05/12] mmc: sdhci-omap: Workaround for Errata i802
Date: Thu, 14 Dec 2017 18:39:34 +0530
Message-ID: <20171214130941.26666-6-kishon@ti.com>
References: <20171214130941.26666-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171214130941.26666-1-kishon-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Errata i802 in AM572x Sitara Processors Silicon Revision 2.0, 1.1
(SPRZ429K July 2014–Revised March 2017 [1]) mentions
DCRC error interrupts (MMCHS_STAT[21] DCRC=0x1) can occur
during the tuning procedure and it has to be disabled during the
tuning procedure Implement workaround for Errata i802 here..

[1] -> http://www.ti.com/lit/er/sprz429k/sprz429k.pdf

Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
---
 drivers/mmc/host/sdhci-omap.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index df8a0a472996..b20f4c79ccc6 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -266,6 +266,7 @@ static int sdhci_omap_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	struct sdhci_pltfm_host *pltfm_host;
 	struct sdhci_omap_host *omap_host;
 	struct device *dev;
+	u32 ier = host->ier;
 
 	pltfm_host = sdhci_priv(host);
 	omap_host = sdhci_pltfm_priv(pltfm_host);
@@ -283,6 +284,16 @@ static int sdhci_omap_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	reg |= DLL_SWT;
 	sdhci_omap_writel(omap_host, SDHCI_OMAP_DLL, reg);
 
+	/*
+	 * OMAP5/DRA74X/DRA72x Errata i802:
+	 * DCRC error interrupts (MMCHS_STAT[21] DCRC=0x1) can occur
+	 * during the tuning procedure. So disable it during the
+	 * tuning procedure.
+	 */
+	ier &= ~SDHCI_INT_DATA_CRC;
+	sdhci_writel(host, ier, SDHCI_INT_ENABLE);
+	sdhci_writel(host, ier, SDHCI_SIGNAL_ENABLE);
+
 	while (phase_delay <= MAX_PHASE_DELAY) {
 		sdhci_omap_set_dll(omap_host, phase_delay);
 
@@ -328,6 +339,8 @@ static int sdhci_omap_execute_tuning(struct mmc_host *mmc, u32 opcode)
 
 ret:
 	sdhci_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
+	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
+	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
 	return ret;
 }
 
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
