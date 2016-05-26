From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v6 5/5] mmc: sdhci-of-arasan: implement enhanced strobe callback
Date: Thu, 26 May 2016 09:56:43 +0800
Message-ID: <1464227803-31380-1-git-send-email-shawn.lin@rock-chips.com>
References: <1464227707-30616-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1464227707-30616-1-git-send-email-shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Currently sdhci-arasan 5.1 can support enhanced strobe function,
and we now limit it just for "arasan,sdhci-5.1". Add
mmc-hs400-enhanced-strobe in DT to enable the function if we're
sure our controller can support it.

Signed-off-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>

Acked-by: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Reviewed-by: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Tested-by: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
---

Changes in v6:
- add Doug's test-tag

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/mmc/host/sdhci-of-arasan.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index b6f4c1d..533e2bc 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -25,7 +25,9 @@
 #include "sdhci-pltfm.h"
 
 #define SDHCI_ARASAN_CLK_CTRL_OFFSET	0x2c
+#define SDHCI_ARASAN_VENDOR_REGISTER	0x78
 
+#define VENDOR_ENHANCED_STROBE		BIT(0)
 #define CLK_CTRL_TIMEOUT_SHIFT		16
 #define CLK_CTRL_TIMEOUT_MASK		(0xf << CLK_CTRL_TIMEOUT_SHIFT)
 #define CLK_CTRL_TIMEOUT_MIN_EXP	13
@@ -79,6 +81,21 @@ static void sdhci_arasan_set_clock(struct sdhci_host *host, unsigned int clock)
 	}
 }
 
+static void sdhci_arasan_hs400_enhanced_strobe(struct mmc_host *mmc,
+					struct mmc_ios *ios)
+{
+	u32 vendor;
+	struct sdhci_host *host = mmc_priv(mmc);
+
+	vendor = readl(host->ioaddr + SDHCI_ARASAN_VENDOR_REGISTER);
+	if (ios->enhanced_strobe)
+		vendor |= VENDOR_ENHANCED_STROBE;
+	else
+		vendor &= ~VENDOR_ENHANCED_STROBE;
+
+	writel(vendor, host->ioaddr + SDHCI_ARASAN_VENDOR_REGISTER);
+}
+
 static struct sdhci_ops sdhci_arasan_ops = {
 	.set_clock = sdhci_arasan_set_clock,
 	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
@@ -245,6 +262,9 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev, "phy_power_on err.\n");
 			goto err_phy_power;
 		}
+
+		host->mmc_host_ops.hs400_enhanced_strobe =
+					sdhci_arasan_hs400_enhanced_strobe;
 	}
 
 	ret = sdhci_add_host(host);
-- 
2.3.7


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
