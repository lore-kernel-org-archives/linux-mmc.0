From: <patrice.chotard@st.com>
Subject: [PATCH v2 12/15] ARM: configs: stm32: Enable MMC_ARMMMCI support
Date: Tue, 16 Jan 2018 13:30:56 +0100
Message-ID: <1516105859-3525-13-git-send-email-patrice.chotard@st.com>
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
Cc: devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Patrice Chotard <patrice.chotard@st.com>, linux-gpio@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

From: Patrice Chotard <patrice.chotard@st.com>

Enable MMC_ARMMCI support to add SDIO support for
STM32F4 and STM32F7 SoCs family

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---

v2 _ none

 arch/arm/configs/stm32_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/stm32_defconfig b/arch/arm/configs/stm32_defconfig
index 21b2bf7..8b64a9e 100644
--- a/arch/arm/configs/stm32_defconfig
+++ b/arch/arm/configs/stm32_defconfig
@@ -56,6 +56,8 @@ CONFIG_MFD_STMPE=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 # CONFIG_USB_SUPPORT is not set
+CONFIG_MMC=y
+CONFIG_MMC_ARMMMCI=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_GPIO=y
-- 
1.9.1
