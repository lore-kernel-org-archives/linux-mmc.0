From: Hein Tibosch <hein_tibosch@yahoo.es>
Subject: [PATCH 2/2] mmc: atmel-mci: AP700x PDC is not connected to MCI
Date: Mon, 27 Aug 2012 04:22:02 +0800
Message-ID: <503A856A.9020303@yahoo.es>
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
To: Nicolas Ferre <nicolas.ferre@atmel.com>, "ludovic.desroches" <ludovic.desroches@atmel.com>
Cc: Havard Skinnemoen <havard@skinnemoen.net>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org, egtvedt@samfundet.no
List-Id: linux-mmc@vger.kernel.org

Earlier, atmel-mci was adapter to make use of the peripheral DMA
controller (PDC), in case normal DMA wouldn't work.
( http://comments.gmane.org/gmane.linux.kernel.mmc/9403 )
This works OK on ARM platforms (AT91), but it broke the driver
for AVR32, the AP700x.
This patch makes the use of PDC depend on CONFIG_AVR32

Signed-off-by: Hein Tibosch <hein_tibosch@yahoo.es>

---
 drivers/mmc/host/atmel-mci-regs.h |    7 +++++++
 drivers/mmc/host/atmel-mci.c      |    2 +-
 2 files changed, 8 insertions(+), 1 deletions(-)
 
diff --git a/drivers/mmc/host/atmel-mci-regs.h b/drivers/mmc/host/atmel-mci-regs.h
index ab56f7d..c97001e 100644
--- a/drivers/mmc/host/atmel-mci-regs.h
+++ b/drivers/mmc/host/atmel-mci-regs.h
@@ -140,6 +140,13 @@
 #define atmci_writel(port,reg,value)			\
 	__raw_writel((value), (port)->regs + reg)
 
+/* On AVR chips the Peripheral DMA Controller is not connected to MCI. */
+#ifdef CONFIG_AVR32
+#	define ATMCI_PDC_CONNECTED	0
+#else
+#	define ATMCI_PDC_CONNECTED	1
+#endif
+
 /*
  * Fix sconfig's burst size according to atmel MCI. We need to convert them as:
  * 1 -> 0, 4 -> 1, 8 -> 2, 16 -> 3.
diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 66e9fdc..702ab5c 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -2205,7 +2205,7 @@ static void __init atmci_get_cap(struct atmel_mci *host)
 			"version: 0x%x\n", version);
 
 	host->caps.has_dma_conf_reg = 0;
-	host->caps.has_pdc = 1;
+	host->caps.has_pdc = ATMCI_PDC_CONNECTED;
 	host->caps.has_cfg_reg = 0;
 	host->caps.has_cstor_reg = 0;
 	host->caps.has_highspeed = 0;
-- 
1.7.8.0
