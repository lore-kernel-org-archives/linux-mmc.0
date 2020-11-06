Return-Path: <SRS0=Gh8q=EM=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B071CC4742C
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Nov 2020 02:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 593DD2075A
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Nov 2020 02:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oIjNDl0z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725815AbgKFC3m (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 5 Nov 2020 21:29:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgKFC2b (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Nov 2020 21:28:31 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FD0C0613CF
        for <linux-mmc@vger.kernel.org>; Thu,  5 Nov 2020 18:28:31 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id z3so2929682pfb.10
        for <linux-mmc@vger.kernel.org>; Thu, 05 Nov 2020 18:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oZAw8U8D8vUHF1iKm82K3cyupIMt/ic4sf021LXENYE=;
        b=oIjNDl0zi+tWdyTAiIsIrDRLeNt3wr6uCZ1wu4wnkQE8Ygsqv5rsDN5tFftVM35Rr4
         ooaPFKla07r24s13egCTqRIdG+r4XgY44zSwbXH5puBugnDHXYxxczb0w4jp853uP77U
         4Pkx0sRjAZkEsb2OUn08YsURqp/QNUSnJivegoY/+l22I+ItxIh20qYHiX2wnYRfy/o2
         +qy6KLZ58Gxk+Ltb8oWH90f6FigFiKps4PdG3bTyf+hZgN50VjJpLoc2l5ORwsMsqqGa
         0muwqdlkejVwvfOYiXd0Mf+TP0rHxnixehINf+zhnLBlXbypkiwDMb6fr5Eusq5UpnDT
         FG8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oZAw8U8D8vUHF1iKm82K3cyupIMt/ic4sf021LXENYE=;
        b=EDdi4KYgUlIb7HdJokXxZBjbQ2iuGb6T9tvWA7wXrR2Bcnm0ZuWJOld7RLSpAUtvFe
         hMVaTrVs2D9ykdBysNUM5XLyWW6DizFAfphZ5E5xKh7WmxPoDUAPSgSsA9SwXGt1hJEr
         6JoMXs4gpH0iseShIDaVZHkOO/hB6naIs0H9GB1T5WRPX8OnbMgRB00vtvnwfTrYHDeS
         eZctmSVWHpJK2prB/2xijD3Al5LMG8pg61I5/qvaP2Xn1rccI3u0vD12j09EggbBHkRC
         +EOpD/ZpihOTDWumJXae3zAypRRPgta2wqqBV1hMnqipwskh8FRPh0uBydaNibLS9Jp/
         XG5g==
X-Gm-Message-State: AOAM5318yc3HQbIuQzkBuvUb6QkmHjTpG8T6pucvBdBxFYrcw1NIvJ9t
        N1reVgWqXNRXDfGL2iakUrRfIw==
X-Google-Smtp-Source: ABdhPJzK378a95yCfn6eUIRq+vi+CZ1APkk+uYquqTfgUt0dC1DA1WZcm9dBq5RJjc8jWrWFLnUYlw==
X-Received: by 2002:a17:90a:1b84:: with SMTP id w4mr352286pjc.65.1604629711046;
        Thu, 05 Nov 2020 18:28:31 -0800 (PST)
Received: from localhost.localdomain (p784a66b9.tkyea130.ap.so-net.ne.jp. [120.74.102.185])
        by smtp.gmail.com with ESMTPSA id m13sm3703040pjr.30.2020.11.05.18.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 18:28:30 -0800 (PST)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC PATCH v3.1 11/27] mmc: sdhci-uhs2: dump UHS-II registers
Date:   Fri,  6 Nov 2020 11:27:10 +0900
Message-Id: <20201106022726.19831-12-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201106022726.19831-1-takahiro.akashi@linaro.org>
References: <20201106022726.19831-1-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Dump UHS-II specific registers, if available, in sdhci_dumpregs()
for informative/debugging use.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 drivers/mmc/host/sdhci-uhs2.c | 30 ++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-uhs2.h |  4 ++++
 drivers/mmc/host/sdhci.c      |  3 +++
 3 files changed, 37 insertions(+)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index f29d3a4ed43c..08905ed081fb 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -18,6 +18,36 @@
 #define DRIVER_NAME "sdhci_uhs2"
 #define DBG(f, x...) \
 	pr_debug(DRIVER_NAME " [%s()]: " f, __func__, ## x)
+#define SDHCI_UHS2_DUMP(f, x...) \
+	pr_err("%s: " DRIVER_NAME ": " f, mmc_hostname(host->mmc), ## x)
+
+void sdhci_uhs2_dump_regs(struct sdhci_host *host)
+{
+	if (!host->mmc || !(host->mmc->flags & MMC_UHS2_SUPPORT))
+		return;
+
+	SDHCI_UHS2_DUMP("==================== UHS2 ==================\n");
+	SDHCI_UHS2_DUMP("Blk Size:  0x%08x | Blk Cnt:  0x%08x\n",
+			sdhci_readw(host, SDHCI_UHS2_BLOCK_SIZE),
+			sdhci_readl(host, SDHCI_UHS2_BLOCK_COUNT));
+	SDHCI_UHS2_DUMP("Cmd:       0x%08x | Trn mode: 0x%08x\n",
+			sdhci_readw(host, SDHCI_UHS2_COMMAND),
+			sdhci_readw(host, SDHCI_UHS2_TRANS_MODE));
+	SDHCI_UHS2_DUMP("Int Stat:  0x%08x | Dev Sel : 0x%08x\n",
+			sdhci_readw(host, SDHCI_UHS2_DEV_INT_STATUS),
+			sdhci_readb(host, SDHCI_UHS2_DEV_SELECT));
+	SDHCI_UHS2_DUMP("Dev Int Code:  0x%08x\n",
+			sdhci_readb(host, SDHCI_UHS2_DEV_INT_CODE));
+	SDHCI_UHS2_DUMP("Reset:     0x%08x | Timer:    0x%08x\n",
+			sdhci_readw(host, SDHCI_UHS2_SW_RESET),
+			sdhci_readw(host, SDHCI_UHS2_TIMER_CTRL));
+	SDHCI_UHS2_DUMP("ErrInt:    0x%08x | ErrIntEn: 0x%08x\n",
+			sdhci_readl(host, SDHCI_UHS2_ERR_INT_STATUS),
+			sdhci_readl(host, SDHCI_UHS2_ERR_INT_STATUS_EN));
+	SDHCI_UHS2_DUMP("ErrSigEn:  0x%08x\n",
+			sdhci_readl(host, SDHCI_UHS2_ERR_INT_SIG_EN));
+}
+EXPORT_SYMBOL_GPL(sdhci_uhs2_dump_regs);
 
 /*****************************************************************************\
  *                                                                           *
diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.h
index 3b157df9c89c..b9529d32b58d 100644
--- a/drivers/mmc/host/sdhci-uhs2.h
+++ b/drivers/mmc/host/sdhci-uhs2.h
@@ -207,4 +207,8 @@
 #define SDHCI_UHS2_EMBED_CTRL	0xE6
 #define SDHCI_UHS2_VENDOR	0xE8
 
+struct sdhci_host;
+
+void sdhci_uhs2_dump_regs(struct sdhci_host *host);
+
 #endif /* __SDHCI_UHS2_H */
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 592a55a34b58..d4a57e8c9bb8 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -111,6 +111,9 @@ void sdhci_dumpregs(struct sdhci_host *host)
 		}
 	}
 
+	if (host->ops->dump_uhs2_regs)
+		host->ops->dump_uhs2_regs(host);
+
 	if (host->ops->dump_vendor_regs)
 		host->ops->dump_vendor_regs(host);
 
-- 
2.28.0

