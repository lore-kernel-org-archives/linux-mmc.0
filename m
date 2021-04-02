Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11326C433ED
	for <linux-mmc@archiver.kernel.org>; Fri,  2 Apr 2021 09:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBD6F61106
	for <linux-mmc@archiver.kernel.org>; Fri,  2 Apr 2021 09:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234751AbhDBJYn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 2 Apr 2021 05:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234722AbhDBJYm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Apr 2021 05:24:42 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4DFC0613E6;
        Fri,  2 Apr 2021 02:24:41 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id y6so4880996eds.1;
        Fri, 02 Apr 2021 02:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wn5d++rfmvtELM/sf6Dq+OLRcl7a6HCrW4SVrkbDM3A=;
        b=NYAFfSGS6MdC49j4haXrB23D/MIWZQ/gTnWpmNFkIZHg0+tsWnnqlVYATWd10Xen4r
         ZtQzuitO93IbvbvBQeT6UQ9PWO9Iq5BHghXT8Kk8ujhnAewbTktHDtEGUCM6CTxQrCkV
         wUwJ4UCSf2Rm15zehdFenR+d3cSgnQv6Qx0iWdIeoTKaWvOVgw4aLTanGnyv3iTU3wNa
         MDJNe4USfyXnuwxrqk9dwvGaBPSGQ7lUsri/iRzcj3iilsMAsYER28V+Dk7+UQHOpRvP
         qtNsCN+Oy8oDjqxLr9iI8q/NB8AqYL6ZCde4B5gG+mjg6CeyfkSgr1vRLw3TjNgogrov
         LtCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wn5d++rfmvtELM/sf6Dq+OLRcl7a6HCrW4SVrkbDM3A=;
        b=Fy5HR9ov44iG36INly0rHh1K0of3pLA+oRAEh87/qGpalXxvH8yhovFHtwKiOl48EW
         s0D36JsHU02hWXQpZsgwhVYVIOQOYRmPGXtKQDowYljtYQJ2Hc10sG1j9KDS0lYnvu2l
         tW540ru7hyLfDhd56K+qlXzyQIP8QgBow7R8yeMJeREEDzFl4ezwRoAms0fyfxvdSNpt
         HKe7R7aAs0AeuUgp7iaFDIxXdEOax62E1Bbwdl6L7rdihloNFWLLFdmN099hadPNOAFC
         z5VCrE1zvE3obSvh8CUSCdGLXT2WZ+FPHoDIIABxEpmM47Us51LXHJWxsskIpf7nvPh4
         9AyA==
X-Gm-Message-State: AOAM533q7/aovIrMD17aH8kQRPtRDz0zYVb/rpbkxOL0TvLeHuyKhhWj
        scNnsOBkwyDH3ep2U5J7PeDyMAJinAErhg==
X-Google-Smtp-Source: ABdhPJzJ0BezDEO8rOerqU724YxyL26IsXYWxwiDDWkZVYNVvX/5U1mtPpIN+E4BpVY8s6ASrwvcIQ==
X-Received: by 2002:a05:6402:354d:: with SMTP id f13mr14774871edd.228.1617355480547;
        Fri, 02 Apr 2021 02:24:40 -0700 (PDT)
Received: from localhost.localdomain (ip5f5bec5d.dynamic.kabel-deutschland.de. [95.91.236.93])
        by smtp.gmail.com with ESMTPSA id d16sm247990ejo.85.2021.04.02.02.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 02:24:40 -0700 (PDT)
From:   Bean Huo <huobean@gmail.com>
To:     ulf.hansson@linaro.org, yoshihiro.shimoda.uh@renesas.com,
        wsa+renesas@sang-engineering.com, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bean Huo <beanhuo@micron.com>
Subject: [PATCH v3 1/2] mmc: core: Pass down user specified timeout value to sanitize
Date:   Fri,  2 Apr 2021 11:24:31 +0200
Message-Id: <20210402092432.25069-2-huobean@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210402092432.25069-1-huobean@gmail.com>
References: <20210402092432.25069-1-huobean@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

As the density increases, the 4-minute timeout value for
sanitize is no longer feasible. At the same time, devices
of different densities have different timeout values, and it is
difficult to obtain a unified standard timeout value. Therefore,
it is better to pass down user-specified sanitize timeout value.

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 drivers/mmc/core/block.c   | 2 +-
 drivers/mmc/core/mmc_ops.c | 7 +++++--
 drivers/mmc/core/mmc_ops.h | 2 +-
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index fe5892d30778..8bfd4d95b386 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -539,7 +539,7 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 
 	if ((MMC_EXTRACT_INDEX_FROM_ARG(cmd.arg) == EXT_CSD_SANITIZE_START) &&
 	    (cmd.opcode == MMC_SWITCH))
-		return mmc_sanitize(card);
+		return mmc_sanitize(card, idata->ic.cmd_timeout_ms);
 
 	mmc_wait_for_req(card->host, &mrq);
 
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index f413474f0f80..ccca067db993 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -1010,7 +1010,7 @@ int mmc_cmdq_disable(struct mmc_card *card)
 }
 EXPORT_SYMBOL_GPL(mmc_cmdq_disable);
 
-int mmc_sanitize(struct mmc_card *card)
+int mmc_sanitize(struct mmc_card *card, unsigned int timeout_ms)
 {
 	struct mmc_host *host = card->host;
 	int err;
@@ -1020,12 +1020,15 @@ int mmc_sanitize(struct mmc_card *card)
 		return -EOPNOTSUPP;
 	}
 
+	if (!timeout_ms)
+		timeout_ms = MMC_SANITIZE_TIMEOUT_MS;
+
 	pr_debug("%s: Sanitize in progress...\n", mmc_hostname(host));
 
 	mmc_retune_hold(host);
 
 	err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_SANITIZE_START,
-			 1, MMC_SANITIZE_TIMEOUT_MS);
+			 1, timeout_ms);
 	if (err)
 		pr_err("%s: Sanitize failed err=%d\n", mmc_hostname(host), err);
 
diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
index 632009260e51..1ed0d0375780 100644
--- a/drivers/mmc/core/mmc_ops.h
+++ b/drivers/mmc/core/mmc_ops.h
@@ -46,7 +46,7 @@ void mmc_run_bkops(struct mmc_card *card);
 int mmc_flush_cache(struct mmc_card *card);
 int mmc_cmdq_enable(struct mmc_card *card);
 int mmc_cmdq_disable(struct mmc_card *card);
-int mmc_sanitize(struct mmc_card *card);
+int mmc_sanitize(struct mmc_card *card, unsigned int timeout_ms);
 
 #endif
 
-- 
2.25.1

