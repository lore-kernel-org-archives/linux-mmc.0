From: <patrice.chotard@st.com>
Subject: [PATCH v2 14/15] clk: stm32: Add clk entry for SDMMC2 on stm32F769
Date: Tue, 16 Jan 2018 13:30:58 +0100
Message-ID: <1516105859-3525-15-git-send-email-patrice.chotard@st.com>
References: <1516105859-3525-1-git-send-email-patrice.chotard@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1516105859-3525-1-git-send-email-patrice.chotard@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King <linux@armlinux.org.uk>, Ulf Hansson <ulf.hansson@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexandre Torgue <alexandre.torgue@st.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, Patrice Chotard <patrice.chotard@st.com>
List-Id: linux-mmc@vger.kernel.org

From: Patrice Chotard <patrice.chotard@st.com>

STM32F769 has 2 SDMMC port, add clock entry for the second one.

Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>
Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
Acked-by: Stephen Boyd <sboyd@codeaurora.org>
---

v2 _ Add Acked-by

 drivers/clk/clk-stm32f4.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-stm32f4.c b/drivers/clk/clk-stm32f4.c
index 96c6b6b..8f8a178 100644
--- a/drivers/clk/clk-stm32f4.c
+++ b/drivers/clk/clk-stm32f4.c
@@ -282,6 +282,7 @@ struct stm32f4_gate_data {
 
 	{ STM32F4_RCC_APB2ENR,  0,	"tim1",		"apb2_mul" },
 	{ STM32F4_RCC_APB2ENR,  1,	"tim8",		"apb2_mul" },
+	{ STM32F4_RCC_APB2ENR,  7,	"sdmmc2",	"sdmux"    },
 	{ STM32F4_RCC_APB2ENR,  8,	"adc1",		"apb2_div" },
 	{ STM32F4_RCC_APB2ENR,  9,	"adc2",		"apb2_div" },
 	{ STM32F4_RCC_APB2ENR, 10,	"adc3",		"apb2_div" },
@@ -315,7 +316,7 @@ struct stm32f4_gate_data {
 
 static const u64 stm32f746_gate_map[MAX_GATE_MAP] = { 0x000000f17ef417ffull,
 						      0x0000000000000003ull,
-						      0x04f77f033e01c9ffull };
+						      0x04f77f833e01c9ffull };
 
 static const u64 *stm32f4_gate_map;
 
-- 
1.9.1
