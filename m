From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4/5] mmc: sh_mmcif: Inform the mmc core about the max busy timeout
Date: Tue, 21 Jun 2016 15:12:49 +0200
Message-ID: <1466514770-9462-5-git-send-email-ulf.hansson@linaro.org>
References: <1466514770-9462-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f44.google.com ([209.85.215.44]:35858 "EHLO
	mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751242AbcFUO5t (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Jun 2016 10:57:49 -0400
Received: by mail-lf0-f44.google.com with SMTP id q132so27664035lfe.3
        for <linux-mmc@vger.kernel.org>; Tue, 21 Jun 2016 07:56:54 -0700 (PDT)
In-Reply-To: <1466514770-9462-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Nguyen Viet Dung <nv-dung@jinso.co.jp>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Baolin Wang <baolin.wang@linaro.org>

The sh_mmcif driver is already using a 10s request timeout. Let's also
inform the mmc core about this value, as there are situations when it
needs to know about it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sh_mmcif.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 96a45d8..bab971b 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -1455,6 +1455,7 @@ static int sh_mmcif_probe(struct platform_device *pdev)
 
 	mmc->caps |= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_WAIT_WHILE_BUSY;
 	mmc->caps2 |= MMC_CAP2_NO_SD | MMC_CAP2_NO_SDIO;
+	mmc->max_busy_timeout = 10000;
 
 	if (pd && pd->caps)
 		mmc->caps |= pd->caps;
-- 
1.9.1

