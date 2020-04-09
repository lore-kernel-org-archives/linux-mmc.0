Return-Path: <SRS0=EyEY=5Z=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D3C1C2BA2B
	for <linux-mmc@archiver.kernel.org>; Thu,  9 Apr 2020 12:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D1162078E
	for <linux-mmc@archiver.kernel.org>; Thu,  9 Apr 2020 12:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DyL+LdxQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgDIMy3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 9 Apr 2020 08:54:29 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36024 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbgDIMy3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Apr 2020 08:54:29 -0400
Received: by mail-lj1-f195.google.com with SMTP id b1so11357609ljp.3
        for <linux-mmc@vger.kernel.org>; Thu, 09 Apr 2020 05:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AQ/aQRH3LCE5gpQTa4UpjP+P8PdojvoToFQt58CO2SQ=;
        b=DyL+LdxQXdgjX6UF4nai/ilp4Qau4QxLusGPk7R3RPojNh6jNU8+4bC8E4TG7YMEwM
         BAUPLzWfVtYStWvFfeazmvCjhVYQjex1PsNBToC7IxE4PZNUjVtL0ymjo7RxG0F2rHze
         SOGR/yZAR2vywMlqAJfZl2Zqd6X9IQuP4rXuKFcXriJHd9ONnIkCyM7BHcIBveIVttW+
         98tbrUWMMCcEayRcE36xrCHdgNQNa3VCJXZygIKe7H06mET/Qc/BkcIctfxez8E4gbUC
         9PQD9LGz7B43m9NzxlWCZrRk3UuJdLXUr/6GbLxDGd3a8p7DYsBmo03IYxlOkG8jJmdL
         21ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AQ/aQRH3LCE5gpQTa4UpjP+P8PdojvoToFQt58CO2SQ=;
        b=B5jmIqfmGY3eGj49Hajd0PzeuN0uI0JpXb+JYtA/6yOKSQe8yahgjyBFhDmFiyTA4t
         HCArak9bYmPWX2bYNR2VElM/iNfrRlhyzIANZLBmymzEdTEgY+ZGChM4udBNeKc5Vcgm
         uY5qc4aD7/3L/JJNp12wGWO6XmXyl1TroiHAaquU3iIp3CbamAESrrY8b47bs7y723cq
         Rp0sI+5tT+QIYuIWDwvmGjGJDqKC1EzYd1PXUcNLQ297njbe8GtN25MOfBK5nE8ALsFJ
         9Pwp8uelyPT8QyDjVpB4N4w+jvDyUIYapQUBjuOsk8frSBHuISoXnK4PzXgHhYToam5r
         FRZg==
X-Gm-Message-State: AGi0PuaSKwPiMUQAyuf/aXhODbAEiYxLu5FxJm9/y6UQ7yYaTAiO/d7c
        9WL5IATE7PIDCpsbHEitvY+YFSAds74=
X-Google-Smtp-Source: APiQypJnaS7moxjWVcXv3vfdEFDpuEw+zgSDhGoiD6Rct8JNwZt8v07tNN2uUaIByWsfgn3pRXHZoQ==
X-Received: by 2002:a2e:a412:: with SMTP id p18mr8440329ljn.39.1586436867261;
        Thu, 09 Apr 2020 05:54:27 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-131.NA.cust.bahnhof.se. [98.128.181.131])
        by smtp.gmail.com with ESMTPSA id x67sm690205lfa.76.2020.04.09.05.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 05:54:26 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Pierre Ossman <pierre@ossman.eu>
Subject: [PATCH] mmc: wbsd: Replace hardcoded command numbers with existing defines
Date:   Thu,  9 Apr 2020 14:54:22 +0200
Message-Id: <20200409125422.21842-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/wbsd.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/wbsd.c b/drivers/mmc/host/wbsd.c
index 740179f42cf2..67f917d6ecd3 100644
--- a/drivers/mmc/host/wbsd.c
+++ b/drivers/mmc/host/wbsd.c
@@ -28,6 +28,8 @@
 #include <linux/pnp.h>
 #include <linux/highmem.h>
 #include <linux/mmc/host.h>
+#include <linux/mmc/mmc.h>
+#include <linux/mmc/sd.h>
 #include <linux/scatterlist.h>
 #include <linux/slab.h>
 
@@ -770,22 +772,22 @@ static void wbsd_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		 * interrupts.
 		 */
 		switch (cmd->opcode) {
-		case 11:
-		case 17:
-		case 18:
-		case 20:
-		case 24:
-		case 25:
-		case 26:
-		case 27:
-		case 30:
-		case 42:
-		case 56:
+		case SD_SWITCH_VOLTAGE:
+		case MMC_READ_SINGLE_BLOCK:
+		case MMC_READ_MULTIPLE_BLOCK:
+		case MMC_WRITE_DAT_UNTIL_STOP:
+		case MMC_WRITE_BLOCK:
+		case MMC_WRITE_MULTIPLE_BLOCK:
+		case MMC_PROGRAM_CID:
+		case MMC_PROGRAM_CSD:
+		case MMC_SEND_WRITE_PROT:
+		case MMC_LOCK_UNLOCK:
+		case MMC_GEN_CMD:
 			break;
 
 		/* ACMDs. We don't keep track of state, so we just treat them
 		 * like any other command. */
-		case 51:
+		case SD_APP_SEND_SCR:
 			break;
 
 		default:
-- 
2.20.1

