From: <micky_ching@realsil.com.cn>
Subject: [PATCH v5 6/6] mmc: rtsx: swap function position to avoid pre
 declaration
Date: Tue, 23 Dec 2014 09:19:46 +0800
Message-ID: <c0aa0feb42b3cbf4edcbd7d609d8eac33316e268.1419297154.git.micky_ching@realsil.com.cn>
References: <cover.1419297154.git.micky_ching@realsil.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <cover.1419297154.git.micky_ching@realsil.com.cn>
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

move function sd_read_data()/sd_write_data() behind
sd_send_cmd_get_rsp() to avoid pre-declaration.

Signed-off-by: Micky Ching <micky_ching@realsil.com.cn>
---
 drivers/mmc/host/rtsx_pci_sdmmc.c | 203 +++++++++++++++++++-------------------
 1 file changed, 100 insertions(+), 103 deletions(-)

diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
index 0217db6..26c6a7c 100644
--- a/drivers/mmc/host/rtsx_pci_sdmmc.c
+++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
@@ -71,9 +71,6 @@ static inline void sd_clear_error(struct realtek_pci_sdmmc *host)
 			SD_STOP | SD_CLR_ERR, SD_STOP | SD_CLR_ERR);
 }
 
-static void sd_send_cmd_get_rsp(struct realtek_pci_sdmmc *host,
-	struct mmc_command *cmd);
-
 #ifdef DEBUG
 static void dump_reg_range(struct realtek_pci_sdmmc *host, u16 start, u16 end)
 {
@@ -218,106 +215,6 @@ static void sdmmc_post_req(struct mmc_host *mmc, struct mmc_request *mrq,
 	data->host_cookie = 0;
 }
 
-static int sd_read_data(struct realtek_pci_sdmmc *host, struct mmc_command *cmd,
-	u16 byte_cnt, u8 *buf, int buf_len, int timeout)
-{
-	struct rtsx_pcr *pcr = host->pcr;
-	int err;
-	u8 trans_mode;
-
-	dev_dbg(sdmmc_dev(host), "%s: SD/MMC CMD %d, arg = 0x%08x\n",
-		__func__, cmd->opcode, cmd->arg);
-
-	if (!buf)
-		buf_len = 0;
-
-	if (cmd->opcode == MMC_SEND_TUNING_BLOCK)
-		trans_mode = SD_TM_AUTO_TUNING;
-	else
-		trans_mode = SD_TM_NORMAL_READ;
-
-	rtsx_pci_init_cmd(pcr);
-	sd_cmd_set_sd_cmd(pcr, cmd);
-	sd_cmd_set_data_len(pcr, 1, byte_cnt);
-	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, SD_CFG2, 0xFF,
-			SD_CALCULATE_CRC7 | SD_CHECK_CRC16 |
-			SD_NO_WAIT_BUSY_END | SD_CHECK_CRC7 | SD_RSP_LEN_6);
-	if (trans_mode != SD_TM_AUTO_TUNING)
-		rtsx_pci_add_cmd(pcr, WRITE_REG_CMD,
-				CARD_DATA_SOURCE, 0x01, PINGPONG_BUFFER);
-
-	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, SD_TRANSFER,
-			0xFF, trans_mode | SD_TRANSFER_START);
-	rtsx_pci_add_cmd(pcr, CHECK_REG_CMD, SD_TRANSFER,
-			SD_TRANSFER_END, SD_TRANSFER_END);
-
-	err = rtsx_pci_send_cmd(pcr, timeout);
-	if (err < 0) {
-		sd_print_debug_regs(host);
-		dev_dbg(sdmmc_dev(host),
-			"rtsx_pci_send_cmd fail (err = %d)\n", err);
-		return err;
-	}
-
-	if (buf && buf_len) {
-		err = rtsx_pci_read_ppbuf(pcr, buf, buf_len);
-		if (err < 0) {
-			dev_dbg(sdmmc_dev(host),
-				"rtsx_pci_read_ppbuf fail (err = %d)\n", err);
-			return err;
-		}
-	}
-
-	return 0;
-}
-
-static int sd_write_data(struct realtek_pci_sdmmc *host,
-	struct mmc_command *cmd, u16 byte_cnt, u8 *buf, int buf_len,
-	int timeout)
-{
-	struct rtsx_pcr *pcr = host->pcr;
-	int err;
-
-	dev_dbg(sdmmc_dev(host), "%s: SD/MMC CMD %d, arg = 0x%08x\n",
-		__func__, cmd->opcode, cmd->arg);
-
-	if (!buf)
-		buf_len = 0;
-
-	sd_send_cmd_get_rsp(host, cmd);
-	if (cmd->error)
-		return cmd->error;
-
-	if (buf && buf_len) {
-		err = rtsx_pci_write_ppbuf(pcr, buf, buf_len);
-		if (err < 0) {
-			dev_dbg(sdmmc_dev(host),
-				"rtsx_pci_write_ppbuf fail (err = %d)\n", err);
-			return err;
-		}
-	}
-
-	rtsx_pci_init_cmd(pcr);
-	sd_cmd_set_data_len(pcr, 1, byte_cnt);
-	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, SD_CFG2, 0xFF,
-		SD_CALCULATE_CRC7 | SD_CHECK_CRC16 |
-		SD_NO_WAIT_BUSY_END | SD_CHECK_CRC7 | SD_RSP_LEN_0);
-	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, SD_TRANSFER, 0xFF,
-			SD_TRANSFER_START | SD_TM_AUTO_WRITE_3);
-	rtsx_pci_add_cmd(pcr, CHECK_REG_CMD, SD_TRANSFER,
-			SD_TRANSFER_END, SD_TRANSFER_END);
-
-	err = rtsx_pci_send_cmd(pcr, timeout);
-	if (err < 0) {
-		sd_print_debug_regs(host);
-		dev_dbg(sdmmc_dev(host),
-			"rtsx_pci_send_cmd fail (err = %d)\n", err);
-		return err;
-	}
-
-	return 0;
-}
-
 static void sd_send_cmd_get_rsp(struct realtek_pci_sdmmc *host,
 		struct mmc_command *cmd)
 {
@@ -436,6 +333,106 @@ out:
 				SD_CLK_TOGGLE_EN | SD_CLK_FORCE_STOP, 0);
 }
 
+static int sd_read_data(struct realtek_pci_sdmmc *host, struct mmc_command *cmd,
+	u16 byte_cnt, u8 *buf, int buf_len, int timeout)
+{
+	struct rtsx_pcr *pcr = host->pcr;
+	int err;
+	u8 trans_mode;
+
+	dev_dbg(sdmmc_dev(host), "%s: SD/MMC CMD %d, arg = 0x%08x\n",
+		__func__, cmd->opcode, cmd->arg);
+
+	if (!buf)
+		buf_len = 0;
+
+	if (cmd->opcode == MMC_SEND_TUNING_BLOCK)
+		trans_mode = SD_TM_AUTO_TUNING;
+	else
+		trans_mode = SD_TM_NORMAL_READ;
+
+	rtsx_pci_init_cmd(pcr);
+	sd_cmd_set_sd_cmd(pcr, cmd);
+	sd_cmd_set_data_len(pcr, 1, byte_cnt);
+	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, SD_CFG2, 0xFF,
+			SD_CALCULATE_CRC7 | SD_CHECK_CRC16 |
+			SD_NO_WAIT_BUSY_END | SD_CHECK_CRC7 | SD_RSP_LEN_6);
+	if (trans_mode != SD_TM_AUTO_TUNING)
+		rtsx_pci_add_cmd(pcr, WRITE_REG_CMD,
+				CARD_DATA_SOURCE, 0x01, PINGPONG_BUFFER);
+
+	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, SD_TRANSFER,
+			0xFF, trans_mode | SD_TRANSFER_START);
+	rtsx_pci_add_cmd(pcr, CHECK_REG_CMD, SD_TRANSFER,
+			SD_TRANSFER_END, SD_TRANSFER_END);
+
+	err = rtsx_pci_send_cmd(pcr, timeout);
+	if (err < 0) {
+		sd_print_debug_regs(host);
+		dev_dbg(sdmmc_dev(host),
+			"rtsx_pci_send_cmd fail (err = %d)\n", err);
+		return err;
+	}
+
+	if (buf && buf_len) {
+		err = rtsx_pci_read_ppbuf(pcr, buf, buf_len);
+		if (err < 0) {
+			dev_dbg(sdmmc_dev(host),
+				"rtsx_pci_read_ppbuf fail (err = %d)\n", err);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+static int sd_write_data(struct realtek_pci_sdmmc *host,
+	struct mmc_command *cmd, u16 byte_cnt, u8 *buf, int buf_len,
+	int timeout)
+{
+	struct rtsx_pcr *pcr = host->pcr;
+	int err;
+
+	dev_dbg(sdmmc_dev(host), "%s: SD/MMC CMD %d, arg = 0x%08x\n",
+		__func__, cmd->opcode, cmd->arg);
+
+	if (!buf)
+		buf_len = 0;
+
+	sd_send_cmd_get_rsp(host, cmd);
+	if (cmd->error)
+		return cmd->error;
+
+	if (buf && buf_len) {
+		err = rtsx_pci_write_ppbuf(pcr, buf, buf_len);
+		if (err < 0) {
+			dev_dbg(sdmmc_dev(host),
+				"rtsx_pci_write_ppbuf fail (err = %d)\n", err);
+			return err;
+		}
+	}
+
+	rtsx_pci_init_cmd(pcr);
+	sd_cmd_set_data_len(pcr, 1, byte_cnt);
+	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, SD_CFG2, 0xFF,
+		SD_CALCULATE_CRC7 | SD_CHECK_CRC16 |
+		SD_NO_WAIT_BUSY_END | SD_CHECK_CRC7 | SD_RSP_LEN_0);
+	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, SD_TRANSFER, 0xFF,
+			SD_TRANSFER_START | SD_TM_AUTO_WRITE_3);
+	rtsx_pci_add_cmd(pcr, CHECK_REG_CMD, SD_TRANSFER,
+			SD_TRANSFER_END, SD_TRANSFER_END);
+
+	err = rtsx_pci_send_cmd(pcr, timeout);
+	if (err < 0) {
+		sd_print_debug_regs(host);
+		dev_dbg(sdmmc_dev(host),
+			"rtsx_pci_send_cmd fail (err = %d)\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
 static int sd_read_long_data(struct realtek_pci_sdmmc *host,
 	struct mmc_request *mrq)
 {
-- 
1.9.1
