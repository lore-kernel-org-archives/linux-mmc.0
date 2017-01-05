From: Ziyuan Xu <xzy.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v4] mmc: dw_mmc: force setup bus if active slots exist
Date: Thu,  5 Jan 2017 15:23:32 +0800
Message-ID: <1483601012-18241-1-git-send-email-xzy.xu@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org
Cc: randy.li-TNX95d0MmH7DzftRWevZcw@public.gmane.org, Ziyuan Xu <xzy.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

It's necessary to setup bus if any slots are present.
- update clock after ctrl reset
- if the host has genpd node, we can guarantee the clock is available
before starting request. Otherwies, the clock register is reset once
power off the pd, and host can't output the active clock during
communication.

fixes: e9ed8835e990 ("mmc: dw_mmc: add runtime PM callback")
Reported-by: Randy Li <randy.li-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Signed-off-by: Ziyuan Xu <xzy.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>

---
Hi guys,

I found a similar issue on rk3399 platform, which has a genpd node for
SD card host. Power off-on pd will reset the registers to a default
value (ie. CLKENA), so that the host can't output the active clock
during communication.

So we need to setup bus in rpm resume. It also wraps the update clock
behaviour which I did in V3.

Thanks,
Ziyuan Xu


Changes in v4:
- update commit message
- fix SD host rpm resume can't work

Changes in v3:
- only reset host with active slot.

Changes in v2:
- update the commit message
- use dw_mci_reset instead of dw_mci_ctrl_reset

 drivers/mmc/host/dw_mmc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index b44306b..b6053b3 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -3354,10 +3354,10 @@ int dw_mci_runtime_resume(struct device *dev)
 
 		if (!slot)
 			continue;
-		if (slot->mmc->pm_flags & MMC_PM_KEEP_POWER) {
+		if (slot->mmc->pm_flags & MMC_PM_KEEP_POWER)
 			dw_mci_set_ios(slot->mmc, &slot->mmc->ios);
-			dw_mci_setup_bus(slot, true);
-		}
+		/* Force setup bus to guarantee available clock output */
+		dw_mci_setup_bus(slot, true);
 	}
 
 	/* Now that slots are all setup, we can enable card detect */
-- 
2.7.4
