Return-Path: <SRS0=hS93=AV=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18413C433E0
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Jul 2020 11:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6CFD2077D
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Jul 2020 11:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pvyejGdj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgGJLKC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 10 Jul 2020 07:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbgGJLKB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 10 Jul 2020 07:10:01 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD0EC08C5CE;
        Fri, 10 Jul 2020 04:10:01 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id e18so2392210pgn.7;
        Fri, 10 Jul 2020 04:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BZxklyfbFjwycZmQoHtOvFDmfd5AMpO1Q2JX3/+fCok=;
        b=pvyejGdj/dmYs6plL0dYgkkAZTOXDXjujnAdH+JWsZRUGjbXUu3Uko24HxPrJBdqat
         aB0rXNsWAr7Pioc9nxQvES150TJJ5D4I2thRjwS/lV8ySMmsGlMdOC6alGQHR8ROPHqz
         zTCTccVQAnuFuEkzlaASPefmTcfvEy7md2P6n1D8TFBePCnpzBlh48yhhDQFtu8jJ3KZ
         T2tLkQF4jFsrQjIzzi4QuSmnJ4FynFkYEJYyY/iUcrq4BaSWes2ZyppOwHPFVdzN3AZu
         +ryS9ripmNncd44fjqOYrZeVUIky0Z4Wzb2kEU91pQiN5xGvJbkogLeZiYlbDUGwVdaD
         aLLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BZxklyfbFjwycZmQoHtOvFDmfd5AMpO1Q2JX3/+fCok=;
        b=O1MbiOJ1ZPGCNodSWtZ29R8KPrYKtzlIqbdaNUJ3Bfi5KWAsPnj+46DWJpaDvNwtAW
         Rhsqgxre7aCQomPKO1sPintoGy7q4BNVT3BjFII+R/8SsdzNO7d17ZHoOVcFo3jvJ0+P
         paJQLOtkN56ft+2nu9I1RcROTjPAaSMUQM7reiE7h9RxjElOPlfd1Y0dRZ/yJO0fj725
         hwW+oRKU9LtOx+8Ty9J6a/YEE91PAN/FzuVP/xDrM6aX/HjrFbeU9qhJLMRmahLhOV0y
         C+tSxf0CkvLh9JSmdPa3Z0mQPynz4TM2gj+9bGLZ1K7TaByQZ7/UxzidtVOfVm3Pd3Vc
         VMbA==
X-Gm-Message-State: AOAM533d11zrvQDQt3bLzbFGUYW9XLf+LW7VB1jVNXdvSwuTtES3B9h8
        bBePWpTrR5PR4/qZtMCZUstSv0/w
X-Google-Smtp-Source: ABdhPJxXFtlTLad17FUpQo+DemvmoR9Qd6xH7xe2ehhYdAG8Du9ZkfDrBj/K04SfqGHpRScVG7wmTQ==
X-Received: by 2002:a63:e00c:: with SMTP id e12mr58217885pgh.413.1594379401209;
        Fri, 10 Jul 2020 04:10:01 -0700 (PDT)
Received: from gli-arch.genesyslogic.com.tw (60-251-58-169.HINET-IP.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id x8sm5437293pfn.61.2020.07.10.04.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 04:10:00 -0700 (PDT)
From:   Ben Chuang <benchuanggli@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        greg.tu@genesyslogic.com.tw, Ben Chuang <benchuanggli@gmail.com>
Subject: [RFC PATCH V3 11/21] mmc: sdhci: UHS-II support, export host operations to core
Date:   Fri, 10 Jul 2020 19:10:44 +0800
Message-Id: <20200710111044.29509-1-benchuanggli@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: AKASHI Takahiro <takahiro.akashi@linaro.org>

Export sdhci-specific UHS-II operations to core.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 drivers/mmc/host/sdhci.c | 70 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index c2f6923d296c..aaf41954511a 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2977,6 +2977,70 @@ static void sdhci_card_event(struct mmc_host *mmc)
 	spin_unlock_irqrestore(&host->lock, flags);
 }
 
+#if IS_ENABLED(CONFIG_MMC_SDHCI_UHS2)
+static int sdhci_uhs2_detect_init(struct mmc_host *mmc)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	int ret;
+
+	if (sdhci_uhs2_ops.do_detect_init)
+		ret = sdhci_uhs2_ops.do_detect_init(host);
+	else
+		return 0;
+
+	return ret;
+}
+
+static int sdhci_uhs2_set_reg(struct mmc_host *mmc, enum uhs2_act act)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	int ret;
+
+	if (sdhci_uhs2_ops.do_set_reg)
+		ret = sdhci_uhs2_ops.do_set_reg(host, act);
+	else
+		ret = 0;
+
+	return ret;
+}
+
+static void sdhci_uhs2_disable_clk(struct mmc_host *mmc)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	u16 clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+
+	clk &= ~SDHCI_CLOCK_CARD_EN;
+	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+}
+
+static void sdhci_uhs2_enable_clk(struct mmc_host *mmc)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	u16 clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+	ktime_t timeout;
+
+	clk |= SDHCI_CLOCK_CARD_EN;
+	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+
+	/* Wait max 20 ms */
+	timeout = ktime_add_ms(ktime_get(), 20);
+	while (1) {
+		bool timedout = ktime_after(ktime_get(), timeout);
+
+		clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+		if (clk & SDHCI_CLOCK_INT_STABLE)
+			break;
+		if (timedout) {
+			pr_err("%s: Internal clock never stabilised.\n",
+			       mmc_hostname(host->mmc));
+			sdhci_dumpregs(host);
+			return;
+		}
+		udelay(10);
+	}
+}
+#endif /* CONFIG_MMC_SDHCI_UHS2 */
+
 static const struct mmc_host_ops sdhci_ops = {
 	.request	= sdhci_request,
 	.post_req	= sdhci_post_req,
@@ -2992,6 +3056,12 @@ static const struct mmc_host_ops sdhci_ops = {
 	.execute_tuning			= sdhci_execute_tuning,
 	.card_event			= sdhci_card_event,
 	.card_busy	= sdhci_card_busy,
+#if IS_ENABLED(CONFIG_MMC_SDHCI_UHS2)
+	.uhs2_detect_init	= sdhci_uhs2_detect_init,
+	.uhs2_set_reg		= sdhci_uhs2_set_reg,
+	.uhs2_disable_clk	= sdhci_uhs2_disable_clk,
+	.uhs2_enable_clk	= sdhci_uhs2_enable_clk,
+#endif /* CONFIG_MMC_SDHCI_UHS2 */
 };
 
 /*****************************************************************************\
-- 
2.27.0

