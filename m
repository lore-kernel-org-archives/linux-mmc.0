From: NeilBrown <neil@brown.name>
Subject: [PATCH 4/4] mmc: mtk-sd: select REGULATOR
Date: Sat, 04 May 2019 20:24:57 +1000
Message-ID: <155696549700.8632.10790498625986428152.stgit@noble.brown>
References: <155696540998.8632.5242582397805128125.stgit@noble.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <155696540998.8632.5242582397805128125.stgit@noble.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chaotian Jing <chaotian.jing@mediatek.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, thirtythreeforty@gmail.com
List-Id: linux-mmc@vger.kernel.org

The mtk-sd driver requires a regulator to be present, even if it is
the "fixed" regulator.  So select REGULATOR to make it hard to build
unusable configurations.

Signed-off-by: NeilBrown <neil@brown.name>
---
 drivers/mmc/host/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 9c01310a0d2e..1249cde7004d 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -941,6 +941,7 @@ config MMC_BCM2835
 config MMC_MTK
 	tristate "MediaTek SD/MMC Card Interface support"
 	depends on HAS_DMA
+	select REGULATOR
 	help
 	  This selects the MediaTek(R) Secure digital and Multimedia card Interface.
 	  If you have a machine with a integrated SD/MMC card reader, say Y or M here.
