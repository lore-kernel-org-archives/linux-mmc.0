Return-Path: <SRS0=hS93=AV=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74BADC433DF
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Jul 2020 11:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D0502076A
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Jul 2020 11:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rtoPGOCQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbgGJLI4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 10 Jul 2020 07:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbgGJLIy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 10 Jul 2020 07:08:54 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84127C08C5CE;
        Fri, 10 Jul 2020 04:08:54 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id k27so2395331pgm.2;
        Fri, 10 Jul 2020 04:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tErlLbdtCWDGv/vKwdRdEOml4K+SgK9V6YiS5pXmAGk=;
        b=rtoPGOCQCl8nBYC27b28IX042RFJzQXF7gcoKuoh66Q41+udmEwxjWuAqt8+VyJrQY
         9xmhqI/5q9DEftOclJP0yuilarwfXpABksX4mf9NW7CeVDr5hnqySm4iJaa0pWnJrra+
         NBU+gVNKCFsbTkPZFta7DpNNq8wuMDp32wBkbep0fFLuqSJUZBNRNvg3qhNKiE19APr5
         HDdlkbafU3q/t2o2nV+EAJkCxIituZZ516DF1Q8OdCVM6O1K+weGxCn3c30T9oYoWa2A
         vcQecjZOgMsRkMyPRBQHD97hTGxqtCyax1x2faS1k+tiye71UgiTdIaYBy2mszi7sWB4
         1Wtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tErlLbdtCWDGv/vKwdRdEOml4K+SgK9V6YiS5pXmAGk=;
        b=jsW6Hjl+AgVng6Z65VFI2ActWhdx/qZo4INhtqHxgMcfFrs/czLVvAAXwtaIaTyflV
         8Wtwi3ek6OUsvR4H3c4vglz1ae0c8ggZWLghVV7bWGDmFms2T+Ire5FYmtWpOOjZgCDO
         25Hp3wJ7JEK4AyM2aYDtLDfqvwSG5TYeAvDhiOqaPBC0RhfV4WWzf79yEV6toVVVq1Ns
         4pr0E3lCd+vcjs6fsL31uWRHiwLbth8ZXt6xpZ0fxl3ESe0H7fiUBIo4huhHwy0S8oOu
         Or5d2SZs5zuj1Td/1cTIputvEGjcx5JQSBG3DYFnGGtmp1RsDzH5/eLfc6caEXiUnTkw
         iqQQ==
X-Gm-Message-State: AOAM532tlZ3mgu07m37+mZi9+IsSKmoHoIU1ek8VbvqSbNVjEhS8Uxlq
        HCwjT15l9z6nPCg/vxpXf5o=
X-Google-Smtp-Source: ABdhPJwuvAeLacUnNNBD4q38sBZjlHgfaYBiCTzmMUKSt2GojtyM91d7broEU4sA0x+Yl6XOx+CN6A==
X-Received: by 2002:a62:f202:: with SMTP id m2mr51534273pfh.157.1594379334138;
        Fri, 10 Jul 2020 04:08:54 -0700 (PDT)
Received: from gli-arch.genesyslogic.com.tw (60-251-58-169.HINET-IP.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id v2sm5395427pje.19.2020.07.10.04.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 04:08:53 -0700 (PDT)
From:   Ben Chuang <benchuanggli@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        greg.tu@genesyslogic.com.tw, Ben Chuang <benchuanggli@gmail.com>
Subject: [RFC PATCH V3 07/21] mmc: core: UHS-II support, set APP_CMD bit if necessary
Date:   Fri, 10 Jul 2020 19:09:37 +0800
Message-Id: <20200710110937.29283-1-benchuanggli@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: AKASHI Takahiro <takahiro.akashi@linaro.org>

In UHS-II mode, MMC_APP_CMD command need not to be sent.
Instead, APP_CMD bit in a packet should be set.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 drivers/mmc/core/sd_ops.c | 9 +++++++++
 drivers/mmc/core/uhs2.c   | 4 ++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
index f58bb50872f6..9dc296356928 100644
--- a/drivers/mmc/core/sd_ops.c
+++ b/drivers/mmc/core/sd_ops.c
@@ -26,6 +26,15 @@ int mmc_app_cmd(struct mmc_host *host, struct mmc_card *card)
 	if (WARN_ON(card && card->host != host))
 		return -EINVAL;
 
+	/* UHS2 packet has APP bit so only set APP_CMD flag here.
+	 * Will set the APP bit when assembling UHS2 packet.
+	 */
+	if (host->flags &  MMC_UHS2_SUPPORT &&
+	    host->flags & MMC_UHS2_INITIALIZED) {
+		host->flags |= MMC_UHS2_APP_CMD;
+		return 0;
+	}
+
 	cmd.opcode = MMC_APP_CMD;
 
 	if (card) {
diff --git a/drivers/mmc/core/uhs2.c b/drivers/mmc/core/uhs2.c
index 6e26de429726..2fbd7b6d9dea 100644
--- a/drivers/mmc/core/uhs2.c
+++ b/drivers/mmc/core/uhs2.c
@@ -826,6 +826,10 @@ int uhs2_prepare_sd_cmd(struct mmc_host *host, struct mmc_request *mrq)
 		header |= UHS2_PACKET_TYPE_CCMD;
 
 	arg = cmd->opcode << UHS2_SD_CMD_INDEX_POS;
+	if (host->flags & MMC_UHS2_APP_CMD) {
+		arg |= UHS2_SD_CMD_APP;
+		host->flags &= ~MMC_UHS2_APP_CMD;
+	}
 
 	uhs2_cmd = cmd->uhs2_cmd;
 	payload = uhs2_cmd->payload;
-- 
2.27.0

