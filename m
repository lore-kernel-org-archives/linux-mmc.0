Return-Path: <SRS0=yZYV=3L=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81E3C2D0DB
	for <linux-mmc@archiver.kernel.org>; Wed, 22 Jan 2020 14:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B357217F4
	for <linux-mmc@archiver.kernel.org>; Wed, 22 Jan 2020 14:27:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZB5T1AhW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgAVO17 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 22 Jan 2020 09:27:59 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34848 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgAVO17 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Jan 2020 09:27:59 -0500
Received: by mail-lj1-f194.google.com with SMTP id j1so7048007lja.2
        for <linux-mmc@vger.kernel.org>; Wed, 22 Jan 2020 06:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7VzLcJjeEnS45bKw7Lmz/k90q+rRtqK0BCgzKkLywLM=;
        b=ZB5T1AhWhlYE9OxX4czvsDOmCie3OIq2PCb7t3+brXVJN03D6GPlKa9qMqFd99HI6X
         3XnsPloGO2mJnQIgNFVxF+cucMuck6V1u5DIjxjfnb6UOn/Kj+B+R8vwi9GFxasDYD4q
         QibUbtru7HHBCqi1kTrxQ2MUZi6mBOVAH1ottkcYuVJKWAySJPRadOT4H+zOQIwR9PGW
         awqO6mW51Moye8qt5nFFVY2lVBwZwZLCUXreh55elFDSpXptkNhnLZ0Q/v0gXDchaJkZ
         ictvabxWEGB6IdMCAahlk3PJeGBZ8p6h08LhoW9QKh+wjJeKsRU5kW5glCEV3OmDe3lm
         x54A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7VzLcJjeEnS45bKw7Lmz/k90q+rRtqK0BCgzKkLywLM=;
        b=UE66iyHWnEC4r+ykGMK4VlZeJ9CXuYR8pFwR2NBKG+PLUKB6AzJ5GwV0YQPFSiHekN
         AOzLLP1JGbNdJGfAEU6skFp8jKDi2z1s5ECLKyAEthmI2dCHyxz6PUG7p9RvBV0V+A+G
         FmCwhsvf7kaCjqxdt0AeYGvPuhYWs/wvncJALi9lvEd74/AkAD9KpOUC1SXscJuZcwiM
         4tNdkfIpuLzXjPvY7NzLuZvVTQuS/nXf3S01vABdsSXxLX+1ySXsBrbYChJ08EglZKZz
         y6gnurI1aEaHPgJB3ryrVR+OH3JLSnUkAZE6IywVWJU5F1e9IFs/cJJ1Y+MNbo8xecMZ
         Q0ag==
X-Gm-Message-State: APjAAAVYZbv4rYiQqOhqappUrqcLCrrU7xzIdrCSYu3rVp+dcEHNs2/G
        nM3/grUJKHNWi9IaH9e43TMGAsjdIHI=
X-Google-Smtp-Source: APXvYqzlO8BGgEneuZccgn8tDP+LUmTOH9B89/9xKXCs35QSQAIAtq4lZyviJFDHB/ha87fK/REzaQ==
X-Received: by 2002:a2e:9041:: with SMTP id n1mr19009718ljg.133.1579703276414;
        Wed, 22 Jan 2020 06:27:56 -0800 (PST)
Received: from uffe-XPS-13-9360.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id u17sm20369548ljk.62.2020.01.22.06.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 06:27:55 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Shawn Lin <shawn.lin@rock-chips.com>, mirq-linux@rere.qmqm.pl
Subject: [PATCH 2/3] mmc: block: Use generic_cmd6_time when modifying INAND_CMD38_ARG_EXT_CSD
Date:   Wed, 22 Jan 2020 15:27:46 +0100
Message-Id: <20200122142747.5690-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200122142747.5690-1-ulf.hansson@linaro.org>
References: <20200122142747.5690-1-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The INAND_CMD38_ARG_EXT_CSD is a vendor specific EXT_CSD register, which is
used to prepare an erase/trim operation. However, it doesn't make sense to
use a timeout of 10 minutes while updating the register, which becomes the
case when the timeout_ms argument for mmc_switch() is set to zero.

Instead, let's use the generic_cmd6_time, as that seems like a reasonable
timeout to use for these cases.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/block.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 95b41c0891d0..663d87924e5e 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1107,7 +1107,7 @@ static void mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req)
 					 card->erase_arg == MMC_TRIM_ARG ?
 					 INAND_CMD38_ARG_TRIM :
 					 INAND_CMD38_ARG_ERASE,
-					 0);
+					 card->ext_csd.generic_cmd6_time);
 		}
 		if (!err)
 			err = mmc_erase(card, from, nr, card->erase_arg);
@@ -1149,7 +1149,7 @@ static void mmc_blk_issue_secdiscard_rq(struct mmc_queue *mq,
 				 arg == MMC_SECURE_TRIM1_ARG ?
 				 INAND_CMD38_ARG_SECTRIM1 :
 				 INAND_CMD38_ARG_SECERASE,
-				 0);
+				 card->ext_csd.generic_cmd6_time);
 		if (err)
 			goto out_retry;
 	}
@@ -1167,7 +1167,7 @@ static void mmc_blk_issue_secdiscard_rq(struct mmc_queue *mq,
 			err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 					 INAND_CMD38_ARG_EXT_CSD,
 					 INAND_CMD38_ARG_SECTRIM2,
-					 0);
+					 card->ext_csd.generic_cmd6_time);
 			if (err)
 				goto out_retry;
 		}
-- 
2.17.1

