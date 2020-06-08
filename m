Return-Path: <SRS0=G9E5=7V=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3115C433E1
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Jun 2020 08:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D89120835
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Jun 2020 08:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="nOdR02uF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729156AbgFHIpF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 8 Jun 2020 04:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729079AbgFHIpE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Jun 2020 04:45:04 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDC6C08C5C4
        for <linux-mmc@vger.kernel.org>; Mon,  8 Jun 2020 01:45:04 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id l11so16457182wru.0
        for <linux-mmc@vger.kernel.org>; Mon, 08 Jun 2020 01:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hVI/LKXmUenAikANgxMZ2mka5xmWY6K/t9X8/sizo9k=;
        b=nOdR02uF9gxHffq36L024aApJfanJ36qvrDfqHocFBNPwBj1zVqUlHv4JTl5tgmCcS
         1E5xr4HzpEST/wJ9ei1RIu764lQsxYCzIUYmrsf9OFx7U7lqMaH03Hfarv+KkHn6svmG
         iO1SlY0zs+QPSQa/mOdjGgXLzFQkxmsGR/1nbEfsHvAPcyoVMSHW3mVZBNFbRy2oP+FV
         DFQtcL/cI176KwTz8hVX2JVVNo5tDEQ9wxqSef7WKLw/vKsdgvDaYl647p/hcvW8DEpg
         EDG/M/8EUFJIMPin+EQAWzuvohpoGiMmqPCvLOWThfrZF01SZqB1Aplb2ZBti4cPYGiz
         6p8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hVI/LKXmUenAikANgxMZ2mka5xmWY6K/t9X8/sizo9k=;
        b=iED3D6gzV12yq0GurVJUTkOE4UhMMY8OZWyNGMuVQqn/Yvnrc+e/SGYScNLxPTF3WD
         BlHNZpV2Oq0ZBz4XUZni7hSuXcrEidppmgvr2jGJ4lpmZy5fsuLqxgYRnsJY/6iZSDsN
         HljUVniLdA/OsLLlGKhQGH9/XHzVw8vpp1nhl7H+Yy5yNs3EkL4/9k5ildEKTue8UcIa
         Ulu/uV/Lr/RhawDi3RD/qmE8ngYAXuFSUhcuWNi3aVPpZINnfRxVMq8YnLrGL/2dxZNs
         88W6oxQqOwHI8JPSm+851Tb9eIM+EBaSbg/JMsYbMJNFXEbrohYJ8oV+KMbo5AFiypyC
         acKQ==
X-Gm-Message-State: AOAM530lKM7AFycdGnCXbofHZGYg1llCpma70kduzJG/6+s+g6lRQ3NK
        ixoeWQQ5jsH+HpvGXIVDJs/wig==
X-Google-Smtp-Source: ABdhPJzNz9G3Dmg3Wt11LpS3mqTMRQpQKBSoZCNvuKQYXSIoKruR+1SCjYkdnFetJ9Vz8+g9JMRFDQ==
X-Received: by 2002:adf:a15c:: with SMTP id r28mr21180984wrr.337.1591605903037;
        Mon, 08 Jun 2020 01:45:03 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:22:5867:d2c6:75f4])
        by smtp.gmail.com with ESMTPSA id d17sm25031888wrg.75.2020.06.08.01.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 01:45:01 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     ulf.hansson@linaro.org
Cc:     linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Art Nikpal <art@khadas.com>,
        Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH] mmc: meson-gx: limit segments to 1 when dram-access-quirk is needed
Date:   Mon,  8 Jun 2020 10:44:58 +0200
Message-Id: <20200608084458.32014-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The actual max_segs computation leads to failure while using the broadcom
sdio brcmfmac/bcmsdh driver, since the driver tries to make usage of scatter
gather.

But with the dram-access-quirk we use a 1,5K SRAM bounce buffer, and the
max_segs current value of 3 leads to max transfers to 4,5k, which doesn't work.

This patch sets max_segs to 1 to better describe the hardware limitation,
and fix the SDIO functionnality with the brcmfmac/bcmsdh driver on Amlogic
G12A/G12B SoCs on boards like SEI510 or Khadas VIM3.

Reported-by: Art Nikpal <art@khadas.com>
Reported-by: Christian Hewitt <christianshewitt@gmail.com>
Fixes: acdc8e71d9bb ("mmc: meson-gx: add dram-access-quirk")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 35400cf2a2e4..cfaf8e7e22ec 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -1143,9 +1143,11 @@ static int meson_mmc_probe(struct platform_device *pdev)
 
 	mmc->caps |= MMC_CAP_CMD23;
 	if (host->dram_access_quirk) {
+		/* Limit segments to 1 due to low available sram memory */
+		mmc->max_segs = 1;
 		/* Limit to the available sram memory */
-		mmc->max_segs = SD_EMMC_SRAM_DATA_BUF_LEN / mmc->max_blk_size;
-		mmc->max_blk_count = mmc->max_segs;
+		mmc->max_blk_count = SD_EMMC_SRAM_DATA_BUF_LEN /
+				     mmc->max_blk_size;
 	} else {
 		mmc->max_blk_count = CMD_CFG_LENGTH_MASK;
 		mmc->max_segs = SD_EMMC_DESC_BUF_LEN /
-- 
2.22.0

