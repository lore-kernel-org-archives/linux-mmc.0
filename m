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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B90ACC433FE
	for <linux-mmc@archiver.kernel.org>; Tue,  7 Sep 2021 15:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1A0F61107
	for <linux-mmc@archiver.kernel.org>; Tue,  7 Sep 2021 15:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345011AbhIGPN1 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 7 Sep 2021 11:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344996AbhIGPNX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Sep 2021 11:13:23 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5019C061575;
        Tue,  7 Sep 2021 08:12:16 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id q11so14980353wrr.9;
        Tue, 07 Sep 2021 08:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5ZP5A58LlRBBGGbuGnMCoDE4Mh32dSN8n7HcWb22LJc=;
        b=EHZeTc4/BfMb0ZzIn2CyucXS5IEfXi/Xu9sVun7MlD9zhcf8oC+IlvO705YuTAnsJn
         vmeq7Eu0XUo1e/SAnOvB/TESxoBDIqBmM9jItC1M1ySnsnI2H2zMgth2+KG4UImCKSWg
         iXsBLfjXNeWmupp64MJn/kPpAejtMZdPSYKOjb5wzK+SCoQWC5faQwcjEsUTmJF/+/Pz
         QerNaaqM6ytmpVNIx5H8TcvIwvbeBDLZTBSViCiHuMFNxmhe53U2lT9sUKx63agbppNA
         sUSFCEtysI6z41VmF4rAgzkmA7zFrm5b5CSD+r62SPoYc0bJy1HHL1PpAFrRRpRuZUME
         jOkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5ZP5A58LlRBBGGbuGnMCoDE4Mh32dSN8n7HcWb22LJc=;
        b=gl8BQEAJHkpy9yUJT17WskAeUhGaLxFGEob92uRl8cTEa4/axzECsP3scyRjn1RYgN
         3mc+9PoUEbHTCbdMpo0kZL25PGxTizvXT1/lEA/3Nz0w+TtwZGvFyMh5S5iWywdYVTuD
         snWHJ9b0NSF56PJT6a0zg+s5lTdxv9bW0e+5ODGMkWKIp30hl9D7VcjTcWshJ7zCUNXQ
         bb61pT9R5vqmjDXrwqjo3mtm8lzuFi1TGB+aoH1AwW6gzDr7YOvEKlCGpGLX+h8ipvbf
         SDrEJnHDMjnKRztgg0A0ypCK81FJviCfgSR3dVuqaZc/lfeJv7hp6SRRRnqYqglvZBLh
         hnJg==
X-Gm-Message-State: AOAM5313r5HUOAVizoHkG0zrE0Y4ShEnD+zgPRk3f3xG2ftIsUV2YRcN
        PbWsFDJhW/+yMozOZ923puIxkFDCPgsR6Q==
X-Google-Smtp-Source: ABdhPJxmZQ+S3bwh/fAgE40A2cXGzZVmmiUSOSc3TCLsBJj29e+zLhq3WuwGAGHUx4z4emqlCPUqZQ==
X-Received: by 2002:a5d:6dd0:: with SMTP id d16mr18990967wrz.177.1631027535470;
        Tue, 07 Sep 2021 08:12:15 -0700 (PDT)
Received: from localhost.localdomain ([2a01:598:b9a6:8ece:d93e:2093:39d0:bcfd])
        by smtp.gmail.com with ESMTPSA id h16sm11271138wre.52.2021.09.07.08.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 08:12:15 -0700 (PDT)
From:   Bean Huo <huobean@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com,
        wsa+renesas@sang-engineering.com, linus.walleij@linaro.org,
        avri.altman@wdc.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     beanhuo@micron.com
Subject: [PATCH v1 2/2] mmc: core: No need to calculate the timeout value for CQE data transmission
Date:   Tue,  7 Sep 2021 17:12:04 +0200
Message-Id: <20210907151204.118861-3-huobean@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210907151204.118861-1-huobean@gmail.com>
References: <20210907151204.118861-1-huobean@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

In case CQE is enabled, the timeout value of data transmission is always
set to be maximum in sdhci_cqe_enable(), so, calculating its timeout value
is obviously superfluous. Change to return directly, which can save some CPU
cycle time.

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 drivers/mmc/core/core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 240c5af793dc..0b571a3bc988 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -649,6 +649,7 @@ EXPORT_SYMBOL(mmc_wait_for_cmd);
 void mmc_set_data_timeout(struct mmc_data *data, const struct mmc_card *card)
 {
 	unsigned int mult;
+	struct mmc_host *host = card->host;
 
 	/*
 	 * SDIO cards only define an upper 1 s limit on access.
@@ -659,6 +660,13 @@ void mmc_set_data_timeout(struct mmc_data *data, const struct mmc_card *card)
 		return;
 	}
 
+	/*
+	 * In case CQE is enabled, the timeout will be set a maximum timeout in
+	 * sdhci_cqe_enable(), so, no need to go through the below algorithm.
+	 */
+	if (host->cqe_enabled)
+		return;
+
 	/*
 	 * SD cards use a 100 multiplier rather than 10
 	 */
-- 
2.25.1

