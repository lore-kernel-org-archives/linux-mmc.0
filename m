From: Jiri Prchal <jiri.prchal@aksignal.cz>
Subject: [PATCH] at91: mmc: fix minimum bus frequency
Date: Tue, 17 Sep 2013 11:57:36 +0200
Message-ID: <1379411857-18516-1-git-send-email-jiri.prchal@aksignal.cz>
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
To: linux-mmc@vger.kernel.org
Cc: ludovic.desroches@atmel.com, Jiri Prchal <jiri.prchal@aksignal.cz>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

In datasheet is mmc bus frequency divided by n+2. Uppon this maximum division is 513.

Signed-off-by: Jiri Prchal <jiri.prchal@aksignal.cz>
---
 drivers/mmc/host/atmel-mci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 69e438e..f61bbf6 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -2145,7 +2145,7 @@ static int __init atmci_init_slot(struct atmel_mci *host,
 		slot_data->wp_pin);
 
 	mmc->ops = &atmci_ops;
-	mmc->f_min = DIV_ROUND_UP(host->bus_hz, 512);
+	mmc->f_min = DIV_ROUND_UP(host->bus_hz, 513);
 	mmc->f_max = host->bus_hz / 2;
 	mmc->ocr_avail	= MMC_VDD_32_33 | MMC_VDD_33_34;
 	if (sdio_irq)
-- 
1.7.9.5
