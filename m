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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE98C6377C
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Jul 2021 04:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E22D61279
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Jul 2021 04:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbhGVDVn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 21 Jul 2021 23:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbhGVDVj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Jul 2021 23:21:39 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94BFC0613D5;
        Wed, 21 Jul 2021 21:02:13 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id ds11-20020a17090b08cbb0290172f971883bso2389461pjb.1;
        Wed, 21 Jul 2021 21:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L5rS4U/NLgMc3Ohw7S7a9WvKYozCjHnEc5ftGhe5Wwk=;
        b=COSuwQL6O1qsP+f9cpXUJ+UoUtiWqIKftgmABdFHNrz3VMms71ThFP/nDl3B7S0QIL
         ge620lhhfAdzsZhp50+9fJnLw9mItep20oq5pwi4YRD3mBUkW5L/QNigmWR0zYyj+qjd
         Wk8IwoMszN0bbvnQMAIJCqPafTUANcZWVYudId5mSdJLrTDEZ0rEKEUG07Hw0kqcHH+0
         YWhOo1cSQQNF64Zlq7LOF5kPHVFJahAox0LKTLvUccnATsc6lL4GCPJCEq6ePKbDlZO8
         lQl2UDdCz5vpSdWuFw6CNdUVHRF6A7vpCzXVUiTcPD8EdMpha714HZMw/lZZwKc6WPeb
         QyWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L5rS4U/NLgMc3Ohw7S7a9WvKYozCjHnEc5ftGhe5Wwk=;
        b=brspVy0fSQtGXtvsSWEr2ygbNxOzkKcCaMWvJlawNH6xT1Rlk+qCMiGheM9izZZmrG
         cwkofLyQE6uP045xLfTvF/566l294204eVjaUyqO0/tZAOFxVu6ntsrsfycHhngblBfq
         RowJ0YOjKOXT969NeqppP9eVAAqTDGHoCZkO6wTW6sJm9Sp5r8oedR3hoJSAhx3kHNYx
         XyZfXtRmJogMEacILdj15cnKNeo4FGIRzNUkIgo1vFuUJkABFVx2ZfjtGwq/72XkluC+
         UEpHQKSLK4e6A75cznXA6FXTIUE23t9EzHb4F5Ay+YTcDEfNDH20hhcmVLCB+bOrnDyA
         XZUQ==
X-Gm-Message-State: AOAM531OVL1qV8jmmNZrACPU+1t6H6p/iaspCucDXYHIW+KMpB0AFIqd
        GinUW18hlX56iN4NiRkPs2k=
X-Google-Smtp-Source: ABdhPJzWg2yvkM53M0PJWsBqcBapIRTpblCRgcU4vfu5M5js39khQl0q/LB4vXI4yl5z63rMvjPwCA==
X-Received: by 2002:aa7:800b:0:b029:330:455f:57a8 with SMTP id j11-20020aa7800b0000b0290330455f57a8mr39101331pfi.7.1626926533507;
        Wed, 21 Jul 2021 21:02:13 -0700 (PDT)
Received: from jason-z170xgaming7.mshome.net (218-35-143-223.cm.dynamic.apol.com.tw. [218.35.143.223])
        by smtp.gmail.com with ESMTPSA id c19sm1663479pfp.184.2021.07.21.21.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 21:02:13 -0700 (PDT)
From:   Jason Lai <jasonlai.genesyslogic@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        jason.lai@genesyslogiv.com.tw,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC PATCH v3.2 11/29] mmc: sdhci-uhs2: dump UHS-II registers
Date:   Thu, 22 Jul 2021 12:01:06 +0800
Message-Id: <20210722040124.7573-11-jasonlai.genesyslogic@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210722040124.7573-1-jasonlai.genesyslogic@gmail.com>
References: <20210722040124.7573-1-jasonlai.genesyslogic@gmail.com>
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
index bf238ade1602..97e7e04e4614 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -110,6 +110,9 @@ void sdhci_dumpregs(struct sdhci_host *host)
 		}
 	}

+	if (host->ops->dump_uhs2_regs)
+		host->ops->dump_uhs2_regs(host);
+
 	if (host->ops->dump_vendor_regs)
 		host->ops->dump_vendor_regs(host);

--
2.32.0

