Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD48AC7EE25
	for <linux-mmc@archiver.kernel.org>; Thu,  8 Jun 2023 19:45:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjFHTpo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 8 Jun 2023 15:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjFHTpo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Jun 2023 15:45:44 -0400
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D0F210D
        for <linux-mmc@vger.kernel.org>; Thu,  8 Jun 2023 12:45:43 -0700 (PDT)
Received: from localhost.localdomain (31.173.86.116) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Thu, 8 Jun 2023
 22:45:35 +0300
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
To:     Ulf Hansson <ulf.hansson@linaro.org>, <linux-mmc@vger.kernel.org>
CC:     Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 02/12] mmc: meson-gx: fix deferred probing
Date:   Thu, 8 Jun 2023 22:45:09 +0300
Message-ID: <20230608194519.10665-3-s.shtylyov@omp.ru>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20230608194519.10665-1-s.shtylyov@omp.ru>
References: <20230608194519.10665-1-s.shtylyov@omp.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [31.173.86.116]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.59, Database issued on: 06/08/2023 19:29:53
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 19
X-KSE-AntiSpam-Info: Lua profiles 177946 [Jun 08 2023]
X-KSE-AntiSpam-Info: Version: 5.9.59.0
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 516 516 efd4d74ff4b68f90ca62ae34a19f27bf46d81db5
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_no_received}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.86.116 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.86.116 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info: 31.173.86.116:7.1.2;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 31.173.86.116
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 19
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/08/2023 19:36:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 6/8/2023 5:02:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The driver overrides the error codes and IRQ0 returned by platform_get_irq()
to -EINVAL, so if it returns -EPROBE_DEFER, the driver will fail the probe
permanently instead of the deferred probing. Switch to propagating the error
codes upstream.  IRQ0 is no longer returned by platform_get_irq(), so we now
can safely ignore it...

Fixes: cbcaac6d7dd2 ("mmc: meson-gx-mmc: Fix platform_get_irq's error checking")
Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---
Changes in version 2:
- updated the fix due to the surrounding code change;
- refreshed the patch;
- removed stray newline in the Fixes: tag;
- slightly reformatted the patch description.

 drivers/mmc/host/meson-gx-mmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index b8514d9d5e73..75f97dce7ef3 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -1192,8 +1192,8 @@ static int meson_mmc_probe(struct platform_device *pdev)
 		return PTR_ERR(host->regs);
 
 	host->irq = platform_get_irq(pdev, 0);
-	if (host->irq <= 0)
-		return -EINVAL;
+	if (host->irq < 0)
+		return host->irq;
 
 	cd_irq = platform_get_irq_optional(pdev, 1);
 	mmc_gpio_set_cd_irq(mmc, cd_irq);
-- 
2.26.3

