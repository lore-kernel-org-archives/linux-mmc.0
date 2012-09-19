From: Chris Ball <cjb@laptop.org>
Subject: [PATCH] mmc: sdhci-pxav3: Use sdhci_get_of_property for parsing DT quirks
Date: Wed, 19 Sep 2012 04:27:39 -0400
Message-ID: <m3lig6h0xw.fsf_-_@pullcord.laptop.org>
References: <87mx0zzyin.fsf@octavius.laptop.org>
	<CAN1soZzebpiQB_7HW80xnqEqqVJumiDxPQ3jqx_8ezBRMr6TZg@mail.gmail.com>
	<87d31sy548.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:56327 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750838Ab2ISI1R (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 19 Sep 2012 04:27:17 -0400
In-Reply-To: <87d31sy548.fsf@octavius.laptop.org> (Chris Ball's message of
	"Tue, 11 Sep 2012 11:02:47 -0400")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: linux-mmc@vger.kernel.org, Philip Rakity <prakity@marvell.com>, Zhangfei Gao <zhangfei.gao@marvell.com>

In particular, this is done to gain support for broken-cd and wp-inverted.

Signed-off-by: Chris Ball <cjb@laptop.org>
---
(A previously submitted patch of mine added broken-cd support to
sdhci-pxav3 directly; I think it's a better idea to discard that
patch and use this one instead.)

 drivers/mmc/host/sdhci-pxav3.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index 3a81cd6..78d7c42 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -296,6 +296,8 @@ static int __devinit sdhci_pxav3_probe(struct platform_device *pdev)
 
 	host->ops = &pxav3_sdhci_ops;
 
+	sdhci_get_of_property(pdev);
+
 	ret = sdhci_add_host(host);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to add host\n");
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
