From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/2] mmc: sdhci_f_sdh30: Fix the size passed to
 sdhci_alloc_host
Date: Fri, 24 Apr 2015 15:02:00 +0800
Message-ID: <1429858920.18906.2.camel@ingics.com>
References: <1429858829.18906.0.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33719 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933431AbbDXHCH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Apr 2015 03:02:07 -0400
Received: by pacwv17 with SMTP id wv17so18533329pac.0
        for <linux-mmc@vger.kernel.org>; Fri, 24 Apr 2015 00:02:07 -0700 (PDT)
In-Reply-To: <1429858829.18906.0.camel@ingics.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Andy Green <andy.green@linaro.org>, Vincent Yang <vincent.yang.fujitsu@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

sdhci_alloc_host() takes priv_size rather than
sizeof(struct sdhci_host) + priv_size.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/mmc/host/sdhci_f_sdh30.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci_f_sdh30.c b/drivers/mmc/host/sdhci_f_sdh30.c
index 5397e27..983b8b3 100644
--- a/drivers/mmc/host/sdhci_f_sdh30.c
+++ b/drivers/mmc/host/sdhci_f_sdh30.c
@@ -114,8 +114,7 @@ static int sdhci_f_sdh30_probe(struct platform_device *pdev)
 		return irq;
 	}
 
-	host = sdhci_alloc_host(dev, sizeof(struct sdhci_host) +
-						sizeof(struct f_sdhost_priv));
+	host = sdhci_alloc_host(dev, sizeof(struct f_sdhost_priv));
 	if (IS_ERR(host))
 		return PTR_ERR(host);
 
-- 
2.1.0



