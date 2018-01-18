From: <patrice.chotard@st.com>
Subject: [PATCH v3 11/14] ARM: stm32: Add AMBA support for STM32F4 and STM32F7
 SoCs
Date: Thu, 18 Jan 2018 15:34:27 +0100
Message-ID: <1516286070-24927-12-git-send-email-patrice.chotard@st.com>
References: <1516286070-24927-1-git-send-email-patrice.chotard@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1516286070-24927-1-git-send-email-patrice.chotard@st.com>
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

As both STM32F4 and STM32F7 SoCs embeds an AMBA PL180 mmci IP,
we need to enable AMBA support in mach-stm32.

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---

v3: _ none

v2: _ none

 arch/arm/mach-stm32/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-stm32/Kconfig b/arch/arm/mach-stm32/Kconfig
index 0d1889b..f53a8db 100644
--- a/arch/arm/mach-stm32/Kconfig
+++ b/arch/arm/mach-stm32/Kconfig
@@ -13,16 +13,19 @@ config ARCH_STM32
 config MACH_STM32F429
 	bool "STMicrolectronics STM32F429"
 	depends on ARCH_STM32
+	select ARM_AMBA
 	default y
 
 config MACH_STM32F469
 	bool "STMicrolectronics STM32F469"
 	depends on ARCH_STM32
+	select ARM_AMBA
 	default y
 
 config MACH_STM32F746
 	bool "STMicrolectronics STM32F746"
 	depends on ARCH_STM32
+	select ARM_AMBA
 	default y
 
 config MACH_STM32H743
-- 
1.9.1
