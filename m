Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E14C76188
	for <linux-mmc@archiver.kernel.org>; Wed,  5 Apr 2023 06:50:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236967AbjDEGuj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 5 Apr 2023 02:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236872AbjDEGui (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Apr 2023 02:50:38 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054CC4200
        for <linux-mmc@vger.kernel.org>; Tue,  4 Apr 2023 23:50:37 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id y20so45369689lfj.2
        for <linux-mmc@vger.kernel.org>; Tue, 04 Apr 2023 23:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680677435;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=htFleaT/35Wjah78kezRl5LI+byd+7VcD53GDDOkAxc=;
        b=tuEyDg0Aqj7IhYFmgZGVe9k/t5Xn0hgxfRE4pF5UxJE793NNpx66snKWdLvDVypXdu
         AXT5JmeHVy9nEU4J/963/pJ3HnV4ZYGje5uR4hXtxp6oXyCCuY0u/JiA8RloiYp87WGs
         KBig72/DAEnoIKjZ7peOe8kchx9+5EJCVfgxev15TIV6MQFtGQRscCVsFvrsOuxwMcXw
         fJ734NL6O4rIkBjcqpbnRQB5AtPTjv3RvVR5xe4xVCvlPtXjuu9GOV3qzzc9YZ+0XBNW
         LGInzH33p401dYAEZPnA9fOJdmv344OMoHIoeFHZjFDOIJCMg9yvroeiCV01Vz/yTCXD
         CGGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680677435;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=htFleaT/35Wjah78kezRl5LI+byd+7VcD53GDDOkAxc=;
        b=W4RjryPoexUnFCTZYbIw3d1jXeu02R5m/qD54I4dTe/QLc5a5hNoGfHqGEyUL8cRyL
         wf8PLO90MX+JtNPxI5C21WhCUm2xqC9CLA7y4gHxs0s5woYs715eMlfS3pbOacBMrofa
         tE4jEs55ql2yIve7xfJom+wZNf7svrxyfc4SSFQrcba6rdh67mJ0gn+Rk1XO4DMSsNtm
         FrmZy3CXQQSbZokYCgTB5hOHv67NcgFLWyaY5dRHwkrNcNgxFv7vT7MjNQSdRI5Z42JN
         5vs4t81hhvV+t6Pz93HQz1edgdhhy+cpDSS35nTdhEvAt6MxHonyfBvs9RJYME4ZH5Wp
         wVEw==
X-Gm-Message-State: AAQBX9foSANb3CcD4JsoeOjD1JDkAAPS458fIL9piZC2sV1wbOjpzm+e
        cLbhnguGXIoJFb1MP+a7no9PsQ==
X-Google-Smtp-Source: AKy350avGN+mdyKp1Y9p5PspjESseEq6nRVNgL1kpPC1dh54xzy6aldKYul26M2/CP56SKCcB9pX5w==
X-Received: by 2002:ac2:5482:0:b0:4db:3e2d:3efc with SMTP id t2-20020ac25482000000b004db3e2d3efcmr1215834lfk.10.1680677435406;
        Tue, 04 Apr 2023 23:50:35 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id z19-20020ac25df3000000b004eb274b3a43sm2683086lfq.134.2023.04.04.23.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 23:50:34 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 05 Apr 2023 08:50:28 +0200
Subject: [PATCH 02/13] mmc: mmci: Clear busy_status when starting command
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230405-pl180-busydetect-fix-v1-2-28ac19a74e5e@linaro.org>
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

If we are starting a command which can generate a busy
response, then clear the variable host->busy_status
if the variant is using a ->busy_complete callback.

We are lucky that the member is zero by default and
hopefully always gets cleared in the ->busy_complete
callback even on errors, but it's just fragile so
make sure it is always initialized to zero.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/mmci.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index bc150c0d5eed..3e08b2e95550 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1238,17 +1238,22 @@ mmci_start_command(struct mmci_host *host, struct mmc_command *cmd, u32 c)
 			c |= host->variant->cmdreg_srsp;
 	}
 
-	if (host->variant->busy_timeout && cmd->flags & MMC_RSP_BUSY) {
-		if (!cmd->busy_timeout)
-			cmd->busy_timeout = 10 * MSEC_PER_SEC;
+	if (cmd->flags & MMC_RSP_BUSY) {
+		if (host->ops->busy_complete)
+			host->busy_status = 0;
 
-		if (cmd->busy_timeout > host->mmc->max_busy_timeout)
-			clks = (unsigned long long)host->mmc->max_busy_timeout * host->cclk;
-		else
-			clks = (unsigned long long)cmd->busy_timeout * host->cclk;
+		if (host->variant->busy_timeout) {
+			if (!cmd->busy_timeout)
+				cmd->busy_timeout = 10 * MSEC_PER_SEC;
+
+			if (cmd->busy_timeout > host->mmc->max_busy_timeout)
+				clks = (unsigned long long)host->mmc->max_busy_timeout * host->cclk;
+			else
+				clks = (unsigned long long)cmd->busy_timeout * host->cclk;
 
-		do_div(clks, MSEC_PER_SEC);
-		writel_relaxed(clks, host->base + MMCIDATATIMER);
+			do_div(clks, MSEC_PER_SEC);
+			writel_relaxed(clks, host->base + MMCIDATATIMER);
+		}
 	}
 
 	if (host->ops->pre_sig_volt_switch && cmd->opcode == SD_SWITCH_VOLTAGE)

-- 
2.39.2

