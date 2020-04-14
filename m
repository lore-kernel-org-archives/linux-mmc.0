Return-Path: <SRS0=djOR=56=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2349FC352BE
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Apr 2020 16:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F323720678
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Apr 2020 16:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pOF2huuq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390544AbgDNQOt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 14 Apr 2020 12:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391332AbgDNQOm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Apr 2020 12:14:42 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA79C061A0E
        for <linux-mmc@vger.kernel.org>; Tue, 14 Apr 2020 09:14:42 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id m8so437227lji.1
        for <linux-mmc@vger.kernel.org>; Tue, 14 Apr 2020 09:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2fc7WtOqZOvMpJU85RcRGqqZ+8XJc5IQ4CJNIRP5fnM=;
        b=pOF2huuqut38BoNJgj0iOYHBXyCNVmoo9Yvh5FawG3zltJ7ZPfJZswslJFAnENYA7I
         K77MbbC9Gi1SC5G5YVdIRTlOr2zirST1v410eFUzxYy17hn1x2HqOHhbjwVGjJR0Yqbk
         hBTyl3BG4QEEkY2qRK+s0uubn2UtmOXJt2Q2sTNOSgCs3QmyuwYEfP70KFEDyJ1Wlowy
         ojbQWIDSi8aa2W7HCCo7Ev0yE4FkG8iQ/+l3jWNhSKoezJ2t2IQ8cwQ7zoMpChk8JnVj
         CIt8FqrJU+d4afqIhJQBMtlycUzfc2gIuHm389R2Z4N30MUPXMIAACffm+w+4mKJVDcF
         oMSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2fc7WtOqZOvMpJU85RcRGqqZ+8XJc5IQ4CJNIRP5fnM=;
        b=N0lN3xUU4vKR9i+q9S+5jThs8hz42G6xtZSquF1BzSeLZ7aIw+OfiAe+npKbaMMJTt
         NUbMPfIzCmujW2xN9QPBun+pItdOi7qUfk0ngDuqwMMTne7FrQw9+wuxOfE8BgY6vIXm
         4OxUpd0NTJ6ePpNFheLx5Hq/F5eg3+lpe8uvRYqRfUWBlfJ9JqBrp07dhTNg+iAmwieQ
         005iYlFPDw5OkHvbGbUSQKFvhV+MsDm5/pfVxnTYnrSYJx3ojPDVvYtqSB3mSZiWY0Y1
         zcb2JyQ3setKZzTqbjIzeBseqU/ViDG5ycmDfIBNJ1+Zq5VGao8oktzSTBIub0HInV0z
         kNuw==
X-Gm-Message-State: AGi0PuaSm8lpUOIP4cSnEFbr1l37Ti1DOSgKbXJNaw2E7EF7GZmc92qh
        GT3t733RsySxVmO/zG20XbDVKcEt9kE=
X-Google-Smtp-Source: APiQypLAkI1rn94043/JUBbLE/tcZ4krtmAWvBc1ranLU7T14jnbHyK/ZMTiWUw5X6G6bsDXUS/mPg==
X-Received: by 2002:a2e:a584:: with SMTP id m4mr573350ljp.194.1586880880086;
        Tue, 14 Apr 2020 09:14:40 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-131.NA.cust.bahnhof.se. [98.128.181.131])
        by smtp.gmail.com with ESMTPSA id a26sm9330669ljn.22.2020.04.14.09.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 09:14:39 -0700 (PDT)
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
Subject: [PATCH 13/19] mmc: sdricoh_cs: Throttle polling rate for commands
Date:   Tue, 14 Apr 2020 18:14:07 +0200
Message-Id: <20200414161413.3036-14-ulf.hansson@linaro.org>
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
 drivers/mmc/host/sdricoh_cs.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/host/sdricoh_cs.c b/drivers/mmc/host/sdricoh_cs.c
index 7e407fb6dab8..d7a191f14337 100644
--- a/drivers/mmc/host/sdricoh_cs.c
+++ b/drivers/mmc/host/sdricoh_cs.c
@@ -59,7 +59,7 @@ static unsigned int switchlocked;
 #define STATUS_BUSY              0x40000000
 
 /* timeouts */
-#define CMD_TIMEOUT       100000
+#define SDRICOH_CMD_TIMEOUT_US	1000000
 #define SDRICOH_DATA_TIMEOUT_US	1000000
 
 /* list of supported pcmcia devices */
@@ -157,8 +157,7 @@ static int sdricoh_query_status(struct sdricoh_host *host, unsigned int wanted)
 static int sdricoh_mmc_cmd(struct sdricoh_host *host, struct mmc_command *cmd)
 {
 	unsigned int status;
-	int result = 0;
-	unsigned int loop = 0;
+	int ret;
 	unsigned char opcode = cmd->opcode;
 
 	/* reset status reg? */
@@ -174,24 +173,23 @@ static int sdricoh_mmc_cmd(struct sdricoh_host *host, struct mmc_command *cmd)
 	/* fill parameters */
 	sdricoh_writel(host, R204_CMD_ARG, cmd->arg);
 	sdricoh_writel(host, R200_CMD, (0x10000 << 8) | opcode);
+
 	/* wait for command completion */
-	if (opcode) {
-		for (loop = 0; loop < CMD_TIMEOUT; loop++) {
-			status = sdricoh_readl(host, R21C_STATUS);
-			sdricoh_writel(host, R2E4_STATUS_RESP, status);
-			if (status  & STATUS_CMD_FINISHED)
-				break;
-		}
-		/* don't check for timeout in the loop it is not always
-		   reset correctly
-		*/
-		if (loop == CMD_TIMEOUT || status & STATUS_CMD_TIMEOUT)
-			result = -ETIMEDOUT;
+	if (!opcode)
+		return 0;
 
-	}
+	ret = readl_poll_timeout(host->iobase + R21C_STATUS, status,
+			sdricoh_status_ok(host, status, STATUS_CMD_FINISHED),
+			32, SDRICOH_CMD_TIMEOUT_US);
 
-	return result;
+	/*
+	 * Don't check for timeout status in the loop, as it's not always reset
+	 * correctly.
+	 */
+	if (ret || status & STATUS_CMD_TIMEOUT)
+		return -ETIMEDOUT;
 
+	return 0;
 }
 
 static int sdricoh_reset(struct sdricoh_host *host)
-- 
2.20.1

