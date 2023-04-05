Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F5AC76188
	for <linux-mmc@archiver.kernel.org>; Wed,  5 Apr 2023 06:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237041AbjDEGuq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 5 Apr 2023 02:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236985AbjDEGup (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Apr 2023 02:50:45 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA40448C
        for <linux-mmc@vger.kernel.org>; Tue,  4 Apr 2023 23:50:43 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id q16so45304016lfe.10
        for <linux-mmc@vger.kernel.org>; Tue, 04 Apr 2023 23:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680677443;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OU29sLolFBKRRrM2SwmaE/cR08rID9BsyZV6fg0YEgw=;
        b=hV2g54d4uBykzRRJFGdYqiFznq7btZms3bs8Iwn3lBuAlDhrl660foVDXeaOb+yChM
         jLZsKYiFd5IN2KrdTGCQR+qP6Lq+kLNkP3fPvd5HHL9vHgNzHwQQQab4kUMskCSJ5mwf
         dZr3pQD5KswfyfofrZ1is7+YjNm3HbuwRS6BODkaLmfDgmpWswjtMqj14vWcfaq5Evqf
         r8tn6a0iTtDo5r6tU2xfTm8gzgmDhPjDJvHLQMUDAt6B1JddEbV0UgS5v4e3tvu/8kea
         t3F94MMl1byFw4ZZaUn3BhcZR7UMC4fqyL9adCDdMUb5xV2lKRYRfjT8SWDTwr8IcXbR
         vM6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680677443;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OU29sLolFBKRRrM2SwmaE/cR08rID9BsyZV6fg0YEgw=;
        b=gw1rSFFDO3x5ZZiOhhPD4V9FBGAfxcuGgZPCz58Wvd5sWiMUCD42s1ZnN+dEUHdTip
         lary4ILvMaV436QIVqxZ/M7FRRqpJo50sdUhhKMDBwmAUgoLVNOJNaqZd62Kmyq5Ky+Z
         cVYB7Q+wla9a0yyVhWN9FQHWkBbNY2yGRnbz4lByUh0o07mBJK9stZdGmkbgGBYczlMI
         18L7trXk3WqHOjqfL4G0lJXWkfve5sXkU2umVA6qRp95ApW4BevqV+i+xNWDGKBO4fgB
         GWCXgGemIc7zKd61seF0XP4StuWeb0R94Xthb2nUNaCYV4c0I8aAT4j2Voo3ahhtquFj
         EPDw==
X-Gm-Message-State: AAQBX9faJ/pjc0Rh3uzjdroglNAKz1C9DolcqrgeeOHDITE07ZgRtPP+
        xvh9bYHPFiVEuo37sXSmvUi1ug==
X-Google-Smtp-Source: AKy350bXEOoF7rWHlL8fzzu9oZ6TpABcoX6qKLw/hdmAZRE2CTKjJfGoxdLsmUdIdnZ//D83I+EngA==
X-Received: by 2002:a05:6512:971:b0:4dc:537c:9229 with SMTP id v17-20020a056512097100b004dc537c9229mr1340343lft.30.1680677443526;
        Tue, 04 Apr 2023 23:50:43 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id z19-20020ac25df3000000b004eb274b3a43sm2683086lfq.134.2023.04.04.23.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 23:50:43 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 05 Apr 2023 08:50:37 +0200
Subject: [PATCH 11/13] mmc: mmci: mmci_card_busy() from state machine
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230405-pl180-busydetect-fix-v1-11-28ac19a74e5e@linaro.org>
References: <20230405-pl180-busydetect-fix-v1-0-28ac19a74e5e@linaro.org>
In-Reply-To: <20230405-pl180-busydetect-fix-v1-0-28ac19a74e5e@linaro.org>
To:     Stefan Hansson <newbyte@disroot.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     linux-mmc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

If we have a .busy_complete() callback, then the state
machine triggered from the busy detect interrupts will
determine if the busy is complete or not.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/mmci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 92a49726cf83..2779d4985b63 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -339,6 +339,14 @@ static int mmci_card_busy(struct mmc_host *mmc)
 	unsigned long flags;
 	int busy = 0;
 
+	if (host->ops->busy_complete) {
+		if ((host->busy_state == MMCI_BUSY_IDLE) ||
+		    (host->busy_state == MMCI_BUSY_DONE))
+			return 0;
+		else
+			return 1;
+	}
+
 	spin_lock_irqsave(&host->lock, flags);
 	if (readl(host->base + MMCISTATUS) & host->variant->busy_detect_flag)
 		busy = 1;

-- 
2.39.2

