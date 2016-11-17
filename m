From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCHv3 1/9] mmc: dw_mmc: display the real register value on debugfs
Date: Thu, 17 Nov 2016 16:40:33 +0900
Message-ID: <20161117074041.8641-2-jh80.chung@samsung.com>
References: <20161117074041.8641-1-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:58231 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751059AbcKQHkz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Nov 2016 02:40:55 -0500
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OGR01SAEZZO5X60@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 17 Nov 2016 16:40:42 +0900 (KST)
In-reply-to: <20161117074041.8641-1-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, shawn.lin@rock-chips.com, adrian.hunter@intel.com, Jaehoon Chung <jh80.chung@samsung.com>

Developer wants to see the real register value, not register offset.
This patch fixed to display the real value of register.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
---
 drivers/mmc/host/dw_mmc.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 9341b18..7ffd57b 100644
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

