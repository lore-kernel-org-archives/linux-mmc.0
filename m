From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2] mmc: sdhci-of-arasan: Properly set corecfg_clockmultiplier on rk3399
Date: Fri, 26 Aug 2016 16:51:15 +0800
Message-ID: <1472201475-7970-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.134]:39556 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750766AbcHZI4L (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 26 Aug 2016 04:56:11 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, xzy.xu@rock-chips.com, linux-rockchip@lists.infradead.org, Shawn Lin <shawn.lin@rock-chips.com>, Douglas Anderson <dianders@chromium.org>

corecfg_clockmultiplier indicates clock multiplier value of
programmable clock generator which should be the same value
of SDHCI_CAPABILITIES_1. The default value of the register,
corecfg_clockmultiplier, is 0x10. But actually it is a mistake
by designer as our intention was to set it to be zero which
means we don't support programmable clock generator. So we have
to make it to be zero on bootloader which seems work fine until
now. But now we find an issue that when deploying genpd support
for it, the remove callback will trigger the genpd to poweroff the
power domain for sdhci-of-arasan which manage the controller, phy
and corecfg_* stuff.

So when we do bind/unbind the driver, we have already reinit
the controller and phy, but without doing that for corecfg_*.
Regarding to only the corecfg_clockmultipler is wrong, let's
fix it by explicitly marking it to be zero when probing. With
this change, we could do bind/unbind successfully.

Reported-by: Ziyuan Xu <xzy.xu@rock-chips.com>
Cc: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

Changes in v2:
- fix some typos and build
- move the configuration of corecfg_clockmultiplier after
  enabling aclk_emmc to avoid the off state of aclk_emmc_grf.
  I add a new function to make it more common for other coming
  users who have the same requirment for setting diff clkmul.

 drivers/mmc/host/sdhci-of-arasan.c | 46 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 0b3a9cf..33601a8 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -67,10 +67,12 @@ struct sdhci_arasan_soc_ctl_field {
  * accessible via the syscon API.
  *
  * @baseclkfreq:	Where to find corecfg_baseclkfreq
+ * @clockmultiplier:	Where to find corecfg_clockmultiplier
  * @hiword_update:	If true, use HIWORD_UPDATE to access the syscon
  */
 struct sdhci_arasan_soc_ctl_map {
 	struct sdhci_arasan_soc_ctl_field	baseclkfreq;
+	struct sdhci_arasan_soc_ctl_field	clockmultiplier;
 	bool					hiword_update;
 };
 
@@ -100,6 +102,7 @@ struct sdhci_arasan_data {
 
 static const struct sdhci_arasan_soc_ctl_map rk3399_soc_ctl_map = {
 	.baseclkfreq = { .reg = 0xf000, .width = 8, .shift = 8 },
+	.clockmultiplier = { .reg = 0xf02c, .width = 8, .shift = 0},
 	.hiword_update = true,
 };
 
@@ -379,6 +382,45 @@ static const struct clk_ops arasan_sdcardclk_ops = {
 };
 
 /**
+ * sdhci_arasan_update_clockmultiplier - Set corecfg_clockmultiplier
+ *
+ * The corecfg_clockmultiplier is supposed to contain clock multiplier
+ * value of programmable clock generator.
+ *
+ * NOTES:
+ * - Many existing devices don't seem to do this and work fine.  To keep
+ *   compatibility for old hardware where the device tree doesn't provide a
+ *   register map, this function is a noop if a soc_ctl_map hasn't been provided
+ *   for this platform.
+ * - The value of corecfg_clockmultiplier should sync with that of corresponding
+ *   value reading from sdhci_capability_register. So this function is called
+ *   once at probe time and never called again.
+ *
+ * @host:		The sdhci_host
+ */
+static void sdhci_arasan_update_clockmultiplier(struct sdhci_host *host,
+						u32 value)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
+	const struct sdhci_arasan_soc_ctl_map *soc_ctl_map =
+		sdhci_arasan->soc_ctl_map;
+
+	/* Having a map is optional */
+	if (!soc_ctl_map)
+		return;
+
+	/* If we have a map, we expect to have a syscon */
+	if (!sdhci_arasan->soc_ctl_base) {
+		pr_warn("%s: Have regmap, but no soc-ctl-syscon\n",
+			mmc_hostname(host->mmc));
+		return;
+	}
+
+	sdhci_arasan_syscon_write(host, &soc_ctl_map->clockmultiplier, value);
+}
+
+/**
  * sdhci_arasan_update_baseclkfreq - Set corecfg_baseclkfreq
  *
  * The corecfg_baseclkfreq is supposed to contain the MHz of clk_xin.  This
@@ -559,6 +601,10 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 	sdhci_get_of_property(pdev);
 	pltfm_host->clk = clk_xin;
 
+	if (of_device_is_compatible(pdev->dev.of_node,
+				    "rockchip,rk3399-sdhci-5.1"))
+		sdhci_arasan_update_clockmultiplier(host, 0x0);
+
 	sdhci_arasan_update_baseclkfreq(host);
 
 	ret = sdhci_arasan_register_sdclk(sdhci_arasan, clk_xin, &pdev->dev);
-- 
2.3.7


