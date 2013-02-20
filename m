From: Kevin Liu <kliu5@marvell.com>
Subject: [PATCH] mmc: core: restore ocr and operation voltage in resume
Date: Wed, 20 Feb 2013 17:31:01 +0800
Message-ID: <1361352662-12263-1-git-send-email-kliu5@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:54559 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932912Ab3BTJdJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Feb 2013 04:33:09 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Jaehoon Chung <jh80.chung@samsung.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Aaron Lu <aaron.lu@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Alexander Stein <alexander.stein@systec-electronic.com>, Wei WANG <wei_wang@realsil.com.cn>, Fabio Estevam <fabio.estevam@freescale.com>
Cc: Anton Vorontsov <cbouatmailru@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, Lars-Peter Clausen <lars@metafoo.de>, Mike Rapoport <mike@compulab.co.il>, Nicolas Pitre <nico@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Philip Rakity <prakity@nvidia.com>, Shawn Guo <shawn.guo@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, Daniel Drake <dsd@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Jerry Huang <Chang-Ming.Huang@freescale.com>, Girish K S <girish.shivananjappa@linaro.org>, Haijun Zhang <Haijun.Zhang@freescale.com>, Viresh Kumar <viresh.kumar@linaro.org>, Heiko Stuebner <heiko@sntech.de>, Thomas Abraham <thomas.abraham@linaro.org>, Chander Kashyap <chander.kashyap@linaro.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Zhangfei Gao <zhangfei.gao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Chao

host->ocr has been reset in power off but not restored after power up
in resume. And operation voltage will be set to the highest after resume
back. This patch fix these two bugs.

Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/core/core.c  |    3 ++-
 include/linux/mmc/host.h |    1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 08a3cf2..b8c3d41 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1523,6 +1523,7 @@ void mmc_power_off(struct mmc_host *host)
 	 * Reset ocr mask to be the highest possible voltage supported for
 	 * this mmc host. This value will be used at next power up.
 	 */
+	host->ocr_bak = host->ocr;
 	host->ocr = 1 << (fls(host->ocr_avail) - 1);
 
 	if (!mmc_host_is_spi(host)) {
@@ -2666,7 +2667,7 @@ int mmc_resume_host(struct mmc_host *host)
 	if (host->bus_ops && !host->bus_dead) {
 		if (!mmc_card_keep_power(host)) {
 			mmc_power_up(host);
-			mmc_select_voltage(host, host->ocr);
+			host->ocr = mmc_select_voltage(host, host->ocr_bak);
 			/*
 			 * Tell runtime PM core we just powered up the card,
 			 * since it still believes the card is powered off.
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index d6f20cc..6e355d1 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -309,6 +309,7 @@ struct mmc_host {
 
 	struct mmc_ios		ios;		/* current io bus settings */
 	u32			ocr;		/* the current OCR setting */
+	u32			ocr_bak;	/* save current OCR setting */
 
 	/* group bitfields together to minimize padding */
 	unsigned int		use_spi_crc:1;
-- 
1.7.9.5

