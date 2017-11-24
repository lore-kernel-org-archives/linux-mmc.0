From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v2 02/22] mmc: renesas_sdhi: remove wrong depends on to enable compile test
Date: Sat, 25 Nov 2017 01:24:37 +0900
Message-ID: <1511540697-27387-3-git-send-email-yamada.masahiro@socionext.com>
References: <1511540697-27387-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1511540697-27387-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-renesas-soc@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

ARCH_RENESAS is a stronger condition than (ARM || ARM64).
If ARCH_RENESAS is enabled, (ARM || ARM64) is met as well.

What is worse, the first depends on line prevents COMPILE_TEST from
enabling this driver.  It should be removed.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Changes in v2:
  - Fix a typo:  renesas_sdhc -> renesas_sdhi

 drivers/mmc/host/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 1932188..ac25354 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -595,7 +595,6 @@ config MMC_TMIO
 
 config MMC_SDHI
 	tristate "Renesas SDHI SD/SDIO controller support"
-	depends on SUPERH || ARM || ARM64
 	depends on SUPERH || ARCH_RENESAS || COMPILE_TEST
 	select MMC_TMIO_CORE
 	help
-- 
2.7.4
