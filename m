From: John Tobias <john.tobias.ph@gmail.com>
Subject: [PATCH 2/4] Moving of_init_opp_table
Date: Tue, 17 Dec 2013 17:17:29 -0800
Message-ID: <1387329451-17480-2-git-send-email-john.tobias.ph@gmail.com>
References: <1387329451-17480-1-git-send-email-john.tobias.ph@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:58116 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751293Ab3LRBRk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Dec 2013 20:17:40 -0500
Received: by mail-pa0-f42.google.com with SMTP id lj1so5279377pab.1
        for <linux-mmc@vger.kernel.org>; Tue, 17 Dec 2013 17:17:39 -0800 (PST)
In-Reply-To: <1387329451-17480-1-git-send-email-john.tobias.ph@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, shawn.guo@linaro.org, festevam@gmail.com, cjb@laptop.org
Cc: John Tobias <john.tobias.ph@gmail.com>

    Moving of_init_opp_table from mach-imx6q.c to imx6q-cpufreq.c in order to avoid adding it to mach-imx6sl.c.
    Just incase the cpu frequency scaling is enabled on iMX6SL.

Signed-off-by: John Tobias <john.tobias.ph@gmail.com>
---
 drivers/cpufreq/imx6q-cpufreq.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index 4b3f18e..2eea3d9 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -166,6 +166,11 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
 		return -ENOENT;
 	}
 
+	if (of_init_opp_table(cpu_dev)) {
+		dev_err(cpu_dev,"failed to init OPP table\n");
+		return -ENODEV;
+	}
+
 	arm_clk = devm_clk_get(cpu_dev, "arm");
 	pll1_sys_clk = devm_clk_get(cpu_dev, "pll1_sys");
 	pll1_sw_clk = devm_clk_get(cpu_dev, "pll1_sw");
-- 
1.8.3.2

