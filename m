From: <micky_ching@realsil.com.cn>
Subject: [PATCH 07/12] mmc: sdhci: add data structure for SD4.0
Date: Wed, 29 Apr 2015 09:23:39 +0800
Message-ID: <d854a023e0b5c7836b1385114dbad6acc7874d07.1429845922.git.micky_ching@realsil.com.cn>
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

add SD4.0 register define and host data structure for
handshake with SD4.0 card.

Signed-off-by: Micky Ching <micky_ching@realsil.com.cn>
Signed-off-by: Wei Wang <wei_wang@realsil.com.cn>
---
 drivers/mmc/host/sdhci.h | 136 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 135 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index e639b7f..659eb64 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -73,6 +73,9 @@
 #define  SDHCI_DATA_LVL_MASK	0x00F00000
 #define   SDHCI_DATA_LVL_SHIFT	20
 #define   SDHCI_DATA_0_LVL_MASK	0x00100000
+#define  SDHCI_IN_DORMANT_STATE	0x20000000
+#define  SDHCI_LANE_SYNC	0x40000000
+#define  SDHCI_STBL_DETECT	0x80000000
 
 #define SDHCI_HOST_CONTROL	0x28
 #define  SDHCI_CTRL_LED		0x01
@@ -90,6 +93,8 @@
 #define  SDHCI_POWER_180	0x0A
 #define  SDHCI_POWER_300	0x0C
 #define  SDHCI_POWER_330	0x0E
+#define  SDHCI_VDD1_SHIFT	0
+#define  SDHCI_VDD2_SHIFT	4
 
 #define SDHCI_BLOCK_GAP_CONTROL	0x2A
 
@@ -162,6 +167,7 @@
 #define   SDHCI_CTRL_UHS_SDR104		0x0003
 #define   SDHCI_CTRL_UHS_DDR50		0x0004
 #define   SDHCI_CTRL_HS400		0x0005 /* Non-standard */
+#define   SDHCI_CTRL_UHSII		0x0007
 #define  SDHCI_CTRL_VDD_180		0x0008
 #define  SDHCI_CTRL_DRV_TYPE_MASK	0x0030
 #define   SDHCI_CTRL_DRV_TYPE_B		0x0000
@@ -170,6 +176,10 @@
 #define   SDHCI_CTRL_DRV_TYPE_D		0x0030
 #define  SDHCI_CTRL_EXEC_TUNING		0x0040
 #define  SDHCI_CTRL_TUNED_CLK		0x0080
+#define  SDHCI_CTRL_UHSII_IF_ENABLE	0x0100
+#define  SDHCI_CTRL_HOST_V4_ENABLE	0x1000
+#define  SDHCI_CTRL_64BIT_ADDR_ENABLE	0x2000
+#define  SDHCI_CTRL_ASYNC_INT_ENABLE	0x4000
 #define  SDHCI_CTRL_PRESET_VAL_ENABLE	0x8000
 
 #define SDHCI_CAPABILITIES	0x40
@@ -194,6 +204,7 @@
 #define  SDHCI_SUPPORT_SDR50	0x00000001
 #define  SDHCI_SUPPORT_SDR104	0x00000002
 #define  SDHCI_SUPPORT_DDR50	0x00000004
+#define  SDHCI_SUPPORT_UHSII	0x00000008
 #define  SDHCI_DRIVER_TYPE_A	0x00000010
 #define  SDHCI_DRIVER_TYPE_C	0x00000020
 #define  SDHCI_DRIVER_TYPE_D	0x00000040
@@ -205,6 +216,8 @@
 #define  SDHCI_CLOCK_MUL_MASK	0x00FF0000
 #define  SDHCI_CLOCK_MUL_SHIFT	16
 #define  SDHCI_SUPPORT_HS400	0x80000000 /* Non-standard */
+#define  SDHCI_CAN_DO_ADMA3	0x08000000
+#define  SDHCI_CAN_VDD2_180	0x10000000
 
 #define SDHCI_CAPABILITIES_1	0x44
 
@@ -230,7 +243,7 @@
 #define SDHCI_ADMA_ADDRESS	0x58
 #define SDHCI_ADMA_ADDRESS_HI	0x5C
 
-/* 60-FB reserved */
+/* 60-73 reserved */
 
 #define SDHCI_PRESET_FOR_SDR12 0x66
 #define SDHCI_PRESET_FOR_SDR25 0x68
@@ -245,6 +258,71 @@
 #define SDHCI_PRESET_SDCLK_FREQ_MASK   0x3FF
 #define SDHCI_PRESET_SDCLK_FREQ_SHIFT	0
 
+#define SDHCI_PRESET_VALUE_UHSII	0x74
+#define SDHCI_ADMA3_ID_ADDRESS		0x78
+
+#define SDHCI_UHSII_BLOCK_SIZE		0x80
+#define SDHCI_UHSII_BLOCK_COUNT		0x84
+
+#define SDHCI_UHSII_CMD_PACKET		0x88
+#define  SDHCI_UHSII_CMD_PACK_LEN	20
+#define SDHCI_UHSII_CMD_HEADER		(SDHCI_UHSII_CMD_PACKET)
+#define SDHCI_UHSII_CMD_ARGUMENT	(SDHCI_UHSII_CMD_PACKET + 2)
+#define SDHCI_UHSII_CMD_PAYLOAD		(SDHCI_UHSII_CMD_PACKET + 4)
+
+#define SDHCI_UHSII_TRANSFER_MODE	0x9C
+#define  SDHCI_UHSII_TRNS_DMA		0x01
+#define  SDHCI_UHSII_TRNS_BLK_CNT_EN	0x02
+#define  SDHCI_UHSII_TRNS_WRITE		0x10
+#define  SDHCI_UHSII_TRNS_BYTE_MODE	0x20
+#define  SDHCI_UHSII_TRNS_WAIT_EBSY	0x4000
+#define  SDHCI_UHSII_TRANS_2LANE_HD	0x8000
+#define SDHCI_UHSII_COMMAND		0x9E
+#define  SDHCI_UHSII_DATA_PRESENT	0x0020
+#define  SDHCI_UHSII_NORMAL_COMMAND	(0 << 6)
+#define  SDHCI_UHSII_TRANS_ABORT_CCMD	(1 << 6)
+#define  SDHCI_UHSII_ABORT_COMMAND	(2 << 6)
+#define  SDHCI_UHSII_GO_DORMANT		(3 << 6)
+#define  SDHCI_UHSII_COMMAND_LEN_SHIFT	8
+#define  SDHCI_UHSII_COMMAND_LEN_MASK	0x1F
+
+#define SDHCI_UHSII_RESPONSE		0xA0
+#define  SDHCI_UHSII_RESP_LEN		20
+#define SDHCI_UHSII_RESP_HEADER		SDHCI_UHSII_RESPONSE
+#define SDHCI_UHSII_RESP_ARGUMENT	(SDHCI_UHSII_RESPONSE + 2)
+#define SDHCI_UHSII_RESP_PAYLOAD	(SDHCI_UHSII_RESPONSE + 4)
+
+#define SDHCI_UHSII_MSG_SEL		0xB4
+#define SDHCI_UHSII_MSG_REG		0xB8
+#define SDHCI_UHSII_DEV_INT_STATUS	0xBC
+#define SDHCI_UHSII_DEV_SEL		0xBE
+#define SDHCI_UHSII_INT_CODE		0xBF
+#define SDHCI_UHSII_SOFT_RESET		0xC0
+#define  SDHCI_UHSII_HOST_FULL_RESET	0x0001
+#define SDHCI_UHSII_TIMER_CONTROL	0xC2
+#define SDHCI_UHSII_INT_STATUS		0xC4
+#define SDHCI_UHSII_INT_ENABLE		0xC8
+#define SDHCI_UHSII_SIGNAL_ENABLE	0xCC
+#define  SDHCI_UHSII_INT_HEADER		0x00000001
+#define  SDHCI_UHSII_INT_RES		0x00000002
+#define  SDHCI_UHSII_INT_EXPIRED	0x00000004
+#define  SDHCI_UHSII_INT_CRC		0x00000008
+#define  SDHCI_UHSII_INT_FRAMING	0x00000010
+#define  SDHCI_UHSII_INT_TID		0x00000020
+#define  SDHCI_UHSII_INT_UNRECOVERABLE	0x00000080
+#define  SDHCI_UHSII_INT_EBSY		0x00000100
+#define  SDHCI_UHSII_INT_ADMA		0x00008000
+#define  SDHCI_UHSII_INT_TO_RES		0x00010000
+#define  SDHCI_UHSII_INT_TO_DEADLOCK	0x00020000
+#define  SDHCI_UHSII_INT_TIMEOUT \
+	(SDHCI_UHSII_INT_TO_RES | SDHCI_UHSII_INT_TO_DEADLOCK)
+
+#define SDHCI_UHSII_SETTINGS_PTR	0xE0
+#define SDHCI_UHSII_HOST_CAPS_PTR	0xE2
+#define SDHCI_UHSII_TEST_REG_PTR	0xE4
+#define SDHCI_EMBEDDED_CONTROL_PTR	0xE6
+#define SDHCI_VENDOR_SPEC_AREA_PTR	0xE8
+
 #define SDHCI_SLOT_INT_STATUS	0xFC
 
 #define SDHCI_HOST_VERSION	0xFE
@@ -255,6 +333,42 @@
 #define   SDHCI_SPEC_100	0
 #define   SDHCI_SPEC_200	1
 #define   SDHCI_SPEC_300	2
+#define   SDHCI_SPEC_400	3
+
+#define SDHCI_UHSII_GENERAL_REG		0x00
+#define SDHCI_UHSII_PHY_REG		0x04
+#define SDHCI_UHSII_LINK_REG_L		0x08
+#define SDHCI_UHSII_LINK_REG_H		0x0C
+
+/* UHS-II General Setting */
+#define SDHCI_UHSII_LOW_PWR_MODE	0x01
+
+/* UHS-II General Capabilities */
+#define SDHCI_UHSII_LANES_SHIFT		8
+#define SDHCI_UHSII_LANES_MASK		0x3F00
+#define  SDHCI_UHSII_LANES_2L_HD	0x01
+#define  SDHCI_UHSII_LANES_2D1U_FD	0x02
+#define  SDHCI_UHSII_LANES_1D2U_FD	0x04
+#define  SDHCI_UHSII_LANES_2D2U_FD	0x08
+#define SDHCI_UHSII_GAP_SHIFT		4
+#define SDHCI_UHSII_GAP_MASK		0xF0
+#define SDHCI_UHSII_DAP_SHIFT		0
+#define SDHCI_UHSII_DAP_MASK		0x0F
+
+/* UHS-II PHY Capabilities */
+#define SDHCI_UHSII_LSS_DIR_SHIFT	20
+#define SDHCI_UHSII_LSS_DIR_MASK	(0x0F >> SDHCI_UHSII_LSS_DIR_SHIFT)
+#define SDHCI_UHSII_LSS_SYN_SHIFT	16
+#define SDHCI_UHSII_LSS_SYN_MASK	(0x0F >> SDHCI_UHSII_LSS_SYN_SHIFT)
+#define SDHCI_UHSII_RANGE_SHIFT		6
+#define SDHCI_UHSII_RANGE_MASK		0xC0
+#define SDHCI_UHSII_RANGE_A		0x00
+#define SDHCI_UHSII_RANGE_AB		0x01
+
+/* UHS-II LINK/TRAN Capabilities */
+#define SDHCI_UHSII_DATA_GAP_MASK	0xFF
+#define SDHCI_UHSII_N_FCU_SHIFT		8
+#define SDHCI_UHSII_N_FCU_MASK		0xFF00
 
 /*
  * End of controller registers.
@@ -441,6 +555,7 @@ struct sdhci_host {
 #define SDHCI_USING_RETUNING_TIMER (1<<11)	/* Host is using a retuning timer for the card */
 #define SDHCI_USE_64_BIT_DMA	(1<<12)	/* Use 64-bit DMA */
 #define SDHCI_HS400_TUNING	(1<<13)	/* Tuning for HS400 */
+#define SDHCI_HOST_V4_ENABLED	(1<<12)
 
 	unsigned int version;	/* SDHCI spec. version */
 
@@ -451,11 +566,25 @@ struct sdhci_host {
 	unsigned int clock;	/* Current clock (MHz) */
 	u8 pwr;			/* Current voltage */
 
+	bool uhsii_if_enabled;
+	u8 lane_mode;
+	u8 max_gap;
+	u8 max_dap;
+	u8 n_data_gap;
+	u8 n_fcu;
+	u8 n_lss_dir;
+	u8 n_lss_syn;
+	u8 speed_range;
+
+	u16 uhsii_settings_ptr;
+	u16 uhsii_caps_ptr;
+
 	bool runtime_suspended;	/* Host is runtime suspended */
 	bool bus_on;		/* Bus power prevents runtime suspend */
 	bool preset_enabled;	/* Preset is enabled */
 
 	struct mmc_request *mrq;	/* Current request */
+	struct mmc_tlp *tlp;		/* Current native TLP */
 	struct mmc_command *cmd;	/* Current command */
 	struct mmc_data *data;	/* Current data request */
 	unsigned int data_early:1;	/* Data finished before cmd */
@@ -627,6 +756,11 @@ static inline u8 sdhci_readb(struct sdhci_host *host, int reg)
 
 #endif /* CONFIG_MMC_SDHCI_IO_ACCESSORS */
 
+static inline u32 sdhci_raw_readl(struct sdhci_host *host, int reg)
+{
+	return __raw_readl(host->ioaddr + reg);
+}
+
 extern struct sdhci_host *sdhci_alloc_host(struct device *dev,
 	size_t priv_size);
 extern void sdhci_free_host(struct sdhci_host *host);
-- 
1.9.1
