Return-Path: <SRS0=bHgK=EO=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BEE4C388F9
	for <linux-mmc@archiver.kernel.org>; Sun,  8 Nov 2020 15:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32147206F4
	for <linux-mmc@archiver.kernel.org>; Sun,  8 Nov 2020 15:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n0PXC9h6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbgKHPAz (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 8 Nov 2020 10:00:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgKHPAy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 8 Nov 2020 10:00:54 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD784C0613CF
        for <linux-mmc@vger.kernel.org>; Sun,  8 Nov 2020 07:00:54 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id t6so3283311plq.11
        for <linux-mmc@vger.kernel.org>; Sun, 08 Nov 2020 07:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=VuE+LGxedlZO1VHs76LPL0zM1ge+G1qv/1y/hiJxwjU=;
        b=n0PXC9h6ZNFMNnq0V2Po4o2i+zny9muRlC4E/HAFPLIKPvFQLr06lm7VGBTGsUTqaU
         uXFo/PzqoIs+jtG1dlySUe6xLc0BzdwKU6UPqA24UfJTOCJKYt1/3rF+erFqYhuo6yYY
         5xsiL9pc+XnIHABEHh7gMKhf8Y2UikC3tH5kI2w1bcOddl72UllraKZOrNBz8iQoi+bH
         IKePBp16jV3fe17AehwkBTVocU+iI6laWNtGbZLkMjgAQc8KJqDsP1HN0Awje9tkaxxC
         /llqgGDDSj1kq8xL8X0bGhoSHO5aJ7APxiE4rAFhAhB75/Dpi/MSwkJ9M9Nxs+QLrKeZ
         YBGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VuE+LGxedlZO1VHs76LPL0zM1ge+G1qv/1y/hiJxwjU=;
        b=d7T5ZbHj6Siog5Qw8iwdQij3xZ95rzWYQQlvDIvNPSUpfYRwiXzcDPtZODho6FhsjJ
         E5tKn7OOj4yMPe0JXOiXjoaJWgc60hE/mFq2KYWS4NDHhGmYFOXovndYvm/VdMrNFIXo
         y0UE4JeSRXUgcngUp34w7+lmQPOzBY/nZl6x6pw6LxSiosTPeVjVLC0KK93yGFax+lr4
         r+mL+tEwyKZxQinH/BqVm4VVVZ6FasMXE89AjLwjWKtuR+ZQQLpQKd2YJxf254z9q+dD
         aWMxWBR/G4iOL9xNhSe7iRhA80R4f7x3Cy7dniAOBBWrcUkt0iivUFEpx+1wmsXzNnvc
         BcWw==
X-Gm-Message-State: AOAM531wB4qU8Glat8/H0tKWoXXZvp2vcqr5WKY39JV96z+SEAyOtVXo
        d+g54g+4z0iEOeQoJWFwLfhBCDJjGJiq
X-Google-Smtp-Source: ABdhPJz2+C52SpiSGTiS7Wx3XUlaoAyJsNhtcqsZaiAipjpsSGRJhOAyRP5qswSuMAy7fh/igVhKXQ==
X-Received: by 2002:a17:902:d30c:b029:d6:8208:bb1 with SMTP id b12-20020a170902d30cb02900d682080bb1mr9138808plc.44.1604847654249;
        Sun, 08 Nov 2020 07:00:54 -0800 (PST)
Received: from he-cluster.localdomain (67.216.221.250.16clouds.com. [67.216.221.250])
        by smtp.gmail.com with ESMTPSA id u10sm8547417pfn.101.2020.11.08.07.00.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Nov 2020 07:00:53 -0800 (PST)
From:   xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To:     adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH] mmc: sdhci: Make pic32_sdhci_probe_platform() void
Date:   Sun,  8 Nov 2020 23:00:48 +0800
Message-Id: <1604847648-13036-1-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Kaixu Xia <kaixuxia@tencent.com>

pic32_sdhci_probe_platform() always returned 0, so there's no reason for
a return value.  In addition, pic32_sdhci_probe() checked the return value
for possible error which is unnecessary.

Convert pic32_sdhci_probe_platform() to a void function and remove the
return value check. Fix the following Coccinelle warning:

./drivers/mmc/host/sdhci-pic32.c:127:5-8: Unneeded variable: "ret". Return "0" on line 137

Reported-by: Tosk Robot <tencent_os_robot@tencent.com>
Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
 drivers/mmc/host/sdhci-pic32.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pic32.c b/drivers/mmc/host/sdhci-pic32.c
index 6ce1519ae177..6696b6bdd88e 100644
--- a/drivers/mmc/host/sdhci-pic32.c
+++ b/drivers/mmc/host/sdhci-pic32.c
@@ -121,10 +121,9 @@ static void pic32_sdhci_shared_bus(struct platform_device *pdev)
 	writel(bus, host->ioaddr + SDH_SHARED_BUS_CTRL);
 }
 
-static int pic32_sdhci_probe_platform(struct platform_device *pdev,
+static void pic32_sdhci_probe_platform(struct platform_device *pdev,
 				      struct pic32_sdhci_priv *pdata)
 {
-	int ret = 0;
 	u32 caps_slot_type;
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 
@@ -133,8 +132,6 @@ static int pic32_sdhci_probe_platform(struct platform_device *pdev,
 	caps_slot_type = (host->caps & SDH_CAPS_SDH_SLOT_TYPE_MASK) >> 30;
 	if (caps_slot_type == SDH_SLOT_TYPE_SHARED_BUS)
 		pic32_sdhci_shared_bus(pdev);
-
-	return ret;
 }
 
 static int pic32_sdhci_probe(struct platform_device *pdev)
@@ -193,11 +190,7 @@ static int pic32_sdhci_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_base_clk;
 
-	ret = pic32_sdhci_probe_platform(pdev, sdhci_pdata);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to probe platform!\n");
-		goto err_base_clk;
-	}
+	pic32_sdhci_probe_platform(pdev, sdhci_pdata);
 
 	ret = sdhci_add_host(host);
 	if (ret)
-- 
2.20.0

