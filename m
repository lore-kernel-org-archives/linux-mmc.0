From: Shailendra Verma <shailendra.v@samsung.com>
Subject: [PATCH] Mmc: host - Fix possible NULL derefrence.
Date: Mon, 30 Jan 2017 10:18:18 +0530
Message-ID: <1485751698-29036-1-git-send-email-shailendra.v@samsung.com>
References: <CGME20170130044838epcas1p43a1c58ae970b39909cfb67b2aa619a88@epcas1p4.samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:52244 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751921AbdA3Esk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 29 Jan 2017 23:48:40 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Fabio Estevam <fabio.estevam@nxp.com>, Marek Vasut <marex@denx.de>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, p.shailesh@samsung.com, ashish.kalra@samsung.com, Shailendra Verma <shailendra.v@samsung.com>, Shailendra Verma <shailendra.capricorn@gmail.com>

of_match_device could return NULL, and so can cause a NULL
pointer dereference later.

Signed-off-by: Shailendra Verma <shailendra.v@samsung.com>
---
 drivers/mmc/host/mxs-mmc.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index 44ecebd..d12a5b7 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -581,6 +581,11 @@ static int mxs_mmc_probe(struct platform_device *pdev)
 	struct regulator *reg_vmmc;
 	struct mxs_ssp *ssp;
 
+	if (!of_id) {
+		dev_err(&pdev->dev, "Error: No device match found\n");
+		return -ENODEV;
+	}
+
 	irq_err = platform_get_irq(pdev, 0);
 	if (irq_err < 0)
 		return irq_err;
-- 
1.7.9.5

