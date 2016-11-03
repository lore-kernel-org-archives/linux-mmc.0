From: Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 01/13] mmc: dw_mmc: display the real register value on debugfs
Date: Thu, 03 Nov 2016 15:21:23 +0900
Message-ID: <20161103062135.10697-2-jh80.chung@samsung.com>
References: <20161103062135.10697-1-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-reply-to: <20161103062135.10697-1-jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Developer wants to see the real register value, not register offset.
This patch fixed to display the real value of register.

Signed-off-by: Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/mmc/host/dw_mmc.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 1c9ee36..b87dd07 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -165,12 +165,14 @@ static const struct file_operations dw_mci_req_fops = {
 
 static int dw_mci_regs_show(struct seq_file *s, void *v)
 {
-	seq_printf(s, "STATUS:\t0x%08x\n", SDMMC_STATUS);
-	seq_printf(s, "RINTSTS:\t0x%08x\n", SDMMC_RINTSTS);
-	seq_printf(s, "CMD:\t0x%08x\n", SDMMC_CMD);
-	seq_printf(s, "CTRL:\t0x%08x\n", SDMMC_CTRL);
-	seq_printf(s, "INTMASK:\t0x%08x\n", SDMMC_INTMASK);
-	seq_printf(s, "CLKENA:\t0x%08x\n", SDMMC_CLKENA);
+	struct dw_mci *host = s->private;
+
+	seq_printf(s, "STATUS:\t0x%08x\n", mci_readl(host, STATUS));
+	seq_printf(s, "RINTSTS:\t0x%08x\n", mci_readl(host, RINTSTS));
+	seq_printf(s, "CMD:\t0x%08x\n", mci_readl(host, CMD));
+	seq_printf(s, "CTRL:\t0x%08x\n", mci_readl(host, CTRL));
+	seq_printf(s, "INTMASK:\t0x%08x\n", mci_readl(host, INTMASK));
+	seq_printf(s, "CLKENA:\t0x%08x\n", mci_readl(host, CLKENA));
 
 	return 0;
 }
-- 
2.10.1
