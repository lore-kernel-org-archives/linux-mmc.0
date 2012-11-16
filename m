From: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>
Subject: [RFC PATCH 3.7.0-rc4 4/4] mm:shmobile: use of_simple_module_id_table macro.
Date: Fri, 16 Nov 2012 13:22:03 +0000
Message-ID: <1353072123-21893-1-git-send-email-srinivas.kandagatla@st.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog115.obsmtp.com ([207.126.144.139]:47919 "EHLO
	eu1sys200aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751624Ab2KPNX0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Nov 2012 08:23:26 -0500
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
 drivers/mmc/host/sh_mobile_sdhi.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 0bdc146..7535ee4 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -316,11 +316,7 @@ static const struct dev_pm_ops tmio_mmc_dev_pm_ops = {
 	.runtime_resume = tmio_mmc_host_runtime_resume,
 };
 
-static const struct of_device_id sh_mobile_sdhi_of_match[] = {
-	{ .compatible = "renesas,shmobile-sdhi" },
-	{ }
-};
-MODULE_DEVICE_TABLE(of, sh_mobile_sdhi_of_match);
+of_simple_module_id_table(sh_mobile_sdhi_of_match, "renesas,shmobile-sdhi");
 
 static struct platform_driver sh_mobile_sdhi_driver = {
 	.driver		= {
-- 
1.7.0.4

