From: Tanmay Upadhyay <tanmay.upadhyay@einfochips.com>
Subject: [PATCH 3/3] ARM: pxa168/gplugd: Add support for SD port 1
Date: Tue, 25 Oct 2011 18:08:00 +0530
Message-ID: <1319546280-31848-1-git-send-email-tanmay.upadhyay@einfochips.com>
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
To: eric.y.miao@gmail.com, jason.chagas@marvell.com
Cc: linux-mmc@vger.kernel.org, Tanmay Upadhyay <tanmay.upadhyay@einfochips.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: Tanmay Upadhyay <tanmay.upadhyay@einfochips.com>
---
 arch/arm/mach-mmp/gplugd.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mmp/gplugd.c b/arch/arm/mach-mmp/gplugd.c
index 98e25d9..f453561 100644
--- a/arch/arm/mach-mmp/gplugd.c
+++ b/arch/arm/mach-mmp/gplugd.c
@@ -17,6 +17,8 @@
 #include <mach/pxa168.h>
 #include <mach/mfp-pxa168.h>
 
+#include <linux/mmc/sdhci.h>
+
 #include "common.h"
 
 static unsigned long gplugd_pin_config[] __initdata = {
@@ -154,6 +156,10 @@ struct pxa168_eth_platform_data gplugd_eth_platform_data = {
 	.init        = gplugd_eth_init,
 };
 
+struct sdhci_pxa_platdata gplugd_sdh_platdata = {
+	.delay_in_ms = 4,
+};
+
 static void __init select_disp_freq(void)
 {
 	/* set GPIO 35 & clear GPIO 85 to set LCD External Clock to 74.25 MHz */
@@ -186,6 +192,7 @@ static void __init gplugd_init(void)
 	pxa168_add_twsi(0, NULL, ARRAY_AND_SIZE(gplugd_i2c_board_info));
 
 	pxa168_add_eth(&gplugd_eth_platform_data);
+	pxa168_add_sdh(0, &gplugd_sdh_platdata);
 }
 
 MACHINE_START(SHEEVAD, "PXA168-based GuruPlug Display (gplugD) Platform")
-- 
1.6.3.3
