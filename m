Return-Path: <SRS0=djOR=56=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62FB1C2BA19
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Apr 2020 16:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DCD920775
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Apr 2020 16:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DryjMEKr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389777AbgDNQOq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 14 Apr 2020 12:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390544AbgDNQOl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Apr 2020 12:14:41 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE97C061A0C
        for <linux-mmc@vger.kernel.org>; Tue, 14 Apr 2020 09:14:40 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id d8so397494ljo.6
        for <linux-mmc@vger.kernel.org>; Tue, 14 Apr 2020 09:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dl5IYIZsM+xCsV4Ecpy9SUMpLQO9Iofc7JQPlPyzfk4=;
        b=DryjMEKrVO5cGSgi2YFVMImFkP1YSPCxmWdaNk+r4GvhQkI/mnECJV5s3T9HjkHZlG
         bJZPSKCUL9mZno5IxN3xnEZhzAks9v4jyto1e6ZQos13mqoLpDdSTZbpixnpdo8QU99v
         O7HFKT6wTQFvuv9CrIONrD5U+5KNUAP+tLexQyZfqrR3GgC0PN2YUn0ho4cmf6O9Cabe
         uiNuknLBHu1mgjFhwwGYWppr/vwlgxpBKbuKoGiKP51hoo3gOycSfrD3yrSmETTIv/Zu
         moyijH48Y0Hkhh53qyoRYZjZv6GE10R240TStiZ4mUfcxTZMctCBRgMUje93aoxMsU90
         b7Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dl5IYIZsM+xCsV4Ecpy9SUMpLQO9Iofc7JQPlPyzfk4=;
        b=IseOPz8B1bh+HjA6dwvjABz2x24srq5EYoCWfFhErll/zxU8OwPcuApoZ8wC49iIG8
         uWBRqMOkKrxhvef16UW8m7Kq2jrZqFcuX/soG85BVVw01/PVq6NjF5zZ+SSD4bgwKjAd
         y7dtKea6pB92fC2NqwaKuEDE/Y1jqbAAlEe4seleu6LDjuAYm06VQyEpAz9Lm61Nlfz2
         dM7bt8ohOq7HQwezYzAbTIa4MxPycfwt0nmXMIUVvCNksAPuKrGUArL7YMjct13iv0yC
         UuTWbiXyfvfYP89w1quuWCt0pNr9ZYM81JdR9NSNOt95rDHyDY/o3RMc7x4yZmLudECL
         jgCw==
X-Gm-Message-State: AGi0PuYqCbRAvCDmvyeqkqheYYz36o5uI/WpaPdqaqZVoT2I1Q1Iv+YJ
        RvLlPGEWVBz7sj1yq4e7dO5V0IgPWYw=
X-Google-Smtp-Source: APiQypICI5S6iE4gdXMXAr+FOW4UXprBZW6+RBHUTF9xmN/eKtOI8iHHcHKeYxC0pVba8L5j8x8u0Q==
X-Received: by 2002:a2e:b8c7:: with SMTP id s7mr582589ljp.212.1586880878482;
        Tue, 14 Apr 2020 09:14:38 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-131.NA.cust.bahnhof.se. [98.128.181.131])
        by smtp.gmail.com with ESMTPSA id a26sm9330669ljn.22.2020.04.14.09.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 09:14:37 -0700 (PDT)
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
Subject: [PATCH 12/19] mmc: sdricoh_cs: Throttle polling rate for data transfers
Date:   Tue, 14 Apr 2020 18:14:06 +0200
Message-Id: <20200414161413.3036-13-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200414161413.3036-1-ulf.hansson@linaro.org>
References: <20200414161413.3036-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Rather than to poll in a busy-loop, let's convert into using
readl_poll_timeout() and insert a small delay between each polling
attempts. In particular, this avoids hogging the CPU.

Additionally, to convert to readl_poll_timeout() we also need to switch
from using a specific number of polling attempts, into a specific timeout
in us instead. The previous 100000 attempts, is translated into a total
timeout of total 1s, as that seemed like reasonable value to pick.

Cc: Sascha Sommer <saschasommer@freenet.de>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sdricoh_cs.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/sdricoh_cs.c b/drivers/mmc/host/sdricoh_cs.c
index 97ef7d71375a..7e407fb6dab8 100644
--- a/drivers/mmc/host/sdricoh_cs.c
+++ b/drivers/mmc/host/sdricoh_cs.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/ioport.h>
+#include <linux/iopoll.h>
 #include <linux/scatterlist.h>
 
 #include <pcmcia/cistpl.h>
@@ -59,7 +60,7 @@ static unsigned int switchlocked;
 
 /* timeouts */
 #define CMD_TIMEOUT       100000
-#define TRANSFER_TIMEOUT  100000
+#define SDRICOH_DATA_TIMEOUT_US	1000000
 
 /* list of supported pcmcia devices */
 static const struct pcmcia_device_id pcmcia_ids[] = {
@@ -123,21 +124,23 @@ static inline unsigned int sdricoh_readb(struct sdricoh_host *host,
 	return value;
 }
 
+static bool sdricoh_status_ok(struct sdricoh_host *host, unsigned int status,
+			      unsigned int wanted)
+{
+	sdricoh_writel(host, R2E4_STATUS_RESP, status);
+	return status & wanted;
+}
+
 static int sdricoh_query_status(struct sdricoh_host *host, unsigned int wanted)
 {
-	unsigned int loop;
+	int ret;
 	unsigned int status = 0;
-	unsigned int timeout = TRANSFER_TIMEOUT;
 	struct device *dev = host->dev;
 
-	for (loop = 0; loop < timeout; loop++) {
-		status = sdricoh_readl(host, R21C_STATUS);
-		sdricoh_writel(host, R2E4_STATUS_RESP, status);
-		if (status & wanted)
-			break;
-	}
-
-	if (loop == timeout) {
+	ret = readl_poll_timeout(host->iobase + R21C_STATUS, status,
+				 sdricoh_status_ok(host, status, wanted),
+				 32, SDRICOH_DATA_TIMEOUT_US);
+	if (ret) {
 		dev_err(dev, "query_status: timeout waiting for %x\n", wanted);
 		return -ETIMEDOUT;
 	}
-- 
2.20.1

