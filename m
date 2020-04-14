Return-Path: <SRS0=djOR=56=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6EFC2BB85
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Apr 2020 16:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 981D820678
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Apr 2020 16:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ys2a2Rxv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390877AbgDNQPi (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 14 Apr 2020 12:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390415AbgDNQOe (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Apr 2020 12:14:34 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BD8C0610D6
        for <linux-mmc@vger.kernel.org>; Tue, 14 Apr 2020 09:14:29 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id u15so421601ljd.3
        for <linux-mmc@vger.kernel.org>; Tue, 14 Apr 2020 09:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XmKXGQtxsIOhznp9pNPhEFf64m8qqLbnWlsrQ/4SF4E=;
        b=ys2a2Rxv1fHn6dNE3FKrh4UthQoW9bZjzaswrXjhQ4Iq/aceKq1zFPe1B/WUuYki0O
         kr5I47/MFXUgaCHkk3GwoT0mT6E0HIRhLmV5zHMDD+ddUsCupd17lfD0sjfhgsFLC4u+
         Dmu1oWXhVQaCxIQ2eI4o7iNiI1dxXSoOSmxHxR2/9ZLla326g5CNJ5lzv+QBGs/lXZBZ
         hc+X82PFAdA5AS/cjVPWD4hmTDDm2TYADl1IXLe2Ji3zqrpZwHio32Zh3RT13j06sxpC
         8yaj2g0cOf1nj4OCYp4iGx9bVm8KK3TmUHTolbyP0xP+TTTEoSyfL+iRMpUTcSa0Nd6U
         Z8Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XmKXGQtxsIOhznp9pNPhEFf64m8qqLbnWlsrQ/4SF4E=;
        b=NRJ4F9syI7lKfOSuPXy0ATNiZVBaWxSsq2RLIFrmpJSzuk3fBugvK6js5CEEwPY1XP
         cCyVqpIi7c/09PjTyQmlk2/cEoaRdw2q4R3vmx3Bi0t14/ARbUhHBclevXy8ccgFFf/9
         0i2yUnIZllpHucKf0pXEs8/od43Q/VFWHvizs+Ab3SRLk2pY9PCXoYzEeEf3RUgZ6O0y
         EVI9TBvTXUczvbciIz0dySqTo8y6A+azJ090PiT/m5L9jMj0/r2dRVV/T/Mq7xW8oH+V
         d/7A7/qez5JPPp4TBTAkKjMblpM0xJ0ta4rOuorwkYZATs3u/fTVMKstYr53BhNRsS50
         LcYQ==
X-Gm-Message-State: AGi0PuZzlAFNlhmzCd/7YozLUBlCeOGXlVFeEunXpjRAc0fRv2o7+CXY
        IiJ+6Ef4QJnVhqp1FJENZCLT6SS30iM=
X-Google-Smtp-Source: APiQypIaSC7iIt+X71C9p8KMhHncniaeFLEwdearv2pXqObwPy8NQfjCkb14xmevkMJ2cFK7rA7FMg==
X-Received: by 2002:a2e:2413:: with SMTP id k19mr587913ljk.134.1586880867557;
        Tue, 14 Apr 2020 09:14:27 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-131.NA.cust.bahnhof.se. [98.128.181.131])
        by smtp.gmail.com with ESMTPSA id a26sm9330669ljn.22.2020.04.14.09.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 09:14:27 -0700 (PDT)
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
Subject: [PATCH 06/19] mmc: cb710: Inform the mmc core about the maximum busy timeout
Date:   Tue, 14 Apr 2020 18:14:00 +0200
Message-Id: <20200414161413.3036-7-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200414161413.3036-1-ulf.hansson@linaro.org>
References: <20200414161413.3036-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Some commands uses R1B responses, which means the card may assert the DAT0
line to signal busy for a period of time, after it has received the
command. The mmc core normally specifies the busy period for the command in
the cmd->busy_timeout. Ideally the driver should respect it, but that
requires quite some update of the code, so let's defer that to someone with
the HW at hand.

Instead, let's inform the mmc core about the maximum supported busy timeout
in ->max_busy_timeout during ->probe(). This value corresponds to the fixed
~2s timeout of the polling loop, implemented in cb710_wait_for_event(). In
this way, we let the mmc core validate the needed timeout, which may lead
to that it converts from a R1B into a R1 response and then use CMD13 to
poll for busy completion.

In other words, this change enables support for commands with longer busy
periods than 2s, like erase (CMD38) for example.

Cc: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/cb710-mmc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mmc/host/cb710-mmc.c b/drivers/mmc/host/cb710-mmc.c
index e33270e40539..e84ed84ea4cc 100644
--- a/drivers/mmc/host/cb710-mmc.c
+++ b/drivers/mmc/host/cb710-mmc.c
@@ -10,6 +10,8 @@
 #include <linux/delay.h>
 #include "cb710-mmc.h"
 
+#define CB710_MMC_REQ_TIMEOUT_MS	2000
+
 static const u8 cb710_clock_divider_log2[8] = {
 /*	1, 2, 4, 8, 16, 32, 128, 512 */
 	0, 1, 2, 3,  4,  5,   7,   9
@@ -707,6 +709,12 @@ static int cb710_mmc_init(struct platform_device *pdev)
 	mmc->f_min = val >> cb710_clock_divider_log2[CB710_MAX_DIVIDER_IDX];
 	mmc->ocr_avail = MMC_VDD_32_33|MMC_VDD_33_34;
 	mmc->caps = MMC_CAP_4_BIT_DATA;
+	/*
+	 * In cb710_wait_for_event() we use a fixed timeout of ~2s, hence let's
+	 * inform the core about it. A future improvement should instead make
+	 * use of the cmd->busy_timeout.
+	 */
+	mmc->max_busy_timeout = CB710_MMC_REQ_TIMEOUT_MS;
 
 	reader = mmc_priv(mmc);
 
-- 
2.20.1

