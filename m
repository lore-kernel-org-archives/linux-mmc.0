Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 816D0C636D4
	for <linux-mmc@archiver.kernel.org>; Mon, 13 Feb 2023 13:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjBMNhU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 13 Feb 2023 08:37:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjBMNhT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Feb 2023 08:37:19 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50FC15279
        for <linux-mmc@vger.kernel.org>; Mon, 13 Feb 2023 05:37:18 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id d40so11663429eda.8
        for <linux-mmc@vger.kernel.org>; Mon, 13 Feb 2023 05:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VWQukUmOBboD3ve0t2WRko6zyPeadupb+Yh41Dodqd0=;
        b=Zye4jEMN+Yl53MaO/BHLu1SWyGYajA+w0bxj16SpsO3ZyIzI5bBZaVnaZfcgH2VRkC
         KPmKoFmw+sXR3Sl06y62D5DuLImsp/nViquQ4hMy9hbvpMRLXCykeQSGbxlEqr0YMgMs
         1yGIUY4MgPsuOLelM/DhBm5CnB9y7QtYB19Gp0RhLFxrH5a7A53+wQN4i/BFkQnmfFZv
         7qTbqvP6pO/zgzTRv/yuNC+GC02cXw6BJVNB3W3bgAD4Et62spQt480dIZLc1nqWgEZI
         TGRhZ5x1rf390PSpkuRNkB8eDAWs+b9rakkX6iJQT300BJWRgN3DNfvLKsglcF28nnCU
         D9Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VWQukUmOBboD3ve0t2WRko6zyPeadupb+Yh41Dodqd0=;
        b=AqQfGV6XJ2kfLi7i9hXjhUS9RRYLhhUwv8chZXaYTAKYLbRwlgcw4HK3rN+nlb4VAr
         myPS8UX7GeqZwaIQ/RCAXrOg5d2918eb7SnmDkLSTRjD2cbVbYnuihAqM6bpwSSqWX9q
         pCXq9Iu4EfJVLjpXcqtTOY53NZ6uNuLUrk0m8ZlxpKpW3HmodGK8qPfiezVuI7uTdi9z
         048yNLh25jctWFfEgyDqjftcYBv5rEKeeS5K44sYicydWpe+18qHqLDdF3e8OQeLmRdo
         GcYHWWeXFeC8B4OzTddaPLUZ0SMZJqEBSHQi9gFhRrAcQ/aHKgiiZKn0ltonr+CQp1JV
         Ozrg==
X-Gm-Message-State: AO0yUKW0bCO31pR9tknON3Vjjo3YXZS9346qD+2+OE9aQWx49/QUE4tH
        v31BGZRi7KQgXbaYH/ss11AxguBwR0Zsn5Jn
X-Google-Smtp-Source: AK7set8Lj62T8qa7+NLRmOhfIL/j5f1E2nG3gDc9Eur29BCoi0KMNC8239U6ykKD/urpvIfb4wxEZw==
X-Received: by 2002:a50:bace:0:b0:4ac:cc7a:24c1 with SMTP id x72-20020a50bace000000b004accc7a24c1mr2235597ede.37.1676295436512;
        Mon, 13 Feb 2023 05:37:16 -0800 (PST)
Received: from uffe-XPS13.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id n25-20020a50c219000000b004a21c9facd5sm6602798edf.67.2023.02.13.05.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 05:37:15 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Avri Altman <avri.altman@wdc.com>,
        Christian Lohle <cloehle@hyperstone.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: core: Align to common busy polling behaviour for mmc ioctls
Date:   Mon, 13 Feb 2023 14:37:07 +0100
Message-Id: <20230213133707.27857-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Let's align to the common busy polling behaviour for mmc ioctls, by
updating the below two corresponding parts, that comes into play when using
an R1B response for a command.

*) A command with an R1B response should be prepared by calling
mmc_prepare_busy_cmd(), which make us respects the host's busy timeout
constraints.
**) When an R1B response is being used and the host also supports HW busy
detection, we should skip to poll for busy completion.

Suggested-by: Christian Loehle <cloehle@hyperstone.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/block.c   | 25 +++++++++++++++++--------
 drivers/mmc/core/mmc_ops.c |  1 +
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 20da7ed43e6d..672ab90c4b2d 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -470,6 +470,8 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 	struct mmc_data data = {};
 	struct mmc_request mrq = {};
 	struct scatterlist sg;
+	bool r1b_resp, use_r1b_resp = false;
+	unsigned int busy_timeout_ms;
 	int err;
 	unsigned int target_part;
 
@@ -545,6 +547,13 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 	    (cmd.opcode == MMC_SWITCH))
 		return mmc_sanitize(card, idata->ic.cmd_timeout_ms);
 
+	/* If it's an R1B response we need some more preparations. */
+	busy_timeout_ms = idata->ic.cmd_timeout_ms ? : MMC_BLK_TIMEOUT_MS;
+	r1b_resp = (cmd.flags & MMC_RSP_R1B) == MMC_RSP_R1B;
+	if (r1b_resp)
+		use_r1b_resp = mmc_prepare_busy_cmd(card->host, &cmd,
+						    busy_timeout_ms);
+
 	mmc_wait_for_req(card->host, &mrq);
 	memcpy(&idata->ic.response, cmd.resp, sizeof(cmd.resp));
 
@@ -596,14 +605,14 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 	if (idata->ic.postsleep_min_us)
 		usleep_range(idata->ic.postsleep_min_us, idata->ic.postsleep_max_us);
 
-	if (idata->rpmb || (cmd.flags & MMC_RSP_R1B) == MMC_RSP_R1B) {
-		/*
-		 * Ensure RPMB/R1B command has completed by polling CMD13 "Send Status". Here we
-		 * allow to override the default timeout value if a custom timeout is specified.
-		 */
-		err = mmc_poll_for_busy(card, idata->ic.cmd_timeout_ms ? : MMC_BLK_TIMEOUT_MS,
-					false, MMC_BUSY_IO);
-	}
+	/* No need to poll when using HW busy detection. */
+	if ((card->host->caps & MMC_CAP_WAIT_WHILE_BUSY) && use_r1b_resp)
+		return 0;
+
+	/* Ensure RPMB/R1B command has completed by polling with CMD13. */
+	if (idata->rpmb || r1b_resp)
+		err = mmc_poll_for_busy(card, busy_timeout_ms, false,
+					MMC_BUSY_IO);
 
 	return err;
 }
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 81c55bfd6e0c..3b3adbddf664 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -575,6 +575,7 @@ bool mmc_prepare_busy_cmd(struct mmc_host *host, struct mmc_command *cmd,
 	cmd->busy_timeout = timeout_ms;
 	return true;
 }
+EXPORT_SYMBOL_GPL(mmc_prepare_busy_cmd);
 
 /**
  *	__mmc_switch - modify EXT_CSD register
-- 
2.34.1

