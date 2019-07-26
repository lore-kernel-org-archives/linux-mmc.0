From: "Michael K. Johnson" <johnsonm@danlj.org>
Subject: [PATCH v2 1/2] mmc: sdhci: Add PLL Enable support to internal clock
 setup
Date: Thu, 25 Jul 2019 22:07:46 -0400
Message-ID: <20190726020746.GB12042@people.danlj.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Ben Chuang <ben.chuang@genesyslogic.com.tw>
List-Id: linux-mmc@vger.kernel.org

The GL9750 and GL9755 chipsets, and possibly others, require PLL Enable
setup as part of the internal clock setup as described in 3.2.1 Internal
Clock Setup Sequence of SD Host Controller Simplified Specification
Version 4.20.  This changes the timeouts to the new specification of
150ms for each step and is documented as safe for "prior versions which
do not support PLL Enable."

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Co-developed-by: Michael K Johnson <johnsonm@danlj.org>
Signed-off-by: Michael K Johnson <johnsonm@danlj.org>

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 59acf8e3331e..14957578bf2e 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1636,8 +1636,8 @@ void sdhci_enable_clk(struct sdhci_host *host, u16 clk)
 	clk |= SDHCI_CLOCK_INT_EN;
 	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
 
-	/* Wait max 20 ms */
-	timeout = ktime_add_ms(ktime_get(), 20);
+	/* Wait max 150 ms */
+	timeout = ktime_add_ms(ktime_get(), 150);
 	while (1) {
 		bool timedout = ktime_after(ktime_get(), timeout);
 
@@ -1650,7 +1650,28 @@ void sdhci_enable_clk(struct sdhci_host *host, u16 clk)
 			sdhci_dumpregs(host);
 			return;
 		}
-		udelay(10);
+		usleep_range(10,15);
+	}
+
+	clk |= SDHCI_CLOCK_PLL_EN;
+	clk &= ~SDHCI_CLOCK_INT_STABLE;
+	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+
+	/* Wait max 150 ms */
+	timeout = ktime_add_ms(ktime_get(), 150);
+	while (1) {
+		bool timedout = ktime_after(ktime_get(), timeout);
+
+		clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+		if (clk & SDHCI_CLOCK_INT_STABLE)
+			break;
+		if (timedout) {
+			pr_err("%s: PLL clock never stabilised.\n",
+			       mmc_hostname(host->mmc));
+			sdhci_dumpregs(host);
+			return;
+		}
+		usleep_range(10,15);
 	}
 
 	clk |= SDHCI_CLOCK_CARD_EN;
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 199712e7adbb..72601a4d2e95 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -114,6 +114,7 @@
 #define  SDHCI_DIV_HI_MASK	0x300
 #define  SDHCI_PROG_CLOCK_MODE	0x0020
 #define  SDHCI_CLOCK_CARD_EN	0x0004
+#define  SDHCI_CLOCK_PLL_EN	0x0008
 #define  SDHCI_CLOCK_INT_STABLE	0x0002
 #define  SDHCI_CLOCK_INT_EN	0x0001
 
