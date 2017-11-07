From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 2/2] mmc: renesas_shci: remove wrong depends on to enable compile test
Date: Tue,  7 Nov 2017 16:57:22 +0900
Message-ID: <1510041442-15176-3-git-send-email-yamada.masahiro@socionext.com>
References: <1510041442-15176-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1510041442-15176-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org
Cc: Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

ARCH_RENESAS is a stronger condition than (ARM || ARM64).
If ARCH_RENESAS is enabled, (ARM || ARM64) is met as well.

What is worse, the first depends on line prevents COMPILE_TEST from
enabling this driver.  It should be removed.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mmc/host/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 5420da5..5bc6388 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -581,7 +581,6 @@ config MMC_TMIO
 
 config MMC_SDHI
 	tristate "Renesas SDHI SD/SDIO controller support"
-	depends on SUPERH || ARM || ARM64
 	depends on SUPERH || ARCH_RENESAS || COMPILE_TEST
 	select MMC_TMIO_CORE
 	help
-- 
2.7.4
