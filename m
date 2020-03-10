Return-Path: <SRS0=AZQG=43=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01876C18E5B
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Mar 2020 15:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD54D215A4
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Mar 2020 15:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d3gT/cV7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgCJPdw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 10 Mar 2020 11:33:52 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34844 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgCJPdw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Mar 2020 11:33:52 -0400
Received: by mail-lj1-f195.google.com with SMTP id u12so10445782ljo.2
        for <linux-mmc@vger.kernel.org>; Tue, 10 Mar 2020 08:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0AS4iD/EqLgDWiA/Em9kdqcmCXIvsjkX4pJSBWor6Nk=;
        b=d3gT/cV7yOBnJzdr1xBBXMnSAnWAFLDvl7xcHlspC0LOGFpsE72iS1YE9y9y1hng/8
         sVSc2dRPuFLTwq5AA5GAA4NjVCYrvI4spfy6YFz9qV6Bkufx+syjQ/YfV09B0Hw8grLz
         scrjQBrAxtPZsDpMoTyYsktdNQ9Dw5JtGWltX2b05iZX01gTZ84NVjkd0NQd5efjTm5D
         0jg3uvhnLV4DfctHeY6npC1Klk3gdFU5zG+79f9ngEBV4TGe8vvilXAi7NKk1XBCnUDA
         ASRWW/gH6EKTbIsc9nX+RY5S3+YDYQPBYp9pk307/CS9FDalkm0EFzDtt65dofgKd3TV
         eQqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0AS4iD/EqLgDWiA/Em9kdqcmCXIvsjkX4pJSBWor6Nk=;
        b=nauPSvJKqIuge76MCDgX5WwBXq2nmNhdu8uZon/UrMHtQqqY8Squ8pNZttOcYb4/4L
         U8RaYjnSpJnAlofPfqMyJoeIwbBrKaG7wZParkyqwr8ZUz5Bsyl70gvJ2SRqFu11aT/0
         O1UrzbbJy0KlYw0vgolAsTGRX/y1tJ3btG82ZO7P0gCQK6/7/G70nV9ZCD8j9UNGYjW5
         4zrPwsr/H4JU4ll8X2SDucebMTxSv9F20YMKonzxMSZS+RLL4TNKQxGRCqO2F2Ub7En8
         4fFTe+LotVpLg9eoDoKtlSbW5hYJyjzL+TMwiYDrIepYih0f4Y8blA2riOc0eiIRn50M
         O/5Q==
X-Gm-Message-State: ANhLgQ2f0XkMWuapeFCxOHU0Q4PBEIVoAVyZ879Z3mnHHEC30fMNZEP/
        Ljml7xU4g1DBIugHtRda+d3YG/5zmMU=
X-Google-Smtp-Source: ADFU+vvDpOfAMYNpRyOb2/6Q/jBOsY7V3AOt4HZMfeH3/3M38eXJsrZFEEpUT+38SSIr+2kEgT0qCg==
X-Received: by 2002:a05:651c:414:: with SMTP id 20mr12234008lja.165.1583854427939;
        Tue, 10 Mar 2020 08:33:47 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id c22sm17283776lfi.41.2020.03.10.08.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 08:33:46 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Shawn Lin <shawn.lin@rock-chips.com>, mirq-linux@rere.qmqm.pl,
        Bitan Biswas <bbiswas@nvidia.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Jon Hunter <jonathanh@nvidia.com>, stable@vger.kernel.org
Subject: [PATCH 1/4] mmc: core: Allow host controllers to require R1B for CMD6
Date:   Tue, 10 Mar 2020 16:33:37 +0100
Message-Id: <20200310153340.5593-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200310153340.5593-1-ulf.hansson@linaro.org>
References: <20200310153340.5593-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

It has turned out that some host controllers can't use R1B for CMD6 and
other commands that have R1B associated with them. Therefore invent a new
host cap, MMC_CAP_NEED_RSP_BUSY to let them specify this.

In __mmc_switch(), let's check the flag and use it to prevent R1B responses
from being converted into R1. Note that, this also means that the host are
on its own, when it comes to manage the busy timeout.

Suggested-by: Sowjanya Komatineni <skomatineni@nvidia.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/mmc_ops.c | 6 ++++--
 include/linux/mmc/host.h   | 1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index da425ee2d9bf..e025604e17d4 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -542,9 +542,11 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 	 * If the max_busy_timeout of the host is specified, make sure it's
 	 * enough to fit the used timeout_ms. In case it's not, let's instruct
 	 * the host to avoid HW busy detection, by converting to a R1 response
-	 * instead of a R1B.
+	 * instead of a R1B. Note, some hosts requires R1B, which also means
+	 * they are on their own when it comes to deal with the busy timeout.
 	 */
-	if (host->max_busy_timeout && (timeout_ms > host->max_busy_timeout))
+	if (!(host->caps & MMC_CAP_NEED_RSP_BUSY) && host->max_busy_timeout &&
+	    (timeout_ms > host->max_busy_timeout))
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

