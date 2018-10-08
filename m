From: Ludovic Barre <ludovic.Barre@st.com>
Subject: [PATCH V6 20/23] mmc: mmci: add clock divider for stm32 sdmmc
Date: Mon, 8 Oct 2018 14:08:52 +0200
Message-ID: <1539000535-13261-21-git-send-email-ludovic.Barre@st.com>
References: <1539000535-13261-1-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539000535-13261-1-git-send-email-ludovic.Barre@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: srinivas.kandagatla@linaro.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, Ludovic Barre <ludovic.barre@st.com>
List-Id: linux-mmc@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

The STM32 sdmmc variant has a different clock divider.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 2 ++
 drivers/mmc/host/mmci.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index d636a0e..ad2f62f 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1862,6 +1862,8 @@ static int mmci_probe(struct amba_device *dev,
 	 */
 	if (variant->st_clkdiv)
 		mmc->f_min = DIV_ROUND_UP(host->mclk, 257);
+	else if (variant->stm32_clkdiv)
+		mmc->f_min = DIV_ROUND_UP(host->mclk, 2046);
 	else if (variant->explicit_mclk_control)
 		mmc->f_min = clk_round_rate(host->clk, 100000);
 	else
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 8ecb1ee..a962cfa 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -216,6 +216,7 @@ struct mmci_host;
  * @data_cmd_enable: enable value for data commands.
  * @st_sdio: enable ST specific SDIO logic
  * @st_clkdiv: true if using a ST-specific clock divider algorithm
+ * @stm32_clkdiv: true if using a STM32-specific clock divider algorithm
  * @datactrl_mask_ddrmode: ddr mode mask in datactrl register.
  * @blksz_datactrl16: true if Block size is at b16..b30 position in datactrl register
  * @blksz_datactrl4: true if Block size is at b4..b16 position in datactrl
@@ -269,6 +270,7 @@ struct variant_data {
 	u8			datacnt_useless:1;
 	u8			st_sdio:1;
 	u8			st_clkdiv:1;
+	u8			stm32_clkdiv:1;
 	u8			blksz_datactrl16:1;
 	u8			blksz_datactrl4:1;
 	u32			pwrreg_powerup;
-- 
2.7.4
