Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 717E8C433EF
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Sep 2021 17:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 573A860F21
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Sep 2021 17:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343934AbhIQR3C (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 17 Sep 2021 13:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343936AbhIQR3C (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Sep 2021 13:29:02 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C13C061574;
        Fri, 17 Sep 2021 10:27:39 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id s24so7911769wmh.4;
        Fri, 17 Sep 2021 10:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JIDuOpli6Tm6uAgMYJxGWn19bIwu9o76mZlI5FTH9oc=;
        b=czug9s0DxI5GlPg92K+1xRO9pOADDVD9NVcAxQoMZ+Li6odATspbD0BcJlUhJ9T3hG
         JvFArDAejsSsunerzLTG1d3IdohLKbWF2AQd9m25wck/Rw2i3PIUPWfTG7bWTS/pbypH
         m25WLI9jR0WnNIFDYgh52pRDxshmWxJbbsWLq0FY3KWV5zjxDsjKchm1X162Kmnu412J
         8rfMXYDHxDkfHCfSkl9R7V1Vbqp8iUTlLctef1kxvcIqV9So66a62CEG8XbBTBWGM2oy
         6GWXljUAFr9qYzSbqTMuM62U/XNHyKp7lQ4W1AtemIkAyXG6dovwUR0z0HDswIf9jHYC
         /wyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JIDuOpli6Tm6uAgMYJxGWn19bIwu9o76mZlI5FTH9oc=;
        b=Sl/Qo51MB2ybOiY0juhXvWz9Q1sM5SieC6hJU+JQRJyp6bHLEv6mN+5IbVXw6QhCxR
         ZA/7ySYJDLKLY/qalJamJx0Y6Nw38hKVi45mHgbMMDWEvm67yVDOoBDtotrMVZHvkIEU
         0w9dwI/D7nRBrxNBDF9r2etw7PvbMq3iEcAiZZWfG0wMEPwF3/WBe9xdH+xbteKxTGK5
         /BN8oj5p42KvMNq6CXA9FKrKqk1svLPGEknfZfYDVkWCzdD+mEPQfabZDTNo3JU0XDPq
         nvGf9R6NLTWiCiLpfpaeBdmlfu9CrqjW6dQ1GWjy9rY7CFR7C2p5hfDfHv1GCGegHQzC
         4T9g==
X-Gm-Message-State: AOAM533XIt85yRglTo69INjpLP7AakvhLZd+dpQ9p4gjR1cYgYLqXhFS
        2X67P2tEwaI44psO40wAKBc=
X-Google-Smtp-Source: ABdhPJwbXAtYjb4wuhQfkD6R6RBTyGA/mPa4/hArXdaZHYJZ81c6UOfdoJJdEfOPsoESZQH8TsvRBw==
X-Received: by 2002:a1c:2705:: with SMTP id n5mr16136176wmn.176.1631899658467;
        Fri, 17 Sep 2021 10:27:38 -0700 (PDT)
Received: from ubuntu-laptop.speedport.ip (p200300e94717cf050f860509a8ecdb17.dip0.t-ipconnect.de. [2003:e9:4717:cf05:f86:509:a8ec:db17])
        by smtp.gmail.com with ESMTPSA id 135sm2901947wma.32.2021.09.17.10.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 10:27:38 -0700 (PDT)
From:   Bean Huo <huobean@gmail.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Bean Huo <beanhuo@micron.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] mmc: sdhci: Return true only when timeout exceeds capacity of the HW timer
Date:   Fri, 17 Sep 2021 19:27:26 +0200
Message-Id: <20210917172727.26834-2-huobean@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210917172727.26834-1-huobean@gmail.com>
References: <20210917172727.26834-1-huobean@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

Clean up sdhci_calc_timeout() a bit,  and let it set too_big to be true only
when the timeout value required by the eMMC device exceeds the capability of
the host hardware timer.

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 drivers/mmc/host/sdhci.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 7ae398f8d4d3..357b365bf0ec 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -930,7 +930,7 @@ static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command *cmd,
 	struct mmc_data *data;
 	unsigned target_timeout, current_timeout;
 
-	*too_big = true;
+	*too_big = false;
 
 	/*
 	 * If the host controller provides us with an incorrect timeout
@@ -941,7 +941,7 @@ static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command *cmd,
 	if (host->quirks & SDHCI_QUIRK_BROKEN_TIMEOUT_VAL)
 		return host->max_timeout_count;
 
-	/* Unspecified command, asume max */
+	/* Unspecified command, assume max */
 	if (cmd == NULL)
 		return host->max_timeout_count;
 
@@ -968,17 +968,14 @@ static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command *cmd,
 	while (current_timeout < target_timeout) {
 		count++;
 		current_timeout <<= 1;
-		if (count > host->max_timeout_count)
+		if (count > host->max_timeout_count) {
+			if (!(host->quirks2 & SDHCI_QUIRK2_DISABLE_HW_TIMEOUT))
+				DBG("Too large timeout 0x%x requested for CMD%d!\n",
+				    count, cmd->opcode);
+			count = host->max_timeout_count;
+			*too_big = true;
 			break;
-	}
-
-	if (count > host->max_timeout_count) {
-		if (!(host->quirks2 & SDHCI_QUIRK2_DISABLE_HW_TIMEOUT))
-			DBG("Too large timeout 0x%x requested for CMD%d!\n",
-			    count, cmd->opcode);
-		count = host->max_timeout_count;
-	} else {
-		*too_big = false;
+		}
 	}
 
 	return count;
-- 
2.25.1

