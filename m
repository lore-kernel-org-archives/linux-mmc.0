From: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH v2 2/4] mmc: read mmc alias from device tree
Date: Fri, 29 Apr 2016 10:32:17 -0700
Message-ID: <1461951139-6109-3-git-send-email-dianders@chromium.org>
References: <1461951139-6109-1-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1461951139-6109-1-git-send-email-dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
Cc: jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, devicetree-spec-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, stefan-XLVq0VzYD2Y@public.gmane.org, Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, vbyravarasu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Dmitry Torokhov <dtor-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, zhonghui.fu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, kirill.shutemov-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

From: Stefan Agner <stefan-XLVq0VzYD2Y@public.gmane.org>

To get the SD/MMC host device ID, read the alias from the device
tree.

This is useful in case a SoC has multipe SD/MMC host controllers while
the second controller should logically be the first device (e.g. if
the second controller is connected to an internal eMMC). Combined
with block device numbering using MMC/SD host device ID, this
results in predictable name assignment of the internal eMMC block
device.

Signed-off-by: Stefan Agner <stefan-XLVq0VzYD2Y@public.gmane.org>
Signed-off-by: Dmitry Torokhov <dtor-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
[dianders: rebase + roll in http://crosreview.com/259916]
Signed-off-by: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
---
Changes in v2:
- Rebased atop mmc-next
- Stat dynamic allocation after fixed allocation; thanks Wolfram!

 drivers/mmc/core/host.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index e0a3ee16c0d3..e09f1d6207d3 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -314,11 +314,26 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 {
 	int err;
 	struct mmc_host *host;
+	int id;
 
 	host = kzalloc(sizeof(struct mmc_host) + extra, GFP_KERNEL);
 	if (!host)
 		return NULL;
 
+	/* If OF aliases exist, start dynamic assignment after highest */
+	id = of_alias_get_highest_id("mmc");
+	id = (id < 0) ? 0 : id + 1;
+
+	/* If this devices has OF node, maybe it has an alias */
+	if (dev->of_node) {
+		int of_id = of_alias_get_id(dev->of_node, "mmc");
+
+		if (of_id < 0)
+			dev_warn(dev, "/aliases ID not available\n");
+		else
+			id = of_id;
+	}
+
 	/* scanning will be enabled when we're ready */
 	host->rescan_disable = 1;
 
@@ -329,7 +344,7 @@ again:
 	}
 
 	spin_lock(&mmc_host_lock);
-	err = ida_get_new(&mmc_host_ida, &host->index);
+	err = ida_get_new_above(&mmc_host_ida, id, &host->index);
 	spin_unlock(&mmc_host_lock);
 
 	if (err == -EAGAIN) {
-- 
2.8.0.rc3.226.g39d4020
