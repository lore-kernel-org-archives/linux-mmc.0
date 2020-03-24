Return-Path: <SRS0=tDGl=5J=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44302C2BAEE
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Mar 2020 18:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 237C12074D
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Mar 2020 18:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="npCbnLl6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbgCXSII (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Mar 2020 14:08:08 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44489 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727382AbgCXSII (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Mar 2020 14:08:08 -0400
Received: by mail-lf1-f65.google.com with SMTP id j188so10197694lfj.11
        for <linux-mmc@vger.kernel.org>; Tue, 24 Mar 2020 11:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5E1VJzGwtosUipNZawyOp6QQ2qvHexwnEsdNcedQu34=;
        b=npCbnLl6rCS6PMqC396BY+LfqiKGtkTxvbNgpTQM2IG+qbkagX3mG9unHZNiqPbtzN
         HjcXlqfhLcvKWtacfuTNq6h2S+W2LtoJwe6ag/2hoR2sV02g+Bg4GxOVqDgHtJDqmKeV
         E2YvasBMpwUUmr9HLSWkWDJNYQ2K2r0o7gHI7umykeQ476OEHHZIZK3oH8Yy+0RR16ZP
         b4uta55OslLMO+cSMjUzZbvpPXQjvBFDHS8IAMapTmfOY57E9Hf+EFdVzi5aJ3HIojt1
         pQgI7Uth/eTjzVLMNLFs8liTp3fpdMWT07yl+50eVkGxgK7nN0nrnmu8Rx8C5TYBYoEi
         gYKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5E1VJzGwtosUipNZawyOp6QQ2qvHexwnEsdNcedQu34=;
        b=bREFlMZNUA3YTt2LLd4jqpPp+zr0HmeI3Eo612jjfSpwO/w0Yxa8b1BTxllAzqiRj2
         2yrResLMbfrEV4jk7pDM+ia7Vk8gSH0cOq9f4Z+ki0Nzwwu22SDzW23+uY37hbJ8NQ8u
         WYLmKRM1XS/sMbFG4aH/YR/R3OfyyFiWHLaeQpRNQGhAgjJfaPCszatMqCJ2RDu6gct2
         fR9YkoBFRfn6OCzRWFhG0/Nw5O4OXQ29Ow+gVX3lx25v1pLj7QjgS25v/KWZnPVeT4Mz
         dtBZswVAxd39Yc9c/UXiM7bMdCDghf9EaVT34j414BLFGX5nbjx9Whg27qagjyg/n/6c
         3IjA==
X-Gm-Message-State: ANhLgQ1woAcy0UTqBm6imryORY29Ra8CY8ticGhfeOWrb3tgi7wMQsgh
        poddSqj0wXfznBC8niK32gmcUA==
X-Google-Smtp-Source: ADFU+vvylM9aHeyX1GJIvKdQNfT5GzT5Kc9oSRG5Bbq4LDbH02/g96U9VJ2wPrUj5oqiVl6v76nxrA==
X-Received: by 2002:a19:4f01:: with SMTP id d1mr13123052lfb.182.1585073285302;
        Tue, 24 Mar 2020 11:08:05 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id s10sm11029858ljp.87.2020.03.24.11.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 11:08:04 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>
Subject: [PATCH 4.19.113 1/5] mmc: core: Allow host controllers to require R1B for CMD6
Date:   Tue, 24 Mar 2020 19:07:56 +0100
Message-Id: <20200324180800.28953-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200324180800.28953-1-ulf.hansson@linaro.org>
References: <20200324180800.28953-1-ulf.hansson@linaro.org>
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
index 873b2aa0c155..693b99eff74b 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -536,10 +536,12 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
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
index 840462ed1ec7..7e8e5b20e82b 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -332,6 +332,7 @@ struct mmc_host {
 				 MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_SDR104 | \
 				 MMC_CAP_UHS_DDR50)
 /* (1 << 21) is free for reuse */
+#define MMC_CAP_NEED_RSP_BUSY	(1 << 22)	/* Commands with R1B can't use R1. */
 #define MMC_CAP_DRIVER_TYPE_A	(1 << 23)	/* Host supports Driver Type A */
 #define MMC_CAP_DRIVER_TYPE_C	(1 << 24)	/* Host supports Driver Type C */
 #define MMC_CAP_DRIVER_TYPE_D	(1 << 25)	/* Host supports Driver Type D */
-- 
2.20.1

