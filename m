From: Linus Walleij <linus.walleij@stericsson.com>
Subject: [PATCH 1/4] mmci: use StartBitErr to detect bad connections
Date: Tue, 28 Jun 2011 09:57:25 +0200
Message-ID: <1309247845-17105-1-git-send-email-linus.walleij@stericsson.com>
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
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Linus Walleij <linus.walleij@linaro.org>, Lee Jones <lee.jones@linaro.org>, Ulf Hansson <ulf.hansson@stericsson.com>
List-Id: linux-mmc@vger.kernel.org

From: Ulf Hansson <ulf.hansson@stericsson.com>

Stresstesting insert/remove of SD-cards can trigger
a StartBitErr. This made the driver to hang in forever
waiting for a non ocurring data timeout.

This bit and interrupt is documented in the original
PL180 TRM, just never implemented until now.

Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
Reviewed-by: Linus Walleij <linus.walleij@stericsson.com>
Reviewed-by: Jonas Aberg <jonas.aberg@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/mmci.c |    2 ++
 drivers/mmc/host/mmci.h |    5 ++++-
 2 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 7721de9..fe14072 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -582,6 +582,8 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
 			data->error = -EILSEQ;
 		} else if (status & MCI_DATATIMEOUT) {
 			data->error = -ETIMEDOUT;
+		} else if (status & MCI_STARTBITERR) {
+			data->error = -ECOMM;
 		} else if (status & MCI_TXUNDERRUN) {
 			data->error = -EIO;
 		} else if (status & MCI_RXOVERRUN) {
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index bb32e21..2164e8c 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -86,6 +86,7 @@
 #define MCI_CMDRESPEND		(1 << 6)
 #define MCI_CMDSENT		(1 << 7)
 #define MCI_DATAEND		(1 << 8)
+#define MCI_STARTBITERR		(1 << 9)
 #define MCI_DATABLOCKEND	(1 << 10)
 #define MCI_CMDACTIVE		(1 << 11)
 #define MCI_TXACTIVE		(1 << 12)
@@ -112,6 +113,7 @@
 #define MCI_CMDRESPENDCLR	(1 << 6)
 #define MCI_CMDSENTCLR		(1 << 7)
 #define MCI_DATAENDCLR		(1 << 8)
+#define MCI_STARTBITERRCLR	(1 << 9)
 #define MCI_DATABLOCKENDCLR	(1 << 10)
 /* Extended status bits for the ST Micro variants */
 #define MCI_ST_SDIOITC		(1 << 22)
@@ -127,6 +129,7 @@
 #define MCI_CMDRESPENDMASK	(1 << 6)
 #define MCI_CMDSENTMASK		(1 << 7)
 #define MCI_DATAENDMASK		(1 << 8)
+#define MCI_STARTBITERRMASK	(1 << 9)
 #define MCI_DATABLOCKENDMASK	(1 << 10)
 #define MCI_CMDACTIVEMASK	(1 << 11)
 #define MCI_TXACTIVEMASK	(1 << 12)
@@ -150,7 +153,7 @@
 #define MCI_IRQENABLE	\
 	(MCI_CMDCRCFAILMASK|MCI_DATACRCFAILMASK|MCI_CMDTIMEOUTMASK|	\
 	MCI_DATATIMEOUTMASK|MCI_TXUNDERRUNMASK|MCI_RXOVERRUNMASK|	\
-	MCI_CMDRESPENDMASK|MCI_CMDSENTMASK)
+	MCI_CMDRESPENDMASK|MCI_CMDSENTMASK|MCI_STARTBITERRMASK)
 
 /* These interrupts are directed to IRQ1 when two IRQ lines are available */
 #define MCI_IRQ1MASK \
-- 
1.7.3.2
