From: Jean-Francois Moine <moinejf@free.fr>
Subject: [PATCH] mmc: core: Assign a fixed number to MMC devices
Date: Thu, 1 Sep 2016 11:40:31 +0200
Message-ID: <E1bfRRI-0006Dz-Bs@bombadil.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

This patch prevents MMC device numbering to change at each reboot
by using DT labels.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 drivers/mmc/core/host.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 98f25ff..38b94ce 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -346,6 +346,14 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 {
 	int err;
 	struct mmc_host *host;
+	int id = 0;
+
+	/* use DT label as mmc index */
+	if (dev->of_node) {
+		id = of_alias_get_id(dev->of_node, "mmc");
+		if (id < 0)
+			id = 0;
+	}
 
 	host = kzalloc(sizeof(struct mmc_host) + extra, GFP_KERNEL);
 	if (!host)
@@ -361,7 +369,7 @@ again:
 	}
 
 	spin_lock(&mmc_host_lock);
-	err = ida_get_new(&mmc_host_ida, &host->index);
+	err = ida_get_new_above(&mmc_host_ida, id, &host->index);
 	spin_unlock(&mmc_host_lock);
 
 	if (err == -EAGAIN) {
-- 
2.9.3
