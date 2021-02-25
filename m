Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A53D3C433DB
	for <linux-mmc@archiver.kernel.org>; Thu, 25 Feb 2021 17:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EDBA64F13
	for <linux-mmc@archiver.kernel.org>; Thu, 25 Feb 2021 17:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbhBYRF4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 25 Feb 2021 12:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbhBYREt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 25 Feb 2021 12:04:49 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB51C061786
        for <linux-mmc@vger.kernel.org>; Thu, 25 Feb 2021 09:04:08 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id e7so9651255lft.2
        for <linux-mmc@vger.kernel.org>; Thu, 25 Feb 2021 09:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vj9rdIaC2NXd2ktY/guBoYHKwtZ19VGh75jY1riwXmk=;
        b=guHDoLEECvKjKyHltm0WRI213M65b10M0InJ3+CiKpohgzE/LmWJCZVMa3/9hcSsy1
         7M95nwTk9s8UQEoTlg0+nasyj8VFxZ1YUj5JF/3viFIglVKrNUXkZVv5Swxk++ow7Qsw
         3s7SfeSAzTds/HRMJPji2dHIPyM6ovWZSygdXeqCUOeS4gARnLP5nV+hbe8KUrAVx6VB
         KuWkQ6xAdaejLoXqPO3nVd6n9t9SAwbzvXWNLSYhfis5cYrhJMMf5ovGpjYi/JDD5it9
         xPi92RBccdKq1vHi2CX9I6aTZiKj9XT585/lwOp1FtJ4UMhOrEr8Q+uORU+qyoAQU5qE
         xcng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vj9rdIaC2NXd2ktY/guBoYHKwtZ19VGh75jY1riwXmk=;
        b=T47w1rhfBkPUEo5FsMI3eehhK3lHsJlIZcmsyS+nwiggXg3npVmbQlg98yqBGFLICI
         Kek+ndVGqjz1HA1oRitMAQFnmDjixYp4QXp9YRteDUDEjTKThbgNEiqkllD9zr/cZfPB
         4KllP15FP5/61O3xNLLU57iMykyCa2b4ANPjyXH5/V7m3ssNoRkhI9YvuGAIBF02loU1
         QbPGVtp/xWRzxmXIBKsIgxavPUf/Mg4lX66DnnePYwMLzTaVZnlGLSJ1klEnIx0QwqEi
         Ng85gk4tONP2UF6LqEgqkZXmzH6GoLy9UFuESQhOv/9sP6cDk+1//vsyz1wcXS5mN6z6
         XZEg==
X-Gm-Message-State: AOAM531HphvboWvnkIZsDPhfxCU6eQwaeZTSe9JVyJyG0ZptkDBdo2Ld
        MwqhJPjp6+FiAZDG4P4y/I45Su3jWoyEBA==
X-Google-Smtp-Source: ABdhPJwRC+KhmoMpNcZAsBwMSKrl2NeOaJRIlJkg1RF7mJ9XoLIydrpQAmVR0qTjIyxwhXBYYWonoQ==
X-Received: by 2002:a05:6512:5d7:: with SMTP id o23mr2454322lfo.254.1614272646204;
        Thu, 25 Feb 2021 09:04:06 -0800 (PST)
Received: from localhost.localdomain (h-155-4-129-234.NA.cust.bahnhof.se. [155.4.129.234])
        by smtp.gmail.com with ESMTPSA id b39sm1103749ljf.68.2021.02.25.09.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 09:04:05 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        greg.tu@genesyslogic.com.tw, Renius Chen <reniuschengl@gmail.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Takao Orito <orito.takao@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] mmc: core: Cleanup printing of speed mode at card insertion
Date:   Thu, 25 Feb 2021 18:03:49 +0100
Message-Id: <20210225170352.76872-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210225170352.76872-1-ulf.hansson@linaro.org>
References: <20210225170352.76872-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The current print of the bus speed mode in mmc_add_card() has grown over
the years and is now difficult to parse. Let's clean up the code and also
take the opportunity to properly announce "DDR" for eMMCs as
"high speed DDR", which is according to the eMMC spec.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/bus.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index c2e70b757dd1..f4851ec8290c 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -311,6 +311,7 @@ int mmc_add_card(struct mmc_card *card)
 {
 	int ret;
 	const char *type;
+	const char *speed_mode = "";
 	const char *uhs_bus_speed_mode = "";
 	static const char *const uhs_speeds[] = {
 		[UHS_SDR12_BUS_SPEED] = "SDR12 ",
@@ -349,27 +350,30 @@ int mmc_add_card(struct mmc_card *card)
 		break;
 	}
 
+	if (mmc_card_hs(card))
+		speed_mode = "high speed ";
+	else if (mmc_card_uhs(card))
+		speed_mode = "ultra high speed ";
+	else if	(mmc_card_ddr52(card))
+		speed_mode = "high speed DDR ";
+	else if (mmc_card_hs200(card))
+		speed_mode = "HS200 ";
+	else if (mmc_card_hs400es(card))
+		speed_mode = "HS400 Enhanced strobe ";
+	else if (mmc_card_hs400(card))
+		speed_mode = "HS400 ";
+
 	if (mmc_card_uhs(card) &&
 		(card->sd_bus_speed < ARRAY_SIZE(uhs_speeds)))
 		uhs_bus_speed_mode = uhs_speeds[card->sd_bus_speed];
 
-	if (mmc_host_is_spi(card->host)) {
-		pr_info("%s: new %s%s%s card on SPI\n",
-			mmc_hostname(card->host),
-			mmc_card_hs(card) ? "high speed " : "",
-			mmc_card_ddr52(card) ? "DDR " : "",
-			type);
-	} else {
-		pr_info("%s: new %s%s%s%s%s%s card at address %04x\n",
-			mmc_hostname(card->host),
-			mmc_card_uhs(card) ? "ultra high speed " :
-			(mmc_card_hs(card) ? "high speed " : ""),
-			mmc_card_hs400(card) ? "HS400 " :
-			(mmc_card_hs200(card) ? "HS200 " : ""),
-			mmc_card_hs400es(card) ? "Enhanced strobe " : "",
-			mmc_card_ddr52(card) ? "DDR " : "",
+	if (mmc_host_is_spi(card->host))
+		pr_info("%s: new %s%s card on SPI\n",
+			mmc_hostname(card->host), speed_mode, type);
+	else
+		pr_info("%s: new %s%s%s card at address %04x\n",
+			mmc_hostname(card->host), speed_mode,
 			uhs_bus_speed_mode, type, card->rca);
-	}
 
 #ifdef CONFIG_DEBUG_FS
 	mmc_add_card_debugfs(card);
-- 
2.25.1

