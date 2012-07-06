From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: [PATCH] mmc: atmel-mci: fix incorrect setting of host->data to NULL
Date: Fri,  6 Jul 2012 11:58:33 +0200
Message-ID: <1341568713-8869-1-git-send-email-nicolas.ferre@atmel.com>
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
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-mmc@vger.kernel.org, Ludovic.Desroches@atmel.com
Cc: Seungwon Jeon <tgih.jun@samsung.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Setting host->data to NULL is incorrect sequence in STATE_SENDING_STOP
state of FSM: This early setting leads to the skip of dma_unmap_sg()
in atmci_dma_cleanup() which is a bug.

Idea taken form dw_mmc by Seungwon Jeon.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Seungwon Jeon <tgih.jun@samsung.com>
---
 drivers/mmc/host/atmel-mci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 78e5326..2ce109d 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -1860,7 +1860,6 @@ static void atmci_tasklet_func(unsigned long priv)
 
 			dev_dbg(&host->pdev->dev, "FSM: cmd ready\n");
 			host->cmd = NULL;
-			host->data = NULL;
 			data->bytes_xfered = data->blocks * data->blksz;
 			data->error = 0;
 			atmci_command_complete(host, mrq->stop);
@@ -1874,6 +1873,7 @@ static void atmci_tasklet_func(unsigned long priv)
 				atmci_writel(host, ATMCI_IER, ATMCI_NOTBUSY);
 				state = STATE_WAITING_NOTBUSY;
 			}
+			host->data = NULL;
 			break;
 
 		case STATE_END_REQUEST:
-- 
1.7.5.4
