From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v3 4/4] mmc: host: tmio: fill in response from auto cmd12
Date: Tue, 14 Mar 2017 11:09:19 +0100
Message-ID: <20170314100919.25401-5-wsa+renesas@sang-engineering.com>
References: <20170314100919.25401-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170314100919.25401-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Simon Horman <horms+renesas@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

After we received the dataend interrupt, R1 response register carries
the value from the automatically generated stop command. Report that
info back to the MMC block layer, so we will be notified in case of e.g.
ECC errors which happened during the last transfer.

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/host/tmio_mmc_pio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index b47dd9195fe3fe..a08db28b0100d6 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -557,6 +557,9 @@ void tmio_mmc_do_data_irq(struct tmio_mmc_host *host)
 			dev_err(&host->pdev->dev, "unsupported stop: CMD%u,0x%x. We did CMD12,0\n",
 				stop->opcode, stop->arg);
 
+		/* fill in response from auto CMD12 */
+		stop->resp[0] = sd_ctrl_read16_and_16_as_32(host, CTL_RESPONSE);
+
 		sd_ctrl_write16(host, CTL_STOP_INTERNAL_ACTION, 0);
 	}
 
-- 
2.11.0
