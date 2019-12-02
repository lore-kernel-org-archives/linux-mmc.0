Return-Path: <SRS0=vSIZ=ZY=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E4BC432C0
	for <linux-mmc@archiver.kernel.org>; Mon,  2 Dec 2019 14:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 188D620718
	for <linux-mmc@archiver.kernel.org>; Mon,  2 Dec 2019 14:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Oh/2eLfC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfLBOlY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 2 Dec 2019 09:41:24 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39567 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727362AbfLBOlY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Dec 2019 09:41:24 -0500
Received: by mail-pg1-f193.google.com with SMTP id b137so16133201pga.6
        for <linux-mmc@vger.kernel.org>; Mon, 02 Dec 2019 06:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=w/Mrna2Khv21UvkkLKLf8+wkF9y7ELMmGnTl9xg6qEs=;
        b=Oh/2eLfC0XDRjQkZGpdyye7rIWda5/CX+OOdOlDtTTmlKYcc4Z151RrD0lgc6af+/P
         bDdjFqmEP9MYR9GDEMe8IgNDbrik5/U+h2iT92/LhRs0vDQW/CPTXti5P1iwUIG7H3nP
         Lus0lG/bCoI6DuRRj4vJSP3PbzRNsOoP7RpxmTNrYLUwyXlDVSVj3zXTuc7A56WKF++o
         2PRXYmECjryOUJsG+i4uOxe/QnTbDcxPTPSCFHNyl0wlk6UD6PzecAWDKLpK4+6ZRpPX
         piR8gEa8pEBGlmbVXmuRwK4rDFGKcnzM3oUCO/cJolALucf6uH9U8ehH0RK8IjHv91Mg
         sikA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=w/Mrna2Khv21UvkkLKLf8+wkF9y7ELMmGnTl9xg6qEs=;
        b=oPI3XQbbkYqNgvfmafaXU0cvNgRdK0HT6UroDJEo6GfiMt6P5TIwPTXEJAL7Eq0yLT
         qga2379X7kjKFQE20HU63LayVx+4QZJfldxABzo/1Zgp/n+Q6HECQFGtwZslJjcr5gB8
         sv7WZbvVNaOWhHR9Jn4iwF+Nh1xkRHsWK4q1uiKfoubALJSfpp+p/aFwXEnUrypDpmLK
         zGU0ThAuQXCq3bNMY3BZKqNwzd+ze+j01bbGaoeSUnubiJUeCN3gexNloB2C9d3saMQA
         NMkX2h8Z+6H6IPGqF8JSZLpfZJjBbib4Bwn+WcD0KnJI6HVyX2H7FEqIZPg7W5Y1x1DI
         rYbg==
X-Gm-Message-State: APjAAAVuJKOBQzSZGIvYW1Aa50nBCxZzy27Xrzbd6k8yxdvOizvIADau
        LQPK/Bmx6YHHUJOTnEkIfWtQeQ==
X-Google-Smtp-Source: APXvYqznAknYoi41MG6MIjzLzXVsivc5YQY7oG+bjnezRmsZh0eylJSvbqibyZiX/Ebx6EoUmXZMzg==
X-Received: by 2002:aa7:91c7:: with SMTP id z7mr73521893pfa.111.1575297683922;
        Mon, 02 Dec 2019 06:41:23 -0800 (PST)
Received: from localhost.localdomain (li519-153.members.linode.com. [66.175.222.153])
        by smtp.gmail.com with ESMTPSA id f30sm33985090pga.20.2019.12.02.06.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 06:41:23 -0800 (PST)
From:   Jun Nie <jun.nie@linaro.org>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 1/4] mmc: sdhci: Add delay after power off
Date:   Mon,  2 Dec 2019 22:41:01 +0800
Message-Id: <20191202144104.5069-2-jun.nie@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191202144104.5069-1-jun.nie@linaro.org>
References: <20191202144104.5069-1-jun.nie@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add delay after power off to ensure that full power cycle is
successful. Otherwise, some controllers, at lease for Hisilicon
eMMC controller, may not be unstable sometimes for full power
cycle operation.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 drivers/mmc/host/sdhci.c | 7 +++++++
 drivers/mmc/host/sdhci.h | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 3140fe2e5dba..a654f0aeb438 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1761,6 +1761,13 @@ void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
 		sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
 		if (host->quirks2 & SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON)
 			sdhci_runtime_pm_bus_off(host);
+
+		/*
+		 * Some controllers need an extra 100ms delay to secure
+		 * full power cycle is successful.
+		 */
+		if (host->quirks2 & SDHCI_QUIRK2_DELAY_AFTER_POWER_OFF)
+			msleep(100);
 	} else {
 		/*
 		 * Spec says that we should clear the power reg before setting
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 0ed3e0eaef5f..0e6f97eaa796 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -482,6 +482,8 @@ struct sdhci_host {
  * block count.
  */
 #define SDHCI_QUIRK2_USE_32BIT_BLK_CNT			(1<<18)
+/* Controllers need an extra 100ms delay to make sure power off completely */
+#define SDHCI_QUIRK2_DELAY_AFTER_POWER_OFF		(1<<19)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
2.17.1

