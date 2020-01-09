Return-Path: <SRS0=zEeD=26=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5EFC32771
	for <linux-mmc@archiver.kernel.org>; Thu,  9 Jan 2020 09:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9092820673
	for <linux-mmc@archiver.kernel.org>; Thu,  9 Jan 2020 09:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OpQlpHWD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbgAIJOn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 9 Jan 2020 04:14:43 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35077 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728946AbgAIJOm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Jan 2020 04:14:42 -0500
Received: by mail-pf1-f195.google.com with SMTP id i23so3094906pfo.2;
        Thu, 09 Jan 2020 01:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8Rg+d621Q/DEet6hos9ceAjmVBZFRndyzgA44fX7sKI=;
        b=OpQlpHWDrQ3NowQTMT/QoXrY3uIcc7RTD1EZW8f+XFj8/fmX2zLuOzcNqFRwiISeXv
         HC0WoVXt8Y3Xa/j7bKs8253Y9BAk9TjRb9U4j28DA5XIZcrL8i3WFQH6wu5YxSyMXyr+
         c7FgYVZWTxtxZlzt7mCYoP5k6JObo68X1T+gIXDiHLYs/4Shc5QfF1DW1MVRHekqP//d
         lMlDssGiLYv9bZOOFcaGw4aulmS0Pmc/PDLUUj5rGb+BelLR8/uCXvnp+Xq3ZxQ0V8Lg
         5LRbWCzZaxR0K3IVXpIy1ZjEDzbQwF3sew3rUQzbiZqIiYUTXUbw3e9DYTBSKJgNFZNM
         +M5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8Rg+d621Q/DEet6hos9ceAjmVBZFRndyzgA44fX7sKI=;
        b=qWUwHLDSmc6gL0eIKRzNIGVq/p35a4Qbh5GGgvnUuEaTazjupKjQniNQuZGU/JFu10
         sfFHPkAIlUV1Wh/PARhBfJhrKF2DAZKb438XzuqaAU1N/0KdjDCMiBNSorZ95V8bAard
         2sjPr5J9P8a0n5Zo7Od40No1+vkDLidwRBS17YRIWiY3CocfpdIJ5mhAjnNQPrjyOxpP
         hQinqZ8Anbmc+bQCeVE6L6BFOcuz6NTxZgdxucAIZ9OyQVmC5tqIf8Rk6C7izH427uZh
         j3qDex0O++y2Ux8RhI/DZ04XqroYw2sgaQ6h0Va6FfsxlI1zbwT2YugKZ9MQvW3mm6sS
         q8+Q==
X-Gm-Message-State: APjAAAWfLG0bzr3vqOTAbA3t1jC6pKK93GHQvIED4zFhTcj/yMG5cYIa
        gTxL4CsaygES31M1RNr5BdxhNIvh
X-Google-Smtp-Source: APXvYqy2Atu64NbtrIZqmgOCvkwvwHSpVWIJOUl7Xhy5FKo6VJyzzLJv890Y3JmaOeZ3Y096SJbP6g==
X-Received: by 2002:a62:78c1:: with SMTP id t184mr9908265pfc.222.1578561282121;
        Thu, 09 Jan 2020 01:14:42 -0800 (PST)
Received: from gli-arch.genesyslogic.com.tw (60-251-58-169.HINET-IP.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id x65sm7380180pfb.171.2020.01.09.01.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 01:14:41 -0800 (PST)
From:   Ben Chuang <benchuanggli@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        greg.tu@genesyslogic.com.tw, ben.chuang@genesyslogic.com.tw,
        Ben Chuang <benchuanggli@gmail.com>
Subject: [RFC PATCH v2 5/6] mmc: sdhci-uhs2: Introduce a uhs2_pre_detect_init function
Date:   Thu,  9 Jan 2020 17:15:05 +0800
Message-Id: <cbbfc14fe23c9cd2541c5307f6a1356332e6bc35.1578560282.git.benchuanggli@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1578560282.git.benchuanggli@gmail.com>
References: <cover.1578560282.git.benchuanggli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Ben Chuang <ben.chuang@genesyslogic.com.tw>

Introduce a uhs2_pre_detect_init function before detect uhs2 interface.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
---
 drivers/mmc/host/sdhci-uhs2.c | 3 +++
 drivers/mmc/host/sdhci.h      | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index e9c42894185a..9f53b7b938b9 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -506,6 +506,9 @@ int sdhci_uhs2_do_detect_init(struct sdhci_host *host)
 	DBG("%s: begin UHS2 init.\n", __func__);
 	spin_lock_irqsave(&host->lock, flags);
 
+	if (host->ops && host->ops->uhs2_pre_detect_init)
+		host->ops->uhs2_pre_detect_init(host);
+
 	if (sdhci_uhs2_interface_detect(host)) {
 		pr_warn("%s: cannot detect UHS2 interface.\n",
 				mmc_hostname(host->mmc));
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 7f779ac81931..08ee4c805474 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -906,6 +906,7 @@ struct sdhci_ops {
 	void	(*voltage_switch)(struct sdhci_host *host);
 	void	(*adma_write_desc)(struct sdhci_host *host, void **desc,
 				   dma_addr_t addr, int len, unsigned int cmd);
+	void    (*uhs2_pre_detect_init)(struct sdhci_host *host);
 	void    (*uhs2_post_attach_sd)(struct sdhci_host *host);
 };
 
-- 
2.24.1

