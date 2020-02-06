Return-Path: <SRS0=1u/W=32=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B64DC33CAC
	for <linux-mmc@archiver.kernel.org>; Thu,  6 Feb 2020 16:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1250821775
	for <linux-mmc@archiver.kernel.org>; Thu,  6 Feb 2020 16:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eH2NDF96"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbgBFQV0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 6 Feb 2020 11:21:26 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:53569 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbgBFQV0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 6 Feb 2020 11:21:26 -0500
Received: by mail-pj1-f66.google.com with SMTP id n96so177930pjc.3
        for <linux-mmc@vger.kernel.org>; Thu, 06 Feb 2020 08:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QlJKHAGPQncF0D0oCcwGP81Vimrl3GRnoMKNObOvMNY=;
        b=eH2NDF96uK/D4Lwh2yni2ATG9os2I6zbN0CeYC5MvFVjpyJ72kGNZJ59YvNPLLW/r3
         Xb/jJsZAD9/Gg6iAxWj7se8HvI36n9xOJbhjDoxash7uzRh/Q4unGYsFHNBKeInVGv3e
         NhLc7BSta+YYrLo+LLAnNkFDWr8aDzuUnuxsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QlJKHAGPQncF0D0oCcwGP81Vimrl3GRnoMKNObOvMNY=;
        b=ek+v8tMwepsubWFiILYRHmpOUGbBWO4tnVp1oSkmpV0ow5QFPlhcYr7dlHruJN/9Tc
         hNJz/EPHgxPzXU5V0zStDO3gl3Xg6FfUu1Zlg/68ngx4DsVzz3pOhvuJYdzmihi29PG9
         jHpv+ifAEDYGL4LP5uoisLRVVYNESP7t/rFdzM3q0sB/PjUA3t1fFYY9ZZX+8WUrq1uU
         a9tpMyxP1FCYsasqRFmSqU/gK+nzszTF0dqqfY9TE6CovD9PPRahW06oaQQCtTVCgQ8J
         PswzCNR5N1ox8p9K5h90xXzGJY2LTVAUpMblxP9ciKAipOKFHY+TeutriHRHAZ99aDp4
         eEAA==
X-Gm-Message-State: APjAAAWoXjPWhYkpKkeXe0ab89IMJJLHDTri7y5QFM0ZJNhwqNCM0aMt
        jD2YdjybELPcyxTv94vFmB4BtQ==
X-Google-Smtp-Source: APXvYqzdXdztcbyt8vZ93QCo79sb52l3J1PF4VvWaL/OhPnYudGqSKOKkxdxzAyzoIMPAxeoiIorNA==
X-Received: by 2002:a17:902:6809:: with SMTP id h9mr4635684plk.32.1581006085723;
        Thu, 06 Feb 2020 08:21:25 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id 13sm3930697pfj.68.2020.02.06.08.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 08:21:25 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        Ritesh Harjani <riteshh@codeaurora.org>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH] mmc: sdhci-msm: Mark sdhci_msm_cqe_disable static
Date:   Thu,  6 Feb 2020 08:21:24 -0800
Message-Id: <20200206162124.201195-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This function is not exported and only used in this file. Mark it
static.

Cc: Ritesh Harjani <riteshh@codeaurora.org>
Cc: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/mmc/host/sdhci-msm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index c3a160c18047..3955fa5db43c 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -1590,7 +1590,7 @@ static u32 sdhci_msm_cqe_irq(struct sdhci_host *host, u32 intmask)
 	return 0;
 }
 
-void sdhci_msm_cqe_disable(struct mmc_host *mmc, bool recovery)
+static void sdhci_msm_cqe_disable(struct mmc_host *mmc, bool recovery)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
 	unsigned long flags;
-- 
Sent by a computer, using git, on the internet

