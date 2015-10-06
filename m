From: Marcin Wojtas <mw@semihalf.com>
Subject: [PATCH 2/8] mmc: sdhci-pxav3: disable clock inversion for HS MMC cards
Date: Tue,  6 Oct 2015 03:22:36 +0200
Message-ID: <1444094562-31165-3-git-send-email-mw@semihalf.com>
References: <1444094562-31165-1-git-send-email-mw@semihalf.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1444094562-31165-1-git-send-email-mw@semihalf.com>
Sender: stable-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, sebastian.hesselbarth@gmail.com, andrew@lunn.ch, jason@lakedaemon.net, thomas.petazzoni@free-electrons.com, gregory.clement@free-electrons.com, nadavh@marvell.com, alior@marvell.com, tawfik@marvell.com, mw@semihalf.com, jaz@semihalf.com, stable@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

From: Nadav Haklai <nadavh@marvell.com>

According to 'FE-2946959' erratum the clock inversion option is
needed to support slow frequencies when the card input hold time
requirement is high. This setting is not required for high speed
MMC and might cause timing violation.

Signed-off-by: Nadav Haklai <nadavh@marvell.com>
Cc: <stable@vger.kernel.org> # v4.2
---
 drivers/mmc/host/sdhci-pxav3.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index 976cddd..89a9e49 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -291,6 +291,9 @@ static void pxav3_set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
 		    uhs == MMC_TIMING_UHS_DDR50) {
 			reg_val &= ~SDIO3_CONF_CLK_INV;
 			reg_val |= SDIO3_CONF_SD_FB_CLK;
+		} else if (uhs == MMC_TIMING_MMC_HS) {
+			reg_val &= ~SDIO3_CONF_CLK_INV;
+			reg_val &= ~SDIO3_CONF_SD_FB_CLK;
 		} else {
 			reg_val |= SDIO3_CONF_CLK_INV;
 			reg_val &= ~SDIO3_CONF_SD_FB_CLK;
-- 
1.8.3.1
