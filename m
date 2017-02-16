From: =?UTF-8?q?Micha=C5=82=20Zegan?= <webczat@webczatnet.pl>
Subject: [PATCH 2/2] mmc: meson-gx: remove mmc host on device removal
Date: Thu, 16 Feb 2017 15:52:22 +0100
Message-ID: <20170216145222.1577-3-webczat@webczatnet.pl>
References: <20170216145222.1577-1-webczat@webczatnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from webczatnet.pl ([91.121.100.5]:59934 "EHLO webczatnet.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932269AbdBPOwz (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 16 Feb 2017 09:52:55 -0500
In-Reply-To: <20170216145222.1577-1-webczat@webczatnet.pl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Hilman <khilman@baylibre.com>
Cc: Carlo Caione <carlo@caione.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Micha=C5=82=20Zegan?= <webczat@webczatnet.pl>

The mmc host was added in meson_mmc_probe, but never removed in meson_mmc_remove.
Fix that by removing the host before deallocating other resources.

Signed-off-by: Michał Zegan <webczat@webczatnet.pl>
---
 drivers/mmc/host/meson-gx-mmc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index d444b6bfa02b..bb83446118a3 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -818,6 +818,8 @@ static int meson_mmc_remove(struct platform_device *pdev)
 	if (WARN_ON(!host))
 		return 0;
 
+	mmc_remove_host(host->mmc);
+
 	if (host->bounce_buf)
 		dma_free_coherent(host->dev, host->bounce_buf_size,
 				  host->bounce_buf, host->bounce_dma_addr);
-- 
2.11.0

