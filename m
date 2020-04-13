Return-Path: <SRS0=9sJp=55=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C6E0C2BB85
	for <linux-mmc@archiver.kernel.org>; Mon, 13 Apr 2020 02:46:32 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08810206C3
	for <linux-mmc@archiver.kernel.org>; Mon, 13 Apr 2020 02:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rpg9/nlM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08810206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-mmc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbgDMCqa (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 12 Apr 2020 22:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728248AbgDMCqa (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 12 Apr 2020 22:46:30 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9304BC0086D3;
        Sun, 12 Apr 2020 19:46:30 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id w3so2917376plz.5;
        Sun, 12 Apr 2020 19:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=YHBOhO4LyqyjDx63OQCrCgMDcpXOM1V+lH7ff49OMtU=;
        b=rpg9/nlMwTlyEJRJJPlYEBSDp/Z9HeRshrYva2w7lnYuF+gpYqSKj935QpmBLwpe6g
         cqkuatIMM2kfDKdrxtPul9bOOz7WOcfxyNBqyPZUIb7rJrYhHwGaJWWWzIGK9luKeL5W
         LKSS6dx3R6PKwt5EwTMy19NeDGeBxIx2LfbqJEOO9t9XzwA3CPJkCV3njVNZwo2UzLDi
         ff7D2dufkBNXhFgrXqHDFuK0juKbIow4m8o9g5lUpVr72CjIKBqQF8hpRzHKg/0j+TXV
         +ao5HNGl+opLh2+rF6LA/Oj3VJ2oOwln98a+Wwa7hwrREDObBoq9utmLXXrG1qt7NyfF
         ItrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=YHBOhO4LyqyjDx63OQCrCgMDcpXOM1V+lH7ff49OMtU=;
        b=Sjkl+OEeLLNNlzrHirI8JL0KaO2KZ3SwwOCw6vEV7xQxbVH79Fc/dCHjd7nR12nyKD
         +W/yMd5alZLE8mfZEyzEtzjffc4al5Mt2DTvgwAS0GpCiK10lp12DCIUAuYVOWCp83Tf
         uAme3PIBswy5H8zi+mmBFfYNSkVgvwyUkCehLNC+8vWtddOWYEBRnIyQBhtvLqeBEEuE
         56rbaY98H21gkgi0Nle8T+nmnxZoDeD8rwgtHVL2uC1OCaeCjAr25D8SDd5JYwk/yCuJ
         SupTyy5T8IR9b1NMNV/XR8mj/btV/jh1+ulYvHRDBGJvbG+2GwaZvFhlF5kZCpzLCfld
         B6YQ==
X-Gm-Message-State: AGi0PuYyZsXf0bX/NS24kzJkIOKdgNrUTgMijcw3upBoancBMlEtW4IJ
        /JX2RtSxjMJMD/AOEeyPjegP6K7jYv0=
X-Google-Smtp-Source: APiQypJTd9TiVaxLLVzNoyXtGYQYZ8rJP07wc26cWc97WPOhF2d4SZRmELRkul+6+o13HIR6ctmrjw==
X-Received: by 2002:a17:902:8542:: with SMTP id d2mr9943031plo.273.1586745990075;
        Sun, 12 Apr 2020 19:46:30 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.19])
        by smtp.gmail.com with ESMTPSA id i15sm2327882pfe.197.2020.04.12.19.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2020 19:46:29 -0700 (PDT)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     arnd@arndb.de, baolin.wang7@gmail.com, orsonzhai@gmail.com,
        zhang.lyra@gmail.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/3] mmc: host: sdhci: Implement the request_atomic() API
Date:   Mon, 13 Apr 2020 10:46:04 +0800
Message-Id: <9ed34afa9fb42e0c234065cac5401d7826942b55.1586744073.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1586744073.git.baolin.wang7@gmail.com>
References: <cover.1586744073.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1586744073.git.baolin.wang7@gmail.com>
References: <cover.1586744073.git.baolin.wang7@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Implement the request_atomic() ops for the sdhci driver to process
one request in the atomic context if the card is nonremovable.

Moreover, we should return BUSY flag if controller has not released
the inhibit bits to allow HSQ trying to send request again in non-atomic
context.

Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/mmc/host/sdhci.c | 34 ++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci.h |  1 +
 2 files changed, 35 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 10b9570f48aa..0baef595de26 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2144,6 +2144,40 @@ void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 }
 EXPORT_SYMBOL_GPL(sdhci_request);
 
+int sdhci_request_atomic(struct mmc_host *mmc, struct mmc_request *mrq)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	struct mmc_command *cmd;
+	unsigned long flags;
+	int ret = 0;
+
+	spin_lock_irqsave(&host->lock, flags);
+
+	if (sdhci_present_error(host, mrq->cmd, true)) {
+		sdhci_finish_mrq(host, mrq);
+		goto out_finish;
+	}
+
+	cmd = sdhci_manual_cmd23(host, mrq) ? mrq->sbc : mrq->cmd;
+
+	/*
+	 * The HSQ may send a command in interrupt context without polling
+	 * the busy signaling, which means we should return BUSY if controller
+	 * has not released inhibit bits to allow HSQ trying to send request
+	 * again in non-atomic context. So we should not finish this request
+	 * here.
+	 */
+	if (!sdhci_send_command(host, cmd))
+		ret = -EBUSY;
+	else
+		sdhci_led_activate(host);
+
+out_finish:
+	spin_unlock_irqrestore(&host->lock, flags);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(sdhci_request_atomic);
+
 void sdhci_set_bus_width(struct sdhci_host *host, int width)
 {
 	u8 ctrl;
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index a7e469c00617..4bd70da7aa00 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -776,6 +776,7 @@ void sdhci_set_power_and_bus_voltage(struct sdhci_host *host,
 void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
 			   unsigned short vdd);
 void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq);
+int sdhci_request_atomic(struct mmc_host *mmc, struct mmc_request *mrq);
 void sdhci_set_bus_width(struct sdhci_host *host, int width);
 void sdhci_reset(struct sdhci_host *host, u8 mask);
 void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing);
-- 
2.17.1

