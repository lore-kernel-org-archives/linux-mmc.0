Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF3EC77B61
	for <linux-mmc@archiver.kernel.org>; Sat,  8 Apr 2023 22:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbjDHWAk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 8 Apr 2023 18:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjDHWAi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 8 Apr 2023 18:00:38 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85D4558A
        for <linux-mmc@vger.kernel.org>; Sat,  8 Apr 2023 15:00:36 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id z8so4100852lfb.12
        for <linux-mmc@vger.kernel.org>; Sat, 08 Apr 2023 15:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680991235;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lw3XG8iQC5gX8Uhau9KwDjMohP4XjFt98wfUm6sYpak=;
        b=Jr+zCxPVmuN7u4WW0VprumqpO+7exh+l2L9UIvs1dUFOOCJKfeDvUS5yAUMg1QEDbb
         /A2iAz3VS+nE9jZSOzuAVl4qLiQfMbIU45pNx3rZ1rqzUPL+z+kNlCfhP8Art1t03UP3
         kaihr2lWbL/SKEyKTDpH7oPkQny6k83Gg/zNocJ1z9gISwHWnfhkuuFV+K2OWq9k1bUq
         n4UjFnrmKdltwmfp6lle9eX/e1NqZZ6dZH/QN1tbeF7LdfrrgiFi5gtPl+t5dEEWYzLJ
         L38TSdLnMAaivCzEz7kRfrsX1rjRNG6n+v+uAJb/UT6uMCKR04dNg8sbzZwZDZuwewo+
         rWGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680991235;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lw3XG8iQC5gX8Uhau9KwDjMohP4XjFt98wfUm6sYpak=;
        b=2w6gqhno2iyDp4TYw9VXEBD7NinR6iwA0d1fp4+6iV1B+BpLetGvODH5pPaiOYXkIW
         kfkgCd8Jq7JGnQXtqvn/gcnxgCKmOG0/pfY5HmIEfUo9i6S5FaAJFdlKFdPWV6ePkR0o
         IJyuw6XDwM4OdBc9i/G1AyiVG24sp5xYvV/tWP0AymbyyTG6LcI31W1BMC2kQgrIGpTR
         o0jMnOJwTGDWlv+fp4BygkaBRUn/glbt0q5cZmA0JpiLgl4av5DYri7HVFiHOx+ZUtR1
         nn0aMhpxRw8JJNwGhoLw4KmwxSpJ+EaBxMvUBNQpTthPgcGY+lFWGx4G5HY2lljK8oUY
         ap3g==
X-Gm-Message-State: AAQBX9eBwStELZjiJREq3a05BjaEv+9S3FDgcYNu8Oxm8cYOjKjFUef1
        qlaKVMAa0Joq8c1vm8OT7EG6VQ==
X-Google-Smtp-Source: AKy350Y9kOlYLM2ZeuRBQ6/s7P5O+DOglnhe/y95JUOU6D8fllrRE/bjLDxQz2noH/HlTJqP2ClHDg==
X-Received: by 2002:ac2:547b:0:b0:4d8:82d5:f5bc with SMTP id e27-20020ac2547b000000b004d882d5f5bcmr811710lfn.34.1680991235145;
        Sat, 08 Apr 2023 15:00:35 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id v9-20020a056512048900b004e9cad1cd7csm1328904lfq.229.2023.04.08.15.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Apr 2023 15:00:34 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 09 Apr 2023 00:00:22 +0200
Subject: [PATCH v2 01/12] mmc: mmci: Clear busy_status when starting
 command
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230405-pl180-busydetect-fix-v2-1-eeb10323b546@linaro.org>
References: <20230405-pl180-busydetect-fix-v2-0-eeb10323b546@linaro.org>
In-Reply-To: <20230405-pl180-busydetect-fix-v2-0-eeb10323b546@linaro.org>
To:     Yann Gautier <yann.gautier@foss.st.com>,
        Stefan Hansson <newbyte@disroot.org>,
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
ChangeLog v1->v2:
- Unconditionally clear host->busy_status if we get a
  busy response.
---
 drivers/mmc/host/mmci.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index b9e5dfe74e5c..9b48df842425 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1238,17 +1238,21 @@ mmci_start_command(struct mmci_host *host, struct mmc_command *cmd, u32 c)
 			c |= host->variant->cmdreg_srsp;
 	}
 
-	if (host->variant->busy_timeout && cmd->flags & MMC_RSP_BUSY) {
-		if (!cmd->busy_timeout)
-			cmd->busy_timeout = 10 * MSEC_PER_SEC;
+	if (cmd->flags & MMC_RSP_BUSY) {
+		host->busy_status = 0;
 
-		if (cmd->busy_timeout > host->mmc->max_busy_timeout)
-			clks = (unsigned long long)host->mmc->max_busy_timeout * host->cclk;
-		else
-			clks = (unsigned long long)cmd->busy_timeout * host->cclk;
+		if (host->variant->busy_timeout) {
+			if (!cmd->busy_timeout)
+				cmd->busy_timeout = 10 * MSEC_PER_SEC;
 
-		do_div(clks, MSEC_PER_SEC);
-		writel_relaxed(clks, host->base + MMCIDATATIMER);
+			if (cmd->busy_timeout > host->mmc->max_busy_timeout)
+				clks = (unsigned long long)host->mmc->max_busy_timeout * host->cclk;
+			else
+				clks = (unsigned long long)cmd->busy_timeout * host->cclk;
+
+			do_div(clks, MSEC_PER_SEC);
+			writel_relaxed(clks, host->base + MMCIDATATIMER);
+		}
 	}
 
 	if (host->ops->pre_sig_volt_switch && cmd->opcode == SD_SWITCH_VOLTAGE)

-- 
2.39.2

