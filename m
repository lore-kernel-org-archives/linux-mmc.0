From: Huang Shijie <b32955@freescale.com>
Subject: [PATCH 03/10] MXS-MMC : change the DMA header file
Date: Thu, 19 Jan 2012 14:16:00 +0800
Message-ID: <1326953767-24155-4-git-send-email-b32955@freescale.com>
References: <1326953767-24155-1-git-send-email-b32955@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1326953767-24155-1-git-send-email-b32955@freescale.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: vinod.koul@intel.com
Cc: alsa-devel@alsa-project.org, artem.bityutskiy@intel.com, b29396@freescale.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, w.sang@pengutronix.de, Huang Shijie <b32955@freescale.com>, linux-mtd@lists.infradead.org, shawn.guo@linaro.org, shijie8@gmail.com, linux-arm-kernel@lists.infradead.org, LW@KARO-electronics.de
List-Id: linux-mmc@vger.kernel.org

use the new MXS-DMA header for mxs-mmc driver.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 drivers/mmc/host/mxs-mmc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index 382c835..1e18970 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -38,10 +38,10 @@
 #include <linux/gpio.h>
 #include <linux/regulator/consumer.h>
 #include <linux/module.h>
+#include <linux/mxs-dma.h>
 
 #include <mach/mxs.h>
 #include <mach/common.h>
-#include <mach/dma.h>
 #include <mach/mmc.h>
 
 #define DRIVER_NAME	"mxs-mmc"
-- 
1.7.0.4
