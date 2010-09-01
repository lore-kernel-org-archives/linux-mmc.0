From: Richard Zhu <r65037@freescale.com>
Subject: [PATCH 9/9] esdhc-5 mx51: enable fsl esdhc driver
Date: Wed, 1 Sep 2010 17:49:04 +0800
Message-ID: <1283334544-12830-1-git-send-email-r65037@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-mmc@vger.kernel.org
Cc: Richard Zhu <r65037@freescale.com>, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
List-Id: linux-mmc@vger.kernel.org

Enable the fsl esdhc driver on mx51 platforms

Signed-off-by: Richard Zhu <r65037@freescale.com>
---
 arch/arm/configs/mx51_defconfig |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/mx51_defconfig b/arch/arm/configs/mx51_defconfig
index a665ecb..30a0d59 100644
--- a/arch/arm/configs/mx51_defconfig
+++ b/arch/arm/configs/mx51_defconfig
@@ -106,8 +106,13 @@ CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_MXC=y
 CONFIG_MMC=y
-CONFIG_MMC_BLOCK=m
-CONFIG_MMC_SDHCI=m
+CONFIG_MMC_BLOCK=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_IO_ACCESSORS=y
+# CONFIG_MMC_SDHCI_PLTFM is not set
+CONFIG_MMC_SDHCI_FSL=y
+# CONFIG_MMC_MXC is not set
+# CONFIG_MEMSTICK is not set
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=m
 CONFIG_RTC_CLASS=y
-- 
1.7.0
