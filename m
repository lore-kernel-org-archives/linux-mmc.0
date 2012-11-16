From: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>
Subject: [RFC PATCH 3.7.0-rc4 3/4] mm:sdhci-spear: use of_simple_module_id_table macro.
Date: Fri, 16 Nov 2012 13:21:53 +0000
Message-ID: <1353072113-21855-1-git-send-email-srinivas.kandagatla@st.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog114.obsmtp.com ([207.126.144.137]:42027 "EHLO
	eu1sys200aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751599Ab2KPNXO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Nov 2012 08:23:14 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: grant.likely@secretlab.ca, rob.herring@calxeda.com, viresh.linux@gmail.com, g.liakhovetski@gmx.de, ian@mnementh.co.uk, thomas.ab@samsung.com
Cc: srinivas.kandagatla@st.com, spear-devel@list.st.com, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

From: Srinivas Kandagatla <srinivas.kandagatla@st.com>

This patch uses of_simple_module_id_table macro to replace code like:

#ifdef CONFIG_OF
	static struct of_device_id xxx_of_match[] = {
		{ .compatible = "yyy,zzz" },
		{ },
	};
	MODULE_DEVICE_TABLE(of, xxx_of_match);
#endif

with
	of_simple_module_id_table(xxx_of_match, "yyy,zzz");

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
---
 drivers/mmc/host/sdhci-spear.c |    8 +-------
 1 files changed, 1 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci-spear.c b/drivers/mmc/host/sdhci-spear.c
index 6be89c0..accf4f4 100644
--- a/drivers/mmc/host/sdhci-spear.c
+++ b/drivers/mmc/host/sdhci-spear.c
@@ -320,13 +320,7 @@ static int sdhci_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(sdhci_pm_ops, sdhci_suspend, sdhci_resume);
 
-#ifdef CONFIG_OF
-static const struct of_device_id sdhci_spear_id_table[] = {
-	{ .compatible = "st,spear300-sdhci" },
-	{}
-};
-MODULE_DEVICE_TABLE(of, sdhci_spear_id_table);
-#endif
+of_simple_module_id_table(sdhci_spear_id_table, "st,spear300-sdhci");
 
 static struct platform_driver sdhci_driver = {
 	.driver = {
-- 
1.7.0.4

