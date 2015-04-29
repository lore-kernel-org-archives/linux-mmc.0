From: <micky_ching@realsil.com.cn>
Subject: [PATCH 03/12] mmc: core: add SD4.0 operation function
Date: Wed, 29 Apr 2015 09:23:35 +0800
Message-ID: <a5f1089db3928579c14d03cc6f517ef0dd7068e3.1429845922.git.micky_ching@realsil.com.cn>
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

SD4.0 add some new operations, which include follows:

UHSII interface detect: when UHSII interface is detected, the power is up.
go/exit dormant: enter or exit dormant state.
device init: device init CCMD.
enumerate: enumerate CCMD.
config space read/write CCMD.

when we send SD command in UHSII mode, we need to pack mmc_command to
mmc_tlp_block, using tlp to transfer cmd.

Signed-off-by: Micky Ching <micky_ching@realsil.com.cn>
Signed-off-by: Wei Wang <wei_wang@realsil.com.cn>
---
 drivers/mmc/core/sd.c     | 187 +++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/core/sd.h     |   1 +
 drivers/mmc/core/sd_ops.c | 210 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/core/sd_ops.h |   7 ++
 4 files changed, 405 insertions(+)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 31a9ef2..8dd35d9 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -707,6 +707,38 @@ struct device_type sd_type = {
 	.groups = sd_std_groups,
 };
 
+static int mmc_sd_switch_uhsii_if(struct mmc_host *host)
+{
+	int err = 0;
+
+	if (!(host->caps & MMC_CAP_UHSII) || !host->ops->switch_uhsii_if)
+		return -ENXIO;
+
+	mmc_host_clk_hold(host);
+	err = host->ops->switch_uhsii_if(host);
+	mmc_host_clk_release(host);
+
+	if (!err)
+		host->ios.power_mode = MMC_POWER_ON;
+
+	mmc_delay(10);
+	return err;
+}
+
+static int mmc_sd_exit_dormant(struct mmc_host *host)
+{
+	int ret;
+
+	if (!(host->caps & MMC_CAP_UHSII) || !host->ops->exit_dormant)
+		return 0;
+
+	mmc_host_clk_hold(host);
+	ret = host->ops->exit_dormant(host);
+	mmc_host_clk_release(host);
+
+	return ret;
+}
+
 /*
  * Fetch CID from card.
  */
@@ -1211,6 +1243,161 @@ static const struct mmc_bus_ops mmc_sd_ops = {
 	.reset = mmc_sd_reset,
 };
 
+static inline void mmc_set_uhsii_ios(struct mmc_host *host)
+{
+	struct mmc_uhsii_ios *ios = &host->uhsii_ios;
+
+	pr_debug("%s: speedrange %d nfcu %d\n",
+		 mmc_hostname(host), ios->speed_range, ios->n_fcu);
+
+	host->ops->set_uhsii_ios(host, ios);
+}
+
+int mmc_sd_init_uhsii_card(struct mmc_card *card)
+{
+	struct mmc_host *host = card->host;
+	int err = 0, i;
+	u32 cap[2], setting;
+
+	mmc_card_set_uhsii(card);
+
+	err = mmc_sd_switch_uhsii_if(host);
+	if (err) {
+		mmc_card_clr_uhsii(card);
+		return err;
+	}
+
+	pr_debug("%s: try UHS-II interface\n", mmc_hostname(host));
+
+	for (i = 0; i < 5; i++) {
+		err = mmc_sd_send_device_init_ccmd(card);
+		if (!err)
+			break;
+
+		msleep(20);
+	}
+	if (err)
+		goto poweroff;
+
+	err = mmc_sd_send_enumerate_ccmd(card);
+	if (err)
+		goto poweroff;
+
+	err = mmc_sd_read_cfg_ccmd(card, SD40_IOADR_GEN_CAP_L, 2, cap);
+	if (err)
+		goto poweroff;
+	card->lane_mode = (cap[0] & SD40_LANE_MODE_MASK) >>
+		SD40_LANE_MODE_SHIFT;
+	card->lane_mode &= host->lane_mode;
+	pr_debug("%s: card->lane_mode = 0x%x\n",
+		mmc_hostname(host), card->lane_mode);
+
+	err = mmc_sd_read_cfg_ccmd(card, SD40_IOADR_PHY_CAP_L, 2, cap);
+	if (err)
+		goto poweroff;
+	card->n_lss_dir = (cap[1] & 0xF0) >> 4;
+	card->n_lss_syn = cap[1] & 0x0F;
+	pr_debug("%s: card->n_lss_dir = %d, card->n_lss_syn = %d\n",
+		mmc_hostname(host), card->n_lss_dir, card->n_lss_syn);
+
+	err = mmc_sd_read_cfg_ccmd(card, SD40_IOADR_LINK_CAP_L, 2, cap);
+	if (err)
+		goto poweroff;
+	card->n_fcu = (cap[0] & 0xFF00) >> 8;
+	card->max_retry_num = (cap[0] & 0x30000) >> 16;
+	card->max_blklen = (cap[0] & 0xFFF00000) >> 20;
+	card->n_data_gap = cap[1] & 0xFF;
+	pr_debug("%s: card->n_fcu = %d\n", mmc_hostname(host), card->n_fcu);
+	pr_debug("%s: card->max_retry_num = %d\n",
+		mmc_hostname(host), card->max_retry_num);
+	pr_debug("%s: card->max_blklen = %d\n",
+		mmc_hostname(host), card->max_blklen);
+	pr_debug("%s: card->n_data_gap = %d\n",
+		mmc_hostname(host), card->n_data_gap);
+
+	if (card->n_lss_dir < host->n_lss_dir)
+		card->n_lss_dir = host->n_lss_dir;
+	if (card->n_lss_syn < host->n_lss_syn)
+		card->n_lss_syn = host->n_lss_syn;
+	setting = ((card->n_lss_dir << 4) & 0xF0) | (card->n_lss_syn & 0x0F);
+	err = mmc_sd_write_cfg_ccmd(card,
+			SD40_IOADR_PHY_SET_H, 1, &setting);
+	if (err)
+		goto poweroff;
+
+	if (card->n_data_gap < host->n_data_gap)
+		card->n_data_gap = host->n_data_gap;
+	setting = card->n_data_gap;
+	err = mmc_sd_write_cfg_ccmd(card,
+			SD40_IOADR_LINK_SET_H, 1, &setting);
+	if (err)
+		goto poweroff;
+
+	if (host->caps2 & MMC_CAP2_UHSII_LOW_PWR) {
+		/* Set low power mode */
+		setting = SD40_LOW_PWR_MODE;
+		err = mmc_sd_write_cfg_ccmd(card,
+				SD40_IOADR_GEN_SET_L, 1, &setting);
+		if (err)
+			goto poweroff;
+		host->uhsii_ios.pwr_ctl_mode = SD_UHSII_PWR_CTL_LOW_PWR_MODE;
+		host->uhsii_ios.flags = SETTING_PWR_CTL_MODE;
+		mmc_set_uhsii_ios(host);
+	}
+
+	if (host->n_fcu) {
+		if (!card->n_fcu || (card->n_fcu > host->n_fcu))
+			card->n_fcu = host->n_fcu;
+	}
+	setting = (card->n_fcu << 8) | (card->max_retry_num << 16) |
+		(card->max_blklen << 20);
+	err = mmc_sd_write_cfg_ccmd(card, SD40_IOADR_LINK_SET_L, 1, &setting);
+	if (err)
+		goto poweroff;
+
+	setting = SD40_CONFIG_COMPLETE;
+	err = mmc_sd_write_cfg_ccmd(card, SD40_IOADR_GEN_SET_H, 1, &setting);
+	if (err)
+		goto poweroff;
+
+	host->uhsii_ios.n_fcu = card->n_fcu;
+	host->uhsii_ios.flags = SETTING_N_FCU;
+	mmc_set_uhsii_ios(host);
+
+	if (host->caps2 & MMC_CAP2_UHSII_RANGE_AB) {
+		pr_debug("%s: Select Speed Range B\n", mmc_hostname(host));
+
+		setting = (1 << 6);
+		err = mmc_sd_write_cfg_ccmd(card,
+				SD40_IOADR_PHY_SET_L, 1, &setting);
+		if (err)
+			goto poweroff;
+
+		host->uhsii_ios.speed_range = SD_UHSII_SPEED_RANGE_B;
+		host->uhsii_ios.flags = SETTING_SPEED_RANGE;
+		mmc_set_uhsii_ios(host);
+
+		/* Enter dormant state */
+		err = mmc_sd_send_go_dormant_state_ccmd(card, 0);
+		if (err)
+			goto poweroff;
+
+		/* Exit dormant state */
+		err = mmc_sd_exit_dormant(host);
+		if (err)
+			goto poweroff;
+	}
+
+	pr_debug("%s: UHSII-interface init success\n", mmc_hostname(host));
+	return 0;
+
+poweroff:
+	mmc_power_off(host);
+	mmc_card_clr_uhsii(card);
+
+	return err;
+}
+
 /*
  * Starting point for SD card init.
  */
diff --git a/drivers/mmc/core/sd.h b/drivers/mmc/core/sd.h
index aab824a..4f3a6e0 100644
--- a/drivers/mmc/core/sd.h
+++ b/drivers/mmc/core/sd.h
@@ -12,5 +12,6 @@ int mmc_sd_setup_card(struct mmc_host *host, struct mmc_card *card,
 	bool reinit);
 unsigned mmc_sd_get_max_clock(struct mmc_card *card);
 int mmc_sd_switch_hs(struct mmc_card *card);
+int mmc_sd_init_uhsii_card(struct mmc_card *card);
 
 #endif
diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
index cd37971c..1f3dd30 100644
--- a/drivers/mmc/core/sd_ops.c
+++ b/drivers/mmc/core/sd_ops.c
@@ -400,3 +400,213 @@ int mmc_app_sd_status(struct mmc_card *card, void *ssr)
 
 	return 0;
 }
+
+int mmc_sd_send_device_init_ccmd(struct mmc_card *card)
+{
+	struct mmc_host *host = card->host;
+	struct mmc_request mrq = {NULL};
+	struct mmc_tlp tlp = {NULL};
+	struct mmc_tlp_block cmd = {0}, resp = {0};
+	int i;
+	u8 gd = 0, gap;
+	u16 ioadr = UHSII_IOADR(SD40_IOADR_CMD_BASE, SD40_DEVICE_INIT);
+	u32 payload;
+
+	payload = SD40_CF | SD40_GAP(host->max_gap) | SD40_DAP(host->max_dap);
+
+	mrq.tlp = &tlp;
+	tlp.tlp_send = &cmd;
+	tlp.tlp_back = &resp;
+	tlp.retries = 0;
+
+	tlp.tlp_send->header = UHSII_HD_NP | UHSII_HD_TYP_CCMD;
+	tlp.tlp_send->argument = UHSII_ARG_DIR_WRITE |
+		(1 << UHSII_ARG_PLEN_SHIFT) | (ioadr & UHSII_ARG_IOADR_MASK);
+
+	for (i = 0; i < 30; i++) {
+		tlp.tlp_send->payload[0] = payload;
+
+		mmc_wait_for_req(host, &mrq);
+
+		if (tlp.error)
+			return tlp.error;
+
+		if (tlp.tlp_back->payload[0] & SD40_CF)
+			return 0;
+
+		gap = UHSII_GET_GAP(tlp.tlp_back);
+		if (gap == host->max_gap) {
+			gd++;
+			payload |= (gd & SD40_GD_MASK) << SD40_GD_SHIFT;
+		}
+	}
+
+	return -ETIMEDOUT;
+}
+
+int mmc_sd_send_enumerate_ccmd(struct mmc_card *card)
+{
+	struct mmc_host *host = card->host;
+	struct mmc_request mrq = {NULL};
+	struct mmc_tlp tlp = {NULL};
+	struct mmc_tlp_block cmd = {0}, resp = {0};
+	u16 ioadr = UHSII_IOADR(SD40_IOADR_CMD_BASE, SD40_ENUMERATE);
+
+	mrq.tlp = &tlp;
+	tlp.tlp_send = &cmd;
+	tlp.tlp_back = &resp;
+	tlp.retries = 0;
+
+	tlp.tlp_send->header = UHSII_HD_NP | UHSII_HD_TYP_CCMD;
+	tlp.tlp_send->argument = UHSII_ARG_DIR_WRITE |
+		(1 << UHSII_ARG_PLEN_SHIFT) | (ioadr & UHSII_ARG_IOADR_MASK);
+	tlp.tlp_send->payload[0] = 0;
+
+	mmc_wait_for_req(host, &mrq);
+
+	if (tlp.error)
+		return tlp.error;
+
+	card->node_id = (tlp.tlp_back->payload[0] & SD40_IDL_MASK)
+		>> SD40_IDL_SHIFT;
+
+	return 0;
+}
+
+int mmc_sd_send_go_dormant_state_ccmd(struct mmc_card *card, int hibernate)
+{
+	struct mmc_host *host = card->host;
+	struct mmc_request mrq = {NULL};
+	struct mmc_tlp tlp = {NULL};
+	struct mmc_tlp_block cmd = {0}, resp = {0};
+	u16 ioadr = UHSII_IOADR(SD40_IOADR_CMD_BASE, SD40_GO_DORMANT_STATE);
+
+	mrq.tlp = &tlp;
+	tlp.tlp_send = &cmd;
+	tlp.tlp_back = &resp;
+	tlp.retries = 0;
+	tlp.cmd_type = UHSII_COMMAND_GO_DORMANT;
+
+	tlp.tlp_send->header = UHSII_HD_NP | UHSII_HD_TYP_CCMD |
+		UHSII_HD_DID(card->node_id);
+	tlp.tlp_send->argument = UHSII_ARG_DIR_WRITE |
+		(1 << UHSII_ARG_PLEN_SHIFT) | (ioadr & UHSII_ARG_IOADR_MASK);
+	if (hibernate)
+		tlp.tlp_send->payload[0] = 0x80000000;
+	else
+		tlp.tlp_send->payload[0] = 0;
+
+	mmc_wait_for_req(host, &mrq);
+
+	if (tlp.error)
+		return tlp.error;
+
+	return 0;
+}
+
+int mmc_sd_read_cfg_ccmd(struct mmc_card *card, u8 offset, u8 plen, u32 *buf)
+{
+	struct mmc_host *host = card->host;
+	struct mmc_request mrq = {NULL};
+	struct mmc_tlp tlp = {NULL};
+	struct mmc_tlp_block cmd = {0}, resp = {0};
+	u16 ioadr = UHSII_IOADR(SD40_IOADR_CFG_BASE, offset);
+	int i;
+
+	mrq.tlp = &tlp;
+	tlp.tlp_send = &cmd;
+	tlp.tlp_back = &resp;
+	tlp.retries = 0;
+
+	tlp.tlp_send->header = UHSII_HD_NP | UHSII_HD_TYP_CCMD |
+		UHSII_HD_DID(card->node_id);
+	tlp.tlp_send->argument = UHSII_ARG_DIR_READ |
+		(plen << UHSII_ARG_PLEN_SHIFT) |
+		(ioadr & UHSII_ARG_IOADR_MASK);
+
+	mmc_wait_for_req(host, &mrq);
+
+	if (tlp.error)
+		return tlp.error;
+
+	for (i = 0; i < plen; i++)
+		buf[i] = tlp.tlp_back->payload[i];
+
+	return 0;
+}
+
+int mmc_sd_write_cfg_ccmd(struct mmc_card *card, u8 offset, u8 plen, u32 *buf)
+{
+	struct mmc_host *host = card->host;
+	struct mmc_request mrq = {NULL};
+	struct mmc_tlp tlp = {NULL};
+	struct mmc_tlp_block cmd = {0}, resp = {0};
+	u16 ioadr = UHSII_IOADR(SD40_IOADR_CFG_BASE, offset);
+	int i;
+
+	mrq.tlp = &tlp;
+	tlp.tlp_send = &cmd;
+	tlp.tlp_back = &resp;
+	tlp.retries = 0;
+
+	tlp.tlp_send->header = UHSII_HD_NP | UHSII_HD_TYP_CCMD |
+		UHSII_HD_DID(card->node_id);
+	tlp.tlp_send->argument = UHSII_ARG_DIR_WRITE |
+		(plen << UHSII_ARG_PLEN_SHIFT) |
+		(ioadr & UHSII_ARG_IOADR_MASK);
+	for (i = 0; i < plen; i++)
+		tlp.tlp_send->payload[i] = buf[i];
+
+	mmc_wait_for_req(host, &mrq);
+
+	if (tlp.error)
+		return tlp.error;
+
+	return 0;
+}
+
+void mmc_sd_tran_pack_ccmd(struct mmc_card *card, struct mmc_command *cmd)
+{
+	struct mmc_tlp_block *tlp_send = &cmd->tlp_send;
+
+	tlp_send->header = UHSII_HD_TYP_CCMD | UHSII_HD_DID(card->node_id);
+
+	tlp_send->argument = cmd->opcode & UHSII_ARG_CMD_INDEX_MASK;
+	if (cmd->app_cmd)
+		tlp_send->argument |= UHSII_ARG_APP_CMD;
+
+	tlp_send->payload[0] = cmd->arg;
+
+	pr_debug("%s: SDTRAN CCMD header = 0x%04x, arg = 0x%04x\n",
+		mmc_hostname(card->host), tlp_send->header, tlp_send->argument);
+}
+
+void mmc_sd_tran_pack_dcmd(struct mmc_card *card, struct mmc_command *cmd)
+{
+	u8 tmode = 0;
+	u32 tlen = 0;
+	struct mmc_tlp_block *tlp_send = &cmd->tlp_send;
+
+	tlp_send->header = UHSII_HD_TYP_DCMD | UHSII_HD_DID(card->node_id);
+
+	tlp_send->argument = cmd->opcode & UHSII_ARG_CMD_INDEX_MASK;
+	if (cmd->app_cmd)
+		tlp_send->argument |= UHSII_ARG_APP_CMD;
+	if (cmd->data && (cmd->data->flags & MMC_DATA_WRITE))
+		tlp_send->argument |= UHSII_ARG_DIR_WRITE;
+	if (mmc_op_multi(cmd->opcode)) {
+		tmode |= UHSII_TMODE_LM_SPECIFIED;
+		if (card->lane_mode & SD40_LANE_MODE_2L_HD)
+			tmode |= UHSII_TMODE_DM_HD;
+		if (cmd->data)
+			tlen = cmd->data->blocks;
+	}
+	tlp_send->argument |= tmode << UHSII_ARG_TMODE_SHIFT;
+
+	tlp_send->payload[0] = cmd->arg;
+	tlp_send->payload[1] = tlen;
+
+	pr_debug("%s: SDTRAN DCMD header = 0x%04x, arg = 0x%04x, TLEN = %d\n",
+		mmc_hostname(card->host), tlp_send->header, tlp_send->argument,
+		tlen);
+}
diff --git a/drivers/mmc/core/sd_ops.h b/drivers/mmc/core/sd_ops.h
index ffc2305..00aea01 100644
--- a/drivers/mmc/core/sd_ops.h
+++ b/drivers/mmc/core/sd_ops.h
@@ -20,6 +20,13 @@ int mmc_app_send_scr(struct mmc_card *card, u32 *scr);
 int mmc_sd_switch(struct mmc_card *card, int mode, int group,
 	u8 value, u8 *resp);
 int mmc_app_sd_status(struct mmc_card *card, void *ssr);
+int mmc_sd_send_device_init_ccmd(struct mmc_card *card);
+int mmc_sd_send_enumerate_ccmd(struct mmc_card *card);
+int mmc_sd_send_go_dormant_state_ccmd(struct mmc_card *card, int hibernate);
+int mmc_sd_read_cfg_ccmd(struct mmc_card *card, u8 offset, u8 plen, u32 *buf);
+int mmc_sd_write_cfg_ccmd(struct mmc_card *card, u8 offset, u8 plen, u32 *buf);
+void mmc_sd_tran_pack_ccmd(struct mmc_card *card, struct mmc_command *cmd);
+void mmc_sd_tran_pack_dcmd(struct mmc_card *card, struct mmc_command *cmd);
 
 #endif
 
-- 
1.9.1
