Return-Path: <SRS0=tDGl=5J=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F215BC43331
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Mar 2020 18:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D101A2074D
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Mar 2020 18:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gq3yC4cz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgCXSHr (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Mar 2020 14:07:47 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39391 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727982AbgCXSHr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Mar 2020 14:07:47 -0400
Received: by mail-lj1-f196.google.com with SMTP id i20so7557731ljn.6
        for <linux-mmc@vger.kernel.org>; Tue, 24 Mar 2020 11:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d70w+xNz4UWAEzx/SWZLFiI5SjHc8+R+STsNWkc4DPs=;
        b=Gq3yC4czVfNuJBGTdWK1idn2N27PKbtZpch9RJibEslj77pdpB2s3JF9KTatzqpl7h
         p8tNjPwz/o7v//e41TRaTsHFNOTVgykx5rjPfgo+85Yzg7VrislgLZRQPBZQIov1EdJC
         R3o+sHqPQCit3180CcxWp+ej7kJDgsofCeMic7L8j3cxIOeRwOupDSORB7ixl4Pl/P1r
         I0JtGoUeem3VmX9eZjOA7Kh3NKl5GeZq0qj6mBR7gwQ+7hd2/Z7r1dlaS+UZbQpqSevL
         zlr31AfoDDyD3hSyXJYHs77BKtOCyDxa5vkym8TzTGC3yDSkPk0wsJoHaqtqyj38NRUY
         Uvjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d70w+xNz4UWAEzx/SWZLFiI5SjHc8+R+STsNWkc4DPs=;
        b=KbgWS/vP6/vcca7wiw+sRFPUKKGSc5r1jU7aexgzqmL01oJD4xpcIpRUtNrrdAqY25
         tqCOqUY+JtsoU5OOXpy7DFUxPVvi2uXJAlOAGx91rz386IubkVyoDvvR6hNxQbXtIyMu
         266tTFrcneeco53SiaD6c6XdLCPihCq0q12QId6Wr+7HAaY6HpDuXwaQ+XaJRAiUVNqn
         iGFDffdQBrQWPLGnvjhW41n99/Th6yCVg+RCQ47AmfKLLU3VNy3qPv2G2rysEFkx+g7B
         NTR2WqU9Wvk8l7+qyJhQJbsS4mvOx6OHOB8WHooeNOM/PtWZSFGQCN9UrLUZ2S86KUpv
         4Zcw==
X-Gm-Message-State: ANhLgQ3+2nR9I942+RRJBAPUg1isMtV0Sk895Y8vfHDomwy2nYTscHrz
        2CifZD9yXdXQd963gXE2dZ1Trg==
X-Google-Smtp-Source: ADFU+vsgKAjOH2WDQA9D9nBFsBvvn9urqGZwksozUoLPhdK/6+G7fE4k+Lmag8JD56XtnpZOQJkO3A==
X-Received: by 2002:a2e:94d5:: with SMTP id r21mr16964696ljh.81.1585073264410;
        Tue, 24 Mar 2020 11:07:44 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id 3sm12113809ljq.18.2020.03.24.11.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 11:07:43 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>
Subject: [PATCH 5.4.28 1/5] mmc: core: Allow host controllers to require R1B for CMD6
Date:   Tue, 24 Mar 2020 19:07:34 +0100
Message-Id: <20200324180738.28892-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200324180738.28892-1-ulf.hansson@linaro.org>
References: <20200324180738.28892-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

[ Upstream commit 1292e3efb149ee21d8d33d725eeed4e6b1ade963 ]

It has turned out that some host controllers can't use R1B for CMD6 and
other commands that have R1B associated with them. Therefore invent a new
host cap, MMC_CAP_NEED_RSP_BUSY to let them specify this.

In __mmc_switch(), let's check the flag and use it to prevent R1B responses
from being converted into R1. Note that, this also means that the host are
on its own, when it comes to manage the busy timeout.

Suggested-by: Sowjanya Komatineni <skomatineni@nvidia.com>
Cc: <stable@vger.kernel.org>
Tested-by: Anders Roxell <anders.roxell@linaro.org>
Tested-by: Sowjanya Komatineni <skomatineni@nvidia.com>
Tested-by: Faiz Abbas <faiz_abbas@ti.com>
Tested-By: Peter Geis <pgwipeout@gmail.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/mmc_ops.c | 8 +++++---
 include/linux/mmc/host.h   | 1 +
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 09113b9ad679..18a7afb2a5b2 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -538,10 +538,12 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 	 * If the cmd timeout and the max_busy_timeout of the host are both
 	 * specified, let's validate them. A failure means we need to prevent
 	 * the host from doing hw busy detection, which is done by converting
-	 * to a R1 response instead of a R1B.
+	 * to a R1 response instead of a R1B. Note, some hosts requires R1B,
+	 * which also means they are on their own when it comes to deal with the
+	 * busy timeout.
 	 */
-	if (timeout_ms && host->max_busy_timeout &&
-		(timeout_ms > host->max_busy_timeout))
+	if (!(host->caps & MMC_CAP_NEED_RSP_BUSY) && timeout_ms &&
+	    host->max_busy_timeout && (timeout_ms > host->max_busy_timeout))
 		use_r1b_resp = false;
 
 	cmd.opcode = MMC_SWITCH;
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index ba703384bea0..4c5eb3aa8e72 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -333,6 +333,7 @@ struct mmc_host {
 				 MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_SDR104 | \
 				 MMC_CAP_UHS_DDR50)
 #define MMC_CAP_SYNC_RUNTIME_PM	(1 << 21)	/* Synced runtime PM suspends. */
+#define MMC_CAP_NEED_RSP_BUSY	(1 << 22)	/* Commands with R1B can't use R1. */
 #define MMC_CAP_DRIVER_TYPE_A	(1 << 23)	/* Host supports Driver Type A */
 #define MMC_CAP_DRIVER_TYPE_C	(1 << 24)	/* Host supports Driver Type C */
 #define MMC_CAP_DRIVER_TYPE_D	(1 << 25)	/* Host supports Driver Type D */
-- 
2.20.1

