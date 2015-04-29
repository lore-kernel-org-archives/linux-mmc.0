From: <micky_ching@realsil.com.cn>
Subject: [PATCH 01/12] mmc: core: add data structure define for SD4.0
Date: Wed, 29 Apr 2015 09:23:33 +0800
Message-ID: <6b7df1f4bf284af9cc869f4c42d55c6833d16ef5.1429845922.git.micky_ching@realsil.com.cn>
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

The new data structure for SD4.0 including follows:

register: SD4.0 IO space register define.
protocol: host and card handshake data.
tlp: tlp request data structure for SD4.0 mode.
uhsii ios: UHSII bus control data structure.

Signed-off-by: Micky Ching <micky_ching@realsil.com.cn>
Signed-off-by: Wei Wang <wei_wang@realsil.com.cn>
---
 include/linux/mmc/card.h | 13 +++++++
 include/linux/mmc/core.h | 88 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mmc/host.h | 33 ++++++++++++++++++
 include/linux/mmc/sd.h   | 73 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 207 insertions(+)

diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index a6cf4c0..77baf55 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -262,6 +262,7 @@ struct mmc_card {
 #define MMC_CARD_REMOVED	(1<<4)		/* card has been removed */
 #define MMC_STATE_DOING_BKOPS	(1<<5)		/* card is doing BKOPS */
 #define MMC_STATE_SUSPENDED	(1<<6)		/* card is suspended */
+#define MMC_STATE_UHSII		(1<<12)		/* card is in UHS-II mode */
 	unsigned int		quirks; 	/* card quirks */
 #define MMC_QUIRK_LENIENT_FN0	(1<<0)		/* allow SDIO FN0 writes outside of the VS CCCR range */
 #define MMC_QUIRK_BLKSZ_FOR_BYTE_MODE (1<<1)	/* use func->cur_blksize */
@@ -279,6 +280,15 @@ struct mmc_card {
 #define MMC_QUIRK_SEC_ERASE_TRIM_BROKEN (1<<10)	/* Skip secure for erase/trim */
 #define MMC_QUIRK_BROKEN_IRQ_POLLING	(1<<11)	/* Polling SDIO_CCCR_INTx could create a fake interrupt */
 
+	u8			node_id;	/* Node ID for UHS-II card */
+	u8			lane_mode;
+	u8			n_data_gap;
+	u8			max_retry_num;
+	u8			n_fcu;
+	u8			n_lss_dir;
+	u8			n_lss_syn;
+	u16			max_blklen;
+
 	unsigned int		erase_size;	/* erase size in sectors */
  	unsigned int		erase_shift;	/* if erase unit is power 2 */
  	unsigned int		pref_erase;	/* in sectors */
@@ -423,6 +433,7 @@ static inline void __maybe_unused remove_quirk(struct mmc_card *card, int data)
 #define mmc_card_present(c)	((c)->state & MMC_STATE_PRESENT)
 #define mmc_card_readonly(c)	((c)->state & MMC_STATE_READONLY)
 #define mmc_card_blockaddr(c)	((c)->state & MMC_STATE_BLOCKADDR)
+#define mmc_card_uhsii(c)	((c)->state & MMC_STATE_UHSII)
 #define mmc_card_ext_capacity(c) ((c)->state & MMC_CARD_SDXC)
 #define mmc_card_removed(c)	((c) && ((c)->state & MMC_CARD_REMOVED))
 #define mmc_card_doing_bkops(c)	((c)->state & MMC_STATE_DOING_BKOPS)
@@ -431,6 +442,8 @@ static inline void __maybe_unused remove_quirk(struct mmc_card *card, int data)
 #define mmc_card_set_present(c)	((c)->state |= MMC_STATE_PRESENT)
 #define mmc_card_set_readonly(c) ((c)->state |= MMC_STATE_READONLY)
 #define mmc_card_set_blockaddr(c) ((c)->state |= MMC_STATE_BLOCKADDR)
+#define mmc_card_set_uhsii(c) ((c)->state |= MMC_STATE_UHSII)
+#define mmc_card_clr_uhsii(c) ((c)->state &= ~MMC_STATE_UHSII)
 #define mmc_card_set_ext_capacity(c) ((c)->state |= MMC_CARD_SDXC)
 #define mmc_card_set_removed(c) ((c)->state |= MMC_CARD_REMOVED)
 #define mmc_card_set_doing_bkops(c)	((c)->state |= MMC_STATE_DOING_BKOPS)
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index de722d4e..337c6b8 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -15,6 +15,57 @@ struct request;
 struct mmc_data;
 struct mmc_request;
 
+struct mmc_tlp_block {
+	u16 header;
+
+#define UHSII_HD_NP			0x8000
+#define UHSII_HD_TYP_MASK		0x7000
+#define UHSII_HD_TYP_CCMD		(0 << 12)
+#define UHSII_HD_TYP_DCMD		(1 << 12)
+#define UHSII_HD_TYP_RES		(2 << 12)
+#define UHSII_HD_TYP_DATA		(3 << 12)
+#define UHSII_HD_TYP_MSG		(7 << 12)
+#define UHSII_HD_DID_SHIFT		8
+#define UHSII_HD_DID_MASK		(0x0F << UHSII_HD_DID_SHIFT)
+#define UHSII_HD_SID_SHIFT		4
+#define UHSII_HD_SID_MASK		(0x0F << UHSII_HD_SID_SHIFT)
+
+#define UHSII_HD_DID(val) ((val) << UHSII_HD_DID_SHIFT & UHSII_HD_DID_MASK)
+#define UHSII_CHK_CCMD(val) (((val) & UHSII_HD_TYP_MASK) == UHSII_HD_TYP_CCMD)
+#define UHSII_CHK_DCMD(val) (((val) & UHSII_HD_TYP_MASK) == UHSII_HD_TYP_DCMD)
+
+	u16 argument;
+#define UHSII_ARG_DIR_WRITE		0x8000
+#define UHSII_ARG_DIR_READ		0
+#define UHSII_ARG_PLEN_SHIFT		12
+#define UHSII_ARG_PLEN_MASK		(0x03 << UHSII_ARG_PLEN_SHIFT)
+#define UHSII_ARG_IOADR_MASK		0x0FFF
+#define UHSII_ARG_RES_NACK		0x8000
+#define UHSII_ARG_TMODE_SHIFT		11
+#define UHSII_ARG_TMODE_MASK		(0x0F << UHSII_ARG_TMODE_SHIFT)
+#define  UHSII_TMODE_DM_HD		0x08
+#define  UHSII_TMODE_LM_SPECIFIED	0x04
+#define  UHSII_TMODE_TLUM_BYTE		0x02
+#define  UHSII_TMODE_DAM_FIX		0x01
+#define UHSII_ARG_APP_CMD		0x40
+#define UHSII_ARG_CMD_INDEX_MASK	0x3F
+
+#define UHSII_PLEN_BYTES(plen)		((plen) ? 2 << (plen) : 0)
+#define UHSII_PLEN_DWORDS(plen)		((plen) == 3 ? 4 : (plen))
+
+#define UHSII_GET_PLEN(tlp_block) \
+	((u8)(((tlp_block)->argument & UHSII_ARG_PLEN_MASK)	\
+		>> UHSII_ARG_PLEN_SHIFT))
+#define UHSII_GET_TMODE(tlp_block) \
+	((u8)(((tlp_block)->argument & UHSII_ARG_TMODE_MASK)	\
+		>> UHSII_ARG_TMODE_SHIFT))
+
+	u32 payload[4];
+#define UHSII_GET_GAP(tlp_block)				\
+	((u8)(((tlp_block)->payload[0] >> SD40_GAP_SHIFT)	\
+		& SD40_GAP_MASK))
+};
+
 struct mmc_command {
 	u32			opcode;
 	u32			arg;
@@ -101,6 +152,10 @@ struct mmc_command {
 
 	struct mmc_data		*data;		/* data segment associated with cmd */
 	struct mmc_request	*mrq;		/* associated request */
+
+	struct mmc_tlp_block	tlp_send;
+	bool			use_tlp;
+	bool			app_cmd;
 };
 
 struct mmc_data {
@@ -125,18 +180,51 @@ struct mmc_data {
 	s32			host_cookie;	/* host private data */
 };
 
+struct mmc_tlp {
+	struct mmc_tlp_block		*tlp_send;
+	struct mmc_tlp_block		*tlp_back;
+
+	u8				cmd_type;
+#define UHSII_COMMAND_NORMAL		0x00
+#define UHSII_COMMAND_GO_DORMANT	0x03
+
+	unsigned int			retries; /* max number of retries */
+	int				error;
+};
+
 struct mmc_host;
 struct mmc_request {
 	struct mmc_command	*sbc;		/* SET_BLOCK_COUNT for multiblock */
 	struct mmc_command	*cmd;
 	struct mmc_data		*data;
 	struct mmc_command	*stop;
+	struct mmc_tlp		*tlp;
 
 	struct completion	completion;
 	void			(*done)(struct mmc_request *);/* completion function */
 	struct mmc_host		*host;
 };
 
+static inline void mmc_set_mrq_error_code(struct mmc_request *mrq, int err)
+{
+	if (mrq->cmd)
+		mrq->cmd->error = err;
+	else
+		mrq->tlp->error = err;
+}
+
+static inline int mmc_get_mrq_error_code(struct mmc_request *mrq)
+{
+	int err;
+
+	if (mrq->cmd)
+		err = mrq->cmd->error;
+	else
+		err = mrq->tlp->error;
+
+	return err;
+}
+
 struct mmc_card;
 struct mmc_async_req;
 
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index b5bedae..2c4fcf5 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -78,6 +78,23 @@ struct mmc_ios {
 #define MMC_SET_DRIVER_TYPE_D	3
 };
 
+struct mmc_uhsii_ios {
+	u8 speed_range;
+#define SD_UHSII_SPEED_RANGE_A		0
+#define SD_UHSII_SPEED_RANGE_B		1
+
+	u8 n_fcu;
+
+	u8 pwr_ctl_mode;
+#define SD_UHSII_PWR_CTL_FAST_MODE	0
+#define SD_UHSII_PWR_CTL_LOW_PWR_MODE	1
+
+	u32 flags;
+#define SETTING_SPEED_RANGE		(1 << 0)
+#define SETTING_N_FCU			(1 << 1)
+#define SETTING_PWR_CTL_MODE		(1 << 2)
+};
+
 struct mmc_host_ops {
 	/*
 	 * It is optional for the host to implement pre_req and post_req in
@@ -135,6 +152,10 @@ struct mmc_host_ops {
 	void	(*hw_reset)(struct mmc_host *host);
 	void	(*card_event)(struct mmc_host *host);
 
+	int	(*switch_uhsii_if)(struct mmc_host *host);
+	int	(*exit_dormant)(struct mmc_host *host);
+	void	(*set_uhsii_ios)(struct mmc_host *host,
+			struct mmc_uhsii_ios *ios);
 	/*
 	 * Optional callback to support controllers with HW issues for multiple
 	 * I/O. Returns the number of supported blocks for the request.
@@ -257,6 +278,7 @@ struct mmc_host {
 #define MMC_CAP_UHS_SDR104	(1 << 18)	/* Host supports UHS SDR104 mode */
 #define MMC_CAP_UHS_DDR50	(1 << 19)	/* Host supports UHS DDR50 mode */
 #define MMC_CAP_RUNTIME_RESUME	(1 << 20)	/* Resume at runtime_resume. */
+#define MMC_CAP_UHSII		(1 << 21)	/* Host supports UHS-II mode */
 #define MMC_CAP_DRIVER_TYPE_A	(1 << 23)	/* Host supports Driver Type A */
 #define MMC_CAP_DRIVER_TYPE_C	(1 << 24)	/* Host supports Driver Type C */
 #define MMC_CAP_DRIVER_TYPE_D	(1 << 25)	/* Host supports Driver Type D */
@@ -285,6 +307,8 @@ struct mmc_host {
 				 MMC_CAP2_HS400_1_2V)
 #define MMC_CAP2_HSX00_1_2V	(MMC_CAP2_HS200_1_2V_SDR | MMC_CAP2_HS400_1_2V)
 #define MMC_CAP2_SDIO_IRQ_NOTHREAD (1 << 17)
+#define MMC_CAP2_UHSII_RANGE_AB	(1 << 18)	/* Supported speed range */
+#define MMC_CAP2_UHSII_LOW_PWR	(1 << 19)	/* Support UHS-II low power */
 
 	mmc_pm_flag_t		pm_caps;	/* supported pm features */
 
@@ -300,6 +324,15 @@ struct mmc_host {
 	unsigned long           clkgate_delay;
 #endif
 
+	u8			lane_mode;
+	u8			max_gap;
+	u8			max_dap;
+	u8			n_data_gap;
+	u8			n_fcu;
+	u8			n_lss_dir;
+	u8			n_lss_syn;
+	struct mmc_uhsii_ios	uhsii_ios;
+
 	/* host specific block data */
 	unsigned int		max_seg_size;	/* see blk_queue_max_segment_size */
 	unsigned short		max_segs;	/* see blk_queue_max_segments */
diff --git a/include/linux/mmc/sd.h b/include/linux/mmc/sd.h
index 1ebcf9b..ec0e12d 100644
--- a/include/linux/mmc/sd.h
+++ b/include/linux/mmc/sd.h
@@ -91,4 +91,77 @@
 #define SD_SWITCH_ACCESS_DEF	0
 #define SD_SWITCH_ACCESS_HS	1
 
+#define UHSII_IOADR(base, reg)			(((u16)(base) << 8) | (reg))
+#define UHSII_IOADR_BASE(arg)			(((arg) >> 8) & 0x0F)
+#define UHSII_IOADR_OFFSET(arg)			((arg) & 0xFF)
+
+/* IOADR of Generic Capabilities Register (DW) */
+#define SD40_IOADR_GEN_CAP_L			0x00
+#define SD40_IOADR_GEN_CAP_H			0x01
+
+/* IOADR of PHY Capabilities Register (DW)  */
+#define SD40_IOADR_PHY_CAP_L			0x02
+#define SD40_IOADR_PHY_CAP_H			0x03
+
+/* IOADR LINK/TRAN Capabilities Register (DW) */
+#define SD40_IOADR_LINK_CAP_L			0x04
+#define SD40_IOADR_LINK_CAP_H			0x05
+
+#define SD40_IOADR_GEN_SET_L			0x08
+#define SD40_IOADR_GEN_SET_H			0x09
+
+#define SD40_IOADR_PHY_SET_L			0x0A
+#define SD40_IOADR_PHY_SET_H			0x0B
+
+#define SD40_IOADR_LINK_SET_L			0x0C
+#define SD40_IOADR_LINK_SET_H			0x0D
+
+/* Node ID (First or Last) ENUMERATE */
+#define SD40_IDL_SHIFT				24
+#define SD40_IDL_MASK				(0x0F << SD40_IDL_SHIFT)
+
+/* SD40 I/O Address space offset */
+#define SD40_IOADR_CFG_BASE			0x00  /*000h : 0FFh*/
+#define SD40_IOADR_INT_BASE			0x01  /*100h : 17Fh*/
+#define SD40_IOADR_ST_BASE			0x01  /*180h : 1FFh*/
+#define SD40_IOADR_CMD_BASE			0x02  /*200h : 2FFh*/
+#define SD40_IOADR_VENDOR_BASE			0x0F  /*F00h : FFFh*/
+
+/* Command Register (CMD_REG).  DW, Base on IOADR_CMD_BASE */
+#define SD40_FULL_RESET				0x00
+#define SD40_GO_DORMANT_STATE			0x01
+#define SD40_DEVICE_INIT			0x02
+#define SD40_ENUMERATE				0x03
+#define SD40_TRANS_ABORT			0x04
+
+/* DEVICE_INIT */
+#define SD40_GD_SHIFT				28
+#define SD40_GD_MASK				(0x0F << SD40_GD_SHIFT)
+#define SD40_GAP_SHIFT				24
+#define SD40_GAP_MASK				(0x0F << SD40_GAP_SHIFT)
+#define SD40_DAP_SHIFT				20
+#define SD40_DAP_MASK				(0x0F << SD40_DAP_SHIFT)
+#define SD40_CF					0x80000
+
+#define SD40_GD(val)		(((val) << SD40_GD_SHIFT) & SD40_GD_MASK)
+#define SD40_GAP(val)		(((val) << SD40_GAP_SHIFT) & SD40_GAP_MASK)
+#define SD40_DAP(val)		(((val) << SD40_DAP_SHIFT) & SD40_DAP_MASK)
+
+/* Generic Capabilities Register */
+#define SD40_LANE_MODE_SHIFT			8
+#define SD40_LANE_MODE_MASK			(0x3F << SD40_LANE_MODE_SHIFT)
+#define SD40_LANE_MODE_2L_HD			0x01
+#define SD40_LANE_MODE_2D1U_FD			0x02
+#define SD40_LANE_MODE_1D2U_FD			0x04
+#define SD40_LANE_MODE_2D2U_FD			0x08
+
+#define SD40_APP_TYPE_MASK			0x07
+#define SD40_APP_TYPE_SD_MEMORY			0x01
+#define SD40_APP_TYPE_SDIO			0x02
+#define SD40_APP_TYPE_EMBEDDED			0x04
+
+/* Generic Settings Register */
+#define SD40_CONFIG_COMPLETE			0x80000000
+#define SD40_LOW_PWR_MODE			0x01
+
 #endif /* LINUX_MMC_SD_H */
-- 
1.9.1
