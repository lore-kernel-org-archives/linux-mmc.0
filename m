From: Marcin Wojtas <mw@semihalf.com>
Subject: [PATCH 3/8] mmc: sdhci-pxav3: fix error handling of armada_38x_quirks
Date: Tue,  6 Oct 2015 03:22:37 +0200
Message-ID: <1444094562-31165-4-git-send-email-mw@semihalf.com>
References: <1444094562-31165-1-git-send-email-mw@semihalf.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:36382 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751487AbbJFBQA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Oct 2015 21:16:00 -0400
Received: by laddr2 with SMTP id dr2so17882672lad.3
        for <linux-mmc@vger.kernel.org>; Mon, 05 Oct 2015 18:15:58 -0700 (PDT)
In-Reply-To: <1444094562-31165-1-git-send-email-mw@semihalf.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, sebastian.hesselbarth@gmail.com, andrew@lunn.ch, jason@lakedaemon.net, thomas.petazzoni@free-electrons.com, gregory.clement@free-electrons.com, nadavh@marvell.com, alior@marvell.com, tawfik@marvell.com, mw@semihalf.com, jaz@semihalf.com, stable@vger.kernel.org

In case of armada_38x_quirks error, all clocks should be cleaned-up, same
as after mv_conf_mbus_windows failure.

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
Cc: <stable@vger.kernel.org> # v4.2
---
 drivers/mmc/host/sdhci-pxav3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index 89a9e49..f5edf9d 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -402,7 +402,7 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
 	if (of_device_is_compatible(np, "marvell,armada-380-sdhci")) {
 		ret = armada_38x_quirks(pdev, host);
 		if (ret < 0)
-			goto err_clk_get;
+			goto err_mbus_win;
 		ret = mv_conf_mbus_windows(pdev, mv_mbus_dram_info());
 		if (ret < 0)
 			goto err_mbus_win;
-- 
1.8.3.1

