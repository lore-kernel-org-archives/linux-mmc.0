From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH] mmc: sh_mobile_sdhi: fix error return code in sh_mobile_sdhi_probe()
Date: Tue, 28 May 2013 13:26:50 +0800
Message-ID: <CAPgLHd_dwxRp8Ug7=05=3gTTa9bPME5tb-Mq1aqRFXZSrgqFGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bk0-f41.google.com ([209.85.214.41]:65083 "EHLO
	mail-bk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932458Ab3E1F0y (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 May 2013 01:26:54 -0400
Received: by mail-bk0-f41.google.com with SMTP id jc10so3970990bkc.14
        for <linux-mmc@vger.kernel.org>; Mon, 27 May 2013 22:26:50 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: g.liakhovetski@gmx.de, ian@mnementh.co.uk, cjb@laptop.org, grant.likely@linaro.org, rob.herring@calxeda.com
Cc: yongjun_wei@trendmicro.com.cn, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Fix to return a negative error code instead of 0 when we cannot get
IRQ source by platform_get_irq(), as done elsewhere in this function.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/mmc/host/sh_mobile_sdhi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index cc4c872..a4316b3 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -273,8 +273,10 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 		}
 
 		/* There must be at least one IRQ source */
-		if (!i)
+		if (!i) {
+			ret = irq;
 			goto eirq;
+		}
 	}
 
 	dev_info(&pdev->dev, "%s base at 0x%08lx clock rate %u MHz\n",

