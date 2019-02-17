From: Jonas Karlman <jonas-uIzNG4q0ceqzQB+pC5nmwQ@public.gmane.org>
Subject: [RFC] mmc: core: set initial signal voltage on power off
Date: Sun, 17 Feb 2019 22:14:38 +0000
Message-ID: <AM3PR03MB09664161A7FA2BD68B2800A7AC620@AM3PR03MB0966.eurprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: "linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Jonas Karlman <jonas-uIzNG4q0ceqzQB+pC5nmwQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Some boards have SD card connectors where the power rail cannot be switched
off by the driver. If the card has not been power cycled, it may still be
using 1.8V signaling after a warm re-boot. Bootroms expecting 3.3V signaling
will fail to boot from a UHS card that continue to use 1.8V signaling.

Set initial signal voltage in mmc_power_off() to allow re-boot to function.

This fixes re-boot with UHS cards on Asus Tinker Board (Rockchip RK3288),
same issue have been seen on some Rockchip RK3399 boards.

I am sending this as a RFC because I have no insights into SD/MMC subsystem,
this change fix a re-boot issue on my boards and does not break emmc/sdio.
Is this an acceptable workaround? Any advice is appreciated.

Signed-off-by: Jonas Karlman <jonas-uIzNG4q0ceqzQB+pC5nmwQ@public.gmane.org>
---
 drivers/mmc/core/core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 5bd58b95d318..69d7021916ae 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1684,6 +1684,14 @@ void mmc_power_off(struct mmc_host *host)
 	if (host->ios.power_mode == MMC_POWER_OFF)
 		return;
 
+	mmc_set_initial_signal_voltage(host);
+
+	/*
+	 * This delay should be sufficient to allow the power supply
+	 * to reach the minimum voltage.
+	 */
+	mmc_delay(host->ios.power_delay_ms);
+
 	mmc_pwrseq_power_off(host);
 
 	host->ios.clock = 0;
-- 
2.17.1
