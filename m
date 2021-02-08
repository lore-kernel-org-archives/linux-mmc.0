Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54945C433E6
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Feb 2021 13:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 139B064E54
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Feb 2021 13:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbhBHNsD (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 8 Feb 2021 08:48:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbhBHNrd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Feb 2021 08:47:33 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E7CC061221;
        Mon,  8 Feb 2021 05:46:03 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id r21so959366wrr.9;
        Mon, 08 Feb 2021 05:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t7JqhDBA+qZoqkrdN9PcsP0EetWn4+vl99SpYh6ksj0=;
        b=dmCCkeRW+O5UOMgJIBq61K/T7yrs6ECwcv6GtnoRIjrq+qT40KQzK9ap36oR2mxR3n
         iJjgOtIQ0DPDJzh3QFlLkuqOoFRzTIDNCwEwC4r7VSrGQHDIhqrre3OxXZ9tn3P5kYOL
         M8UiH8XO7QS5jBJSURGraZq/qSGAkB+hqy8U4BnMrNXucC6+UcywSvAh6AF9lb7jF6yX
         LZ2RgsILhlLPL7w3XppqxMyO7P/2ZMhzo448Vs9+4UtGfkDMBunpHYYaKnJeKCDlKr4U
         sS0Gg82NluMvk46WL8G1cYUtiF8qdYkNJJ7tuFfSmCHcwYBKF+cf+/PUlvqQGeAstL+f
         noNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=t7JqhDBA+qZoqkrdN9PcsP0EetWn4+vl99SpYh6ksj0=;
        b=qlVfMhmp/xACu73394WkKtvqUYVXvcltj5Xv2VlPFDOYPueztX9tOhzBO+sN4nqupx
         58+6p8yIexpBADkIfqHejx/nvh59fBssYEcmBqJ+plfETsC/vRXX6zPo/u5xqhFnwtXr
         Tas97FGk6gVlp3n01IEfXhxzLgd8b1vetTn2yM9w0/kJHqRKdYNC2IXOxfBXLMYxBVTf
         RMxhglQ69kS2dC4hS3ljg0G2lyAPzBMeE/VTgb0SAMSabEHw6vpp5hOKYokflhEMKsBQ
         dOfUyR8lOuJmjk5jXs/iDLd/5VMdoNsoUaEJt3Yfr+JR+QoTSnkbQAlFDYYZwye44RMu
         gy7Q==
X-Gm-Message-State: AOAM532/fogv55ldSYAU1sJKVXE87PuY7Tbq6kvgA95EFq00ElOxEZvK
        JSvXLzaaz7mwGav9dhqi2vU9xWCZVo/CaQ==
X-Google-Smtp-Source: ABdhPJxc04wm7pEKEuYZKZLeZnD9PBYpBeCOSWHL10ReYbPcvOIBqc112cmGEZ5PDHm6riL4LHTajA==
X-Received: by 2002:adf:dd83:: with SMTP id x3mr19731086wrl.421.1612791961907;
        Mon, 08 Feb 2021 05:46:01 -0800 (PST)
Received: from stitch.. ([80.71.140.73])
        by smtp.gmail.com with ESMTPSA id m24sm20640696wmi.24.2021.02.08.05.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 05:46:00 -0800 (PST)
Sender: Emil Renner Berthing <emil.renner.berthing@gmail.com>
From:   Emil Renner Berthing <kernel@esmil.dk>
To:     =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        linux-mmc@vger.kernel.org
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: cb710: Use new tasklet API
Date:   Mon,  8 Feb 2021 14:45:51 +0100
Message-Id: <20210208134551.39696-1-kernel@esmil.dk>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This converts the driver to use the new tasklet API introduced in
commit 12cc923f1ccc ("tasklet: Introduce new initialization API")

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---
 drivers/mmc/host/cb710-mmc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/cb710-mmc.c b/drivers/mmc/host/cb710-mmc.c
index e84ed84ea4cc..6d623b2681c3 100644
--- a/drivers/mmc/host/cb710-mmc.c
+++ b/drivers/mmc/host/cb710-mmc.c
@@ -646,14 +646,14 @@ static int cb710_mmc_irq_handler(struct cb710_slot *slot)
 	return 1;
 }
 
-static void cb710_mmc_finish_request_tasklet(unsigned long data)
+static void cb710_mmc_finish_request_tasklet(struct tasklet_struct *t)
 {
-	struct mmc_host *mmc = (void *)data;
-	struct cb710_mmc_reader *reader = mmc_priv(mmc);
+	struct cb710_mmc_reader *reader = from_tasklet(reader, t,
+						       finish_req_tasklet);
 	struct mmc_request *mrq = reader->mrq;
 
 	reader->mrq = NULL;
-	mmc_request_done(mmc, mrq);
+	mmc_request_done(mmc_from_priv(reader), mrq);
 }
 
 static const struct mmc_host_ops cb710_mmc_host = {
@@ -718,8 +718,8 @@ static int cb710_mmc_init(struct platform_device *pdev)
 
 	reader = mmc_priv(mmc);
 
-	tasklet_init(&reader->finish_req_tasklet,
-		cb710_mmc_finish_request_tasklet, (unsigned long)mmc);
+	tasklet_setup(&reader->finish_req_tasklet,
+		      cb710_mmc_finish_request_tasklet);
 	spin_lock_init(&reader->irq_lock);
 	cb710_dump_regs(chip, CB710_DUMP_REGS_MMC);
 
-- 
2.30.0

