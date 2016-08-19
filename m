From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH 2/2] mmc: dw_mmc: avoid race condition of cpu and IDMAC
Date: Fri, 19 Aug 2016 17:40:15 +0800
Message-ID: <1471599615-6249-2-git-send-email-shawn.lin@rock-chips.com>
References: <1471599615-6249-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1471599615-6249-1-git-send-email-shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

We could see an obvious race condition by test that
the former write operation by IDMAC aiming to clear
OWN bit reach right after the later configuration of
the same desc, which makes the IDMAC be in SUSPEND
state as the OWN bit was cleared by the asynchronous
write operation of IDMAC. The bug can be very easy
reproduced on RK3288 or similar when we reduce the
running rate of system buses and keep the CPU running
faster. So as two separate masters, IDMAC and cpu
write the same descriptor stored on the same address,
and this should be protected by adding check of OWN
bit before preparing new descriptors.

Signed-off-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
---

 drivers/mmc/host/dw_mmc.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 0a5a49f..e640f83 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -473,6 +473,7 @@ static inline void dw_mci_prepare_desc64(struct dw_mci *host,
 {
 	unsigned int desc_len;
 	struct idmac_desc_64addr *desc_first, *desc_last, *desc;
+	unsigned long timeout = jiffies + msecs_to_jiffies(100);
 	int i;
 
 	desc_first = desc_last = desc = host->sg_cpu;
@@ -489,6 +490,20 @@ static inline void dw_mci_prepare_desc64(struct dw_mci *host,
 			length -= desc_len;
 
 			/*
+			 * Wait for the former clear OWN bit operation
+			 * of IDMAC to make sure that this descriptor
+			 * isn't still owned by IDMAC as IDMAC's write
+			 * ops and CPU's read ops are asynchronous.
+			 */
+			while (readl(&desc->des0) & IDMAC_DES0_OWN) {
+				if (time_after(jiffies, timeout)) {
+					dev_err(host->dev, "DESC is still owned by IDMAC.\n");
+					break;
+				}
+				udelay(10);
+			}
+
+			/*
 			 * Set the OWN bit and disable interrupts
 			 * for this descriptor
 			 */
@@ -525,6 +540,7 @@ static inline void dw_mci_prepare_desc32(struct dw_mci *host,
 {
 	unsigned int desc_len;
 	struct idmac_desc *desc_first, *desc_last, *desc;
+	unsigned long timeout = jiffies + msecs_to_jiffies(100);
 	int i;
 
 	desc_first = desc_last = desc = host->sg_cpu;
@@ -541,6 +557,20 @@ static inline void dw_mci_prepare_desc32(struct dw_mci *host,
 			length -= desc_len;
 
 			/*
+			 * Wait for the former clear OWN bit operation
+			 * of IDMAC to make sure that this descriptor
+			 * isn't still owned by IDMAC as IDMAC's write
+			 * ops and CPU's read ops are asynchronous.
+			 */
+			while (readl(&desc->des0) & IDMAC_DES0_OWN) {
+				if (time_after(jiffies, timeout)) {
+					dev_err(host->dev, "DESC is still owned by IDMAC.\n");
+					break;
+				}
+				udelay(10);
+			}
+
+			/*
 			 * Set the OWN bit and disable interrupts
 			 * for this descriptor
 			 */
-- 
2.3.7
