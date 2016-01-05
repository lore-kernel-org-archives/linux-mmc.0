From: Jisheng Zhang <jszhang@marvell.com>
Subject: [PATCH 11/11] mmc: sdhci-pltfm: remove priv variable from sdhci_pltfm_host
Date: Tue, 5 Jan 2016 18:51:39 +0800
Message-ID: <1451991099-4946-12-git-send-email-jszhang@marvell.com>
References: <1451991099-4946-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1451991099-4946-1-git-send-email-jszhang@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, swarren@wwwdotorg.org, lee@kernel.org, eric@anholt.net, michal.simek@xilinx.com, soren.brinkmann@xilinx.com, ludovic.desroches@atmel.com, srinivas.kandagatla@gmail.com, maxime.coquelin@st.com, patrice.chotard@st.com, thierry.reding@gmail.com, sebastian.hesselbarth@gmail.com
Cc: linux-mmc@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, linux-tegra@vger.kernel.org, Jisheng Zhang <jszhang@marvell.com>
List-Id: linux-mmc@vger.kernel.org

Now all clients migration to use sdhci_pltfm_init for private
allocation is done and there's no users of the priv variable, so we can
remove it from the sdhci_pltfm_host structure.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
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
2.6.4
