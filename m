From: Arnd Hannemann <arnd@arndnet.de>
Subject: [PATCH 2/4] sh_mobile_sdhi: Allow the platform to specify get_cd
 handler
Date: Tue, 24 Aug 2010 17:27:00 +0200
Message-ID: <1282663622-20564-3-git-send-email-arnd@arndnet.de>
References: <1282663622-20564-1-git-send-email-arnd@arndnet.de>
Content-Transfer-Encoding: 7BIT
Return-path: <linux-sh-owner@vger.kernel.org>
In-reply-to: <1282663622-20564-1-git-send-email-arnd@arndnet.de>
Sender: linux-sh-owner@vger.kernel.org
To: ian@mnementh.co.uk
Cc: sameo@linux.intel.com, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, yusuke.goda.sx@renesas.com, Arnd Hannemann <arnd@arndnet.de>
List-Id: linux-mmc@vger.kernel.org

On some platforms (e.g. AP4EVB) the card detect pin of a slot is not directly
connected to the sdhi hardware, so that polling needs to be used with tmio_mmc
and card detection is handled in the platform code.
This patch allows to set tmio_mmc capabilities (to pass the MMC_CAP_NEEDS_POLL
flag) and exposes a get_cd hook for that purpose.

Signed-off-by: Arnd Hannemann <arnd@arndnet.de>
---
 drivers/mfd/sh_mobile_sdhi.c       |   13 +++++++++++++
 include/linux/mfd/sh_mobile_sdhi.h |    2 ++
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/drivers/mfd/sh_mobile_sdhi.c b/drivers/mfd/sh_mobile_sdhi.c
index cd16459..7c23630 100644
--- a/drivers/mfd/sh_mobile_sdhi.c
+++ b/drivers/mfd/sh_mobile_sdhi.c
@@ -65,6 +65,17 @@ static void sh_mobile_sdhi_set_pwr(struct platform_device *tmio, int state)
 		p->set_pwr(pdev, state);
 }
 
+static int sh_mobile_sdhi_get_cd(struct platform_device *tmio)
+{
+	struct platform_device *pdev = to_platform_device(tmio->dev.parent);
+	struct sh_mobile_sdhi_info *p = pdev->dev.platform_data;
+
+	if (p && p->get_cd)
+		return p->get_cd(pdev);
+	else
+		return -ENOSYS;
+}
+
 static int __init sh_mobile_sdhi_probe(struct platform_device *pdev)
 {
 	struct sh_mobile_sdhi *priv;
@@ -106,10 +117,12 @@ static int __init sh_mobile_sdhi_probe(struct platform_device *pdev)
 
 	mmc_data->hclk = clk_get_rate(priv->clk);
 	mmc_data->set_pwr = sh_mobile_sdhi_set_pwr;
+	mmc_data->get_cd = sh_mobile_sdhi_get_cd;
 	mmc_data->capabilities = MMC_CAP_MMC_HIGHSPEED;
 	if (p) {
 		mmc_data->flags = p->tmio_flags;
 		mmc_data->ocr_mask = p->tmio_ocr_mask;
+		mmc_data->capabilities |= p->tmio_caps;
 	}
 
 	if (p && p->dma_slave_tx >= 0 && p->dma_slave_rx >= 0) {
diff --git a/include/linux/mfd/sh_mobile_sdhi.h b/include/linux/mfd/sh_mobile_sdhi.h
index 4906780..c981b95 100644
--- a/include/linux/mfd/sh_mobile_sdhi.h
+++ b/include/linux/mfd/sh_mobile_sdhi.h
@@ -7,8 +7,10 @@ struct sh_mobile_sdhi_info {
 	int dma_slave_tx;
 	int dma_slave_rx;
 	unsigned long tmio_flags;
+	unsigned long tmio_caps;
 	u32 tmio_ocr_mask;	/* available MMC voltages */
 	void (*set_pwr)(struct platform_device *pdev, int state);
+	int (*get_cd)(struct platform_device *pdev);
 };
 
 #endif /* __SH_MOBILE_SDHI_H__ */
-- 
1.7.0.4

