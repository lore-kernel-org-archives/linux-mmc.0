Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CDFBC433B4
	for <linux-mmc@archiver.kernel.org>; Fri, 21 May 2021 03:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 044CE61074
	for <linux-mmc@archiver.kernel.org>; Fri, 21 May 2021 03:44:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238854AbhEUDqK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 20 May 2021 23:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236995AbhEUDqJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 20 May 2021 23:46:09 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DFCCC061574;
        Thu, 20 May 2021 20:44:45 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id b7so6084960plg.0;
        Thu, 20 May 2021 20:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z0iuTAtArXUnn+cQyamTGlq74FP5MQC6oeVD30RjaVI=;
        b=awAEFn7OK+ophw7i2hWOTlvDf8ox4NW/Yyoisu4q1iAy9cDIelHE7tW1eDvQrvuqkj
         asWWM5QGdMQg0iI4KlxN04kViyi7abl9h/gN+2JDhpcp34I6VDXKJz6n7Lx4lIJd/+Ra
         bqoWrBVcv0k57V09brPLAEEmXR0CiGukIe2YGZpfpASj5YzeXqsTQz1smO3hZgHdbLER
         oyIZJedDzfrJ+rkJDFMcUodKgKfXpqWLlp5D6qLDdI9aDcAql6creXT5sMN025hwHlWA
         KPXQasJi+L/Aa5cEsf09+w0fhHW2Z1HAQCbYHLoB/rupL8CrbcsFn/eJRmCXXx380Ezx
         OyFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z0iuTAtArXUnn+cQyamTGlq74FP5MQC6oeVD30RjaVI=;
        b=aB6LZb1ql9UKq0B26jKexKlo4g5Pkdg1eySOpLrjpKAYqQghUMWemxV6pZBCYlMbAk
         GzCIBTXcJdlg3r5InhjoNY2MfMbnDfZlZ0XKv2UKVUak3GgRn+CddawmJHD/kJYTrrI0
         LuLka5a0F1iZAoGfiS+wmRtDLhuET9wcy4qPOMAkYqei8wlzahGqu28JI0iM+nv8E9bh
         FxGKXqFmj963A99aRjuz8/84VqMMepynNFnub4qAZ6tzU2AYNp2iZ+1OdcUtrmbjdfxh
         2lNLkpLVgQnlRPrYYMze/xNstRUl/RQAYFq6jfriePgiv3kx6M5Dpsgooq5I24kGbJEm
         GMFg==
X-Gm-Message-State: AOAM533UXWWiGikqMlsmCjUecPTQnYufnx9qkXHVtDqFyL1kkUyB9Chp
        YGUJqZ5QbR6JeRvP/7kAiQhhz4wRpU7dPQ==
X-Google-Smtp-Source: ABdhPJyJJMoaM1CdO00dK9FS2DVD1M7xBI4mTCj2qczhECDgxrXrtXWc2ec4/5WSZspKV+FAHumfgg==
X-Received: by 2002:a17:90a:db51:: with SMTP id u17mr8444329pjx.222.1621568684410;
        Thu, 20 May 2021 20:44:44 -0700 (PDT)
Received: from tj.ccdomain.com ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id y20sm2495501pfn.164.2021.05.20.20.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 20:44:43 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
To:     adrian.hunter@intel.com, riteshh@codeaurora.org,
        asutoshd@codeaurora.org, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        huyue2@yulong.com, zbestahu@163.com
Subject: [PATCH] mmc: cqhci: introduce get_trans_desc_offset()
Date:   Fri, 21 May 2021 11:44:32 +0800
Message-Id: <20210521034432.2321-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.29.2.windows.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Yue Hu <huyue2@yulong.com>

The same calculation to get transfer descriptor offset is already used
at 3 different locations. Let's create a new helper to simplify code.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 drivers/mmc/host/cqhci-core.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
index c237b6e..1128dd5 100644
--- a/drivers/mmc/host/cqhci-core.c
+++ b/drivers/mmc/host/cqhci-core.c
@@ -45,17 +45,23 @@ static inline u8 *get_link_desc(struct cqhci_host *cq_host, u8 tag)
 	return desc + cq_host->task_desc_len;
 }
 
+static inline size_t get_trans_desc_offset(struct cqhci_host *cq_host, u8 tag)
+{
+	return cq_host->trans_desc_len * cq_host->mmc->max_segs * tag;
+}
+
 static inline dma_addr_t get_trans_desc_dma(struct cqhci_host *cq_host, u8 tag)
 {
-	return cq_host->trans_desc_dma_base +
-		(cq_host->mmc->max_segs * tag *
-		 cq_host->trans_desc_len);
+	size_t offset = get_trans_desc_offset(cq_host, tag);
+
+	return cq_host->trans_desc_dma_base + offset;
 }
 
 static inline u8 *get_trans_desc(struct cqhci_host *cq_host, u8 tag)
 {
-	return cq_host->trans_desc_base +
-		(cq_host->trans_desc_len * cq_host->mmc->max_segs * tag);
+	size_t offset = get_trans_desc_offset(cq_host, tag);
+
+	return cq_host->trans_desc_base + offset;
 }
 
 static void setup_trans_desc(struct cqhci_host *cq_host, u8 tag)
@@ -194,8 +200,7 @@ static int cqhci_host_alloc_tdl(struct cqhci_host *cq_host)
 
 	cq_host->desc_size = cq_host->slot_sz * cq_host->num_slots;
 
-	cq_host->data_size = cq_host->trans_desc_len * cq_host->mmc->max_segs *
-		cq_host->mmc->cqe_qdepth;
+	cq_host->data_size = get_trans_desc_offset(cq_host, cq_host->mmc->cqe_qdepth);
 
 	pr_debug("%s: cqhci: desc_size: %zu data_sz: %zu slot-sz: %d\n",
 		 mmc_hostname(cq_host->mmc), cq_host->desc_size, cq_host->data_size,
-- 
1.9.1

