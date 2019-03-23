From: Kangjie Lu <kjlu@umn.edu>
Subject: [PATCH v2] net: liquidio: fix NULL pointer dereferences
Date: Fri, 22 Mar 2019 22:24:19 -0500
Message-ID: <20190323032420.21162-1-kjlu@umn.edu>
References: <20190311.121710.968693621648443243.davem@davemloft.net>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190311.121710.968693621648443243.davem@davemloft.net>
Sender: netdev-owner@vger.kernel.org
To: kjlu@umn.edu
Cc: pakki001@umn.edu, Ulf Hansson <ulf.hansson@linaro.org>, Derek Chickles <dchickles@marvell.com>, Satanand Burla <sburla@marvell.com>, Felix Manlunas <fmanlunas@marvell.com>, "David S. Miller" <davem@davemloft.net>, Linus Walleij <linus.walleij@linaro.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

In case octeon_alloc_soft_command fails, the fix reports the
error and goes to cleanup to avoid NULL pointer dereferences.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
V2: goto setup_nic_dev_free for cleanup
---
 drivers/mmc/host/mmc_spi.c                         |  2 +-
 drivers/net/ethernet/cavium/liquidio/lio_vf_main.c | 12 ++++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index 32fea585262b..a3533935e282 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -820,7 +820,7 @@ mmc_spi_readblock(struct mmc_spi_host *host, struct spi_transfer *t,
 
 	status = spi_sync_locked(spi, &host->m);
 	if (status < 0) {
-		dev_dbg(&spi->dev, "read error %02x (%d)\n", status, status);
+		dev_dbg(&spi->dev, "read error %d\n", status);
 		return status;
 	}
 
diff --git a/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c b/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
index 54b245797d2e..e653072846b0 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
@@ -611,6 +611,12 @@ static void send_rx_ctrl_cmd(struct lio *lio, int start_stop)
 	sc = (struct octeon_soft_command *)
 		octeon_alloc_soft_command(oct, OCTNET_CMD_SIZE,
 					  16, 0);
+	if (!sc) {
+		netif_info(lio, rx_err, lio->netdev,
+			   "Failed to allocate octeon_soft_command\n");
+		return;
+	}
+
 
 	ncmd = (union octnet_cmd *)sc->virtdptr;
 
@@ -1960,6 +1966,12 @@ static int setup_nic_devices(struct octeon_device *octeon_dev)
 		sc = (struct octeon_soft_command *)
 			octeon_alloc_soft_command(octeon_dev, data_size,
 						  resp_size, 0);
+		if (!sc) {
+			dev_err(&octeon_dev->pci_dev->dev,
+				"Failed to allocate octeon_soft_command\n");
+			goto setup_nic_dev_free;
+		}
+
 		resp = (struct liquidio_if_cfg_resp *)sc->virtrptr;
 		vdata = (struct lio_version *)sc->virtdptr;
 
-- 
2.17.1
