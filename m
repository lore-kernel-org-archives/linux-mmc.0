From: Yusuke Goda <yusuke.goda.sx@renesas.com>
Subject: [PATCH] tmio_mmc: Revise a limit of the data size
Date: Wed, 07 Jul 2010 11:01:20 +0900
Message-ID: <4C33DFF0.3040804@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.renesas.com ([202.234.163.13]:55285 "EHLO
	mail04.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751114Ab0GGCBc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Jul 2010 22:01:32 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Magnus Damm <magnus.damm@gmail.com>

Signed-off-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
---
 drivers/mmc/host/tmio_mmc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index ee7d0a5..cac1c97 100644
--- a/drivers/mmc/host/tmio_mmc.c
+++ b/drivers/mmc/host/tmio_mmc.c
@@ -661,7 +661,7 @@ static int tmio_mmc_start_data(struct tmio_mmc_host *host,
 		 data->blksz, data->blocks);

 	/* Hardware cannot perform 1 and 2 byte requests in 4 bit mode */
-	if (data->blksz < 4 && host->mmc->ios.bus_width == MMC_BUS_WIDTH_4) {
+	if (data->blksz < 2 && host->mmc->ios.bus_width == MMC_BUS_WIDTH_4) {
 		pr_err("%s: %d byte block unsupported in 4 bit mode\n",
 		       mmc_hostname(host->mmc), data->blksz);
 		return -EINVAL;
-- 
1.7.0



