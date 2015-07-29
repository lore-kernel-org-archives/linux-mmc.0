From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 10/17] mmc: host: omap_hsmmc: avoid pbias regulator enable on
 power off
Date: Wed, 29 Jul 2015 16:39:40 +0530
Message-ID: <1438168187-1614-11-git-send-email-kishon@ti.com>
References: <1438168187-1614-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1438168187-1614-1-git-send-email-kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: tony@atomide.com, ulf.hansson@linaro.org, afenkart@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: nsekhar@ti.com, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

Fix omap_hsmmc_set_power so that pbias regulator is not enabled
during power off.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 8bb3f60..2e5c7cd 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -386,16 +386,16 @@ static int omap_hsmmc_set_power(struct device *dev, int power_on, int vdd)
 		ret = omap_hsmmc_enable_supply(mmc, vdd);
 		if (ret)
 			return ret;
+
+		ret = omap_hsmmc_set_pbias(host, true, vdd);
+		if (ret)
+			goto err_set_voltage;
 	} else {
 		ret = omap_hsmmc_disable_supply(mmc);
 		if (ret)
 			return ret;
 	}
 
-	ret = omap_hsmmc_set_pbias(host, true, vdd);
-	if (ret)
-		goto err_set_voltage;
-
 	if (mmc_pdata(host)->after_set_reg)
 		mmc_pdata(host)->after_set_reg(dev, power_on, vdd);
 
-- 
1.7.9.5
