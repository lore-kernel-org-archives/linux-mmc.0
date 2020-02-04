Return-Path: <SRS0=92ZL=3Y=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51912C2D0B1
	for <linux-mmc@archiver.kernel.org>; Tue,  4 Feb 2020 08:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27D7821744
	for <linux-mmc@archiver.kernel.org>; Tue,  4 Feb 2020 08:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eHizTPsn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgBDIzZ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 4 Feb 2020 03:55:25 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38821 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbgBDIzZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Feb 2020 03:55:25 -0500
Received: by mail-lf1-f66.google.com with SMTP id r14so11636623lfm.5
        for <linux-mmc@vger.kernel.org>; Tue, 04 Feb 2020 00:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4MoUz8e+cau8Xa7ChnTAxFphu0xbbPqaxCnfeEAChL0=;
        b=eHizTPsnr1OuaxkljuFvA0GqC4CKdaPoYVpAxKqjyXiKJbjxcsyGVaNmHuM/aCVmSj
         8EpJotdRKkCcFIiiwxWwQEVFid2SGGI8FeToEKXasAmZvM19XrNlHcTHEUEVTAvDDX30
         OaAG+WFqy8A78zqMAMSUBu3WBPMtn4Zw7Rscsy1Am2ueocR/OTfm8LNiEUBXY4uEGFQO
         BSTJno3fdP37LAIHlZsyBvFHVmihFR9Mpx1u7HF5gh85DJMA481xbRUs895qlrsqAfei
         aRIQICJcNDcIrZCTifg3GSoc1NKyz//SRTsxcUXBEXpnIrxhIh2LyfODwRRbvTjuUTG0
         x6bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4MoUz8e+cau8Xa7ChnTAxFphu0xbbPqaxCnfeEAChL0=;
        b=OqVwdMSc5XhJrQXiO/X7DnN3K7310VtEbzfSs6WRLked0hz4s+jDY2anmMg9uLyvpk
         tFMfzQ9k9WnXirdPHCdjhRpdYCtf9wtw3N5O3cuIs3aVgorIllRbxW1xQan1jESuC0lf
         plG13OiI9Pik2q7pjCMPXWshPQjeHaE98ZrZU0GKKnIM2wtkke0v7L/ZDl00uvFRWamn
         KHY0RoyirNslkGgWowPvhO+ODsgJnSGwMAzT2RBLk3r15dMHU9RXTorljz6AON4m3/c4
         jgckkdB1+nDaqWAnZ2hCIWEIqIi+rXB72g1w6DQm1u835KjBE2WsT95ICwINSMZJKExJ
         Z4kg==
X-Gm-Message-State: APjAAAWnPVgQQhuTf9uxCca+Vn6M0v3ahYfN84g3WecKA+4/KJgZ/sPa
        dTSjoWshkuyrrJY2jfaQRn3FJbD960o=
X-Google-Smtp-Source: APXvYqycLBF/cQ1QLZbuX0A3oqIaEhvd983hPS/2XotETjrWa0tuCjLI/wsSJfbiArTwQtN+brBGyw==
X-Received: by 2002:ac2:485c:: with SMTP id 28mr14319585lfy.118.1580806522261;
        Tue, 04 Feb 2020 00:55:22 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id n2sm11156283ljj.1.2020.02.04.00.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 00:55:21 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Shawn Lin <shawn.lin@rock-chips.com>, mirq-linux@rere.qmqm.pl
Subject: [PATCH 10/12] mmc: core: Convert to mmc_poll_for_busy() for HPI commands
Date:   Tue,  4 Feb 2020 09:54:47 +0100
Message-Id: <20200204085449.32585-11-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200204085449.32585-1-ulf.hansson@linaro.org>
References: <20200204085449.32585-1-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Rather than open coding the polling loop in mmc_interrupt_hpi(), let's
convert to use mmc_poll_for_busy().

Note that, moving to mmc_poll_for_busy() for HPI also improves the
behaviour according to below.

- Adds support for polling via the optional ->card_busy() host ops.
- Require R1_READY_FOR_DATA to be set in the CMD13 response before exiting
  the polling loop.
- Adds a throttling mechanism to avoid CPU hogging when polling.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/mmc_ops.c | 20 +++++---------------
 drivers/mmc/core/mmc_ops.h |  1 +
 2 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 4d8f90d01740..87d54a559b31 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -471,6 +471,8 @@ static int mmc_busy_status(struct mmc_card *card, bool retry_crc_err,
 	case MMC_BUSY_ERASE:
 		err = R1_STATUS(status) ? -EIO : 0;
 		break;
+	case MMC_BUSY_HPI:
+		break;
 	default:
 		err = -EINVAL;
 	}
@@ -829,6 +831,7 @@ int mmc_bus_test(struct mmc_card *card, u8 bus_width)
 
 static int mmc_send_hpi_cmd(struct mmc_card *card)
 {
+	unsigned int busy_timeout_ms = card->ext_csd.out_of_int_time;
 	struct mmc_command cmd = {};
 	unsigned int opcode;
 	int err;
@@ -850,7 +853,8 @@ static int mmc_send_hpi_cmd(struct mmc_card *card)
 		return err;
 	}
 
-	return 0;
+	/* Let's poll to find out when the HPI request completes. */
+	return mmc_poll_for_busy(card, busy_timeout_ms, MMC_BUSY_HPI);
 }
 
 /**
@@ -864,7 +868,6 @@ int mmc_interrupt_hpi(struct mmc_card *card)
 {
 	int err;
 	u32 status;
-	unsigned long prg_wait;
 
 	if (!card->ext_csd.hpi_en) {
 		pr_info("%s: HPI enable bit unset\n", mmc_hostname(card->host));
@@ -898,19 +901,6 @@ int mmc_interrupt_hpi(struct mmc_card *card)
 	}
 
 	err = mmc_send_hpi_cmd(card);
-	if (err)
-		goto out;
-
-	prg_wait = jiffies + msecs_to_jiffies(card->ext_csd.out_of_int_time);
-	do {
-		err = mmc_send_status(card, &status);
-
-		if (!err && R1_CURRENT_STATE(status) == R1_STATE_TRAN)
-			break;
-		if (time_after(jiffies, prg_wait))
-			err = -ETIMEDOUT;
-	} while (!err);
-
 out:
 	return err;
 }
diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
index 8cd05fb583da..38dcfeeaf6d5 100644
--- a/drivers/mmc/core/mmc_ops.h
+++ b/drivers/mmc/core/mmc_ops.h
@@ -13,6 +13,7 @@
 enum mmc_busy_cmd {
 	MMC_BUSY_CMD6,
 	MMC_BUSY_ERASE,
+	MMC_BUSY_HPI,
 };
 
 struct mmc_host;
-- 
2.17.1

