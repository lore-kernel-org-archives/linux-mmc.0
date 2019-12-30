Return-Path: <SRS0=mt+k=2U=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57497C2D0C2
	for <linux-mmc@archiver.kernel.org>; Mon, 30 Dec 2019 11:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A76920748
	for <linux-mmc@archiver.kernel.org>; Mon, 30 Dec 2019 11:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UmgTw1P/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbfL3Ljh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 30 Dec 2019 06:39:37 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35969 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727378AbfL3Ljh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Dec 2019 06:39:37 -0500
Received: by mail-pf1-f193.google.com with SMTP id x184so18136928pfb.3;
        Mon, 30 Dec 2019 03:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AjS97014/RSxpJJZtBtGmJDbmByXyKUam5DG6EgNiy8=;
        b=UmgTw1P/9ZzgH5PZKfu5zE58eIN0goQoO5wun9HJgqKw5mYius2AzarOzOyy+h4cMr
         vTqEjablSBluiMWk/ISAmgRndryTz5QcrvkVoGbHKHJLXWwMV/Vj5LUPZFlEuTfhELe+
         28vAbcnSen+num6VXB/+z45EUAoyZUWRRDuJjuVtT4SxFG5HBgIpgg7RAqEAoUr8wRuK
         BZkCojGvvXAD6PBkKOqgRhhJyXQr/Vcjt3hP9R4MiU3Ba+bwGfSCxsLp023524mwHANw
         WCOKmMLIPpRFmIDEHbuirywRFlBM8ZeCDCbPqf3IC6wXDX4O5cSAHj5y+1d21CF++AqQ
         gHwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AjS97014/RSxpJJZtBtGmJDbmByXyKUam5DG6EgNiy8=;
        b=uUB3hiKG+PogI4CmBfnSKa8DeDgpHfs+47F46OIJ0ObSNLsbLJL2BDS3h1d60nbR2h
         paoH5TUvjUT5amaQfdu4dgPXXfD0mYu7AYYyymeHxdO38jZm5kAHrYRjLqYFH8Reifyk
         5TqKx7YYct2Ceez7nnKcNbqY/OSek3B5qTXtaJa4JjMIMYYlYKkKXWHA6kM3LazQvIkz
         49xPgQQGA5qPdKm2Zc2E/tTB4YkKVHjexMy+PYIk4y6BuirI+6noBWdx2Nk8/zLdnvkK
         Ryn+I0gp5mnEj+N87ow507lIK61NgJ/+MCmQV+wN8LezIUBzQKZBWKx68rC0CYTi3lG6
         qqoQ==
X-Gm-Message-State: APjAAAU7fWExyhtzkc03ZtutVkFzCI8svnUwoiu85vjAakH3sfCWqahW
        dNXIpXOYziamFNgQTFwS6qw=
X-Google-Smtp-Source: APXvYqzuVOkdvjydN2dSkDDOFolDr7AN09tEY958DVQoel8zeVVmAXOPgQhn2k9tRxRsem+12zvQIw==
X-Received: by 2002:a62:1746:: with SMTP id 67mr54330213pfx.45.1577705976608;
        Mon, 30 Dec 2019 03:39:36 -0800 (PST)
Received: from gli-arch.genesyslogic.com.tw ([122.146.30.3])
        by smtp.gmail.com with ESMTPSA id i3sm50535590pfg.94.2019.12.30.03.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 03:39:36 -0800 (PST)
From:   Ben Chuang <benchuanggli@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        Ben Chuang <benchuanggli@gmail.com>
Subject: [RFC,PATCH 4/6] mmc: uhs2: Introduce a uhs2_post_attach_sd function
Date:   Mon, 30 Dec 2019 19:39:47 +0800
Message-Id: <20191230113947.38098-1-benchuanggli@gmail.com>
X-Mailer: git-send-email 2.24.1
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
index 8f396d1de208..7b3e8c978c51 100644
--- a/drivers/mmc/host/sdhci-core.c
+++ b/drivers/mmc/host/sdhci-core.c
@@ -2769,6 +2769,14 @@ void sdhci_uhs2_enable_clk(struct mmc_host *mmc)
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
@@ -2788,6 +2796,7 @@ static const struct mmc_host_ops sdhci_ops = {
 	.uhs2_set_reg		= sdhci_uhs2_set_reg,
 	.uhs2_disable_clk	= sdhci_uhs2_disable_clk,
 	.uhs2_enable_clk	= sdhci_uhs2_enable_clk,
+	.uhs2_post_attach_sd    = sdhci_uhs2_post_attach_sd,
 };
 
 /*****************************************************************************\
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 48176e9556b7..ea5e2119e1c9 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -904,6 +904,7 @@ struct sdhci_ops {
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

