From: <patrice.chotard@st.com>
Subject: [PATCH v2 05/15] mmc: mmci: Add STM32 variant
Date: Tue, 16 Jan 2018 13:30:49 +0100
Message-ID: <1516105859-3525-6-git-send-email-patrice.chotard@st.com>
References: <1516105859-3525-1-git-send-email-patrice.chotard@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1516105859-3525-1-git-send-email-patrice.chotard@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King <linux@armlinux.org.uk>, Ulf Hansson <ulf.hansson@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexandre Torgue <alexandre.torgue@st.com>
Cc: devicetree@vger.kernel.org, Andrea Merello <andrea.merello@gmail.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Patrice Chotard <patrice.chotard@st.com>, linux-gpio@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

From: Patrice Chotard <patrice.chotard@st.com>

STM32F4 and STM32F7 MCUs has a SDIO controller that looks like
an ARM PL810.
This patch adds the STM32 variant so that mmci driver supports it.

Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---

v2: _ Replace "pl180" by "PL180" in commit message

 drivers/mmc/host/mmci.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 2a7aea7..560b2fd 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -244,6 +244,23 @@ struct variant_data {
 	.opendrain		= MCI_OD,
 };
 
+static struct variant_data variant_stm32 = {
+	.fifosize		= 32 * 4,
+	.fifohalfsize		= 8 * 4,
+	.clkreg			= MCI_CLK_ENABLE,
+	.clkreg_enable		= MCI_ST_UX500_HWFCEN,
+	.clkreg_8bit_bus_enable = MCI_ST_8BIT_BUS,
+	.clkreg_neg_edge_enable	= MCI_ST_UX500_NEG_EDGE,
+	.datalength_bits	= 24,
+	.datactrl_mask_sdio	= MCI_DPSM_ST_SDIOEN,
+	.st_sdio		= true,
+	.st_clkdiv		= true,
+	.pwrreg_powerup		= MCI_PWR_ON,
+	.f_max			= 48000000,
+	.pwrreg_clkgate		= true,
+	.pwrreg_nopower		= true,
+};
+
 static struct variant_data variant_qcom = {
 	.fifosize		= 16 * 4,
 	.fifohalfsize		= 8 * 4,
@@ -2025,6 +2042,11 @@ static int mmci_runtime_resume(struct device *dev)
 		.mask   = 0xf0ffffff,
 		.data	= &variant_ux500v2,
 	},
+	{
+		.id     = 0x00880180,
+		.mask   = 0x00ffffff,
+		.data	= &variant_stm32,
+	},
 	/* Qualcomm variants */
 	{
 		.id     = 0x00051180,
-- 
1.9.1
