From: Kangjie Lu <kjlu@umn.edu>
Subject: [PATCH v2] mmc_spi: add a status check for spi_sync_locked
Date: Mon, 11 Mar 2019 00:53:33 -0500
Message-ID: <20190311055334.13670-1-kjlu@umn.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: kjlu@umn.edu
Cc: pakki001@umn.edu, Ulf Hansson <ulf.hansson@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

In case spi_sync_locked fails, the fix reports the error and
returns the error code upstream.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/mmc/host/mmc_spi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index 1b1498805972..a3533935e282 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -819,6 +819,10 @@ mmc_spi_readblock(struct mmc_spi_host *host, struct spi_transfer *t,
 	}
 
 	status = spi_sync_locked(spi, &host->m);
+	if (status < 0) {
+		dev_dbg(&spi->dev, "read error %d\n", status);
+		return status;
+	}
 
 	if (host->dma_dev) {
 		dma_sync_single_for_cpu(host->dma_dev,
-- 
2.17.1
