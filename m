From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH v3 1/7] mmc: sunxi: Reorder the headers
Date: Mon, 16 Apr 2018 16:22:59 +0200
Message-ID: <36d1fdc06b6e1a9baa8a369774a2100ba192cf89.1523888566.git-series.maxime.ripard@bootlin.com>
References: <cover.e9b9c0ab5bc9ffcc52a15e1c2f41462729da5b61.1523888566.git-series.maxime.ripard@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.e9b9c0ab5bc9ffcc52a15e1c2f41462729da5b61.1523888566.git-series.maxime.ripard@bootlin.com>
In-Reply-To: <cover.e9b9c0ab5bc9ffcc52a15e1c2f41462729da5b61.1523888566.git-series.maxime.ripard@bootlin.com>
References: <cover.e9b9c0ab5bc9ffcc52a15e1c2f41462729da5b61.1523888566.git-series.maxime.ripard@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@bootlin.com>, ulf.hansson@linaro.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-mmc@vger.kernel.org, Quentin Schulz <quentin.schulz@bootlin.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Our headers sort algorithm has had pretty chaotic results. Let's fix that.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/mmc/host/sunxi-mmc.c | 43 +++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 23 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 20cfb20418f3..91feed8045fd 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -13,36 +13,33 @@
  * the License, or (at your option) any later version.
  */
 
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/io.h>
-#include <linux/device.h>
-#include <linux/interrupt.h>
-#include <linux/delay.h>
-#include <linux/err.h>
-
 #include <linux/clk.h>
 #include <linux/clk/sunxi-ng.h>
-#include <linux/gpio.h>
-#include <linux/platform_device.h>
-#include <linux/spinlock.h>
-#include <linux/scatterlist.h>
+#include <linux/delay.h>
+#include <linux/device.h>
 #include <linux/dma-mapping.h>
-#include <linux/slab.h>
-#include <linux/reset.h>
-#include <linux/regulator/consumer.h>
-
-#include <linux/of_address.h>
-#include <linux/of_gpio.h>
-#include <linux/of_platform.h>
-
+#include <linux/err.h>
+#include <linux/gpio.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/mmc/card.h>
+#include <linux/mmc/core.h>
 #include <linux/mmc/host.h>
+#include <linux/mmc/mmc.h>
 #include <linux/mmc/sd.h>
 #include <linux/mmc/sdio.h>
-#include <linux/mmc/mmc.h>
-#include <linux/mmc/core.h>
-#include <linux/mmc/card.h>
 #include <linux/mmc/slot-gpio.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_gpio.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
+#include <linux/reset.h>
+#include <linux/scatterlist.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
 
 /* register offset definitions */
 #define SDXC_REG_GCTRL	(0x00) /* SMC Global Control Register */
-- 
git-series 0.9.1
