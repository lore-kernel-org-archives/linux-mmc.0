From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: [PATCH 7/7] mmc: at91_mci: introduce per-mci-revision conditional code
Date: Fri, 26 Feb 2010 19:39:35 +0100
Message-ID: <b0448f44ec87aec433ef0c2240a4b2fd05a5b605.1267209149.git.nicolas.ferre@atmel.com>
References: <9535dc8dfe4476a0314b9513fb9d37862faa731d.1267209149.git.nicolas.ferre@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <9535dc8dfe4476a0314b9513fb9d37862faa731d.1267209149.git.nicolas.ferre@atmel.com>
In-Reply-To: <9535dc8dfe4476a0314b9513fb9d37862faa731d.1267209149.git.nicolas.ferre@atmel.com>
References: <9535dc8dfe4476a0314b9513fb9d37862faa731d.1267209149.git.nicolas.ferre@atmel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: akpm@linux-foundation.org, linux-mmc@vger.kernel.org
Cc: avictor.za@gmail.com, wolfgang.mues@auerswald.de, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

We used to manage features and differences on a per-cpu basis. As several cpus
share the same mci revision, this patch aggregates cpus that have the same IP
revision in one defined constant.
We use the at91mci_is_mci1rev2xx() funtion name not to mess with newer Atmel
sd/mmc IP called "MCI2". _rev2 naming could have been confusing...

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/mmc/host/at91_mci.c |   27 +++++++++++++++++++--------
 1 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/at91_mci.c b/drivers/mmc/host/at91_mci.c
index e78cdc8..07fed42 100644
--- a/drivers/mmc/host/at91_mci.c
+++ b/drivers/mmc/host/at91_mci.c
@@ -78,6 +78,17 @@
 
 #define DRIVER_NAME "at91_mci"
 
+static inline int at91mci_is_mci1rev2xx(void)
+{
+	return (   cpu_is_at91sam9260()
+		|| cpu_is_at91sam9263()
+		|| cpu_is_at91cap9()
+		|| cpu_is_at91sam9rl()
+		|| cpu_is_at91sam9g10()
+		|| cpu_is_at91sam9g20()
+		);
+}
+
 #define FL_SENT_COMMAND	(1 << 0)
 #define FL_SENT_STOP	(1 << 1)
 
@@ -204,8 +215,8 @@ static inline void at91_mci_sg_to_dma(struct at91mci_host *host, struct mmc_data
 	size = data->blksz * data->blocks;
 	len = data->sg_len;
 
-	/* AT91SAM926[0/3] Data Write Operation and number of bytes erratum */
-	if (cpu_is_at91sam9260() || cpu_is_at91sam9263())
+	/* MCI1 rev2xx Data Write Operation and number of bytes erratum */
+	if (at91mci_is_mci1rev2xx())
 		if (host->total_length == 12)
 			memset(dmabuf, 0, 12);
 
@@ -398,7 +409,7 @@ static void at91_mci_enable(struct at91mci_host *host)
 	at91_mci_write(host, AT91_MCI_DTOR, AT91_MCI_DTOMUL_1M | AT91_MCI_DTOCYC);
 	mr = AT91_MCI_PDCMODE | 0x34a;
 
-	if (cpu_is_at91sam9260() || cpu_is_at91sam9263())
+	if (at91mci_is_mci1rev2xx())
 		mr |= AT91_MCI_RDPROOF | AT91_MCI_WRPROOF;
 
 	at91_mci_write(host, AT91_MCI_MR, mr);
@@ -555,10 +566,10 @@ static void at91_mci_send_command(struct at91mci_host *host, struct mmc_command
 				 */
 				host->total_length = block_length * blocks;
 				/*
-				 * AT91SAM926[0/3] Data Write Operation and
+				 * MCI1 rev2xx Data Write Operation and
 				 * number of bytes erratum
 				 */
-				if (cpu_is_at91sam9260 () || cpu_is_at91sam9263())
+				if (at91mci_is_mci1rev2xx())
 					if (host->total_length < 12)
 						host->total_length = 12;
 
@@ -943,7 +954,7 @@ static int __init at91_mci_probe(struct platform_device *pdev)
 	host->bus_mode = 0;
 	host->board = pdev->dev.platform_data;
 	if (host->board->wire4) {
-		if (cpu_is_at91sam9260() || cpu_is_at91sam9263())
+		if (at91mci_is_mci1rev2xx())
 			mmc->caps |= MMC_CAP_4_BIT_DATA;
 		else
 			dev_warn(&pdev->dev, "4 wire bus mode not supported"
@@ -959,8 +970,8 @@ static int __init at91_mci_probe(struct platform_device *pdev)
 	}
 
 	/* Add SDIO capability when available */
-	if (cpu_is_at91sam9260() || cpu_is_at91sam9263()) {
-		/* AT91SAM9260/9263 erratum */
+	if (at91mci_is_mci1rev2xx()) {
+		/* at91mci MCI1 rev2xx sdio interrupt erratum */
 		if (host->board->wire4 || !host->board->slot_b)
 			mmc->caps |= MMC_CAP_SDIO_IRQ;
 	}
-- 
1.5.6.5
