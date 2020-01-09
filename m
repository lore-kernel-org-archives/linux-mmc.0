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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4516FC33CA2
	for <linux-mmc@archiver.kernel.org>; Thu,  9 Jan 2020 09:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AF542072A
	for <linux-mmc@archiver.kernel.org>; Thu,  9 Jan 2020 09:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nq8THdEQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbgAIJOa (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 9 Jan 2020 04:14:30 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38910 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728946AbgAIJOa (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Jan 2020 04:14:30 -0500
Received: by mail-pg1-f196.google.com with SMTP id a33so2934090pgm.5;
        Thu, 09 Jan 2020 01:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0VofrN3+q3uvKqbzjcSavhsqfs4FtK6Er0QtEwgh9UA=;
        b=Nq8THdEQ2t2y/zxif0NygOIQ5hZRzIemZdbBdXTh0KJlvMtswrJgQMUgDHnxRSI+F6
         C8wV+hTNT3JfBzIZbukcChoPbMgFfo8cXAIDwu1ssjfdpo9YzxsXFs97HtOt3cmVTBbn
         ArKJ/eZedzyuyMuDpjcAjg1/RppaQhJpPF7l+2clNImr7Riec8Xu3I6zMIxa+sPOjQh8
         CB+tS6JRCB0oM2OrorNCwk15+q85SURkYR76KGYgtx0bzwrMapzA6a+F48KGkA7Lmy7x
         0rej5pqPwenQsKWHaywpcYYe1b0cXb5s0g5XUu11RALnb8/nQ9g0tGIwE1qGUp+2lpbm
         xKXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0VofrN3+q3uvKqbzjcSavhsqfs4FtK6Er0QtEwgh9UA=;
        b=oEv9/gYMtc85jk+FsC8XnfSAK0WcGTjLBn2md+RVB/cTh2+agZn6keeb7tKnHKxJOk
         +Lb6qfg2MXTjAySSasleC1uGDikuoxE4Geixr2CwQ/UnUcWV06Bj6IPhIYuUDGGpcXzZ
         /Y0b1HgLziPxvbpnkkRHTeKqzfKmqHNTCtSjhzkT5wnmS5rXbUx1HuzZRR2qSNN4hf2+
         IWp4VKdsMJpR+obaIrVK2oIW/+xJvp5uMZo0le2LJhVzW3NBUeNUk9lUpOMW7BMvpNOm
         QZPqmHiDEd39KpQ4GTDs6xxAsmeE89BmsZ4JxJQcqyUIUvwLdx2udDA8lUNFSYz5KTpY
         dNNA==
X-Gm-Message-State: APjAAAU1F7hiIBL99XTMPppLxwZxZgLiaXdbj/dKFJ7713otZv8w/cQ1
        1TMV9Enk4lxGcqGTWLwewEs=
X-Google-Smtp-Source: APXvYqzc+xlyNpOtJx1Wu2SNalzXL3OqzSmyJIjvM/t/GObLS12JEpzMRuQQgpr1kOiD3+8ZiP46NA==
X-Received: by 2002:a62:1857:: with SMTP id 84mr10156389pfy.257.1578561269445;
        Thu, 09 Jan 2020 01:14:29 -0800 (PST)
Received: from gli-arch.genesyslogic.com.tw (60-251-58-169.HINET-IP.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id l21sm6978286pff.100.2020.01.09.01.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 01:14:28 -0800 (PST)
From:   Ben Chuang <benchuanggli@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        greg.tu@genesyslogic.com.tw, ben.chuang@genesyslogic.com.tw,
        Ben Chuang <benchuanggli@gmail.com>
Subject: [RFC PATCH v2 4/6] mmc: uhs2: Introduce a uhs2_post_attach_sd function
Date:   Thu,  9 Jan 2020 17:14:53 +0800
Message-Id: <974a2a211fa97a885ffbdedbb8d596cd4cb57e80.1578560282.git.benchuanggli@gmail.com>
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

Introduce a uhs2_post_attach_sd function after attach_sd on
UHS-II mode.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
---
 drivers/mmc/core/uhs2.c       | 5 ++++-
 drivers/mmc/host/sdhci-core.c | 9 +++++++++
 drivers/mmc/host/sdhci.h      | 1 +
 include/linux/mmc/host.h      | 1 +
 4 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/uhs2.c b/drivers/mmc/core/uhs2.c
index 43ea155ccc59..99aeeccd88e5 100644
--- a/drivers/mmc/core/uhs2.c
+++ b/drivers/mmc/core/uhs2.c
@@ -935,8 +935,11 @@ int mmc_uhs2_try_frequency(struct mmc_host *host, unsigned int freq)
 	 */
 	err = mmc_attach_sd(host, true);
 
-	if (!err)
+	if (!err) {
+		if (host->ops->uhs2_post_attach_sd)
+			host->ops->uhs2_post_attach_sd(host);
 		return 0;
+	}
 
 init_fail:
 	mmc_power_off(host);
diff --git a/drivers/mmc/host/sdhci-core.c b/drivers/mmc/host/sdhci-core.c
index 82184684f963..d7b2535a847a 100644
--- a/drivers/mmc/host/sdhci-core.c
+++ b/drivers/mmc/host/sdhci-core.c
@@ -2778,6 +2778,14 @@ void sdhci_uhs2_enable_clk(struct mmc_host *mmc)
 }
 EXPORT_SYMBOL_GPL(sdhci_uhs2_enable_clk);
 
+static void sdhci_uhs2_post_attach_sd(struct mmc_host *mmc)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+
+	if (host->ops && host->ops->uhs2_post_attach_sd)
+		host->ops->uhs2_post_attach_sd(host);
+}
+
 static const struct mmc_host_ops sdhci_ops = {
 	.request	= sdhci_request,
 	.post_req	= sdhci_post_req,
@@ -2797,6 +2805,7 @@ static const struct mmc_host_ops sdhci_ops = {
 	.uhs2_set_reg		= sdhci_uhs2_set_reg,
 	.uhs2_disable_clk	= sdhci_uhs2_disable_clk,
 	.uhs2_enable_clk	= sdhci_uhs2_enable_clk,
+	.uhs2_post_attach_sd    = sdhci_uhs2_post_attach_sd,
 };
 
 /*****************************************************************************\
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 2f7732f4bb75..7f779ac81931 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -906,6 +906,7 @@ struct sdhci_ops {
 	void	(*voltage_switch)(struct sdhci_host *host);
 	void	(*adma_write_desc)(struct sdhci_host *host, void **desc,
 				   dma_addr_t addr, int len, unsigned int cmd);
+	void    (*uhs2_post_attach_sd)(struct sdhci_host *host);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 3d6a7c9b534f..ed4ebe6bf68a 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -177,6 +177,7 @@ struct mmc_host_ops {
 	int	(*uhs2_set_reg)(struct mmc_host *host, enum uhs2_act act);
 	void    (*uhs2_disable_clk)(struct mmc_host *host);
 	void    (*uhs2_enable_clk)(struct mmc_host *host);
+	void    (*uhs2_post_attach_sd)(struct mmc_host *host);
 };
 
 struct mmc_cqe_ops {
-- 
2.24.1

