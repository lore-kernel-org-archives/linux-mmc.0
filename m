From: Yusuke Goda <yusuke.goda.sx@renesas.com>
Subject: [PATCH] tmio_mmc: Allow 2 byte requests in 4-bit mode
Date: Tue, 20 Jul 2010 16:52:58 +0900
Message-ID: <4C4555DA.40203@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.renesas.com ([202.234.163.13]:35784 "EHLO
	mail01.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754681Ab0GTHzH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Jul 2010 03:55:07 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ian@mnementh.co.uk, damm@opensource.se, sameo@linux.intel.com, Paul Mundt <lethal@linux-sh.org>, g.liakhovetski@gmx.de, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>

Adjust the tmio_mmc block size check to accept 2-byte requests in 4-bit mode.
Tested with the SDHI hardware block included in sh7724.

Signed-off-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
---
 drivers/mmc/host/tmio_mmc.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index ee7d0a5..f49d945 100644
--- a/drivers/mmc/host/tmio_mmc.c
+++ b/drivers/mmc/host/tmio_mmc.c
@@ -660,8 +660,8 @@ static int tmio_mmc_start_data(struct tmio_mmc_host *host,
 	pr_debug("setup data transfer: blocksize %08x  nr_blocks %d\n",
 		 data->blksz, data->blocks);

-	/* Hardware cannot perform 1 and 2 byte requests in 4 bit mode */
-	if (data->blksz < 4 && host->mmc->ios.bus_width == MMC_BUS_WIDTH_4) {
+	/* Hardware cannot perform 1 byte requests in 4 bit mode */
+	if (data->blksz < 2 && host->mmc->ios.bus_width == MMC_BUS_WIDTH_4) {
 		pr_err("%s: %d byte block unsupported in 4 bit mode\n",
 		       mmc_hostname(host->mmc), data->blksz);
 		return -EINVAL;
-- 
1.7.0



