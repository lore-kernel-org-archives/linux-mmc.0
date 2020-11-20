Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC83C64E75
	for <linux-mmc@archiver.kernel.org>; Fri, 20 Nov 2020 03:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0FD8222C8
	for <linux-mmc@archiver.kernel.org>; Fri, 20 Nov 2020 03:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="QSQT9GTq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbgKTD1K (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 19 Nov 2020 22:27:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727300AbgKTD1K (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Nov 2020 22:27:10 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A2FC0613CF
        for <linux-mmc@vger.kernel.org>; Thu, 19 Nov 2020 19:27:08 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id b17so8529567ljf.12
        for <linux-mmc@vger.kernel.org>; Thu, 19 Nov 2020 19:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fqn08+QfMXXA0wyLDJZny72GR+5yc4I41ZsdzMIQxEI=;
        b=QSQT9GTqnDt2d59Jscrlg1jfUicDIQxu4P6sOB+YstjUJsDDTUv5VQQYJA8QRKjt3+
         n5hOOzT2w6WoMNH2yPji10UInHviBo1xSK5yux/QosPm40BRVa+4dkJ6PI8WHcAEIBHy
         g6vYjx3r+5SW8QoH9SrmY2YwgSmrgXnXXPB6rgDYk6hIvCfvI/fUKspLwKfhCV0lOb8B
         /Z52P+fDY0RvamChMgho3pc3xL0OwpdWodl4vgN0wT+ANxfsrTsZSnlfZV+RUYdVHFTv
         BnoqfY/bkCnc/74/iWjI7QnzSXY0OqLS5H7GTLLmQXso1TzqEUj01t7L6nrS2/YZ24Nd
         9RSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fqn08+QfMXXA0wyLDJZny72GR+5yc4I41ZsdzMIQxEI=;
        b=j1I17rnZZgKqJ1xRoMFundFMVJ92In7D/tcHbXil1jxFFky6R+eEkN5vPp1k1INIFL
         mB1wn2hk5a+gbXLKEzQsqhJTaf6cmSmgIe+FGyCwTL2A5KZKvNVgnbCauNMwnuHmdrYw
         ykwpx9zfgOpR07OIHqg5YyOmokXWgBIhfpCR8RwzEkqPscLNDrHEqnAPlfp5h7PVHapg
         q5YS1TU3UNP4fR4ydYTRAhAEZylTM7dhZBN1oTBatfRTioeDyp50blOqCAdTPE4qVCCh
         Vx39vhIchHlZuD/nVs4wPghjJTpL3RQ3/HXGviPQGJ2tKtOx4rq6xsZAfj1NOE+mKh1j
         ReOA==
X-Gm-Message-State: AOAM5332+GkvrH10FW4nRTXNR79ZHSUdnmoKukK9xFZ7gkoHpolyNsNZ
        HnSUkCxhgSrmaAecOfJgI0I1CJNSHg57FPx+
X-Google-Smtp-Source: ABdhPJxTs4t98C90I5qm0dbb3G80E/eQ8N7BnPM3lQeJgjr6k+T3T8OBpKGGm5LGmYH/us7HDgRRPw==
X-Received: by 2002:a2e:b0c4:: with SMTP id g4mr7327273ljl.20.1605842826727;
        Thu, 19 Nov 2020 19:27:06 -0800 (PST)
Received: from gilgamesh.semihalf.com (193-106-246-138.noc.fibertech.net.pl. [193.106.246.138])
        by smtp.gmail.com with ESMTPSA id s26sm153647lji.31.2020.11.19.19.27.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Nov 2020 19:27:06 -0800 (PST)
From:   Marcin Wojtas <mw@semihalf.com>
To:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc:     ulf.hansson@linaro.org, huziji@marvell.com,
        adrian.hunter@intel.com, jaz@semihalf.com, tn@semihalf.com,
        ard.biesheuvel@arm.com, kostap@marvell.com,
        Marcin Wojtas <mw@semihalf.com>
Subject: [PATCH v2 4/4] mmc: sdhci-xenon: introduce ACPI support
Date:   Fri, 20 Nov 2020 04:26:39 +0100
Message-Id: <20201120032639.24386-5-mw@semihalf.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201120032639.24386-1-mw@semihalf.com>
References: <20201120032639.24386-1-mw@semihalf.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Previous patches dropped the strict dependency on the OF_*
in the sdhci-xenon driver. As a result the ACPI support
can be introduced (except for the XENON_A3700 variant)
by adding the necessary ID's in the acpi_match_table.

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
---
 drivers/mmc/host/sdhci-xenon.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
index dfc3b5f62a6d..6d4f588d4c11 100644
--- a/drivers/mmc/host/sdhci-xenon.c
+++ b/drivers/mmc/host/sdhci-xenon.c
@@ -11,6 +11,7 @@
  * Special thanks to Video BG4 project team.
  */
 
+#include <linux/acpi.h>
 #include <linux/delay.h>
 #include <linux/ktime.h>
 #include <linux/module.h>
@@ -698,11 +699,22 @@ static const struct of_device_id sdhci_xenon_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, sdhci_xenon_dt_ids);
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id sdhci_xenon_acpi_ids[] = {
+	{ .id = "MRVL0002", XENON_AP806},
+	{ .id = "MRVL0003", XENON_AP807},
+	{ .id = "MRVL0004", XENON_CP110},
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, sdhci_xenon_acpi_ids);
+#endif
+
 static struct platform_driver sdhci_xenon_driver = {
 	.driver	= {
 		.name	= "xenon-sdhci",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = sdhci_xenon_dt_ids,
+		.acpi_match_table = ACPI_PTR(sdhci_xenon_acpi_ids),
 		.pm = &sdhci_xenon_dev_pm_ops,
 	},
 	.probe	= xenon_probe,
-- 
2.29.0

