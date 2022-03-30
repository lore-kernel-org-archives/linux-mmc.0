Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE361C433EF
	for <linux-mmc@archiver.kernel.org>; Wed, 30 Mar 2022 20:30:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245582AbiC3Ubr (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 30 Mar 2022 16:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350971AbiC3Ubq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Mar 2022 16:31:46 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0006374846
        for <linux-mmc@vger.kernel.org>; Wed, 30 Mar 2022 13:29:59 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id jx9so21854772pjb.5
        for <linux-mmc@vger.kernel.org>; Wed, 30 Mar 2022 13:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bBhmUiIbVUtLcqkxDBArq6a508RJGCJLND9HldXMWPo=;
        b=gC+iL9DmaD4qoKuYuHe+V68JjXPLLS1e5rxSZaxqC3fgEyXSLO8ZGSUE3qVQGaijTr
         b0lBdbOm9XT/bUs3KsqZdJ5ygPCXl/+XlFHGionsv8nKttIHT3qUyp8S5YIck9UbC8+7
         0uTFEdCakel6O0drBwvi8OuzQ2I3fgN//HWwo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bBhmUiIbVUtLcqkxDBArq6a508RJGCJLND9HldXMWPo=;
        b=JT1P+/j2C/HqTYctKpizy0ah2FoO2HJoIh12vjimvSu7v6aHCFdJ8exFagQ4WIXWFY
         TtrHo6v9pMUpjfdzTBYCl91dMkQ2XYkxnecq27zfaoBubTzzWwMMShsFbE2PCXUeQszu
         1K0j3r7A4P5iADJhjTUumWh6u9lJIpOlaFmF6uMjn25SJZxyzkWLgoxqHr5g/1rlJWm7
         DBVKvDI7m6cHWwiAgMBE8mX147F9bOg7hwwufVgRT+6fAOTbFzdSAVe/Qu4/SzODLe2K
         K86xqjSEeKChJiRp+XMQZ+HPC7tq9zeYRgT7smxWMYrjNz+48J4GBY1EObUfCbk9A/in
         Yf/Q==
X-Gm-Message-State: AOAM533CMHkLBttAAH5+u+00ODx4AoY1TZgmQ8Jmw5WNTSM4akBY8VfZ
        0u/z5mY9WvySLjuIWcpUN7ymFg==
X-Google-Smtp-Source: ABdhPJxuHTdll+5fKQElTQKrDDXoXFSfN0lPOfeOpkpjFrKRXZxz1TnD2qZfCZFG3FythWAj6DFFzw==
X-Received: by 2002:a17:902:7784:b0:151:a83a:5402 with SMTP id o4-20020a170902778400b00151a83a5402mr1216175pll.21.1648672199420;
        Wed, 30 Mar 2022 13:29:59 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:e6b7:d834:259a:6ada])
        by smtp.gmail.com with UTF8SMTPSA id f31-20020a631f1f000000b003742e45f7d7sm19847313pgf.32.2022.03.30.13.29.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 13:29:58 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v3] mmc: core: Set HS clock speed before sending HS CMD13
Date:   Wed, 30 Mar 2022 13:29:51 -0700
Message-Id: <20220330132946.v3.1.I484f4ee35609f78b932bd50feed639c29e64997e@changeid>
X-Mailer: git-send-email 2.35.1.1094.g7c7d902a7c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Way back in commit 4f25580fb84d ("mmc: core: changes frequency to
hs_max_dtr when selecting hs400es"), Rockchip engineers noticed that
some eMMC don't respond to SEND_STATUS commands very reliably if they're
still running at a low initial frequency. As mentioned in that commit,
JESD84-B51 P49 suggests a sequence in which the host:
1. sets HS_TIMING
2. bumps the clock ("<= 52 MHz")
3. sends further commands

It doesn't exactly require that we don't use a lower-than-52MHz
frequency, but in practice, these eMMC don't like it.

The aforementioned commit tried to get that right for HS400ES, although
it's unclear whether this ever truly worked as committed into mainline,
as other changes/refactoring adjusted the sequence in conflicting ways:

08573eaf1a70 ("mmc: mmc: do not use CMD13 to get status after speed mode
switch")

53e60650f74e ("mmc: core: Allow CMD13 polling when switching to HS mode
for mmc")

In any case, today we do step 3 before step 2. Let's fix that, and also
apply the same logic to HS200/400, where this eMMC has problems too.

Resolves errors like this seen when booting some RK3399 Gru/Scarlet
systems:

[    2.058881] mmc1: CQHCI version 5.10
[    2.097545] mmc1: SDHCI controller on fe330000.mmc [fe330000.mmc] using ADMA
[    2.209804] mmc1: mmc_select_hs400es failed, error -84
[    2.215597] mmc1: error -84 whilst initialising MMC card
[    2.417514] mmc1: mmc_select_hs400es failed, error -110
[    2.423373] mmc1: error -110 whilst initialising MMC card
[    2.605052] mmc1: mmc_select_hs400es failed, error -110
[    2.617944] mmc1: error -110 whilst initialising MMC card
[    2.835884] mmc1: mmc_select_hs400es failed, error -110
[    2.841751] mmc1: error -110 whilst initialising MMC card

Fixes: 08573eaf1a70 ("mmc: mmc: do not use CMD13 to get status after speed mode switch")
Fixes: 53e60650f74e ("mmc: core: Allow CMD13 polling when switching to HS mode for mmc")
Fixes: 4f25580fb84d ("mmc: core: changes frequency to hs_max_dtr when selecting hs400es")
Cc: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

Changes in v3:
 * Use mmc_set_bus_speed() to help choose the right clock rate
 * Avoid redundant clock rate changes
 * Restore clock rate on failed HS200 switch

Changes in v2:
 * Use ext_csd.hs200_max_dtr for HS200
 * Retest on top of 3b6c472822f8 ("mmc: core: Improve fallback to speed
   modes if eMMC HS200 fails")

 drivers/mmc/core/core.c |  3 +++
 drivers/mmc/core/mmc.c  | 21 +++++++++++++++++----
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 368f10405e13..61abae221623 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -914,6 +914,9 @@ void mmc_set_clock(struct mmc_host *host, unsigned int hz)
 	if (hz > host->f_max)
 		hz = host->f_max;
 
+	if (host->ios.clock == hz)
+		return;
+
 	host->ios.clock = hz;
 	mmc_set_ios(host);
 }
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index e7ea45386c22..1f22f1d2e9b8 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1384,13 +1384,17 @@ static int mmc_select_hs400es(struct mmc_card *card)
 		goto out_err;
 	}
 
+	/*
+	 * Bump to HS timing and frequency. Some cards don't handle
+	 * SEND_STATUS reliably at the initial frequency.
+	 */
 	mmc_set_timing(host, MMC_TIMING_MMC_HS);
+	mmc_set_bus_speed(card);
+
 	err = mmc_switch_status(card, true);
 	if (err)
 		goto out_err;
 
-	mmc_set_clock(host, card->ext_csd.hs_max_dtr);
-
 	/* Switch card to DDR with strobe bit */
 	val = EXT_CSD_DDR_BUS_WIDTH_8 | EXT_CSD_BUS_WIDTH_STROBE;
 	err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
@@ -1448,7 +1452,7 @@ static int mmc_select_hs400es(struct mmc_card *card)
 static int mmc_select_hs200(struct mmc_card *card)
 {
 	struct mmc_host *host = card->host;
-	unsigned int old_timing, old_signal_voltage;
+	unsigned int old_timing, old_signal_voltage, old_clock;
 	int err = -EINVAL;
 	u8 val;
 
@@ -1479,8 +1483,15 @@ static int mmc_select_hs200(struct mmc_card *card)
 				   false, true, MMC_CMD_RETRIES);
 		if (err)
 			goto err;
+
+		/*
+		 * Bump to HS200 timing and frequency. Some cards don't
+		 * handle SEND_STATUS reliably at the initial frequency.
+		 */
 		old_timing = host->ios.timing;
+		old_clock = host->ios.clock;
 		mmc_set_timing(host, MMC_TIMING_MMC_HS200);
+		mmc_set_bus_speed(card);
 
 		/*
 		 * For HS200, CRC errors are not a reliable way to know the
@@ -1493,8 +1504,10 @@ static int mmc_select_hs200(struct mmc_card *card)
 		 * mmc_select_timing() assumes timing has not changed if
 		 * it is a switch error.
 		 */
-		if (err == -EBADMSG)
+		if (err == -EBADMSG) {
+			mmc_set_clock(host, old_clock);
 			mmc_set_timing(host, old_timing);
+		}
 	}
 err:
 	if (err) {
-- 
2.35.1.1094.g7c7d902a7c-goog

