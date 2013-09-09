From: <ludovic.desroches@atmel.com>
Subject: [PATCH] mmc: atmel-mci: abort transfer on timeout error
Date: Mon, 9 Sep 2013 17:29:56 +0200
Message-ID: <1378740596-25026-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, nicolas.ferre@atmel.com, etesial@gmail.com, Ludovic Desroches <ludovic.desroches@atmel.com>
List-Id: linux-mmc@vger.kernel.org

From: Ludovic Desroches <ludovic.desroches@atmel.com>

When a software timeout occurs, the transfer is not stopped. In DMA case, it
causes DMA channel to be stuck because the transfer is still active causing
following transfers to be queued but not computed.

Cc: <stable@vger.kernel.org> #3.9+
Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Reported-by: Alexander Morozov <etesial@gmail.com>
---
 drivers/mmc/host/atmel-mci.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index bdb84da..e9ea2fc 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -582,6 +582,13 @@ static void atmci_timeout_timer(unsigned long data)
 	if (host->mrq->cmd->data) {
 		host->mrq->cmd->data->error = -ETIMEDOUT;
 		host->data = NULL;
+		/*
+		 * With some SDIO modules, sometimes DMA transfer hangs. If
+		 * stop_transfer() is not called then the DMA request is not
+		 * removed, following ones are queued and never computed.
+		 */
+		if (host->state == STATE_DATA_XFER)
+			host->stop_transfer(host);
 	} else {
 		host->mrq->cmd->error = -ETIMEDOUT;
 		host->cmd = NULL;
-- 
1.7.11.3
