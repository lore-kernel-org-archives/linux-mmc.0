From: Jisheng Zhang <jszhang@marvell.com>
Subject: [PATCH v4 13/13] mmc: sdhci-pltfm: remove priv variable from sdhci_pltfm_host
Date: Tue, 26 Jan 2016 18:15:53 +0800
Message-ID: <1453803353-6266-14-git-send-email-jszhang@marvell.com>
References: <1453803353-6266-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:54043 "EHLO
	mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965093AbcAZKU6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Jan 2016 05:20:58 -0500
In-Reply-To: <1453803353-6266-1-git-send-email-jszhang@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, arnd@arndb.de, ludovic.desroches@atmel.com, swarren@wwwdotorg.org, lee@kernel.org, eric@anholt.net, michal.simek@xilinx.com, soren.brinkmann@xilinx.com, srinivas.kandagatla@gmail.com, maxime.coquelin@st.com, patrice.chotard@st.com, thierry.reding@gmail.com, sebastian.hesselbarth@gmail.com
Cc: kernel@stlinux.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jisheng Zhang <jszhang@marvell.com>

Now all clients migration to use sdhci_pltfm_init for private
allocation is done and there's no users of the priv variable, so we can
remove it from the sdhci_pltfm_host structure.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mmc/host/sdhci-pltfm.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.h b/drivers/mmc/host/sdhci-pltfm.h
index 04bc248..d38053b 100644
--- a/drivers/mmc/host/sdhci-pltfm.h
+++ b/drivers/mmc/host/sdhci-pltfm.h
@@ -23,7 +23,6 @@ struct sdhci_pltfm_data {
 
 struct sdhci_pltfm_host {
 	struct clk *clk;
-	void *priv; /* to handle quirks across io-accessor calls */
 
 	/* migrate from sdhci_of_host */
 	unsigned int clock;
-- 
2.7.0

