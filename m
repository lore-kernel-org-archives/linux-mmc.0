From: Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 04/13] MIPS: ingenic: Enable pinctrl for all ingenic SoCs
Date: Wed, 18 Jan 2017 00:14:12 +0100
Message-ID: <20170117231421.16310-5-paul@crapouillou.net>
References: <20170117231421.16310-1-paul@crapouillou.net>
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <20170117231421.16310-1-paul@crapouillou.net>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Ulf Hansson <ulf.hansson@linaro.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Maarten ter Huurne <maarten@treewalker.org>, Lars-Peter Clausen <lars@metafoo.de>, Paul Burton <paul.burton@imgtec.com>
Cc: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, james.hogan@imgtec.com, Paul Cercueil <paul@crapouillou.net>
List-Id: linux-mmc@vger.kernel.org

There is a pinctrl driver for each of the Ingenic SoCs supported by the
upstream Linux kernel. In order to switch away from the old GPIO
platform code, we now enable the pinctrl drivers by default for the
Ingenic SoCs.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 arch/mips/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index b3c5bde43d34..fc720e37661e 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -359,6 +359,7 @@ config MACH_INGENIC
 	select SYS_SUPPORTS_ZBOOT_UART16550
 	select DMA_NONCOHERENT
 	select IRQ_MIPS_CPU
+	select PINCTRL
 	select GPIOLIB
 	select COMMON_CLK
 	select GENERIC_IRQ_CHIP
-- 
2.11.0
