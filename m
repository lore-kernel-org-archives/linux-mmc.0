Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 415E3C48BDF
	for <linux-mmc@archiver.kernel.org>; Thu, 24 Jun 2021 06:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20337613EE
	for <linux-mmc@archiver.kernel.org>; Thu, 24 Jun 2021 06:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbhFXGXq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 24 Jun 2021 02:23:46 -0400
Received: from smtp1.hiworks.co.kr ([121.254.168.204]:40036 "EHLO
        smtp1.hiworks.co.kr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbhFXGXq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Jun 2021 02:23:46 -0400
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Jun 2021 02:23:46 EDT
Received: (qmail 141389 invoked from network); 24 Jun 2021 15:14:45 +0900
Received: from unknown (HELO hiworks.co.kr) (192.168.21.201)
        by 0 (qmail 1.03 + ejcp v14) with SMTP;
        24 Jun 2021 15:14:45 +0900
Received: (qmail 29379 invoked from network); 24 Jun 2021 15:14:45 +0900
Received: from unknown (HELO localhost.localdomain) (tykwon@m2i.co.kr@58.75.176.98)
        by 0 (qmail 1.03 + ejcp v14) with SMTP;
        24 Jun 2021 15:14:45 +0900
X-Authinfo: HIWORKS SMTP authenticated <tykwon@m2i.co.kr|58.75.176.98|tykwon@m2i.co.kr|210624151445_617828793>
From:   Kwon Tae-young <tykwon@m2i.co.kr>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Kwon Tae-young <tykwon@m2i.co.kr>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: core: Added support for LED trigger only when SD card is connected
Date:   Thu, 24 Jun 2021 15:14:17 +0900
Message-Id: <20210624061418.30361-1-tykwon@m2i.co.kr>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

led_trigger_event() is always called.
In this case, if the LED trigger is set to the SD Card, the trigger
will occur even when the SD card is not connected and the LED will blink.

In case of SD Card, it is judged based on Card Detection information and
changes to generate LED trigger only when SD Card is connected.

Board tested: NXP i.MX 8M board

Signed-off-by: Kwon Tae-young <tykwon@m2i.co.kr>
---
 drivers/mmc/core/core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index f194940c5974..b3156f6c5cfa 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -352,7 +352,11 @@ int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
 	if (err)
 		return err;
 
-	led_trigger_event(host->led, LED_FULL);
+	if (host->ops->get_cd)
+		host->ops->get_cd(host) ? led_trigger_event(host->led, LED_FULL) : NULL;
+	else
+		led_trigger_event(host->led, LED_FULL);
+
 	__mmc_start_request(host, mrq);
 
 	return 0;
-- 
2.17.1

