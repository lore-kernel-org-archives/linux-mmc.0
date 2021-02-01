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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2676EC433E0
	for <linux-mmc@archiver.kernel.org>; Mon,  1 Feb 2021 06:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFDDA64E15
	for <linux-mmc@archiver.kernel.org>; Mon,  1 Feb 2021 06:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbhBAGAP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 1 Feb 2021 01:00:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbhBAF5t (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 1 Feb 2021 00:57:49 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99321C0613D6;
        Sun, 31 Jan 2021 21:57:09 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id a20so9647885pjs.1;
        Sun, 31 Jan 2021 21:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zRs35J+9jM+mMBXrhR0hY7dunGBK3siVA/0rJv1BtSU=;
        b=t9hHWfwLooMNi+qvk9J1pxvRmvzqq3igPQ7GJQwc5bwvUVLAruPSRLjrjY3gNhA4eu
         pQjWogkhpdC01hXmO+BhCzevvzqUp0a79Ci2pxJHIgQRxCOu30l27uHPUouthN2M1+pF
         BUmMhBVOzkFpJE/xkbxO7j1TFQeBf5BXTEKDWdsry0bxasJm9j2PexsSxM/5kU6ascw2
         zGhjt0GEuXJAwhh7FM/iHXTHLIpF1N3bT4+h4mcVLPJZAOeCRsgUZ6vEggCKVAQ3OM2S
         +GHmcF0d+3wA6xK/NDdoJPt1zXrTWML3Jb8KEy6TgImaX+6uXaVjeBPoxnv2pElpdZfM
         FmkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zRs35J+9jM+mMBXrhR0hY7dunGBK3siVA/0rJv1BtSU=;
        b=ZEkSZaBbdxy4mChTvYFCQmJjMCt7Nl3DD2Xc6Ceb+ZQPBHVTGgVdEoKSOSuaW7e+zE
         wcOffiy3/Qv6DdHpVY9DsuvrcOjjn2bxjjRfTG+Pzq1HwtA7W2lijZyE/r8fZbQOkPnu
         lbhkM6z5n/9tUNwSwnmXDO9m/iK7XRNQCot0nhNHR79dTIDusFH/ZYe0c0wOV0RQG/Yb
         fRFI9KhdJW43m4ljmXBrqSFyGRFi8xb+WlSg9VjE7Z4x2sM5fmkOlH1wRKyeOSYI41m2
         zZSNqE0DkoaPyd32hy17UIAD1IWgduO0HQKz5Md/zRIykMB6UyTI5YC7sn/0AO/v5Hv2
         vUig==
X-Gm-Message-State: AOAM531Gqb+TXdA0/cVPoBWFvIcBE+InI5HdIyRvVtK3DSwpQx8U5gOc
        mV/cBUZgkBAPaUNkJd8+WLI=
X-Google-Smtp-Source: ABdhPJzBOmZj5yUpp9460gkMGk7iG4gIAeVGl1jmc69B+H1YlctVewE/+lxTp4AX/X4pauYGCRYSdQ==
X-Received: by 2002:a17:902:724b:b029:de:229a:47f1 with SMTP id c11-20020a170902724bb02900de229a47f1mr16508347pll.10.1612159029176;
        Sun, 31 Jan 2021 21:57:09 -0800 (PST)
Received: from tj.ccdomain.com ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id e12sm16700820pga.13.2021.01.31.21.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jan 2021 21:57:08 -0800 (PST)
From:   Yue Hu <zbestahu@gmail.com>
To:     ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        huyue2@yulong.com, zhangwen@yulong.com, zbestahu@163.com
Subject: [PATCH] mmc: core: Use host instead of card argument to mmc_spi_send_csd()
Date:   Mon,  1 Feb 2021 13:55:07 +0800
Message-Id: <20210201055507.542-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.29.2.windows.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Yue Hu <huyue2@yulong.com>

Since mmc_send_cxd_data() does not care card if opcode is MMC_SEND_CSD.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 drivers/mmc/core/mmc_ops.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index baa6314..265d95e 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -296,7 +296,7 @@ int mmc_set_relative_addr(struct mmc_card *card)
 	return 0;
 }
 
-static int mmc_spi_send_csd(struct mmc_card *card, u32 *csd)
+static int mmc_spi_send_csd(struct mmc_host *host, u32 *csd)
 {
 	int ret, i;
 	__be32 *csd_tmp;
@@ -305,7 +305,7 @@ static int mmc_spi_send_csd(struct mmc_card *card, u32 *csd)
 	if (!csd_tmp)
 		return -ENOMEM;
 
-	ret = mmc_send_cxd_data(card, card->host, MMC_SEND_CSD, csd_tmp, 16);
+	ret = mmc_send_cxd_data(NULL, host, MMC_SEND_CSD, csd_tmp, 16);
 	if (ret)
 		goto err;
 
@@ -320,7 +320,7 @@ static int mmc_spi_send_csd(struct mmc_card *card, u32 *csd)
 int mmc_send_csd(struct mmc_card *card, u32 *csd)
 {
 	if (mmc_host_is_spi(card->host))
-		return mmc_spi_send_csd(card, csd);
+		return mmc_spi_send_csd(card->host, csd);
 
 	return mmc_send_cxd_native(card->host, card->rca << 16,	csd,
 				MMC_SEND_CSD);
-- 
1.9.1

