From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] mmc: core: Allow building PWRSEQ_SD8787 with LIBERTAS_SDIO
Date: Mon, 24 Sep 2018 10:56:32 +0200
Message-ID: <20180924085632.448693-1-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Lubomir Rintel <lkundrak@v3.sk>
List-Id: linux-mmc@vger.kernel.org

The sd8686 "libertas" SDIO adapter's power is controlled with WLAN_RST
and WLAN_PD pins -- pretty much the same way as sd8787. Allow building
the power sequencing driver along with the libertas Wi-Fi driver.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/mmc/core/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/Kconfig b/drivers/mmc/core/Kconfig
index 42e89060cd41..2f38a7ad07e0 100644
--- a/drivers/mmc/core/Kconfig
+++ b/drivers/mmc/core/Kconfig
@@ -14,7 +14,7 @@ config PWRSEQ_EMMC
=20
 config PWRSEQ_SD8787
 	tristate "HW reset support for SD8787 BT + Wifi module"
-	depends on OF && (MWIFIEX || BT_MRVL_SDIO)
+	depends on OF && (MWIFIEX || BT_MRVL_SDIO || LIBERTAS_SDIO)
 	help
 	  This selects hardware reset support for the SD8787 BT + Wifi
 	  module. By default this option is set to n.
--=20
2.19.0
