From: <patrice.chotard@st.com>
Subject: [PATCH 11/14] ARM: configs: stm32: Enable MMC_ARMMMCI support
Date: Fri, 12 Jan 2018 13:16:05 +0100
Message-ID: <1515759368-16946-12-git-send-email-patrice.chotard@st.com>
References: <1515759368-16946-1-git-send-email-patrice.chotard@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1515759368-16946-1-git-send-email-patrice.chotard@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King <linux@armlinux.org.uk>, Ulf Hansson <ulf.hansson@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexandre Torgue <alexandre.torgue@st.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, Patrice Chotard <patrice.chotard@st.com>
List-Id: linux-mmc@vger.kernel.org

From: Patrice Chotard <patrice.chotard@st.com>

Enable MMC_ARMMCI support to add SDIO support for
STM32F4 and STM32F7 SoCs family

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
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
