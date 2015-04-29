From: <micky_ching@realsil.com.cn>
Subject: [PATCH 09/12] mmc: sdhci: add tlp handler for SD4.0
Date: Wed, 29 Apr 2015 09:23:41 +0800
Message-ID: <4c0b5d406ba2645f77e0e2a5daa8674faaff60d5.1429845922.git.micky_ching@realsil.com.cn>
References: <cover.1429845922.git.micky_ching@realsil.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <cover.1429845922.git.micky_ching@realsil.com.cn>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: chris@printf.net, ulf.hansson@linaro.org, sameo@linux.intel.com
Cc: gregkh@linuxfoundation.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, wei_wang@realsil.com.cn, devel@linuxdriverproject.org, rogerable@realtek.com, dan.carpenter@oracle.com
List-Id: linux-mmc@vger.kernel.org

From: Micky Ching <micky_ching@realsil.com.cn>

SD4.0 mode using tlp for cmd/data transfer, add tlp functions to handle
this case.

Signed-off-by: Micky Ching <micky_ching@realsil.com.cn>
Signed-off-by: Wei Wang <wei_wang@realsil.com.cn>
---
 drivers/mmc/host/sdhci.c | 244 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 220 insertions(+), 24 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index df1b88d..3c56944 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -976,6 +976,32 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
 	sdhci_writew(host, mode, SDHCI_TRANSFER_MODE);
 }
 
+static void sdhci_uhsii_set_transfer_mode(struct sdhci_host *host,
+	struct mmc_command *cmd)
+{
+	u16 mode = 0;
+	struct mmc_data *data = cmd->data;
+
+	if (UHSII_CHK_CCMD(cmd->tlp_send.header)) {
+		if (cmd->flags & MMC_RSP_BUSY)
+			mode |= SDHCI_UHSII_TRNS_WAIT_EBSY;
+	} else {
+		u8 tmode = (cmd->tlp_send.argument & UHSII_ARG_TMODE_MASK) >>
+			UHSII_ARG_TMODE_SHIFT;
+		if (tmode & UHSII_TMODE_DM_HD)
+			mode |= SDHCI_UHSII_TRANS_2LANE_HD;
+		mode |= SDHCI_UHSII_TRNS_BLK_CNT_EN;
+		mode |= SDHCI_UHSII_TRNS_WAIT_EBSY;
+
+		if (data->flags & MMC_DATA_WRITE)
+			mode |= SDHCI_UHSII_TRNS_WRITE;
+		if (host->flags & SDHCI_REQ_USE_DMA)
+			mode |= SDHCI_UHSII_TRNS_DMA;
+	}
+
+	sdhci_writew(host, mode, SDHCI_UHSII_TRANSFER_MODE);
+}
+
 static void sdhci_finish_data(struct sdhci_host *host)
 {
 	struct mmc_data *data;
@@ -1014,7 +1040,7 @@ static void sdhci_finish_data(struct sdhci_host *host)
 	 * a) open-ended multiblock transfer (no CMD23)
 	 * b) error in multiblock transfer
 	 */
-	if (data->stop &&
+	if (!host->uhsii_if_enabled && data->stop &&
 	    (data->error ||
 	     !host->mrq->sbc)) {
 
@@ -1032,6 +1058,51 @@ static void sdhci_finish_data(struct sdhci_host *host)
 		tasklet_schedule(&host->finish_tasklet);
 }
 
+static void sdhci_send_native_tlp(struct sdhci_host *host, struct mmc_tlp *tlp)
+{
+	int i;
+	unsigned long timeout;
+	u16 cmdreg;
+	u8 plen, cmd_len = 4;
+
+	/* Wait max 10 ms */
+	timeout = 10;
+
+	if (sdhci_checkl(host, SDHCI_PRESENT_STATE, SDHCI_CMD_INHIBIT, 0, 10)) {
+		pr_err("%s: cmd busy...\n", mmc_hostname(host->mmc));
+		sdhci_dumpregs(host);
+		tlp->error = -EIO;
+		tasklet_schedule(&host->finish_tasklet);
+		return;
+	}
+
+	mod_timer(&host->timer, jiffies + 10 * HZ);
+
+	host->tlp = tlp;
+
+	plen = (u8)((tlp->tlp_send->argument & UHSII_ARG_PLEN_MASK) >>
+		UHSII_ARG_PLEN_SHIFT);
+
+	sdhci_writew(host, cpu_to_be16(tlp->tlp_send->header),
+			SDHCI_UHSII_CMD_HEADER);
+	sdhci_writew(host, cpu_to_be16(tlp->tlp_send->argument),
+			SDHCI_UHSII_CMD_ARGUMENT);
+	if (tlp->tlp_send->argument & UHSII_ARG_DIR_WRITE) {
+		for (i = 0; i < UHSII_PLEN_DWORDS(plen); i++)
+			sdhci_writel(host,
+				cpu_to_be32(tlp->tlp_send->payload[i]),
+				SDHCI_UHSII_CMD_PAYLOAD + 4 * i);
+
+		cmd_len = UHSII_PLEN_BYTES(plen) + 4;
+	}
+
+	cmdreg = (cmd_len & SDHCI_UHSII_COMMAND_LEN_MASK) <<
+		SDHCI_UHSII_COMMAND_LEN_SHIFT;
+	if (tlp->cmd_type == UHSII_COMMAND_GO_DORMANT)
+		cmdreg |= SDHCI_UHSII_GO_DORMANT;
+	sdhci_writew(host, cmdreg, SDHCI_UHSII_COMMAND);
+}
+
 void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 {
 	int flags;
@@ -1077,6 +1148,35 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 
 	sdhci_prepare_data(host, cmd);
 
+	if (cmd->use_tlp) {
+		int i;
+		u16 cmdreg;
+		u8 plen = 1, cmd_len = 8;
+
+		if (!UHSII_CHK_CCMD(cmd->tlp_send.header)) {
+			plen = 2;
+			cmd_len = 12;
+		}
+
+		sdhci_writew(host, cpu_to_be16(cmd->tlp_send.header),
+				SDHCI_UHSII_CMD_HEADER);
+		sdhci_writew(host, cpu_to_be16(cmd->tlp_send.argument),
+				SDHCI_UHSII_CMD_ARGUMENT);
+		for (i = 0; i < plen; i++)
+			sdhci_writel(host,
+				cpu_to_be32(cmd->tlp_send.payload[i]),
+				SDHCI_UHSII_CMD_PAYLOAD + (4 * i));
+
+		sdhci_uhsii_set_transfer_mode(host, cmd);
+
+		cmdreg = (cmd_len & SDHCI_UHSII_COMMAND_LEN_MASK) <<
+			SDHCI_UHSII_COMMAND_LEN_SHIFT;
+		if (cmd->data)
+			cmdreg |= SDHCI_UHSII_DATA_PRESENT;
+		sdhci_writew(host, cmdreg, SDHCI_UHSII_COMMAND);
+		return;
+	}
+
 	sdhci_writel(host, cmd->arg, SDHCI_ARGUMENT);
 
 	sdhci_set_transfer_mode(host, cmd);
@@ -1112,28 +1212,64 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 }
 EXPORT_SYMBOL_GPL(sdhci_send_command);
 
-static void sdhci_finish_command(struct sdhci_host *host)
+static void sdhci_read_rsp_136(struct sdhci_host *host)
 {
 	int i;
 
+	if (host->cmd->use_tlp) {
+		for (i = 0; i < 4; i++) {
+			u32 resp = sdhci_raw_readl(host,
+					SDHCI_UHSII_RESP_PAYLOAD + i * 4);
+			host->cmd->resp[i] = be32_to_cpu(resp);
+		}
+	} else {
+		/* CRC is stripped so we need to do some shifting. */
+		for (i = 0; i < 4; i++) {
+			host->cmd->resp[i] = sdhci_readl(host,
+				SDHCI_RESPONSE + (3 - i) * 4) << 8;
+			if (i != 3)
+				host->cmd->resp[i] |= sdhci_readb(host,
+					SDHCI_RESPONSE + (3 - i) * 4 - 1);
+		}
+	}
+
+}
+
+static void sdhci_read_rsp_48(struct sdhci_host *host)
+{
+	if (host->cmd->use_tlp)
+		host->cmd->resp[0] = be32_to_cpu(
+			sdhci_raw_readl(host, SDHCI_UHSII_RESP_PAYLOAD));
+	else
+		host->cmd->resp[0] = sdhci_readl(host, SDHCI_RESPONSE);
+}
+
+static void sdhci_finish_command(struct sdhci_host *host)
+{
 	BUG_ON(host->cmd == NULL);
 
-	if (host->cmd->flags & MMC_RSP_PRESENT) {
-		if (host->cmd->flags & MMC_RSP_136) {
-			/* CRC is stripped so we need to do some shifting. */
-			for (i = 0;i < 4;i++) {
-				host->cmd->resp[i] = sdhci_readl(host,
-					SDHCI_RESPONSE + (3-i)*4) << 8;
-				if (i != 3)
-					host->cmd->resp[i] |=
-						sdhci_readb(host,
-						SDHCI_RESPONSE + (3-i)*4-1);
-			}
-		} else {
-			host->cmd->resp[0] = sdhci_readl(host, SDHCI_RESPONSE);
+	if (host->cmd->use_tlp) {
+		u16 arg = sdhci_readw(host, SDHCI_UHSII_RESP_ARGUMENT);
+
+		arg = be16_to_cpu(arg);
+		if (arg & UHSII_ARG_RES_NACK) {
+			host->cmd->error = -EIO;
+			DBG("Response NACK!");
+
+			tasklet_schedule(&host->finish_tasklet);
+			host->cmd = NULL;
+
+			return;
 		}
 	}
 
+	if (host->cmd->flags & MMC_RSP_PRESENT) {
+		if (host->cmd->flags & MMC_RSP_136)
+			sdhci_read_rsp_136(host);
+		else
+			sdhci_read_rsp_48(host);
+	}
+
 	host->cmd->error = 0;
 
 	/* Finished CMD23, now send actual command. */
@@ -1153,6 +1289,21 @@ static void sdhci_finish_command(struct sdhci_host *host)
 	}
 }
 
+static void sdhci_finish_native_tlp(struct sdhci_host *host)
+{
+	int i;
+
+	host->tlp->tlp_back->header = be16_to_cpu(
+		sdhci_readw(host, SDHCI_UHSII_RESP_HEADER));
+	host->tlp->tlp_back->argument = be16_to_cpu(
+		sdhci_readw(host, SDHCI_UHSII_RESP_ARGUMENT));
+	for (i = 0; i < 4; i++)
+		host->tlp->tlp_back->payload[i] = be32_to_cpu(
+			sdhci_readl(host, SDHCI_UHSII_RESP_PAYLOAD + 4 * i));
+
+	tasklet_schedule(&host->finish_tasklet);
+}
+
 static u16 sdhci_get_preset_value(struct sdhci_host *host)
 {
 	u16 preset = 0;
@@ -1410,7 +1561,7 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	host->mrq = mrq;
 
 	if (!present || host->flags & SDHCI_DEVICE_DEAD) {
-		host->mrq->cmd->error = -ENOMEDIUM;
+		mmc_set_mrq_error_code(host->mrq, -ENOMEDIUM);
 		tasklet_schedule(&host->finish_tasklet);
 	} else {
 		u32 present_state;
@@ -1446,10 +1597,13 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 			}
 		}
 
-		if (mrq->sbc && !(host->flags & SDHCI_AUTO_CMD23))
+		if (!host->uhsii_if_enabled && mrq->sbc &&
+				!(host->flags & SDHCI_AUTO_CMD23))
 			sdhci_send_command(host, mrq->sbc);
-		else
+		else if (mrq->cmd)
 			sdhci_send_command(host, mrq->cmd);
+		else if (mrq->tlp)
+			sdhci_send_native_tlp(host, mrq->tlp);
 	}
 
 	mmiowb();
@@ -2243,7 +2397,7 @@ static void sdhci_card_event(struct mmc_host *mmc)
 		sdhci_do_reset(host, SDHCI_RESET_CMD);
 		sdhci_do_reset(host, SDHCI_RESET_DATA);
 
-		host->mrq->cmd->error = -ENOMEDIUM;
+		mmc_set_mrq_error_code(host->mrq, -ENOMEDIUM);
 		tasklet_schedule(&host->finish_tasklet);
 	}
 
@@ -2450,6 +2604,19 @@ static void sdhci_tasklet_finish(unsigned long param)
 
 	mrq = host->mrq;
 
+	if (mrq->tlp) {
+		if (mrq->tlp->cmd_type == UHSII_COMMAND_GO_DORMANT) {
+			/* Wait In Dormant State */
+			if (sdhci_checkl(host, SDHCI_PRESENT_STATE,
+					SDHCI_IN_DORMANT_STATE,
+					SDHCI_IN_DORMANT_STATE, 100) < 0) {
+				pr_err("%s: Not in dormant state.\n",
+					mmc_hostname(host->mmc));
+				mrq->tlp->error = -ETIMEDOUT;
+			}
+		}
+	}
+
 	/*
 	 * The controller needs a reset of internal state machines
 	 * upon error conditions.
@@ -2457,6 +2624,7 @@ static void sdhci_tasklet_finish(unsigned long param)
 	if (!(host->flags & SDHCI_DEVICE_DEAD) &&
 	    ((mrq->cmd && mrq->cmd->error) ||
 	     (mrq->sbc && mrq->sbc->error) ||
+	     (mrq->tlp && mrq->tlp->error) ||
 	     (mrq->data && ((mrq->data->error && !mrq->data->stop) ||
 			    (mrq->data->stop && mrq->data->stop->error))) ||
 	     (host->quirks & SDHCI_QUIRK_RESET_AFTER_REQUEST))) {
@@ -2475,6 +2643,7 @@ static void sdhci_tasklet_finish(unsigned long param)
 	host->mrq = NULL;
 	host->cmd = NULL;
 	host->data = NULL;
+	host->tlp = NULL;
 
 #ifndef SDHCI_USE_LEDS_CLASS
 	sdhci_deactivate_led(host);
@@ -2505,10 +2674,18 @@ static void sdhci_timeout_timer(unsigned long data)
 			host->data->error = -ETIMEDOUT;
 			sdhci_finish_data(host);
 		} else {
-			if (host->cmd)
-				host->cmd->error = -ETIMEDOUT;
-			else
-				host->mrq->cmd->error = -ETIMEDOUT;
+			if (host->cmd || host->mrq->cmd) {
+				if (host->cmd)
+					host->cmd->error = -ETIMEDOUT;
+				else
+					host->mrq->cmd->error = -ETIMEDOUT;
+			}
+			if (host->tlp || host->mrq->tlp) {
+				if (host->tlp)
+					host->tlp->error = -ETIMEDOUT;
+				else
+					host->mrq->tlp->error = -ETIMEDOUT;
+			}
 
 			tasklet_schedule(&host->finish_tasklet);
 		}
@@ -2550,6 +2727,25 @@ static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask, u32 *mask)
 		return;
 	}
 
+	if (host->tlp) {
+		if (uhsii_intmask & SDHCI_UHSII_INT_TIMEOUT)
+			host->tlp->error = -ETIMEDOUT;
+		else if (uhsii_intmask & (SDHCI_UHSII_INT_CRC |
+				SDHCI_UHSII_INT_HEADER |
+				SDHCI_UHSII_INT_RES |
+				SDHCI_UHSII_INT_UNRECOVERABLE))
+			host->tlp->error = -EILSEQ;
+
+		if (host->tlp->error) {
+			tasklet_schedule(&host->finish_tasklet);
+			return;
+		}
+
+		if (intmask & SDHCI_INT_RESPONSE)
+			sdhci_finish_native_tlp(host);
+		return;
+	}
+
 	if (intmask & SDHCI_INT_TIMEOUT)
 		host->cmd->error = -ETIMEDOUT;
 	else if (intmask & (SDHCI_INT_CRC | SDHCI_INT_END_BIT |
@@ -3669,7 +3865,7 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
 			pr_err("%s: Controller removed during "
 				" transfer!\n", mmc_hostname(mmc));
 
-			host->mrq->cmd->error = -ENOMEDIUM;
+			mmc_set_mrq_error_code(host->mrq, -ENOMEDIUM);
 			tasklet_schedule(&host->finish_tasklet);
 		}
 
-- 
1.9.1
