Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52611C00140
	for <linux-mmc@archiver.kernel.org>; Thu, 18 Aug 2022 12:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239006AbiHRMrD (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 18 Aug 2022 08:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234545AbiHRMrC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Aug 2022 08:47:02 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3E4647D2
        for <linux-mmc@vger.kernel.org>; Thu, 18 Aug 2022 05:47:00 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ba1so1619491wrb.5
        for <linux-mmc@vger.kernel.org>; Thu, 18 Aug 2022 05:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kohlschutter-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=tA1R14Sg29SD+OU/KrtHL4uyHeuXBhNpWPoNMcJBZBc=;
        b=KGZRJ7mnecJzTW9KKPgbHSz9k+hCFduy9ztHKv9FJHxLUw5es+Te9JWtvk08tZkiMG
         b7FAVfUf1pbTfq9G+9v+rQDCFT68/GOhTblK5DmfrOhTxwj1XBa+ujasgC3eCMd3telC
         TXOr6WMgOsLwU9oXp0Kuk1MJuRKyXf0xOCGC2CFkc8HZ064b1PcHiWsNNB4EHK7WA82F
         0glADvqN5hFRHpxIbMQ4qHClMWqwihuxZ9exY1xCDEKv6QmMfDOdp46jEkgauOOjlDwk
         hEZ8wDv9KBaOdQlh0oR+xZ+V46TSQ0Dl1yxAvFzJ8pjuSRaq4fu3rQcldJTe7EtmweMw
         AJWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=tA1R14Sg29SD+OU/KrtHL4uyHeuXBhNpWPoNMcJBZBc=;
        b=t323uQ/5vpgaH2gogtiuTgAAg9+wMx/7JMKwJafzHLj8NaIqIiGtM3XpUTwL8yNkYP
         7a3LhCke/WSBx9iZep+vzdi0azBmxxq8NAqek2coT4wNz2zpDbLXuf8sxiRJbyfVtyKX
         9zbHJffWz12eP+XzprjoM9OpxydLrrQJL01C8F5XLDv/UBlv1PhZE1qWXwLAb/pD3+MY
         /aQ9dqx6EnJkG+eJXe6CeBCdEQBoOftrovVYVXXPL83u1Zzr5HmQmf7t2JgdVqc3qWH0
         wA+JIobEy/sezqY2IMy9j+PNGub05GyTJbk7vdlJFb1IT6+PHfSdlQ5CngyyaKJ0LP2T
         /AJQ==
X-Gm-Message-State: ACgBeo2FOwu3aLaGiATDeNiHRM7scU/J3NWbioIuRPobVJBFKIa3zAaC
        UUqJf9iRdZp0arLrOHxCMzZ80w==
X-Google-Smtp-Source: AA6agR530W/+EKo2o0KHAo/XNpXNqu6Oo57BaqO6dvk2mtHtcuvLeT62hVx9REO/7HO5AUtUiLOaMg==
X-Received: by 2002:a05:6000:3c6:b0:220:5efd:423c with SMTP id b6-20020a05600003c600b002205efd423cmr1616366wrg.214.1660826818469;
        Thu, 18 Aug 2022 05:46:58 -0700 (PDT)
Received: from p330.kohl.home (ip5b434222.dynamic.kabel-deutschland.de. [91.67.66.34])
        by smtp.gmail.com with ESMTPSA id t24-20020a7bc3d8000000b003a5bd5ea215sm1975741wmj.37.2022.08.18.05.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 05:46:57 -0700 (PDT)
From:   =?UTF-8?q?Christian=20Kohlschu=CC=88tter?= 
        <christian@kohlschutter.com>
To:     broonie@kernel.org
Cc:     christian@kohlschutter.com, heiko@sntech.de, lgirdwood@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-rockchip@lists.infradead.org,
        m.reichl@fivetechno.de, robin.murphy@arm.com,
        vincent.legoll@gmail.com, wens@kernel.org
Subject: [PATCH v4] regulator: core: Resolve supply name earlier to prevent double-init
Date:   Thu, 18 Aug 2022 12:46:47 +0000
Message-Id: <20220818124646.6005-1-christian@kohlschutter.com>
X-Mailer: git-send-email 2.36.2
In-Reply-To: <YvorNPDQQr2SH/NF@sirena.org.uk>
References: <YvorNPDQQr2SH/NF@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Christian Kohlschütter <christian@kohlschutter.com>

Previously, an unresolved regulator supply reference upon calling
regulator_register on an always-on or boot-on regulator caused
set_machine_constraints to be called twice.

This in turn may initialize the regulator twice, leading to voltage
glitches that are timing-dependent. A simple, unrelated configuration
change may be enough to hide this problem, only to be surfaced by
chance.

One such example is the SD-Card voltage regulator in a NanoPI R4S that
would not initialize reliably unless the registration flow was just
complex enough to allow the regulator to properly reset between calls.

Fix this by re-arranging regulator_register, trying resolve the
regulator's supply early enough that set_machine_constraints does not
need to be called twice.

Signed-off-by: Christian Kohlschütter <christian@kohlschutter.com>
---
 drivers/regulator/core.c | 52 +++++++++++++++++++++++++---------------
 1 file changed, 33 insertions(+), 19 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index d8373cb04f9..a5033c6ba01 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -5496,7 +5496,39 @@ regulator_register(const struct regulator_desc *regulator_desc,
 	BLOCKING_INIT_NOTIFIER_HEAD(&rdev->notifier);
 	INIT_DELAYED_WORK(&rdev->disable_work, regulator_disable_work);
 
-	/* preform any regulator specific init */
+	/* set regulator constraints */
+	if (init_data)
+		rdev->constraints = kmemdup(&init_data->constraints,
+					    sizeof(*rdev->constraints),
+					    GFP_KERNEL);
+	else
+		rdev->constraints = kzalloc(sizeof(*rdev->constraints),
+					    GFP_KERNEL);
+	if (!rdev->constraints) {
+		ret = -ENOMEM;
+		goto clean;
+	}
+
+	if (init_data && init_data->supply_regulator)
+		rdev->supply_name = init_data->supply_regulator;
+	else if (regulator_desc->supply_name)
+		rdev->supply_name = regulator_desc->supply_name;
+
+	if ((rdev->supply_name && !rdev->supply) &&
+			(rdev->constraints->always_on ||
+			 rdev->constraints->boot_on)) {
+		/* Try to resolve the name of the supplying regulator here first
+		 * so we prevent double-initializing the regulator, which may
+		 * cause timing-specific voltage brownouts/glitches that are
+		 * hard to debug.
+		 */
+		ret = regulator_resolve_supply(rdev);
+		if (ret)
+			rdev_dbg(rdev, "unable to resolve supply early: %pe\n",
+					 ERR_PTR(ret));
+	}
+
+	/* perform any regulator specific init */
 	if (init_data && init_data->regulator_init) {
 		ret = init_data->regulator_init(rdev->reg_data);
 		if (ret < 0)
@@ -5522,24 +5554,6 @@ regulator_register(const struct regulator_desc *regulator_desc,
 		    (unsigned long) atomic_inc_return(&regulator_no));
 	dev_set_drvdata(&rdev->dev, rdev);
 
-	/* set regulator constraints */
-	if (init_data)
-		rdev->constraints = kmemdup(&init_data->constraints,
-					    sizeof(*rdev->constraints),
-					    GFP_KERNEL);
-	else
-		rdev->constraints = kzalloc(sizeof(*rdev->constraints),
-					    GFP_KERNEL);
-	if (!rdev->constraints) {
-		ret = -ENOMEM;
-		goto wash;
-	}
-
-	if (init_data && init_data->supply_regulator)
-		rdev->supply_name = init_data->supply_regulator;
-	else if (regulator_desc->supply_name)
-		rdev->supply_name = regulator_desc->supply_name;
-
 	ret = set_machine_constraints(rdev);
 	if (ret == -EPROBE_DEFER) {
 		/* Regulator might be in bypass mode and so needs its supply
-- 
2.36.2

