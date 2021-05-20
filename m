Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AFD3C4360C
	for <linux-mmc@archiver.kernel.org>; Thu, 20 May 2021 11:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0979E60240
	for <linux-mmc@archiver.kernel.org>; Thu, 20 May 2021 11:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239895AbhETLPT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 20 May 2021 07:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240033AbhETLNU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 20 May 2021 07:13:20 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F864C028020;
        Thu, 20 May 2021 03:00:50 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id l70so11498529pga.1;
        Thu, 20 May 2021 03:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T08PDvJ5aWhDHE7UN2bq23pqqz017tvRN2/y5Yo5lkU=;
        b=kR4voAyfac4Y9JkSDlCiXBERU/mdOJchqPpyDcLAZ8XVsEWuJBqC1P0EBQAsXdrHxc
         Zv8r5lUXQ+GO+bcvKXdm6envSVjmBUU6w0lRyg6465y+TI35BTKe10SDXs9qCIpEAjyW
         mWzQiEK1DsyqY/V9PM8iVEFTDfVvwA9pRg9bPziqYD9E3/4c1D5hfteiT89fX/DUHvy0
         RRfxOCoD0jg5Yj1kDecYqkqxRn+GsxalX6wDauLMAh7joDDN5f+9c1zJm9P+9myUFs+N
         YBgmH2D/xpHlRQdhbVBvvCbdKzma463UhMHvrlOv2fqx+n4Vtu9kjPFHmb7jgHi54ris
         7Rdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T08PDvJ5aWhDHE7UN2bq23pqqz017tvRN2/y5Yo5lkU=;
        b=Z5fKK3sPg76vRdVsVZtSedC1OCMDlZ1kSzv0tjiOj6YenvdyhRrpOAjHzvE6qUlkqi
         dh5OhRRX4EPmRU9HkkDD3Y2422xokwXq/+l4h9FIN/UZPGvq6gOlo0xhIU/qO/LEA+kJ
         tHKHfHin255w32nRmJaKWYNw1hFm/kM3uOPEnSq98JXmUoHhoCzkyrhbrug2oS4Szkbm
         QUtHDwF98mN/xRto86OWfiWrjoF/MUXohkCYPcFeW67O5JocjX7SrmwBsyeb1CAukjbW
         /Bi4Wrh7Tpfcz/N3nFt4BBhN5Uv9+8toSKgIk1Vw0DUdk+XszBWk0kRMI+NNpyLJsajz
         jMtg==
X-Gm-Message-State: AOAM531EYynrQmtLbCCUTrtZbd2MiWkFtBXUnkahdN1FT+YEF9at9N2M
        UfdHOPABaDStWJlbGm2xoY7PLXub3Givfw==
X-Google-Smtp-Source: ABdhPJxKwg1X6fMTC6AGAtOdB/casyKbH46SR2l+fASHySSu4WZdcMTtroyNoGSrOu3Yq5B6b6ouaw==
X-Received: by 2002:a63:368f:: with SMTP id d137mr304435pga.93.1621504850080;
        Thu, 20 May 2021 03:00:50 -0700 (PDT)
Received: from tj.ccdomain.com ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id j16sm1753853pfi.92.2021.05.20.03.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 03:00:49 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
To:     adrian.hunter@intel.com, riteshh@codeaurora.org,
        asutoshd@codeaurora.org, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        huyue2@yulong.com, zbestahu@163.com
Subject: [PATCH] mmc: cqhci: use data instead of mrq parameter from cqhci_dma_map()
Date:   Thu, 20 May 2021 18:00:36 +0800
Message-Id: <20210520100036.2195-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.29.2.windows.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Yue Hu <huyue2@yulong.com>

cqhci_dma_map() will be only called by cqhci_prep_tran_desc() which
already has 'mrq->data'.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 drivers/mmc/host/cqhci-core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
index 93b0432..e759e3b 100644
--- a/drivers/mmc/host/cqhci-core.c
+++ b/drivers/mmc/host/cqhci-core.c
@@ -446,10 +446,9 @@ static void cqhci_prep_task_desc(struct mmc_request *mrq,
 	}
 }
 
-static int cqhci_dma_map(struct mmc_host *host, struct mmc_request *mrq)
+static int cqhci_dma_map(struct mmc_host *host, struct mmc_data *data)
 {
 	int sg_count;
-	struct mmc_data *data = mrq->data;
 
 	if (!data)
 		return -EINVAL;
@@ -499,7 +498,7 @@ static int cqhci_prep_tran_desc(struct mmc_request *mrq,
 	u8 *desc;
 	struct scatterlist *sg;
 
-	sg_count = cqhci_dma_map(mrq->host, mrq);
+	sg_count = cqhci_dma_map(mrq->host, data);
 	if (sg_count < 0) {
 		pr_err("%s: %s: unable to map sg lists, %d\n",
 				mmc_hostname(mrq->host), __func__, sg_count);
-- 
1.9.1

