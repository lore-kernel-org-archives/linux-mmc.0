From: Ludovic Barre <ludovic.Barre@st.com>
Subject: [PATCH 15/19] mmc: mmci: add stm32 sdmmc registers
Date: Tue, 12 Jun 2018 15:14:36 +0200
Message-ID: <1528809280-31116-16-git-send-email-ludovic.Barre@st.com>
References: <1528809280-31116-1-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1528809280-31116-1-git-send-email-ludovic.Barre@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Gerald Baeza <gerald.baeza@st.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, Ludovic Barre <ludovic.barre@st.com>
List-Id: linux-mmc@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch adds stm32 sdmmc specific registers.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.h | 56 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 227927e..c2ad724 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -23,6 +23,14 @@
 #define MCI_ST_DATA31DIREN	(1 << 5)
 #define MCI_ST_FBCLKEN		(1 << 7)
 #define MCI_ST_DATA74DIREN	(1 << 8)
+/*
+ * The STM32 sdmmc does not have PWR_UP/OD/ROD
+ * and uses the power register for
+ */
+#define MCI_STM32_PWR_CYC	0x02
+#define MCI_STM32_VSWITCH	BIT(2)
+#define MCI_STM32_VSWITCHEN	BIT(3)
+#define MCI_STM32_DIRPOL	BIT(4)
 
 #define MMCICLOCK		0x004
 #define MCI_CLK_ENABLE		(1 << 8)
@@ -50,6 +58,19 @@
 #define MCI_QCOM_CLK_SELECT_IN_FBCLK	BIT(15)
 #define MCI_QCOM_CLK_SELECT_IN_DDR_MODE	(BIT(14) | BIT(15))
 
+/* Modified on STM32 sdmmc */
+#define MCI_STM32_CLK_CLKDIV_MSK	GENMASK(9, 0)
+#define MCI_STM32_CLK_WIDEBUS_4		BIT(14)
+#define MCI_STM32_CLK_WIDEBUS_8		BIT(15)
+#define MCI_STM32_CLK_NEGEDGE		BIT(16)
+#define MCI_STM32_CLK_HWFCEN		BIT(17)
+#define MCI_STM32_CLK_DDR		BIT(18)
+#define MCI_STM32_CLK_BUSSPEED		BIT(19)
+#define MCI_STM32_CLK_SEL_MSK		GENMASK(21, 20)
+#define MCI_STM32_CLK_SELCK		(0 << 20)
+#define MCI_STM32_CLK_SELCKIN		(1 << 20)
+#define MCI_STM32_CLK_SELFBCK		(2 << 20)
+
 #define MMCIARGUMENT		0x008
 
 /* The command register controls the Command Path State Machine (CPSM) */
@@ -72,6 +93,15 @@
 #define MCI_CPSM_QCOM_CCSDISABLE	BIT(15)
 #define MCI_CPSM_QCOM_AUTO_CMD19	BIT(16)
 #define MCI_CPSM_QCOM_AUTO_CMD21	BIT(21)
+/* Command register in STM32 sdmmc versions */
+#define MCI_CPSM_STM32_CMDTRANS		BIT(6)
+#define MCI_CPSM_STM32_CMDSTOP		BIT(7)
+#define MCI_CPSM_STM32_WAITRESP_MASK	GENMASK(9, 8)
+#define MCI_CPSM_STM32_NORSP		(0 << 8)
+#define MCI_CPSM_STM32_SRSP_CRC		(1 << 8)
+#define MCI_CPSM_STM32_SRSP		(2 << 8)
+#define MCI_CPSM_STM32_LRSP_CRC		(3 << 8)
+#define MCI_CPSM_STM32_ENABLE		BIT(12)
 
 #define MMCIRESPCMD		0x010
 #define MMCIRESPONSE0		0x014
@@ -130,6 +160,8 @@
 #define MCI_ST_SDIOIT		(1 << 22)
 #define MCI_ST_CEATAEND		(1 << 23)
 #define MCI_ST_CARDBUSY		(1 << 24)
+/* Extended status bits for the STM32 variants */
+#define MCI_STM32_BUSYD0	BIT(20)
 
 #define MMCICLEAR		0x038
 #define MCI_CMDCRCFAILCLR	(1 << 0)
@@ -175,11 +207,32 @@
 #define MCI_ST_SDIOITMASK	(1 << 22)
 #define MCI_ST_CEATAENDMASK	(1 << 23)
 #define MCI_ST_BUSYENDMASK	(1 << 24)
+/* Extended status bits for the STM32 variants */
+#define MCI_STM32_BUSYD0ENDMASK	BIT(21)
 
 #define MMCIMASK1		0x040
 #define MMCIFIFOCNT		0x048
 #define MMCIFIFO		0x080 /* to 0x0bc */
 
+/* STM32 sdmmc registers for IDMA (Internal DMA) */
+#define MMCI_STM32_IDMACTRLR	0x050
+#define MMCI_STM32_IDMAEN	BIT(0)
+#define MMCI_STM32_IDMALLIEN	BIT(1)
+
+#define MMCI_STM32_IDMABSIZER		0x054
+#define MMCI_STM32_IDMABNDT_SHIFT	5
+#define MMCI_STM32_IDMABNDT_MASK	GENMASK(12, 5)
+
+#define MMCI_STM32_IDMABASE0R	0x058
+
+#define MMCI_STM32_IDMALAR	0x64
+#define MMCI_STM32_IDMALA_MASK	GENMASK(13, 0)
+#define MMCI_STM32_ABR		BIT(29)
+#define MMCI_STM32_ULS		BIT(30)
+#define MMCI_STM32_ULA		BIT(31)
+
+#define MMCI_STM32_IDMABAR	0x68
+
 #define MCI_IRQENABLE	\
 	(MCI_CMDCRCFAILMASK | MCI_DATACRCFAILMASK | MCI_CMDTIMEOUTMASK | \
 	MCI_DATATIMEOUTMASK | MCI_TXUNDERRUNMASK | MCI_RXOVERRUNMASK |	\
@@ -190,6 +243,9 @@
 	(MCI_RXFIFOHALFFULLMASK | MCI_RXDATAAVLBLMASK | \
 	 MCI_TXFIFOHALFEMPTYMASK)
 
+#define MCI_IRQ_PIO_STM32_MASK \
+	(MCI_RXFIFOHALFFULLMASK | MCI_TXFIFOHALFEMPTYMASK)
+
 #define NR_SG		128
 
 #define MMCI_PINCTRL_STATE_OPENDRAIN "opendrain"
-- 
2.7.4
