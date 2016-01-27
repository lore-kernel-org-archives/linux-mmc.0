From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC PATCH 09/21] mmc: sdhci_f_sdh30: check sdhci_get_of_property return value
Date: Wed, 27 Jan 2016 13:07:53 +0800
Message-ID: <1453871273-3683-1-git-send-email-shawn.lin@rock-chips.com>
References: <1453871155-3283-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:46153 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753570AbcA0FM1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Jan 2016 00:12:27 -0500
In-Reply-To: <1453871155-3283-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>, Vincent Yang <vincent.yang.fujitsu@gmail.com>, Andy Green <andy.green@linaro.org>

sdhci_get_of_property may failed while probing, so we check
the return value here.

Cc: Vincent Yang <vincent.yang.fujitsu@gmail.com>
Cc: Andy Green <andy.green@linaro.org>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/sdhci_f_sdh30.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci_f_sdh30.c b/drivers/mmc/host/sdhci_f_sdh30.c
index 983b8b3..405e765 100644
--- a/drivers/mmc/host/sdhci_f_sdh30.c
+++ b/drivers/mmc/host/sdhci_f_sdh30.c
@@ -132,7 +132,10 @@ static int sdhci_f_sdh30_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, host);
 
-	sdhci_get_of_property(pdev);
+	ret = sdhci_get_of_property(pdev);
+	if (ret)
+		goto err;
+
 	host->hw_name = "f_sdh30";
 	host->ops = &sdhci_f_sdh30_ops;
 	host->irq = irq;
-- 
2.3.7


