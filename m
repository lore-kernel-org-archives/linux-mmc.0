Return-Path: <SRS0=Gh8q=EM=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE9EDC388F7
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Nov 2020 02:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 602F72083B
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Nov 2020 02:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E9j58YRC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbgKFC3o (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 5 Nov 2020 21:29:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbgKFC2T (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Nov 2020 21:28:19 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B602C0613D2
        for <linux-mmc@vger.kernel.org>; Thu,  5 Nov 2020 18:28:19 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id 10so2942396pfp.5
        for <linux-mmc@vger.kernel.org>; Thu, 05 Nov 2020 18:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MEVDpgENX1AmvzEWHvOBoNvhkQ16z4ClQdBClfU+8tg=;
        b=E9j58YRCc6eGcDwuIsYKo3XfIKDgeJm4AGz5lHBzZ1K5SRk5Hh0HgmKUpHQ3nqaubG
         a512AGvWvdU3z34qEK2LMmE/ND0rNd/p8N18Imbgcr+GzIKJMjTaeKdN3EBwJgI7T3dk
         vlcOaYw6fx41IX0C7EUb1zMP5nhM0rNBWBOgLdKZR40WEa2rja/1f5wR/7Zha8Mj1l1+
         iIEvAevE/6udyKC/X9twXSixY+LToAV9IqkDjwUZAZtD+nkddD9MU7hMvW9sQrnTbTQE
         7gYvkLW4NfncinBYVvWEHC/y7zoUQyJmtUlyhmwXuuyD3/1oGxDCYm5oX4ojkispj6Cs
         DGfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MEVDpgENX1AmvzEWHvOBoNvhkQ16z4ClQdBClfU+8tg=;
        b=OLTmIc/tTYANJZ9uMW4KOrvtvzgJrD0f1G+hTvjTCeb0LKPptnASK+OGaLcIQAnBi3
         8I+hce0EREbV1HAW4iMvEGasKA1frm98i2b9JZSurwvakfB8FV7D4WLDV51gemmyGyDP
         MbmhOgFx/zMbP9c9SpNf7WOSzLvaF10dbQYn4Qg9piU48u65YAMO7voS7jXEOsHPTux2
         Rk+PKKqYW9euC9LoAuyhK3ap7LcKyj67zSBtctJZl2P1nvHxrLM0WlotgKOoAhVM74pv
         m3H6a/8MLeaIvAnSvo4VEPQ398GJs2i1CtsGGinl2cVgtWDc4oCxVkPfJwmZ3oESE1EN
         awtg==
X-Gm-Message-State: AOAM531C59O0qj3tnrtPm/kmjc3jJnmY6Ty4G9BiRIWuZBjTN2DVzPiO
        Rgbv9xF3MpCiDSr4WJHPL4CLD/11rEex4Q==
X-Google-Smtp-Source: ABdhPJz9cDPsgrflHX3y7tV2SlZiY3bSxpN6KZVO22EigS1WEiQNlb75DhGvy8rQS2vkQVYbqpWjTA==
X-Received: by 2002:a65:44cd:: with SMTP id g13mr4977495pgs.259.1604629698767;
        Thu, 05 Nov 2020 18:28:18 -0800 (PST)
Received: from localhost.localdomain (p784a66b9.tkyea130.ap.so-net.ne.jp. [120.74.102.185])
        by smtp.gmail.com with ESMTPSA id m13sm3703040pjr.30.2020.11.05.18.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 18:28:18 -0800 (PST)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC PATCH v3.1 07/27] mmc: core: UHS-II support, set APP_CMD bit if necessary
Date:   Fri,  6 Nov 2020 11:27:06 +0900
Message-Id: <20201106022726.19831-8-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201106022726.19831-1-takahiro.akashi@linaro.org>
References: <20201106022726.19831-1-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

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
index 1f6d0e0cf355..c0d61e7d9e4b 100644
--- a/drivers/mmc/core/uhs2.c
+++ b/drivers/mmc/core/uhs2.c
@@ -835,6 +835,10 @@ int uhs2_prepare_sd_cmd(struct mmc_host *host, struct mmc_request *mrq)
 		header |= UHS2_PACKET_TYPE_CCMD;
 
 	arg = cmd->opcode << UHS2_SD_CMD_INDEX_POS;
+	if (host->flags & MMC_UHS2_APP_CMD) {
+		arg |= UHS2_SD_CMD_APP;
+		host->flags &= ~MMC_UHS2_APP_CMD;
+	}
 
 	uhs2_cmd = cmd->uhs2_cmd;
 	payload = uhs2_cmd->payload;
-- 
2.28.0

