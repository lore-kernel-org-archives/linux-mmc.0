Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA9BC433F5
	for <linux-mmc@archiver.kernel.org>; Thu, 10 Mar 2022 20:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245318AbiCJU55 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 10 Mar 2022 15:57:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237222AbiCJU5v (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Mar 2022 15:57:51 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239D5190B41
        for <linux-mmc@vger.kernel.org>; Thu, 10 Mar 2022 12:56:49 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id c16-20020a17090aa61000b001befad2bfaaso6337890pjq.1
        for <linux-mmc@vger.kernel.org>; Thu, 10 Mar 2022 12:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+k8ctLQCe8XJaC/j2fvvK4DGnmTULy8k6D3OKlVnPmQ=;
        b=Dbn2SdA8XBEzKkhgr/DRBEKQOwwHc5fTtnmTYFq6onbcWgpIIxuwvaK/jH96ZFIgFP
         j0J6CRhI2Fphg8sRtdKBb9CqFEmj/12ziO+DOD/GGeU8rFfXhj9MrQSkJDFxIDGTkVUB
         Rqpw4AFrWgj/+xKNFzzeW2gaHo1CgS8G1x44w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+k8ctLQCe8XJaC/j2fvvK4DGnmTULy8k6D3OKlVnPmQ=;
        b=OToetLzg9mfRCq8pQ7bKWikeH4ZSfHlBk8OagO4zSOQv7W3BQqToXoEuludJ24Gpfr
         +4rE0xJKbRjFtBbW9AxKRAXOnm0j1NoTG3yC5nRFuEq63dr44l6qv9vFcFtfwG0LXGr9
         lxhT/LxR4QdMW+nxUo5hKRyJuznO0DqA+Ja5LsbWGu4OOX0kY3FNEUslanKxnIp3Mcr/
         ZEnJPiKzqTvScYJ3eM35bfJQOfUvKLnsv1GTyBW63xhw2c6Zqpp8BN2nDj8i+SHJYPWJ
         qxT23Luzgrl+Y8OFh5TzNxPOYT76+sxgmOYOQagDbLRt+fwHSfZewUxC69yNUBqM6JWY
         iyzA==
X-Gm-Message-State: AOAM530yHs1ZTDpK2J+UYPWuMa9bju5SZ+1MKijOGYSnqjH8PU7QPIB7
        4pgrdLtPbBqmVKxPENft+2kgAw==
X-Google-Smtp-Source: ABdhPJzoY8GngJ2Y2OCQ6Aod62vcK4WUd1N9F4/6893poNA16PSF+larj4xu/DLXNzauKjq45MfJVA==
X-Received: by 2002:a17:902:ec8f:b0:152:939:ac45 with SMTP id x15-20020a170902ec8f00b001520939ac45mr7038860plg.61.1646945808618;
        Thu, 10 Mar 2022 12:56:48 -0800 (PST)
Received: from localhost ([2620:15c:202:201:7181:d34e:52c2:be45])
        by smtp.gmail.com with UTF8SMTPSA id s30-20020a056a001c5e00b004f75773f3fcsm7585302pfw.119.2022.03.10.12.56.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 12:56:47 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc@vger.kernel.org, Brian Norris <briannorris@chromium.org>
Subject: [PATCH] mmc: core: Set HS clock speed before sending HS CMD13
Date:   Thu, 10 Mar 2022 12:56:39 -0800
Message-Id: <20220310125636.1.I484f4ee35609f78b932bd50feed639c29e64997e@changeid>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
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

Anyway, the aforementioned commit got that right for HS400ES, but the
refactoring in 53e60650f74e ("mmc: core: Allow CMD13 polling when
switching to HS mode for mmc") messed that back up again, by reordering
step 2 after step 3.

Let's fix that, and also apply the same logic to HS200/400, where this
eMMC has problems too.

This resolves errors like this seen when booting some RK3399 Gru/Scarlet
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

Fixes: 53e60650f74e ("mmc: core: Allow CMD13 polling when switching to HS mode for mmc")
Cc: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/mmc/core/mmc.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 13abfcd130a5..821b90caba2f 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1390,12 +1390,17 @@ static int mmc_select_hs400es(struct mmc_card *card)
 	}
 
 	mmc_set_timing(host, MMC_TIMING_MMC_HS);
+
+	/*
+	 * Bump to HS frequency. Some cards don't handle SEND_STATUS reliably
+	 * at the initial frequency.
+	 */
+	mmc_set_clock(host, card->ext_csd.hs_max_dtr);
+
 	err = mmc_switch_status(card, true);
 	if (err)
 		goto out_err;
 
-	mmc_set_clock(host, card->ext_csd.hs_max_dtr);
-
 	/* Switch card to DDR with strobe bit */
 	val = EXT_CSD_DDR_BUS_WIDTH_8 | EXT_CSD_BUS_WIDTH_STROBE;
 	err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
@@ -1487,6 +1492,12 @@ static int mmc_select_hs200(struct mmc_card *card)
 		old_timing = host->ios.timing;
 		mmc_set_timing(host, MMC_TIMING_MMC_HS200);
 
+		/*
+		 * Bump to HS frequency. Some cards don't handle SEND_STATUS
+		 * reliably at the initial frequency.
+		 */
+		mmc_set_clock(host, card->ext_csd.hs_max_dtr);
+
 		/*
 		 * For HS200, CRC errors are not a reliable way to know the
 		 * switch failed. If there really is a problem, we would expect
-- 
2.35.1.723.g4982287a31-goog

