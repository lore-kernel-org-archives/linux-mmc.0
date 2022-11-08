Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8964C433FE
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Nov 2022 08:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbiKHI0z (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 8 Nov 2022 03:26:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233530AbiKHI0r (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Nov 2022 03:26:47 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 96CA627B11
        for <linux-mmc@vger.kernel.org>; Tue,  8 Nov 2022 00:26:44 -0800 (PST)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 08 Nov 2022 17:25:40 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id A2DAD20584CE;
        Tue,  8 Nov 2022 17:25:40 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 8 Nov 2022 17:25:40 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 6A655B62A4;
        Tue,  8 Nov 2022 17:25:40 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Jassi Brar <jaswinder.singh@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 4/4] mmc: f-sdh30: Add compatible string for Socionext F_SDH30_E51
Date:   Tue,  8 Nov 2022 17:25:33 +0900
Message-Id: <20221108082533.21384-5-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221108082533.21384-1-hayashi.kunihiko@socionext.com>
References: <20221108082533.21384-1-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add compatible string for Socionext F_SDH30_E51. Currently there are
no new features for this IP, just add it.

And add missing Copyright and MODULE_AUTHOR.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/mmc/host/sdhci_f_sdh30.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/sdhci_f_sdh30.c b/drivers/mmc/host/sdhci_f_sdh30.c
index af30343eaf33..2643ae97b2e7 100644
--- a/drivers/mmc/host/sdhci_f_sdh30.c
+++ b/drivers/mmc/host/sdhci_f_sdh30.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2013 - 2015 Fujitsu Semiconductor, Ltd
  *              Vincent Yang <vincent.yang@tw.fujitsu.com>
  * Copyright (C) 2015 Linaro Ltd  Andy Green <andy.green@linaro.org>
+ * Copyright (C) 2019 Socionext Inc.
  */
 
 #include <linux/acpi.h>
@@ -228,6 +229,7 @@ static int sdhci_f_sdh30_remove(struct platform_device *pdev)
 #ifdef CONFIG_OF
 static const struct of_device_id f_sdh30_dt_ids[] = {
 	{ .compatible = "fujitsu,mb86s70-sdhci-3.0" },
+	{ .compatible = "socionext,f-sdh30-e51-mmc" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, f_sdh30_dt_ids);
@@ -258,4 +260,5 @@ module_platform_driver(sdhci_f_sdh30_driver);
 MODULE_DESCRIPTION("F_SDH30 SD Card Controller driver");
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("FUJITSU SEMICONDUCTOR LTD.");
+MODULE_AUTHOR("Socionext Inc.");
 MODULE_ALIAS("platform:f_sdh30");
-- 
2.25.1

