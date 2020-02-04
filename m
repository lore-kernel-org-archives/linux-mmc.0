Return-Path: <SRS0=92ZL=3Y=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0659C3524B
	for <linux-mmc@archiver.kernel.org>; Tue,  4 Feb 2020 08:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6EDA2087E
	for <linux-mmc@archiver.kernel.org>; Tue,  4 Feb 2020 08:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mRTuBhRB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgBDIz0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 4 Feb 2020 03:55:26 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37802 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgBDIz0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Feb 2020 03:55:26 -0500
Received: by mail-lj1-f193.google.com with SMTP id v17so17690070ljg.4
        for <linux-mmc@vger.kernel.org>; Tue, 04 Feb 2020 00:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=76qzmT2N+APJISrybQoaQycmewwxQpEPkoOAn/iBjYI=;
        b=mRTuBhRBZ82PkPR7LXi/V9bxQp3U2BR2gSjOJVux+AEKQNVsxPOp1fXrgaQWGUBvRs
         FPuJfvGjDQeUpv+X2frr21Oz/3aiaXuIGiqznJF7edUyw1w3hEYX2XTFV2Z9UA8wd/4D
         mU6OHbfHnKKoPwXdA6h+GVJSbcjaxNFuOu6yC5bYNtZxqQ7KwGiOgLMt0xHxn2fvCt+6
         ZjgwTrGw7UVMvVMoYjSStHvKUKRBEO2odeGKXsRK/biDa33GRLWKpGfe2cBAQqAKMBxC
         Qt97cO9ASTdzjFpCN/mltO51UOc58eKmA9CfkuLW7vXKTQNAGb5Tof+mQlWl7LWkgLz5
         AFdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=76qzmT2N+APJISrybQoaQycmewwxQpEPkoOAn/iBjYI=;
        b=jcWFnvmqe2y7EIgBHI5rzUrxfjtUloSfKyqGfuovolM3X7m1z2QP0kJHk9aIXH06Gm
         REl1hLOuAEyxvQOVY86WvSYaVXGlAWN66AEC0WTnJ8s4Xld29AGUsrtZ0nyyqccvL+KS
         kJgJkIH461V6JtR6PVtHvz5vozF+cP8jUktW82HdJYSCMaW9LyqdEngfBFlMR2CTzxBo
         TebezobFnyg552aOGPrc9SQkqP778nGKrykde7MJScQFohObzjSBovWsGPTELMD+6UKT
         Zr6oLb1W4CWMvJwmC543GPyN56ktvm1mHH/wMEnEyg2DpoNSTwhVk5M4fdAHbwXxIpXa
         0Gkw==
X-Gm-Message-State: APjAAAU5UG/0a9qx8uN0xkoXCncP7ogVUxjxActaNbClNYG7/iAkJl9h
        0gam8m1mj4OfjPml+PEPEJy5X7AuX8o=
X-Google-Smtp-Source: APXvYqyk36ZqUcx/HJiF7kdli1JGrsdOSnZT4EvHE34Z+OOUynosTyy8bF3k69/OJn9iK5jum8m1XQ==
X-Received: by 2002:a2e:9b05:: with SMTP id u5mr16835282lji.59.1580806523679;
        Tue, 04 Feb 2020 00:55:23 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id n2sm11156283ljj.1.2020.02.04.00.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 00:55:23 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Shawn Lin <shawn.lin@rock-chips.com>, mirq-linux@rere.qmqm.pl
Subject: [PATCH 11/12] mmc: core: Fixup support for HW busy detection for HPI commands
Date:   Tue,  4 Feb 2020 09:54:48 +0100
Message-Id: <20200204085449.32585-12-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200204085449.32585-1-ulf.hansson@linaro.org>
References: <20200204085449.32585-1-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

In case the host specify a max_busy_timeout, we need to validate that the
needed timeout for the HPI command conforms to that requirement. If that's
not the case, let's convert from a R1B response to a R1 response, as to
instruct the host to avoid HW busy detection.

Additionally, when R1B is used we must also inform the host about the busy
timeout for the command, so let's do that via updating cmd.busy_timeout.

Finally, when R1B is used and in case the host supports HW busy detection,
there should be no need for doing polling, so then skip that.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/mmc_ops.c | 36 +++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 87d54a559b31..aa0cab190cd8 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -832,27 +832,41 @@ int mmc_bus_test(struct mmc_card *card, u8 bus_width)
 static int mmc_send_hpi_cmd(struct mmc_card *card)
 {
 	unsigned int busy_timeout_ms = card->ext_csd.out_of_int_time;
+	struct mmc_host *host = card->host;
+	bool use_r1b_resp = true;
 	struct mmc_command cmd = {};
-	unsigned int opcode;
 	int err;
 
-	opcode = card->ext_csd.hpi_cmd;
-	if (opcode == MMC_STOP_TRANSMISSION)
+	cmd.opcode = card->ext_csd.hpi_cmd;
+	cmd.arg = card->rca << 16 | 1;
+
+	/*
+	 * Make sure the host's max_busy_timeout fit the needed timeout for HPI.
+	 * In case it doesn't, let's instruct the host to avoid HW busy
+	 * detection, by using a R1 response instead of R1B.
+	 */
+	if (host->max_busy_timeout && busy_timeout_ms > host->max_busy_timeout)
+		use_r1b_resp = false;
+
+	if (cmd.opcode == MMC_STOP_TRANSMISSION && use_r1b_resp) {
 		cmd.flags = MMC_RSP_R1B | MMC_CMD_AC;
-	else if (opcode == MMC_SEND_STATUS)
+		cmd.busy_timeout = busy_timeout_ms;
+	} else {
 		cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
+		use_r1b_resp = false;
+	}
 
-	cmd.opcode = opcode;
-	cmd.arg = card->rca << 16 | 1;
-
-	err = mmc_wait_for_cmd(card->host, &cmd, 0);
+	err = mmc_wait_for_cmd(host, &cmd, 0);
 	if (err) {
-		pr_warn("%s: error %d interrupting operation. "
-			"HPI command response %#x\n", mmc_hostname(card->host),
-			err, cmd.resp[0]);
+		pr_warn("%s: HPI error %d. Command response %#x\n",
+			mmc_hostname(host), err, cmd.resp[0]);
 		return err;
 	}
 
+	/* No need to poll when using HW busy detection. */
+	if (host->caps & MMC_CAP_WAIT_WHILE_BUSY && use_r1b_resp)
+		return 0;
+
 	/* Let's poll to find out when the HPI request completes. */
 	return mmc_poll_for_busy(card, busy_timeout_ms, MMC_BUSY_HPI);
 }
-- 
2.17.1

