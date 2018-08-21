From: Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH] mmc: jz4740: Drop dependency on MACH_JZ4740/80
Date: Tue, 21 Aug 2018 15:03:20 +0200
Message-ID: <20180821130320.1682-1-paul@crapouillou.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: od@zcrc.me, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
List-Id: linux-mmc@vger.kernel.org

Depending on MACH_JZ4740 | MACH_JZ4780 prevent us from creating a generic
kernel that works on more than one MIPS board. Instead, we just depend on
MIPS being set.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/mmc/host/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 0581c199c996..71d9bdc52422 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -761,7 +761,7 @@ config MMC_SH_MMCIF
 
 config MMC_JZ4740
 	tristate "Ingenic JZ47xx SD/Multimedia Card Interface support"
-	depends on MACH_JZ4740 || MACH_JZ4780
+	depends on MIPS
 	help
 	  This selects support for the SD/MMC controller on Ingenic
 	  JZ4740, JZ4750, JZ4770 and JZ4780 SoCs.
-- 
2.11.0
