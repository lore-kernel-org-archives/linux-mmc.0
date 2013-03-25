From: Kevin Liu <kliu5@marvell.com>
Subject: [PATCH RESEND v5 4/4] mmc: sdhci-pxav3: controller should use SDCLK for timeout caculation
Date: Mon, 25 Mar 2013 17:42:59 +0800
Message-ID: <1364204579-13307-5-git-send-email-kliu5@marvell.com>
References: <1364204579-13307-1-git-send-email-kliu5@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:43580 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755545Ab3CYJob (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 25 Mar 2013 05:44:31 -0400
In-Reply-To: <1364204579-13307-1-git-send-email-kliu5@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Jerry Huang <Chang-Ming.Huang@freescale.com>, Chunhe Lan <Chunhe.Lan@freescale.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Jaehoon Chung <jh80.chung@samsung.com>, Aaron Lu <aaron.lu@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Wei WANG <wei_wang@realsil.com.cn>, Fabio Estevam <fabio.estevam@freescale.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Adrian Hunter <adrian.hunter@intel.com>, Philip Rakity <prakity@nvidia.com>, Shawn Guo <shawn.guo@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, Girish K S <girish.shivananjappa@linaro.org>, Haijun Zhang <Haijun.Zhang@freescale.com>, Zhangfei Gao <zhangfei.gao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Chao Xie <cxie4@marvell.com>, Kevin Liu <keyuan.liu@gmail.com>, Kevin Liu <kliu5@marvell.com>

sdhci-pxav3 host controller used SDCLK for data timeout.

Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/host/sdhci-pxav3.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index fb0d23c..1ae358e 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -175,7 +175,7 @@ static const struct sdhci_ops pxav3_sdhci_ops = {
 };
 
 static struct sdhci_pltfm_data sdhci_pxav3_pdata = {
-	.quirks = SDHCI_QUIRK_BROKEN_TIMEOUT_VAL
+	.quirks = SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK
 		| SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC
 		| SDHCI_QUIRK_32BIT_ADMA_SIZE
 		| SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
-- 
1.7.9.5

