Return-Path: <SRS0=Gh8q=EM=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E49EDC388F7
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Nov 2020 02:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 908272075A
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Nov 2020 02:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MiUWaRZj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbgKFC3K (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 5 Nov 2020 21:29:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbgKFC3I (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Nov 2020 21:29:08 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A881C0613D2
        for <linux-mmc@vger.kernel.org>; Thu,  5 Nov 2020 18:29:08 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id z24so2785236pgk.3
        for <linux-mmc@vger.kernel.org>; Thu, 05 Nov 2020 18:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Cx3VoQbaR+Z5v6mQk7FBIZ1yEyqwjxeeLB00ez5Q8ag=;
        b=MiUWaRZjxNWNLJlY97uyYRnFY3hLDVTrcG8EYyZuJYr2d5xfpNdLTnXBcGGhXJATKQ
         ASMZwZ+k7MDAq0hH52UczCF+gNKBiBtPNBk719ajwrAkl/BQ0oSTjgAoYjnUsbqsvKXg
         /nfrYyhTa3PTnXpNJdHaBAcGYTKlBftdJhrE6HENKNd8Jab11KDOyaUEKdaLQW1GWDPy
         AuBI4+EG6CSbPDFnJ06xN6zcY7k7lHU65KKuw+vpGC5z6CdexR9lMBhZBDK+bxlTnCIn
         t0cj0oY/4dFvSSicw006yG5TPTUf9ptLMYKUDGPRa1av6h/FnAzp9nI/4FH4dkxN/GC2
         l8aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cx3VoQbaR+Z5v6mQk7FBIZ1yEyqwjxeeLB00ez5Q8ag=;
        b=hzQ+1MaR9EvQKXvYw/bORzFzsZ/jGx+bT9I6Lwb1d2fCWfZcJDsG7Lt32B6Z2Jc2WO
         lmIjOL1GxYpunej4XQMIBn2HALAcpT3+RJR6TfyI7+oAmV5LFkETld+EAXiQtWxjECbK
         p+a2rtUczPswd4VPr77SnK30j4woR1fefJtPCAfN/ZbOwnTQut830qgri4vVhPD2MTGK
         V85V5PI79gUM0g87NhB7jpe5Tesz+quPmbzyP8D5exntnLJmimQtRLBfvKu5MofNCv5c
         PjQlufBj1STZyMf91DSqIKPNwClwWkCv7nfeHn8vbrDK4c6qpL6p2D1hrdiPuG+TBMt5
         mloA==
X-Gm-Message-State: AOAM53252KW/LmQBXBrD4lHfcELCk0BRMH4J6t75GM76WMrgcjOzMv/L
        fZQf/yuMWES2DVR8csbrAAspYQ==
X-Google-Smtp-Source: ABdhPJypRNlTCibcoawN7Q6kChCkjFXba6Cszjbj36YKmhg/NcAC4TV+sGQVNS4zQa3kZJ2wWLZGOA==
X-Received: by 2002:aa7:8bdd:0:b029:18b:9cb:dead with SMTP id s29-20020aa78bdd0000b029018b09cbdeadmr5304786pfd.24.1604629748103;
        Thu, 05 Nov 2020 18:29:08 -0800 (PST)
Received: from localhost.localdomain (p784a66b9.tkyea130.ap.so-net.ne.jp. [120.74.102.185])
        by smtp.gmail.com with ESMTPSA id m13sm3703040pjr.30.2020.11.05.18.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 18:29:07 -0800 (PST)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC PATCH v3.1 23/27] mmc: sdhci-uhs2: add pre-detect_init hook
Date:   Fri,  6 Nov 2020 11:27:22 +0900
Message-Id: <20201106022726.19831-24-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201106022726.19831-1-takahiro.akashi@linaro.org>
References: <20201106022726.19831-1-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Ben Chuang <ben.chuang@genesyslogic.com.tw>

This "pre" hook for detect_init(), uhs2_pre_detect_init, will be required
to enable UHS-II support, at least, on GL9755.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 drivers/mmc/host/sdhci-uhs2.c | 3 +++
 drivers/mmc/host/sdhci.h      | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index 5d3362ea138f..3dd81c89d8f1 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -1631,6 +1631,9 @@ static int sdhci_uhs2_do_detect_init(struct mmc_host *mmc)
 	DBG("%s: begin UHS2 init.\n", __func__);
 	spin_lock_irqsave(&host->lock, flags);
 
+	if (host->ops && host->ops->uhs2_pre_detect_init)
+		host->ops->uhs2_pre_detect_init(host);
+
 	if (sdhci_uhs2_interface_detect(host)) {
 		pr_warn("%s: cannot detect UHS2 interface.\n",
 			mmc_hostname(host->mmc));
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index b1d856664b58..4e2cb73a63bd 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -723,6 +723,7 @@ struct sdhci_ops {
 				struct mmc_request *mrq);
 	void    (*dump_vendor_regs)(struct sdhci_host *host);
 	void	(*dump_uhs2_regs)(struct sdhci_host *host);
+	void    (*uhs2_pre_detect_init)(struct sdhci_host *host);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
2.28.0

