Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF571C433FE
	for <linux-mmc@archiver.kernel.org>; Wed, 27 Oct 2021 13:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A344A60EFF
	for <linux-mmc@archiver.kernel.org>; Wed, 27 Oct 2021 13:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236340AbhJ0NKl (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 27 Oct 2021 09:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234339AbhJ0NKk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Oct 2021 09:10:40 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36379C061570;
        Wed, 27 Oct 2021 06:08:15 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id s14so1167366wrb.3;
        Wed, 27 Oct 2021 06:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uJds+IVoNkUWmdu46LtTG9grpI87Lx0MMvC2+LXmgro=;
        b=Aju+1WNhnANTfLfuP1d2JmIn+yn/9MYcrflKZCDaRh8YD/iAYKvYArd3rXHHGktyo+
         B2woyjjsVYhOGT9aB2GZc7YJ7YosfhJjj5fZDlWTjlKcjdHOrNsFW7rXaMC5bER/KbcY
         R03WM6dSl8vbqDnOmFHkw/hlp9NqgOXvXQ31cmF+NKYrX+Q+rrZuI2c9IA1E8AdA4VRr
         +qf7Wg2s2pkgytswTPzJme02TqxyDiFL2h/LuiJM1MtQq/NSok8bZQkX8TBQ0B3zYkRa
         o3uy8B+L3Ikx+2YTwrpEwBUtvMC4UlNbwqoz9VesBTRkEi04QIiKpXwYMHGpW/YL3hlN
         YPYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uJds+IVoNkUWmdu46LtTG9grpI87Lx0MMvC2+LXmgro=;
        b=1zkdGzWSHPhayrHDZc1xKs5BrqIa1r3/Oo9w/M593u64qwitq0ndXMUwdeGl7LU58B
         Hf7g9Y0i7IVxE4WQkXHWfYJYaSeDWLlJlVFYk8QrKh0ci6+0BxOrQNRKu7FWYGbsoe2t
         wY5ysUSvQlxcHNOn9P6EoTCgCTrcd8qJa3O2Tr6S+XeqyTRyROps7irGwDd/gQt19Uio
         aaUALNlcLMP6PNH7Xk9kF2Ani9s4PRjdtlodPf1Owxwmsdyh9VhYZBt0XQ3XxMtzocU/
         cJBJnx6t5GhcIH7xr4iSlgvbmtOw33Kp0kIB1VU/ROhtyVAhyyAaca9pl/VkPFNVBlov
         9p3w==
X-Gm-Message-State: AOAM532z1k+qbv1iFROgPVnciiyI+HetaBeZPYZB0aZKbaqdD8G5SD+n
        aunZEvAoz3fJ1w==
X-Google-Smtp-Source: ABdhPJwz40kCBYqsoaPbVFPwg7+k2JSxN80ok3URyhQazdOUZLjwUzSQjFzLtt7Ki5Gx4IzoMMuW0g==
X-Received: by 2002:a5d:6e8d:: with SMTP id k13mr40133468wrz.295.1635340093805;
        Wed, 27 Oct 2021 06:08:13 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id z5sm4279192wmp.26.2021.10.27.06.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 06:08:13 -0700 (PDT)
From:   Colin Ian King <colin.i.king@googlemail.com>
X-Google-Original-From: Colin Ian King <colin.i.king@gmail.com>
To:     Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] mmc: dw_mmc: exynos: Fix spelling mistake "candiates" -> candidates
Date:   Wed, 27 Oct 2021 14:08:12 +0100
Message-Id: <20211027130812.426373-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

There are several spelling mistakes in variable names and in a dev_warn
message. Fix these.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/mmc/host/dw_mmc-exynos.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index 1f8a3c0ddfe1..c2dd29ef45c6 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -442,14 +442,14 @@ static inline u8 dw_mci_exynos_move_next_clksmpl(struct dw_mci *host)
 	return sample;
 }
 
-static s8 dw_mci_exynos_get_best_clksmpl(u8 candiates)
+static s8 dw_mci_exynos_get_best_clksmpl(u8 candidates)
 {
 	const u8 iter = 8;
 	u8 __c;
 	s8 i, loc = -1;
 
 	for (i = 0; i < iter; i++) {
-		__c = ror8(candiates, i);
+		__c = ror8(candidates, i);
 		if ((__c & 0xc7) == 0xc7) {
 			loc = i;
 			goto out;
@@ -457,7 +457,7 @@ static s8 dw_mci_exynos_get_best_clksmpl(u8 candiates)
 	}
 
 	for (i = 0; i < iter; i++) {
-		__c = ror8(candiates, i);
+		__c = ror8(candidates, i);
 		if ((__c & 0x83) == 0x83) {
 			loc = i;
 			goto out;
@@ -466,11 +466,11 @@ static s8 dw_mci_exynos_get_best_clksmpl(u8 candiates)
 
 	/*
 	 * If there is no cadiates value, then it needs to return -EIO.
-	 * If there are candiates values and don't find bset clk sample value,
-	 * then use a first candiates clock sample value.
+	 * If there are candidates values and don't find bset clk sample value,
+	 * then use a first candidates clock sample value.
 	 */
 	for (i = 0; i < iter; i++) {
-		__c = ror8(candiates, i);
+		__c = ror8(candidates, i);
 		if ((__c & 0x1) == 0x1) {
 			loc = i;
 			goto out;
@@ -485,7 +485,7 @@ static int dw_mci_exynos_execute_tuning(struct dw_mci_slot *slot, u32 opcode)
 	struct dw_mci *host = slot->host;
 	struct dw_mci_exynos_priv_data *priv = host->priv;
 	struct mmc_host *mmc = slot->mmc;
-	u8 start_smpl, smpl, candiates = 0;
+	u8 start_smpl, smpl, candidates = 0;
 	s8 found;
 	int ret = 0;
 
@@ -496,18 +496,18 @@ static int dw_mci_exynos_execute_tuning(struct dw_mci_slot *slot, u32 opcode)
 		smpl = dw_mci_exynos_move_next_clksmpl(host);
 
 		if (!mmc_send_tuning(mmc, opcode, NULL))
-			candiates |= (1 << smpl);
+			candidates |= (1 << smpl);
 
 	} while (start_smpl != smpl);
 
-	found = dw_mci_exynos_get_best_clksmpl(candiates);
+	found = dw_mci_exynos_get_best_clksmpl(candidates);
 	if (found >= 0) {
 		dw_mci_exynos_set_clksmpl(host, found);
 		priv->tuned_sample = found;
 	} else {
 		ret = -EIO;
 		dev_warn(&mmc->class_dev,
-			"There is no candiates value about clksmpl!\n");
+			"There is no candidates value about clksmpl!\n");
 	}
 
 	return ret;
-- 
2.32.0

