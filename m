Return-Path: <SRS0=djOR=56=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD3CC2BB85
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Apr 2020 16:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B258D20732
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Apr 2020 16:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="byorq+Hh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390411AbgDNQPd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 14 Apr 2020 12:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391171AbgDNQOf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Apr 2020 12:14:35 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A96BC061A0F
        for <linux-mmc@vger.kernel.org>; Tue, 14 Apr 2020 09:14:35 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id d8so397188ljo.6
        for <linux-mmc@vger.kernel.org>; Tue, 14 Apr 2020 09:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ssNZhCk/W8aH/W/Y1Y0b51fjc3318cXifEh7iCUNpWY=;
        b=byorq+HhD6RQw+ZVbfQkdf7A1wS+BcXsygsl7i9QF9TOlHQ3zVlW7O7peLFC+yyRaH
         /Tr0pk50Ycv4olUb+202GQ7VDfagVPqO7zamNCITsZindq9hJUTo1GTrYbH/CMT1fM4y
         X5TiYxYkHyQdfmsjdU415XSKMcgxMtsuEo1yaHx74sLntpupNNhDM15glIJTadLLG/hn
         YoYw9B+w3tOonSaT+7t8BxtH2m72Ud9ndILWTddmhZv6eBrBVRwt5IEiWYHprdX1srat
         quCAItruFljqp/+0+tocFBvRz1Fxan3udC+uHh94IpSwc+ztS4nyhWScR82laVbSg2tb
         D3/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ssNZhCk/W8aH/W/Y1Y0b51fjc3318cXifEh7iCUNpWY=;
        b=AQQjjYmiazzUNMc6ypq4S1NHdYfDMTSYPPddhtr+rSWcf42GjhwFKfAAdcZs/sTlgT
         +ABEXy6IXrrexnDeJejfbpAmwf0iczN8KYJza/K0E8pHweXrSAIPWhLnEtNSaYHno7pN
         79tP6zrq8gfVyDQHBxs1C2BJgB1i3W5JlSOnbOyfzzeK7HBnQfCb/+JavIL6yB7UbQxF
         PYebkTm05x/LTliQZfG315m46giBDQ1/KoJ7aoqcEyatbuW4fLJ36hLZOcEWF7po2+Q8
         lWlgWc6KjuwYr/4PdZDiyaXiho1nqhZcH2LFTQCbRMQlI4k4RVOBaSZybH45TCUK3gAh
         pNDw==
X-Gm-Message-State: AGi0PuZe3sWXhaO7g5fQIaiGlvFmAcHRYYxicJZEEmIQLaDnoWlIKJPk
        VB4VeXaaa17lSd0X3O/pNgXJ5CYZmCs=
X-Google-Smtp-Source: APiQypK+UzFr/X/xwT3LC57UysC+HMAIQ0E8wkILiPjrXHpb2krTr+eX8VeYjT+17rMTHwOOInINFA==
X-Received: by 2002:a2e:9a0d:: with SMTP id o13mr541104lji.142.1586880873076;
        Tue, 14 Apr 2020 09:14:33 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-131.NA.cust.bahnhof.se. [98.128.181.131])
        by smtp.gmail.com with ESMTPSA id a26sm9330669ljn.22.2020.04.14.09.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 09:14:32 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Bruce Chang <brucechang@via.com.tw>,
        Harald Welte <HaraldWelte@viatech.com>,
        Alex Dubov <oakad@yahoo.com>,
        Sascha Sommer <saschasommer@freenet.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        mirq-linux@rere.qmqm.pl, Jesper Nilsson <jesper.nilsson@axis.com>,
        Lars Persson <lars.persson@axis.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [PATCH 09/19] mmc: sdricoh_cs: Use MMC_APP_CMD rather than a hardcoded number
Date:   Tue, 14 Apr 2020 18:14:03 +0200
Message-Id: <20200414161413.3036-10-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200414161413.3036-1-ulf.hansson@linaro.org>
References: <20200414161413.3036-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Cc: Sascha Sommer <saschasommer@freenet.de>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sdricoh_cs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdricoh_cs.c b/drivers/mmc/host/sdricoh_cs.c
index 1fc4db713ef5..a41c0660abbf 100644
--- a/drivers/mmc/host/sdricoh_cs.c
+++ b/drivers/mmc/host/sdricoh_cs.c
@@ -22,6 +22,7 @@
 #include <linux/io.h>
 
 #include <linux/mmc/host.h>
+#include <linux/mmc/mmc.h>
 
 #define DRIVER_NAME "sdricoh_cs"
 
@@ -261,7 +262,7 @@ static void sdricoh_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	if (host->app_cmd) {
 		opcode |= 64;
 		host->app_cmd = 0;
-	} else if (opcode == 55)
+	} else if (opcode == MMC_APP_CMD)
 		host->app_cmd = 1;
 
 	/* read/write commands seem to require this */
-- 
2.20.1

