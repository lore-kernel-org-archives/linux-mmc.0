Return-Path: <SRS0=yrb8=6P=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25443C47258
	for <linux-mmc@archiver.kernel.org>; Fri,  1 May 2020 23:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 014DB216FD
	for <linux-mmc@archiver.kernel.org>; Fri,  1 May 2020 23:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=timesys-com.20150623.gappssmtp.com header.i=@timesys-com.20150623.gappssmtp.com header.b="rEisY8R7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgEAXyn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 1 May 2020 19:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbgEAXym (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 1 May 2020 19:54:42 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF92C061A0C
        for <linux-mmc@vger.kernel.org>; Fri,  1 May 2020 16:54:41 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id x18so13724639wrq.2
        for <linux-mmc@vger.kernel.org>; Fri, 01 May 2020 16:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HJeXKhqH1ChnCgVvBR4Vrdvm1BdwloRV+f5k24N69rQ=;
        b=rEisY8R7QR6fqnfFC6QxWt4JwrUAWOYJRaYtgx5x/G3EmJmMoJ7CvjQxJeBXKZeADZ
         XxCIcnZYikYz6qElJ9D4S8FB6df2Up/+w9voOurekw8UvNb0yfU4zC9bsXexzlewglv7
         gtTUwy3F3edg/Dpf9xt9A6NY9AvFU8yqdnDLGatxmIot8gaj3sutbq1PYUxKGPHWr6Wx
         FpTGOcfdqQeg0m89wPl+p6bxhJXSRK62c3Ui2jNCrw6RBhaCxWGPL9dYXrT9vBijLdO/
         j/qObbIfl/rFEQ8jS5QY4B4j1zKM6snzlAPFe+VlKG7vZiPmfcEiAIFrim0yQOQsK+5R
         fIfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HJeXKhqH1ChnCgVvBR4Vrdvm1BdwloRV+f5k24N69rQ=;
        b=A3X8tlvVvGasdcS6/iLQnOEKFy0C9N99HF+XHFHEueDoom6bzKnIiR2tpUDaEy3YmY
         pqRItGJPI/AoIqup9SH1huWoZlZH8/kUZubvqF5CpRdxVuqC4aQz3YLDYrwPkI4hMXJW
         yb2O517loo1Jvu1u33hevPSeI/mLEhjiuEIUnI2smbEisgKGOiw1UWy0OoJVtF3KTfaT
         54+VIfFn84DqHCIsv6CX1OPmNKZOhqO73s5xpLRZ4wwNhw3KgiNHoxIAM/iuwt90Ulbs
         9s9e7X237y85+N7q+/2I0/6Yh8MlyrUl/LbNTYUVmI4/2Cjej6c42vblSilyof9Sa7nL
         IeaQ==
X-Gm-Message-State: AGi0Pua1TjyxsT1yBvZIvIIzwHlFzG22sejsTuoFshdJiOvfnvmlPorJ
        sSnejWY2rYVBWqDvPU1GBjQVnjiRquU=
X-Google-Smtp-Source: APiQypJQM/uXv1VqXW//Eu2c6BKWAJeQojrrrq3hOlCUW10k01rDT1A8sgUajT4vA5V/qC88kJn3AA==
X-Received: by 2002:a5d:6844:: with SMTP id o4mr7078808wrw.392.1588377280186;
        Fri, 01 May 2020 16:54:40 -0700 (PDT)
Received: from localhost.localdomain (host142-13-dynamic.2-87-r.retail.telecomitalia.it. [87.2.13.142])
        by smtp.gmail.com with ESMTPSA id r20sm1495155wmh.26.2020.05.01.16.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 16:54:39 -0700 (PDT)
From:   Angelo Dureghello <angelo.dureghello@timesys.com>
To:     adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-m68k@vger.kernel.org,
        Angelo Dureghello <angelo.dureghello@timesys.com>
Subject: [PATCH v3 2/3] mmc: sdhci: add quirks for be to le byte swapping
Date:   Sat,  2 May 2020 01:59:06 +0200
Message-Id: <20200501235907.3978-2-angelo.dureghello@timesys.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200501235907.3978-1-angelo.dureghello@timesys.com>
References: <20200501235907.3978-1-angelo.dureghello@timesys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Some controller as the ColdFire eshdc may require an endianness
byte swap, becouse DMA read endianness is not configurable.

Signed-off-by: Angelo Dureghello <angelo.dureghello@timesys.com>
---
Changes for v3:
- add post request callback
---
 drivers/mmc/host/sdhci.c | 7 +++++++
 drivers/mmc/host/sdhci.h | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 3f716466fcfd..d3bfbb6e11d5 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -637,6 +637,13 @@ static int sdhci_pre_dma_transfer(struct sdhci_host *host,
 			sg_copy_to_buffer(data->sg, data->sg_len,
 					  host->bounce_buffer,
 					  length);
+
+			/*
+			 * Endianness can't be swapped in the sg list,
+			 * since the sg list is processed again later on.
+			 */
+			if (host->ops->pre_dma_transfer)
+				host->ops->pre_dma_transfer(host, data);
 		}
 		/* Switch ownership to the DMA */
 		dma_sync_single_for_device(host->mmc->parent,
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 79dffbb731d3..076054308423 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -653,6 +653,8 @@ struct sdhci_ops {
 	void	(*voltage_switch)(struct sdhci_host *host);
 	void	(*adma_write_desc)(struct sdhci_host *host, void **desc,
 				   dma_addr_t addr, int len, unsigned int cmd);
+	void	(*pre_dma_transfer)(struct sdhci_host *host,
+				    struct mmc_data *data);
 	void	(*request_done)(struct sdhci_host *host,
 				struct mmc_request *mrq);
 };
-- 
2.26.0

