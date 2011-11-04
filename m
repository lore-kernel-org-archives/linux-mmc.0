From: Giuseppe CAVALLARO <peppe.cavallaro@st.com>
Subject: [PATCH] mmc: debugfs: expose the SDCLK frq in sys ios (V6)
Date: Fri,  4 Nov 2011 13:53:19 +0100
Message-ID: <1320411199-16860-1-git-send-email-peppe.cavallaro@st.com>
References: <4EB3A9A4.1000205@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog115.obsmtp.com ([207.126.144.139]:38340 "EHLO
	eu1sys200aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752438Ab1KDMxu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Nov 2011 08:53:50 -0400
In-Reply-To: <4EB3A9A4.1000205@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: adrian.hunter@intel.com, Giuseppe Cavallaro <peppe.cavallaro@st.com>

This patch is to expose the actual SDCLK frequency in
/sys/kernel/debug/mmcX/ios entry.

For example, if the max clk for a normal speed card is 20MHz
this is reported in /sys/kernel/debug/mmcX/ios.
Unfortunately the actual SDCLK frequency (i.e. Baseclock / divisor)
is not reported at all: for example, in that case, on Arasan HC,
it should be 48/4=12 (MHz).

Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
---
 drivers/mmc/core/debugfs.c |    2 ++
 drivers/mmc/host/sdhci.c   |   10 ++++++++++
 include/linux/mmc/host.h   |    2 ++
 3 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
index c3f24a7..688f4f8 100644
--- a/drivers/mmc/core/debugfs.c
+++ b/drivers/mmc/core/debugfs.c
@@ -56,6 +56,8 @@ static int mmc_ios_show(struct seq_file *s, void *data)
 	const char *str;
 
 	seq_printf(s, "clock:\t\t%u Hz\n", ios->clock);
+	if (host->actual_clock)
+		seq_printf(s, "actual clock:\t%u Hz\n", host->actual_clock);
 	seq_printf(s, "vdd:\t\t%u ", ios->vdd);
 	if ((1 << ios->vdd) & MMC_VDD_165_195)
 		seq_printf(s, "(1.65 - 1.95 V)\n");
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 6d8eea3..f900239 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1066,12 +1066,15 @@ static void sdhci_finish_command(struct sdhci_host *host)
 static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 {
 	int div = 0; /* Initialized for compiler warning */
+	int real_div = div, clk_mul = 1;
 	u16 clk = 0;
 	unsigned long timeout;
 
 	if (clock == host->clock)
 		return;
 
+	host->mmc->actual_clock = 0;
+
 	if (host->ops->set_clock) {
 		host->ops->set_clock(host, clock);
 		if (host->quirks & SDHCI_QUIRK_NONSTANDARD_CLOCK)
@@ -1109,6 +1112,8 @@ static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 				 * Control register.
 				 */
 				clk = SDHCI_PROG_CLOCK_MODE;
+				real_div = div;
+				clk_mul = host->clk_mul;
 				div--;
 			}
 		} else {
@@ -1122,6 +1127,7 @@ static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 						break;
 				}
 			}
+			real_div = div;
 			div >>= 1;
 		}
 	} else {
@@ -1130,9 +1136,13 @@ static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 			if ((host->max_clk / div) <= clock)
 				break;
 		}
+		real_div = div;
 		div >>= 1;
 	}
 
+	if (real_div)
+		host->mmc->actual_clock = (host->max_clk * clk_mul) / real_div;
+
 	clk |= (div & SDHCI_DIV_MASK) << SDHCI_DIVIDER_SHIFT;
 	clk |= ((div & SDHCI_DIV_HI_MASK) >> SDHCI_DIV_MASK_LEN)
 		<< SDHCI_DIVIDER_HI_SHIFT;
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index a3ac9c4..cea064f 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -323,6 +323,8 @@ struct mmc_host {
 	struct fault_attr	fail_mmc_request;
 #endif
 
+	unsigned int		actual_clock;	/* Actual HC clock rate */
+
 	unsigned long		private[0] ____cacheline_aligned;
 };
 
-- 
1.7.4.4

