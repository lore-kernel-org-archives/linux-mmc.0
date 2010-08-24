From: Arnd Hannemann <arnd@arndnet.de>
Subject: [PATCH 1/4] tmio_mmc: Allow the mfd driver to specify get_cd handler
Date: Tue, 24 Aug 2010 17:26:59 +0200
Message-ID: <1282663622-20564-2-git-send-email-arnd@arndnet.de>
References: <1282663622-20564-1-git-send-email-arnd@arndnet.de>
Content-Transfer-Encoding: 7BIT
Return-path: <linux-sh-owner@vger.kernel.org>
In-reply-to: <1282663622-20564-1-git-send-email-arnd@arndnet.de>
Sender: linux-sh-owner@vger.kernel.org
To: ian@mnementh.co.uk
Cc: sameo@linux.intel.com, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, yusuke.goda.sx@renesas.com, Arnd Hannemann <arnd@arndnet.de>
List-Id: linux-mmc@vger.kernel.org

Some controllers, supported by the tmio_mmc driver do not have the card detect
pin of a slot connected, so that polling needs to be used and card detection is
handled by other means.
This patch exposes a get_cd hook for that purpose.

Signed-off-by: Arnd Hannemann <arnd@arndnet.de>
---
 drivers/mmc/host/tmio_mmc.c |   13 +++++++++++++
 include/linux/mfd/tmio.h    |    1 +
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index ee7d0a5..fe2ebf6 100644
--- a/drivers/mmc/host/tmio_mmc.c
+++ b/drivers/mmc/host/tmio_mmc.c
@@ -755,10 +755,23 @@ static int tmio_mmc_get_ro(struct mmc_host *mmc)
 		(sd_ctrl_read32(host, CTL_STATUS) & TMIO_STAT_WRPROTECT)) ? 0 : 1;
 }
 
+static int tmio_mmc_get_cd(struct mmc_host *mmc)
+{
+	struct tmio_mmc_host *host = mmc_priv(mmc);
+	struct mfd_cell	*cell = host->pdev->dev.platform_data;
+	struct tmio_mmc_data *pdata = cell->driver_data;
+
+	if (!pdata->get_cd)
+		return -ENOSYS;
+	else
+		return pdata->get_cd(host->pdev);
+}
+
 static const struct mmc_host_ops tmio_mmc_ops = {
 	.request	= tmio_mmc_request,
 	.set_ios	= tmio_mmc_set_ios,
 	.get_ro         = tmio_mmc_get_ro,
+	.get_cd		= tmio_mmc_get_cd,
 };
 
 #ifdef CONFIG_PM
diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
index f07425b..24c43bb 100644
--- a/include/linux/mfd/tmio.h
+++ b/include/linux/mfd/tmio.h
@@ -74,6 +74,7 @@ struct tmio_mmc_data {
 	struct tmio_mmc_dma		*dma;
 	void (*set_pwr)(struct platform_device *host, int state);
 	void (*set_clk_div)(struct platform_device *host, int state);
+	int (*get_cd)(struct platform_device *host);
 };
 
 /*
-- 
1.7.0.4

