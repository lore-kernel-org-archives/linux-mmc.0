From: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 2/4] mmc: omap_hsmmc: Avoid a regulator voltage change with
	dt
Date: Thu, 23 Feb 2012 17:31:28 +0530
Message-ID: <1329998490-27555-3-git-send-email-rnayak@ti.com>
References: <1329998490-27555-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <1329998490-27555-1-git-send-email-rnayak-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, balajitk-l0cyMroinI0@public.gmane.org, Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

When booting with Device tree, the omap_hsmmc driver does not
program the pbias cell (inside OMAP control module) during
a regulator voltage change.
In case of non-dt boot, this is handled using callbacks
from within platform_data and implemented in machine code.
To be able to do this with device tree, without invoking
any machine code, a OMAP control module driver is needed
which is yet missing.

The pbias cell is used to provide a 1.8v or 3.0v reference
to the mmc/sd/sdio1 interface supporting both 1.8v and 3.0v
voltages.

Until a OMAP control module driver is available to handle this,
when booting with a device tree blob, never change the regulator
voltage which might then require a pbias cell re-program.
There are 2 instances where in the mmc regulator voltage can be
changed.
-1- when the regulator is turned OFF.
-2- when attempting a switch to 1.8v from 3.0v for dual volt cards

This patch avoids a voltage change in both cases when booting from
device tree, and hence compromises on power savings.
Once the OMAP control module driver is available and hsmmc driver
is modified to then do pbias programming even when booting
with device tree, these limitaions can be removed to achieve better
power savings.

Signed-off-by: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
---
 drivers/mmc/host/omap_hsmmc.c |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 0c93d58..dffde8d 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -245,6 +245,13 @@ static int omap_hsmmc_set_power(struct device *dev, int slot, int power_on,
 	 */
 	if (!host->vcc)
 		return 0;
+	/*
+	 * With DT, never turn OFF the regulator. This is because
+	 * the pbias cell programming support is still missing when
+	 * booting with Device tree
+	 */
+	if (of_have_populated_dt() && !vdd)
+		return 0;
 
 	if (mmc_slot(host).before_set_reg)
 		mmc_slot(host).before_set_reg(dev, slot, power_on, vdd);
@@ -1537,7 +1544,13 @@ static void omap_hsmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		 * of external transceiver; but they all handle 1.8V.
 		 */
 		if ((OMAP_HSMMC_READ(host->base, HCTL) & SDVSDET) &&
-			(ios->vdd == DUAL_VOLT_OCR_BIT)) {
+			(ios->vdd == DUAL_VOLT_OCR_BIT) &&
+			/*
+			 * With pbias cell programming missing, this
+			 * can't be allowed when booting with device
+			 * tree.
+			 */
+			(!of_have_populated_dt())) {
 				/*
 				 * The mmc_select_voltage fn of the core does
 				 * not seem to set the power_mode to
-- 
1.7.1
