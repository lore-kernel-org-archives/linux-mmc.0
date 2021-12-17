Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982EEC433FE
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Dec 2021 20:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234319AbhLQU1Y (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 17 Dec 2021 15:27:24 -0500
Received: from mxout02.lancloud.ru ([45.84.86.82]:43502 "EHLO
        mxout02.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235287AbhLQU1X (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Dec 2021 15:27:23 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout02.lancloud.ru C086A20CC598
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
To:     Ulf Hansson <ulf.hansson@linaro.org>, <linux-mmc@vger.kernel.org>
CC:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        "Martin Blumenstingl" <martin.blumenstingl@googlemail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>
Subject: [PATCH 2/2] mmc: meson-mx-sdio: add IRQ check
Date:   Fri, 17 Dec 2021 23:27:17 +0300
Message-ID: <20211217202717.10041-3-s.shtylyov@omp.ru>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20211217202717.10041-1-s.shtylyov@omp.ru>
References: <20211217202717.10041-1-s.shtylyov@omp.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The driver neglects to check the result of platform_get_irq()'s call and
blithely passes the negative error codes to devm_request_threaded_irq()
(which takes *unsigned* IRQ #), causing it to fail with -EINVAL, overriding
an original error code. Stop calling devm_request_threaded_irq() with the
invalid IRQ #s.

Fixes: ed80a13bb4c4 ("mmc: meson-mx-sdio: Add a driver for the Amlogic Meson8 and Meson8b SoC")
Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---
 drivers/mmc/host/meson-mx-sdio.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mmc/host/meson-mx-sdio.c b/drivers/mmc/host/meson-mx-sdio.c
index d4a48916bfb6..3a19a05ef55a 100644
--- a/drivers/mmc/host/meson-mx-sdio.c
+++ b/drivers/mmc/host/meson-mx-sdio.c
@@ -662,6 +662,11 @@ static int meson_mx_mmc_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		ret = irq;
+		goto error_free_mmc;
+	}
+
 	ret = devm_request_threaded_irq(host->controller_dev, irq,
 					meson_mx_mmc_irq,
 					meson_mx_mmc_irq_thread, IRQF_ONESHOT,
-- 
2.26.3

