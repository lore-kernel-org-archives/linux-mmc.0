Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 723C5C433E0
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Feb 2021 01:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32E1364DC4
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Feb 2021 01:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbhBOBwM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 14 Feb 2021 20:52:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbhBOBwL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 14 Feb 2021 20:52:11 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C21C061574;
        Sun, 14 Feb 2021 17:51:31 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id m6so3282549pfk.1;
        Sun, 14 Feb 2021 17:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=66Gpo3THQwpAPEL1nYuvGvP8jeKMfFXdb8gVgziwIg4=;
        b=YlH4KGRz7vhGHvJoW2mJvpOice9AgV+D6hVGVcPsCeSEWPhfwTf4CbXxvAP79zio3M
         YespDkqvTSRKDClI9wwQksEUuC/mBmFV5DHJicsKbHVpwhLqNm3HuCkUvxS2+6jl2kDE
         kjhQbsVidZjHav/8HzWOiS6GNwUXDY3cED+J/J6gjCVKt39d+XC1rHeILxLwCWh2Kl5Z
         WvRzyrYqdGkdSDh/Nidhfp/QxavY5TtXeW02VtrTkMkzY/Cy1Db44WclSSSQbb402VGz
         P2rjen49SQSC/zDaoPZlRTv8p7qExtrA6ujUe7qlqVSGL2809IWHUFZPAg6XNzqWSSXc
         1o2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=66Gpo3THQwpAPEL1nYuvGvP8jeKMfFXdb8gVgziwIg4=;
        b=k2kzvzVSnu6TDtY9awQ8F9EGZjPFXUC/fkiTVMQy+uLLJdXSMG6dXheQ2WlLOG4Oji
         2I+iL33dxxUQ3CQJnC2aOF8y8+ex5TnMRk8UgN4Lt2ehos1JXPZyhnjI6xPVRWwWTuEd
         GMOkArKPBN8cPi4bl0FFntbBgVaW/UXXmDlJA0XH3rdkGUYcL/qcR/Zh6h8KHO3174aT
         4yEozzdVkl1JLknBiaBuOlLSIW0Ad7FhjZON3ERX8TDgavJ18gbF5MbvleWHOTZI3F+/
         4J583MV3EI3+d0yzM84pHuZW3QbfhZvmUR9DjU7t39cbI1qw+QPLNPWJxSepZZuayAHi
         hliw==
X-Gm-Message-State: AOAM533aR8L5JzgbtZag/QOkUDHw1Nc3EweEi8kJ5/1ejoIVPkMWt1cp
        Lo01RO05TxYBljX09UnXhF2RXHKGJRy9DtbO
X-Google-Smtp-Source: ABdhPJxNHs5B4aJdaDwdhmZBHZGYlF1w81bqsNNIgJ8Tmu678+BNy9aFN2y17lpG7nDyiLZvEePi1A==
X-Received: by 2002:a62:8445:0:b029:1c1:c862:8fc4 with SMTP id k66-20020a6284450000b02901c1c8628fc4mr13112877pfd.77.1613353891040;
        Sun, 14 Feb 2021 17:51:31 -0800 (PST)
Received: from tj.ccdomain.com ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id j3sm14993653pjs.50.2021.02.14.17.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Feb 2021 17:51:30 -0800 (PST)
From:   Yue Hu <zbestahu@gmail.com>
To:     ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        huyue2@yulong.com, zhangwen@yulong.com, zbestahu@163.com
Subject: [PATCH] mmc: core: Reduce code duplication to mmc_spi_send_{csd|cid}
Date:   Mon, 15 Feb 2021 09:51:16 +0800
Message-Id: <20210215015116.1355-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.29.2.windows.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Yue Hu <huyue2@yulong.com>

mmc_spi_send_{csd|cid} have similar function body. Let's remove the
duplicated part to simplify the code, just add opcode to distinguish
them in changed mmc_spi_send_cxd().

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 drivers/mmc/core/mmc_ops.c | 39 +++++++++------------------------------
 1 file changed, 9 insertions(+), 30 deletions(-)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 265d95e..f413474 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -296,61 +296,40 @@ int mmc_set_relative_addr(struct mmc_card *card)
 	return 0;
 }
 
-static int mmc_spi_send_csd(struct mmc_host *host, u32 *csd)
+static int mmc_spi_send_cxd(struct mmc_host *host, u32 *cxd, u32 opcode)
 {
 	int ret, i;
-	__be32 *csd_tmp;
+	__be32 *cxd_tmp;
 
-	csd_tmp = kzalloc(16, GFP_KERNEL);
-	if (!csd_tmp)
+	cxd_tmp = kzalloc(16, GFP_KERNEL);
+	if (!cxd_tmp)
 		return -ENOMEM;
 
-	ret = mmc_send_cxd_data(NULL, host, MMC_SEND_CSD, csd_tmp, 16);
+	ret = mmc_send_cxd_data(NULL, host, opcode, cxd_tmp, 16);
 	if (ret)
 		goto err;
 
 	for (i = 0; i < 4; i++)
-		csd[i] = be32_to_cpu(csd_tmp[i]);
+		cxd[i] = be32_to_cpu(cxd_tmp[i]);
 
 err:
-	kfree(csd_tmp);
+	kfree(cxd_tmp);
 	return ret;
 }
 
 int mmc_send_csd(struct mmc_card *card, u32 *csd)
 {
 	if (mmc_host_is_spi(card->host))
-		return mmc_spi_send_csd(card->host, csd);
+		return mmc_spi_send_cxd(card->host, csd, MMC_SEND_CSD);
 
 	return mmc_send_cxd_native(card->host, card->rca << 16,	csd,
 				MMC_SEND_CSD);
 }
 
-static int mmc_spi_send_cid(struct mmc_host *host, u32 *cid)
-{
-	int ret, i;
-	__be32 *cid_tmp;
-
-	cid_tmp = kzalloc(16, GFP_KERNEL);
-	if (!cid_tmp)
-		return -ENOMEM;
-
-	ret = mmc_send_cxd_data(NULL, host, MMC_SEND_CID, cid_tmp, 16);
-	if (ret)
-		goto err;
-
-	for (i = 0; i < 4; i++)
-		cid[i] = be32_to_cpu(cid_tmp[i]);
-
-err:
-	kfree(cid_tmp);
-	return ret;
-}
-
 int mmc_send_cid(struct mmc_host *host, u32 *cid)
 {
 	if (mmc_host_is_spi(host))
-		return mmc_spi_send_cid(host, cid);
+		return mmc_spi_send_cxd(host, cid, MMC_SEND_CID);
 
 	return mmc_send_cxd_native(host, 0, cid, MMC_ALL_SEND_CID);
 }
-- 
1.9.1

