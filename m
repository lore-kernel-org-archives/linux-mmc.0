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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00461C433ED
	for <linux-mmc@archiver.kernel.org>; Mon, 17 May 2021 10:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE30B61242
	for <linux-mmc@archiver.kernel.org>; Mon, 17 May 2021 10:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235911AbhEQKKb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 17 May 2021 06:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbhEQKKa (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 17 May 2021 06:10:30 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F32BC06175F;
        Mon, 17 May 2021 03:09:14 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id y32so4285901pga.11;
        Mon, 17 May 2021 03:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hoXZ4vHVHP8vrBjP/Y8D4xxfMB8OzgmtkMwcyzbeX0Q=;
        b=h39floIVlsNNX7rbb5fFw7ehnpgjfPOlxxaXmiu51qMlFCa3eNTyBkCKghenPFtHot
         w22KYex6j6RTa2dpp4oky4+HF+lkye0N/S64nsQNkdtytq4BaWHVsRVge/HXgYX+Pql/
         Y0pgyImyC76QyFhtFSnA+gyPo7Uvx0khpY64YIqQUlfuEnoSUpxguLwk14ctfaXxUTpY
         q9A6FLnhCK22PO1amOYRWJyHNqFwMDxjFbb4FxBTE6UpYTHsTc/RTW2RfFRqQIwc6kAS
         6x+3BbYBjYQvpbEXB/xvy/Dedk9VG/kkdN3VIGEmWO0Jdb4SFiA3mlGAWK6Lsvyu+krQ
         WNbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hoXZ4vHVHP8vrBjP/Y8D4xxfMB8OzgmtkMwcyzbeX0Q=;
        b=qAIkWEB+mJR5qmAwWt81UgP1Zb6b0gPIU0ctlXzxqULns6fliIceFAglxXfpmzvx7s
         77rbO82orNp/ZjQoJCVwTM5VGFcDQJCA8+85N6/ynRU040zxy37CVPRJ5cJ1fWoJbaJV
         3/oeUj/vjICMCgLr5RKNNDY9LcktnYIKKBJLS6SsU9mCi8RlabaL3+qqxYQnrwYDAgTG
         NE/99TECk8I3q9WeVJgCVrDbcx/U4TBSLIazYkZ4D84zY3UcIYKvqZciUN3eSYUpoGBx
         1tousm15tgypxyFvMp0QiRpnnLOwO64ZLNBvvjmxz5U9ahPnpVjwT3snzZKEEA/L/6QM
         ufVQ==
X-Gm-Message-State: AOAM5303ygvZoEDfCisJJX5cH2T7R53uAlLOvHYnTxaIuFDLs+QXAXdP
        0vRKE+4fz5xfhOZcsRg/22eXVjeRLZY=
X-Google-Smtp-Source: ABdhPJz+0UcZFt4a1N9fMPs8K+Ea3wAXhWg1UaC49Ex05b9KOIstw3tWn11ldE1N2/QCo+g6qsCZ3w==
X-Received: by 2002:a63:334b:: with SMTP id z72mr31953889pgz.46.1621246153590;
        Mon, 17 May 2021 03:09:13 -0700 (PDT)
Received: from tj.ccdomain.com ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id u1sm1471193pfc.63.2021.05.17.03.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 03:09:13 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
To:     chaotian.jing@mediatek.com, ulf.hansson@linaro.org,
        matthias.bgg@gmail.com
Cc:     linux-mmc@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, huyue2@yulong.com, zbestahu@163.com
Subject: [PATCH] mmc: mediatek: use data instead of mrq parameter from msdc_{un}prepare_data()
Date:   Mon, 17 May 2021 18:09:00 +0800
Message-Id: <20210517100900.1620-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.29.2.windows.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Yue Hu <huyue2@yulong.com>

We already have 'mrq->data' before calling these two functions, no
need to find it again via 'mrq->data' internally. Also remove local
data variable accordingly.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 drivers/mmc/host/mtk-sd.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 898ed1b..c4db944 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -724,10 +724,8 @@ static inline void msdc_dma_setup(struct msdc_host *host, struct msdc_dma *dma,
 	writel(lower_32_bits(dma->gpd_addr), host->base + MSDC_DMA_SA);
 }
 
-static void msdc_prepare_data(struct msdc_host *host, struct mmc_request *mrq)
+static void msdc_prepare_data(struct msdc_host *host, struct mmc_data *data)
 {
-	struct mmc_data *data = mrq->data;
-
 	if (!(data->host_cookie & MSDC_PREPARE_FLAG)) {
 		data->host_cookie |= MSDC_PREPARE_FLAG;
 		data->sg_count = dma_map_sg(host->dev, data->sg, data->sg_len,
@@ -735,10 +733,8 @@ static void msdc_prepare_data(struct msdc_host *host, struct mmc_request *mrq)
 	}
 }
 
-static void msdc_unprepare_data(struct msdc_host *host, struct mmc_request *mrq)
+static void msdc_unprepare_data(struct msdc_host *host, struct mmc_data *data)
 {
-	struct mmc_data *data = mrq->data;
-
 	if (data->host_cookie & MSDC_ASYNC_FLAG)
 		return;
 
@@ -1140,7 +1136,7 @@ static void msdc_request_done(struct msdc_host *host, struct mmc_request *mrq)
 
 	msdc_track_cmd_data(host, mrq->cmd, mrq->data);
 	if (mrq->data)
-		msdc_unprepare_data(host, mrq);
+		msdc_unprepare_data(host, mrq->data);
 	if (host->error)
 		msdc_reset_hw(host);
 	mmc_request_done(mmc_from_priv(host), mrq);
@@ -1311,7 +1307,7 @@ static void msdc_ops_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	host->mrq = mrq;
 
 	if (mrq->data)
-		msdc_prepare_data(host, mrq);
+		msdc_prepare_data(host, mrq->data);
 
 	/* if SBC is required, we have HW option and SW option.
 	 * if HW option is enabled, and SBC does not have "special" flags,
@@ -1332,7 +1328,7 @@ static void msdc_pre_req(struct mmc_host *mmc, struct mmc_request *mrq)
 	if (!data)
 		return;
 
-	msdc_prepare_data(host, mrq);
+	msdc_prepare_data(host, data);
 	data->host_cookie |= MSDC_ASYNC_FLAG;
 }
 
@@ -1340,14 +1336,14 @@ static void msdc_post_req(struct mmc_host *mmc, struct mmc_request *mrq,
 		int err)
 {
 	struct msdc_host *host = mmc_priv(mmc);
-	struct mmc_data *data;
+	struct mmc_data *data = mrq->data;
 
-	data = mrq->data;
 	if (!data)
 		return;
+
 	if (data->host_cookie) {
 		data->host_cookie &= ~MSDC_ASYNC_FLAG;
-		msdc_unprepare_data(host, mrq);
+		msdc_unprepare_data(host, data);
 	}
 }
 
-- 
1.9.1

