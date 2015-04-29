From: <micky_ching@realsil.com.cn>
Subject: [PATCH 05/12] mmc: core: disable full power cycle for SD4.0
Date: Wed, 29 Apr 2015 09:23:37 +0800
Message-ID: <60047e2c332812cce9685648c0bcc78a650dffe4.1429845922.git.micky_ching@realsil.com.cn>
References: <cover.1429845922.git.micky_ching@realsil.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <cover.1429845922.git.micky_ching@realsil.com.cn>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: chris@printf.net, ulf.hansson@linaro.org, sameo@linux.intel.com
Cc: gregkh@linuxfoundation.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, wei_wang@realsil.com.cn, devel@linuxdriverproject.org, rogerable@realtek.com, dan.carpenter@oracle.com
List-Id: linux-mmc@vger.kernel.org

From: Micky Ching <micky_ching@realsil.com.cn>

We should not do power cycle when card is in SD4.0 mode,
if we power off, we should detect UHSII interface again.
so we can disable it when card is in UHSII mode.

Signed-off-by: Micky Ching <micky_ching@realsil.com.cn>
Signed-off-by: Wei Wang <wei_wang@realsil.com.cn>
---
 drivers/mmc/core/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index ebb6fea..4c5433b 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1550,7 +1550,8 @@ u32 mmc_select_voltage(struct mmc_host *host, u32 ocr)
 		return 0;
 	}
 
-	if (host->caps2 & MMC_CAP2_FULL_PWR_CYCLE) {
+	if (!mmc_card_uhsii(host->card) &&
+		(host->caps2 & MMC_CAP2_FULL_PWR_CYCLE)) {
 		bit = ffs(ocr) - 1;
 		ocr &= 3 << bit;
 		mmc_power_cycle(host, ocr);
-- 
1.9.1
