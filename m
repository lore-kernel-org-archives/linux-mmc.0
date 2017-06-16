From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 07/16] mmc: host: omap_hsmmc: Allow io voltage switch even for
 fixed vdd
Date: Fri, 16 Jun 2017 18:15:35 +0530
Message-ID: <20170616124544.15046-8-kishon@ti.com>
References: <20170616124544.15046-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170616124544.15046-1-kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, nsekhar@ti.com
Cc: devicetree@vger.kernel.org, kishon@ti.com, linux-mmc@vger.kernel.org, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, Ravikumar Kattekola <rk@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Now that vmmc regulator is made optional, do not bail out if vmmc
regulator is not found.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index f64148b119df..f1d5e8385591 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -415,13 +415,6 @@ static int omap_hsmmc_set_power(struct omap_hsmmc_host *host, int power_on,
 	if (mmc_pdata(host)->set_power)
 		return mmc_pdata(host)->set_power(host->dev, power_on, iov);
 
-	/*
-	 * If we don't see a Vcc regulator, assume it's a fixed
-	 * voltage always-on regulator.
-	 */
-	if (IS_ERR(mmc->supply.vmmc))
-		return 0;
-
 	if (mmc_pdata(host)->before_set_reg)
 		mmc_pdata(host)->before_set_reg(host->dev, power_on, iov);
 
-- 
2.11.0
