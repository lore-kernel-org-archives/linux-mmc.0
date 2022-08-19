Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4FDC25B0E
	for <linux-mmc@archiver.kernel.org>; Fri, 19 Aug 2022 06:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346798AbiHSGJ4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 19 Aug 2022 02:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346639AbiHSGJD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Aug 2022 02:09:03 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E266CC9
        for <linux-mmc@vger.kernel.org>; Thu, 18 Aug 2022 23:08:33 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id i14so6977969ejg.6
        for <linux-mmc@vger.kernel.org>; Thu, 18 Aug 2022 23:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=aWxibmll6dw/pqOCoi7TR4UJQijH/2FtimkTNrGyezk=;
        b=BvBSOSyw3iiv7zGvCap/WbdDf/oN0NTZE0qS3IMD0KNzeUdTvihvlvLMuuYitRZvE/
         m91mX5BcHAzQzmFlYJ9XOMgeaKGEidyXAmrwZyN9tu4ux2wrV78lw/hrcbiXneJuZZEs
         cFVDStud4vcr2LzM4HQ3TqvwE4yXd75WYW32FPgqBEgFhe+MbOcln3OEbaJdLxL3OpmG
         yz4pjFzomcWQWZrGSR928lMeJDqYKk7nzXFR1WwiTdcleoICgdZczEbk4dE3ByCZ3W52
         ZPE7HrzuhjQWRDJh6F1NgSQal4hinjGHUmETkoVL7jQYlECrig3h4g0k89jbgWMEWaBH
         njDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=aWxibmll6dw/pqOCoi7TR4UJQijH/2FtimkTNrGyezk=;
        b=M2sewxlP7NKGvrP1FihQWw4AAHJkef6+U2adVmQx0jemVet/9BY95XL9SqpGz2Lpzc
         rMsL7QnmpOBIG2pB2SmttL8zhlZMCHp4kSJpNY3HxTWBG6+8scVnFZDZ9v5lyhBVY6p3
         Eb4djFRonx0e1dWoCPwXFpRrVRWc/NBE1tlH4guuRh9H8KrhFveLaPXSMtOBoxkDndfT
         QLHenscGXwccTTo+wAK6mT9l0rh7Zid05I05KMEcec30AKCJbB7NAgwWQrH4XfwjNiIY
         p6I7ykSIWkGNQmdT3DZMMTrE/6e1lgTHKJEaMmAltKUpfnbjqZLe4YrQXt5AJ0pt7wR+
         WzrQ==
X-Gm-Message-State: ACgBeo3F2r51DbP+nHWwZBQqxSJlK8Y+nlagpJDOgs7tAuxCFZWtO0FH
        BmvBWVAYZ87sIWNNqgVM+yVsKA==
X-Google-Smtp-Source: AA6agR4Iy4mG3WSo/+iV+l4otLH2sa6d2rwaJAQsAE1Z1Nuy5iTIHXL0YtgWK+Uf3LeX6Gm0YwCa4Q==
X-Received: by 2002:a17:907:1c26:b0:730:960f:118 with SMTP id nc38-20020a1709071c2600b00730960f0118mr3868462ejc.650.1660889311411;
        Thu, 18 Aug 2022 23:08:31 -0700 (PDT)
Received: from lb02065.fritz.box ([2001:9e8:143b:fd00:5207:8c7f:747a:b80d])
        by smtp.gmail.com with ESMTPSA id y14-20020a1709063a8e00b0073a644ef803sm1809660ejd.101.2022.08.18.23.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 23:08:30 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-kernel@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mips@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: [PATCH v1 18/19] mmc: jz4740_mmc: Fix error check for dma_map_sg
Date:   Fri, 19 Aug 2022 08:08:00 +0200
Message-Id: <20220819060801.10443-19-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220819060801.10443-1-jinpu.wang@ionos.com>
References: <20220819060801.10443-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

dma_map_sg return 0 on error.

Cc: Paul Cercueil <paul@crapouillou.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mips@vger.kernel.org
Cc: linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/mmc/host/jz4740_mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index b1d563b2ed1b..666600055b06 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -308,7 +308,7 @@ static int jz4740_mmc_prepare_dma_data(struct jz4740_mmc_host *host,
 			data->sg_len,
 			dir);
 
-	if (sg_count <= 0) {
+	if (!sg_count) {
 		dev_err(mmc_dev(host->mmc),
 			"Failed to map scatterlist for DMA operation\n");
 		return -EINVAL;
-- 
2.34.1

