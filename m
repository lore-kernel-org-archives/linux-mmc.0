From: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v6 03/14] mmc: core: Add mmc-card dt sub-node parse in core layer
Date: Tue, 14 Feb 2017 18:01:43 +0100
Message-ID: <34e51d32c82b57571e061e80df3bbaed731db554.1487091464.git-series.gregory.clement@free-electrons.com>
References: <cover.ff78bebe0384f650a51e5e6f0f1dca6e7894b53b.1487091464.git-series.gregory.clement@free-electrons.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.ff78bebe0384f650a51e5e6f0f1dca6e7894b53b.1487091464.git-series.gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
In-Reply-To: <cover.ff78bebe0384f650a51e5e6f0f1dca6e7894b53b.1487091464.git-series.gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
References: <cover.ff78bebe0384f650a51e5e6f0f1dca6e7894b53b.1487091464.git-series.gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Mike Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ziji Hu <huziji-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Jimmy Xu <zmxu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Ryan Gao <ygao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Doug Jones <dougj-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Victor Gu <xigu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, "Wei(SOCP) Liu" <liuw-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Wilson Ding <dingwei-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Yehuda
List-Id: linux-mmc@vger.kernel.org

From: Hu Ziji <huziji-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>

Some vendor host, like Xenon, can support multiple types.
In dts, use mmc-card dt sub-node to indicate eMMC is in use.

Add a generic mmc-card parse function in mmc core layer.
If mmc-card sub-node is detected, set eMMC common caps, such as
MMC_CAP_NONREMOVABLE, MMC_CAP2_NO_SD and MMC_CAP2_NO_SDIO.

Since it is likely that struct mmc_card is not allocated yet when
this mmc-card parse function is called, it will return true if
mmc-card sub-node is detected. Otherwise, return false.
It can help vendor host determine if the card type is eMMC.

Signed-off-by: Hu Ziji <huziji-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 drivers/mmc/core/mmc.c   | 24 ++++++++++++++++++++++++
 include/linux/mmc/core.h |  2 ++
 2 files changed, 26 insertions(+)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index b61b52f9da3d..dc480006a303 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -2111,6 +2111,30 @@ static const struct mmc_bus_ops mmc_ops = {
 };
 
 /*
+ * Parse mmc-card dt sub-node and set eMMC common caps
+ * if mmc-card exists.
+ * If mmc-card is detected, return true.
+ * Otherwise, return false.
+ */
+bool mmc_of_parse_mmc_card(struct mmc_host *host)
+{
+	struct device_node *np;
+	bool ret = false;
+
+	np = mmc_of_find_child_device(host, 0);
+	if (np && of_device_is_compatible(np, "mmc-card")) {
+		/* mmc-card sub-node indicates eMMC card is in use. */
+		host->caps |= MMC_CAP_NONREMOVABLE;
+		host->caps2 |= MMC_CAP2_NO_SDIO | MMC_CAP2_NO_SD;
+		ret = true;
+	}
+
+	of_node_put(np);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mmc_of_parse_mmc_card);
+
+/*
  * Starting point for MMC card init.
  */
 int mmc_attach_mmc(struct mmc_host *host)
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index e33cc748dcfe..1b27323f3b6e 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -234,4 +234,6 @@ struct device_node;
 extern u32 mmc_vddrange_to_ocrmask(int vdd_min, int vdd_max);
 extern int mmc_of_parse_voltage(struct device_node *np, u32 *mask);
 
+extern bool mmc_of_parse_mmc_card(struct mmc_host *host);
+
 #endif /* LINUX_MMC_CORE_H */
-- 
git-series 0.9.1
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
