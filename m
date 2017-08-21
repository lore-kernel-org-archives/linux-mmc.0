From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH v2 03/16] mmc: meson-gx: clean up some constants
Date: Mon, 21 Aug 2017 18:02:48 +0200
Message-ID: <20170821160301.21899-4-jbrunet@baylibre.com>
References: <20170821160301.21899-1-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170821160301.21899-1-jbrunet@baylibre.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
Cc: linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>
List-Id: linux-mmc@vger.kernel.org

Remove unused clock rate defines. These should not be defined but
requested from the clock framework.

Also correct typo on the DELAY register

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index d480a8052a06..8a74a048db88 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -45,9 +45,7 @@
 #define   CLK_DIV_MAX 63
 #define   CLK_SRC_MASK GENMASK(7, 6)
 #define   CLK_SRC_XTAL 0   /* external crystal */
-#define   CLK_SRC_XTAL_RATE 24000000
 #define   CLK_SRC_PLL 1    /* FCLK_DIV2 */
-#define   CLK_SRC_PLL_RATE 1000000000
 #define   CLK_CORE_PHASE_MASK GENMASK(9, 8)
 #define   CLK_TX_PHASE_MASK GENMASK(11, 10)
 #define   CLK_RX_PHASE_MASK GENMASK(13, 12)
@@ -57,7 +55,7 @@
 #define   CLK_PHASE_270 3
 #define   CLK_ALWAYS_ON BIT(24)
 
-#define SD_EMMC_DElAY 0x4
+#define SD_EMMC_DELAY 0x4
 #define SD_EMMC_ADJUST 0x8
 #define SD_EMMC_CALOUT 0x10
 #define SD_EMMC_START 0x40
-- 
2.9.5
