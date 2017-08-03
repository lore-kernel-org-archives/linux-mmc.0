From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH] Revert "mmc: sdhi: use maximum width for the sdbuf register"
Date: Thu,  3 Aug 2017 11:49:47 +0200
Message-ID: <20170803094947.1490-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Biju Das <biju.das@bp.renesas.com>, Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-mmc@vger.kernel.org

This reverts commit 785b215250310c690142abb1bdbb0767b8487c49. There is a
secondary SDHI instance on Gen2 with has a 32-bit wide SDBUF register
while all other registers are 16 bit apart. So, the logic used here does
not apply and we need to rethink this and start cleanly from scratch.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/host/renesas_sdhi_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 48da28dfef6465..dd215723fa4312 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -461,7 +461,8 @@ static void renesas_sdhi_enable_dma(struct tmio_mmc_host *host, bool enable)
 {
 	sd_ctrl_write16(host, CTL_DMA_ENABLE, enable ? DMA_ENABLE_DMASDRW : 0);
 
-	renesas_sdhi_sdbuf_width(host, enable ? (16 << host->bus_shift) : 16);
+	/* enable 32bit access if DMA mode if possibile */
+	renesas_sdhi_sdbuf_width(host, enable ? 32 : 16);
 }
 
 int renesas_sdhi_probe(struct platform_device *pdev,
-- 
2.11.0
