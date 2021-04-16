Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 345BEC433B4
	for <linux-mmc@archiver.kernel.org>; Fri, 16 Apr 2021 09:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1441061184
	for <linux-mmc@archiver.kernel.org>; Fri, 16 Apr 2021 09:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242004AbhDPJoW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 16 Apr 2021 05:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242080AbhDPJoR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Apr 2021 05:44:17 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6119AC061574
        for <linux-mmc@vger.kernel.org>; Fri, 16 Apr 2021 02:43:51 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id t14-20020a05600c198eb029012eeb3edfaeso3815375wmq.2
        for <linux-mmc@vger.kernel.org>; Fri, 16 Apr 2021 02:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DNXIm2x7iZSWnu0rM9rcYpiEEBJSY5oANhLVzMZb7Z0=;
        b=q77MX6rw0CxCVzhn54CaK3fTSKcDS/VmNVRWaiJrxjlc73ODQGuA0kPcuxTeehAp+b
         eyF/YaOS9NO+KUSeUvdAv13pS8+uUCzDm/2e6EzsbOAHlGjs4d5zCLJTNEIF6FkzT0bT
         nHvq1U+y9VsfVoaAqx2ohwND3YHlZYOrkgK2CwG4Y2QJoEBCfFP+ZmPBvFmyMf4yNILz
         J6jEjQC6HrPoiZIUfna7bOwushYp43o8QWLzYIEWxFKBOlOM9JORGa+iwiktmmpAMcln
         VevKA1SAjVSwaUFikbBNgYuKhtQGjgjo/m2nscUXfsiJ5MTSBgRvt1aLqEitmzyuvD0C
         Rvag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DNXIm2x7iZSWnu0rM9rcYpiEEBJSY5oANhLVzMZb7Z0=;
        b=O3jsH5AHLXAGuYOZDf107SVvt1HFTWGT+JaLVJ4CCdGwgLHGDIHpL8IxaHPhSStMjH
         BpIXgOg7ZEkWAS28g/PPjqzY25mmJzx6/b+RTF1+52zyquxGiWyfruRqTCC/hAC+YDN5
         LzT+vUbzjEWg1FvvF5z52pspVd/2b5VDxESl+Kc3cKHZ4+jb/1Ua714IbMIikmfvOsfs
         bPKRdwsMM0ZoIUygQdb7IjoYC95lyVbs4IsUAQGBJSB1PtjGVwZNhTipe2ghUxnPz8ee
         Y5NNLpzAIub0ddErm0iokfmKzkDd+FiBfqeUqFkgwovqhu8XtMc59j5mJ+RNwwIoybR2
         O0IQ==
X-Gm-Message-State: AOAM531voSLP+RjSBlDAW/ou+G/RBwQZPZcBynQJ8eAxVPa7lUwSrK9I
        X2mW0o4qBETrbK3EBt5MmUnjXA==
X-Google-Smtp-Source: ABdhPJy38WGnMQGvcGAZDuyAQHhopBQibip3naXYdj9nO3tbNM9T2pB/fanWPEG67HAB1uIMne2+dA==
X-Received: by 2002:a05:600c:3541:: with SMTP id i1mr7316584wmq.97.1618566230000;
        Fri, 16 Apr 2021 02:43:50 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:90c:e290:6e70:fd4e:dfdb:68d7])
        by smtp.gmail.com with ESMTPSA id e9sm9585744wrs.84.2021.04.16.02.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 02:43:49 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        lebed.dmitry@gmail.com, Neil Armstrong <narmstrong@baylibre.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v2] mmc: meson-gx: replace WARN_ONCE with dev_warn_once about scatterlist size alignment in block mode
Date:   Fri, 16 Apr 2021 11:43:47 +0200
Message-Id: <20210416094347.2015896-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Since commit e085b51c74cc ("mmc: meson-gx: check for scatterlist size alignment in block mode"),
support for SDIO SD_IO_RW_EXTENDED transferts are properly filtered but some driver
like brcmfmac still gives a block sg buffer size not aligned with SDIO block,
triggerring a WARN_ONCE() with scary stacktrace even if the transfer works fine
but with possible degraded performances.

Simply replace with dev_warn_once() to inform user this should be fixed to avoid
degraded performance.

This should be ultimately fixed in brcmfmac, but since it's only a performance issue
the warning should be removed.

Fixes: e085b51c74cc ("mmc: meson-gx: check for scatterlist size alignment in block mode")
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
Changes since v1:
- replace WARN_ONCE with dev_warn_once and explicit the warning message

 drivers/mmc/host/meson-gx-mmc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index eb6c02bc4a02..b8b771b643cc 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -247,8 +247,9 @@ static void meson_mmc_get_transfer_mode(struct mmc_host *mmc,
 		 */
 		for_each_sg(data->sg, sg, data->sg_len, i) {
 			if (sg->length % data->blksz) {
-				WARN_ONCE(1, "unaligned sg len %u blksize %u\n",
-					  sg->length, data->blksz);
+				dev_warn_once(mmc_dev(mmc),
+					      "unaligned sg len %u blksize %u, disabling descriptor DMA for transfer\n",
+					      sg->length, data->blksz);
 				return;
 			}
 		}
-- 
2.25.1

