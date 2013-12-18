From: John Tobias <john.tobias.ph@gmail.com>
Subject: [PATCH 3/4] Removing imx6q_opp_init
Date: Tue, 17 Dec 2013 17:17:30 -0800
Message-ID: <1387329451-17480-3-git-send-email-john.tobias.ph@gmail.com>
References: <1387329451-17480-1-git-send-email-john.tobias.ph@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:34317 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751293Ab3LRBRl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Dec 2013 20:17:41 -0500
Received: by mail-pa0-f49.google.com with SMTP id kx10so5219374pab.36
        for <linux-mmc@vger.kernel.org>; Tue, 17 Dec 2013 17:17:40 -0800 (PST)
In-Reply-To: <1387329451-17480-1-git-send-email-john.tobias.ph@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, shawn.guo@linaro.org, festevam@gmail.com, cjb@laptop.org
Cc: John Tobias <john.tobias.ph@gmail.com>

    Since of_init_opp_table is in imx6q-cpufreq.c, the imx6q_opp_init is no longer needed anymore.
    The only question right now is the imx6q_opp_check_1p2ghz function.

    Is the function below are acceptible under imx6q_init_late?.

    if (!cpu_dev)
        imx6q_opp_check_1p2ghz(cpu_dev);

    If not, what is the better way to impelement because the said function is board specific?.

Signed-off-by: John Tobias <john.tobias.ph@gmail.com>
---
 arch/arm/mach-imx/mach-imx6q.c | 30 ++++--------------------------
 1 file changed, 4 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index d0cfb22..f5d9e04 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -183,31 +183,6 @@ put_node:
 	of_node_put(np);
 }
 
-static void __init imx6q_opp_init(void)
-{
-	struct device_node *np;
-	struct device *cpu_dev = get_cpu_device(0);
-
-	if (!cpu_dev) {
-		pr_warn("failed to get cpu0 device\n");
-		return;
-	}
-	np = of_node_get(cpu_dev->of_node);
-	if (!np) {
-		pr_warn("failed to find cpu0 node\n");
-		return;
-	}
-
-	if (of_init_opp_table(cpu_dev)) {
-		pr_warn("failed to init OPP table\n");
-		goto put_node;
-	}
-
-	imx6q_opp_check_1p2ghz(cpu_dev);
-
-put_node:
-	of_node_put(np);
-}
 
 static struct platform_device imx6q_cpufreq_pdev = {
 	.name = "imx6q-cpufreq",
@@ -215,6 +190,7 @@ static struct platform_device imx6q_cpufreq_pdev = {
 
 static void __init imx6q_init_late(void)
 {
+	struct device *cpu_dev = get_cpu_device(0);
 	/*
 	 * WAIT mode is broken on TO 1.0 and 1.1, so there is no point
 	 * to run cpuidle on them.
@@ -223,8 +199,10 @@ static void __init imx6q_init_late(void)
 		imx6q_cpuidle_init();
 
 	if (IS_ENABLED(CONFIG_ARM_IMX6Q_CPUFREQ)) {
-		imx6q_opp_init();
 		platform_device_register(&imx6q_cpufreq_pdev);
+		
+		if (!cpu_dev)
+			imx6q_opp_check_1p2ghz(cpu_dev);
 	}
 }
 
-- 
1.8.3.2

