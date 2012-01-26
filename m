From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 5/7 v2] serial: sh-sci: prepare for conversion to simple DMA
Date: Thu, 26 Jan 2012 15:56:22 +0100
Message-ID: <1327589784-4287-6-git-send-email-g.liakhovetski@gmx.de>
References: <1327589784-4287-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <1327589784-4287-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-serial-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-mmc@vger.kernel.org, alsa-devel@alsa-project.org, linux-serial@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/tty/serial/sh-sci.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 7508579..8b99aac 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1574,9 +1574,9 @@ static bool filter(struct dma_chan *chan, void *slave)
 	struct sh_dmae_slave *param = slave;
 
 	dev_dbg(chan->device->dev, "%s: slave ID %d\n", __func__,
-		param->slave_id);
+		param->simple_slave.slave_id);
 
-	chan->private = param;
+	chan->private = &param->simple_slave;
 	return true;
 }
 
@@ -1615,7 +1615,7 @@ static void sci_request_dma(struct uart_port *port)
 	param = &s->param_tx;
 
 	/* Slave ID, e.g., SHDMA_SLAVE_SCIF0_TX */
-	param->slave_id = s->cfg->dma_slave_tx;
+	param->simple_slave.slave_id = s->cfg->dma_slave_tx;
 
 	s->cookie_tx = -EINVAL;
 	chan = dma_request_channel(mask, filter, param);
@@ -1643,7 +1643,7 @@ static void sci_request_dma(struct uart_port *port)
 	param = &s->param_rx;
 
 	/* Slave ID, e.g., SHDMA_SLAVE_SCIF0_RX */
-	param->slave_id = s->cfg->dma_slave_rx;
+	param->simple_slave.slave_id = s->cfg->dma_slave_rx;
 
 	chan = dma_request_channel(mask, filter, param);
 	dev_dbg(port->dev, "%s: RX: got channel %p\n", __func__, chan);
-- 
1.7.2.5

