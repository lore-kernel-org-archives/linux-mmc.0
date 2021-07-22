Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00793C6377E
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Jul 2021 04:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE8C461222
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Jul 2021 04:02:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbhGVDWB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 21 Jul 2021 23:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbhGVDVq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Jul 2021 23:21:46 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AD2C0613C1;
        Wed, 21 Jul 2021 21:02:21 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id y3so3013123plp.4;
        Wed, 21 Jul 2021 21:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CQfXFdO5AEIdfPufawPvgOpW6II+HeJ1KkO9+iMXy5s=;
        b=IdlQMfton5ZPJks2yC6JdkJWks1ukLPO7xQFbAEzBKz/VRo3YhyBC4zb5xF7jMrSzB
         LhcyVlUckRU0G9MQ9RMwvckGShxysJCqGV7XPBTVkaojMNSzr/V54+T+pA/iVT8lXcD+
         kNmW44RqdhfOJUsHxH/S7O6xp6RDlxzKebO4Z0bULyr5jXEqUH1mxuucLU2j4fGCsGr3
         2Mvze2hNG/OeEc2zIZqGFWxsBwotRE4e83E0WA+r4TLiyDe9Sht1LgWldiAHMZIRRY/M
         79GGfCUxR9bD0DOfauxGqAmJ21D9r/QuTouAEqzwVQdnIwatJGIggQZ2fPv0uikMLQ4a
         7HHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CQfXFdO5AEIdfPufawPvgOpW6II+HeJ1KkO9+iMXy5s=;
        b=UknSLOFzgN0WEZcM4JRmIMV4W8CZ8a6LusGfAgcDLIpUKsriW5/ZeLzAqKK+JbOKcH
         dpw54nAurI30Y1d2wVv+g1WvzsKGt0EDtqu51UKJLpYLQ1lg97rdk2NqGdwuPIekx2xG
         Ccb8emTXX8NMNNDcanZU5BT+tm8Cdh7XmCiEhgPvtri2clfNwOLT3+BWfqZjK8b1Do3l
         G/VywuwfMP1UsChKRcjRd7RuREPRoxm6gYg/Q2pRDRBGuJGVnb+oO7k0sO2NDOUFZ3we
         pU0He9xZsf/a/GDiPSb1OeUC3ABglG0quVwbNZ1LYG/YIsLQB8Vad/15WZPqw87juGTK
         5+9g==
X-Gm-Message-State: AOAM532WqCwm2c3izlqYppz7ADnS9gn4tDdppQr0a1de6+ZWiErEDQmE
        m+idPewyFzRJl4LmxuE9nbk=
X-Google-Smtp-Source: ABdhPJzMe7vGkNEmv+sRfdgqQ9q9YzeTSh7yKMJWvS426JSLU13gVa+/4EopqHpAl60tHOmzNjS1ww==
X-Received: by 2002:a63:dd46:: with SMTP id g6mr15211013pgj.347.1626926540968;
        Wed, 21 Jul 2021 21:02:20 -0700 (PDT)
Received: from jason-z170xgaming7.mshome.net (218-35-143-223.cm.dynamic.apol.com.tw. [218.35.143.223])
        by smtp.gmail.com with ESMTPSA id c19sm1663479pfp.184.2021.07.21.21.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 21:02:20 -0700 (PDT)
From:   Jason Lai <jasonlai.genesyslogic@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        jason.lai@genesyslogiv.com.tw,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC PATCH v3.2 15/29] mmc: sdhci-uhs2: add set_timeout()
Date:   Thu, 22 Jul 2021 12:01:10 +0800
Message-Id: <20210722040124.7573-15-jasonlai.genesyslogic@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210722040124.7573-1-jasonlai.genesyslogic@gmail.com>
References: <20210722040124.7573-1-jasonlai.genesyslogic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This is a UHS-II version of sdhci's set_timeout() operation.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 drivers/mmc/host/sdhci-uhs2.c | 85 +++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-uhs2.h |  1 +
 2 files changed, 86 insertions(+)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index 1eca89359351..d9e98c097bfe 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -178,6 +178,91 @@ void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode,
 }
 EXPORT_SYMBOL_GPL(sdhci_uhs2_set_power);

+static u8 sdhci_calc_timeout_uhs2(struct sdhci_host *host, u8 *cmd_res,
+				  u8 *dead_lock)
+{
+	u8 count;
+	unsigned int cmd_res_timeout, dead_lock_timeout, current_timeout;
+
+	/*
+	 * If the host controller provides us with an incorrect timeout
+	 * value, just skip the check and use 0xE.  The hardware may take
+	 * longer to time out, but that's much better than having a too-short
+	 * timeout value.
+	 */
+	if (host->quirks & SDHCI_QUIRK_BROKEN_TIMEOUT_VAL) {
+		*cmd_res = 0xE;
+		*dead_lock = 0xE;
+		return 0xE;
+	}
+
+	/* timeout in us */
+	cmd_res_timeout = 5 * 1000;
+	dead_lock_timeout = 1 * 1000 * 1000;
+
+	/*
+	 * Figure out needed cycles.
+	 * We do this in steps in order to fit inside a 32 bit int.
+	 * The first step is the minimum timeout, which will have a
+	 * minimum resolution of 6 bits:
+	 * (1) 2^13*1000 > 2^22,
+	 * (2) host->timeout_clk < 2^16
+	 *     =>
+	 *     (1) / (2) > 2^6
+	 */
+	count = 0;
+	current_timeout = (1 << 13) * 1000 / host->timeout_clk;
+	while (current_timeout < cmd_res_timeout) {
+		count++;
+		current_timeout <<= 1;
+		if (count >= 0xF)
+			break;
+	}
+
+	if (count >= 0xF) {
+		DBG("%s: Too large timeout 0x%x requested for CMD_RES!\n",
+		    mmc_hostname(host->mmc), count);
+		count = 0xE;
+	}
+	*cmd_res = count;
+
+	count = 0;
+	current_timeout = (1 << 13) * 1000 / host->timeout_clk;
+	while (current_timeout < dead_lock_timeout) {
+		count++;
+		current_timeout <<= 1;
+		if (count >= 0xF)
+			break;
+	}
+
+	if (count >= 0xF) {
+		DBG("%s: Too large timeout 0x%x requested for DEADLOCK!\n",
+		    mmc_hostname(host->mmc), count);
+		count = 0xE;
+	}
+	*dead_lock = count;
+
+	return count;
+}
+
+static void __sdhci_uhs2_set_timeout(struct sdhci_host *host)
+{
+	u8 cmd_res, dead_lock;
+
+	sdhci_calc_timeout_uhs2(host, &cmd_res, &dead_lock);
+	cmd_res |= dead_lock << SDHCI_UHS2_TIMER_CTRL_DEADLOCK_SHIFT;
+	sdhci_writeb(host, cmd_res, SDHCI_UHS2_TIMER_CTRL);
+}
+
+void sdhci_uhs2_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
+{
+	__sdhci_set_timeout(host, cmd);
+
+	if (host->mmc->flags & MMC_UHS2_SUPPORT)
+		__sdhci_uhs2_set_timeout(host);
+}
+EXPORT_SYMBOL_GPL(sdhci_uhs2_set_timeout);
+
 /*****************************************************************************\
  *                                                                           *
  * MMC callbacks                                                             *
diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.h
index 3c19d8e44c36..efe70577bc74 100644
--- a/drivers/mmc/host/sdhci-uhs2.h
+++ b/drivers/mmc/host/sdhci-uhs2.h
@@ -213,5 +213,6 @@ void sdhci_uhs2_dump_regs(struct sdhci_host *host);
 void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask);
 void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode,
 			  unsigned short vdd);
+void sdhci_uhs2_set_timeout(struct sdhci_host *host, struct mmc_command *cmd);

 #endif /* __SDHCI_UHS2_H */
--
2.32.0

