From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v2 4/4] mmc: host: tmio: fill in response from auto cmd12
Date: Mon, 13 Feb 2017 19:03:42 +0100
Message-ID: <20170213180342.26172-5-wsa+renesas@sang-engineering.com>
References: <20170213180342.26172-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:53504 "EHLO pokefinder.org"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751472AbdBMSDw (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 13 Feb 2017 13:03:52 -0500
In-Reply-To: <20170213180342.26172-1-wsa+renesas@sang-engineering.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Simon Horman <horms+renesas@verge.net.au>

After we received the dataend interrupt, R1 response register carries
the value from the automatically generated stop command. Report that
info back to the MMC block layer, so we will be notified in case of e.g.
ECC errors which happened during the last transfer.

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
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

