From: akpm@linux-foundation.org
Subject: [patch 097/160] mmc: bfin_sdh: set timeout based on actual card data
Date: Fri, 05 Mar 2010 13:43:25 -0800
Message-ID: <201003052143.o25LhPCM029753@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:51553 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755358Ab0CEVn2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Mar 2010 16:43:28 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, cliff.cai@analog.com, linux-mmc@vger.kernel.org, vapier@gentoo.org

From: Cliff Cai <cliff.cai@analog.com>

The hardcoded value doesn't really work for all cards.

Signed-off-by: Cliff Cai <cliff.cai@analog.com>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/host/bfin_sdh.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff -puN drivers/mmc/host/bfin_sdh.c~mmc-bfin_sdh-set-timeout-based-on-actual-card-data drivers/mmc/host/bfin_sdh.c
--- a/drivers/mmc/host/bfin_sdh.c~mmc-bfin_sdh-set-timeout-based-on-actual-card-data
+++ a/drivers/mmc/host/bfin_sdh.c
@@ -115,6 +115,7 @@ static int sdh_setup_data(struct sdh_hos
 	unsigned int length;
 	unsigned int data_ctl;
 	unsigned int dma_cfg;
+	unsigned int cycle_ns, timeout;
 
 	dev_dbg(mmc_dev(host->mmc), "%s enter flags: 0x%x\n", __func__, data->flags);
 	host->data = data;
@@ -135,8 +136,11 @@ static int sdh_setup_data(struct sdh_hos
 	data_ctl |= ((ffs(data->blksz) - 1) << 4);
 
 	bfin_write_SDH_DATA_CTL(data_ctl);
-
-	bfin_write_SDH_DATA_TIMER(0xFFFF);
+	/* the time of a host clock period in ns */
+	cycle_ns = 1000000000 / (get_sclk() / (2 * (host->clk_div + 1)));
+	timeout = data->timeout_ns / cycle_ns;
+	timeout += data->timeout_clks;
+	bfin_write_SDH_DATA_TIMER(timeout);
 	SSYNC();
 
 	if (data->flags & MMC_DATA_READ) {
_
