Return-Path: <SRS0=djOR=56=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69412C2BB85
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Apr 2020 16:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4376220678
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Apr 2020 16:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gfl+HsJW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391332AbgDNQO4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 14 Apr 2020 12:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391333AbgDNQOp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Apr 2020 12:14:45 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD850C061A0C
        for <linux-mmc@vger.kernel.org>; Tue, 14 Apr 2020 09:14:43 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id f8so163209lfe.12
        for <linux-mmc@vger.kernel.org>; Tue, 14 Apr 2020 09:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NAYTGOzmF1yJPLoKf5SgLIcN0uv0T4GhbNXd2UBLOr8=;
        b=Gfl+HsJWMnWxD/gVNOZTbUdrOLFGtdIuGd3A8G7HoKyhcEA2BIiVTchOnmhPA2whJS
         bUecBLlWxzcifZpDbNPwUR8K2vocMXWcsRWSNRZ5z4iPoq8DPJpFIbPcaoBFW5Pg2gum
         awSIam4Mk5yBSkR9AlMJxjOtvO3CUdx6CE+KURe7wvfGbaP6ILwTO+aBLLP5+Njk/HBQ
         d5L0x5hq/mwv96kzvHWeBvRISzLaCyk8rKXCwGo0qx/un7Std0fkZcHA6wtDYA0pX0ty
         vDz+5uByI/OkDCWwo/1sltsZG8dLoi4o7LQjDIVGHyRQWcRs2UebcdC/maA4HmpuMxBE
         fS5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NAYTGOzmF1yJPLoKf5SgLIcN0uv0T4GhbNXd2UBLOr8=;
        b=tbBbCR0TvJ9hrfGfwf0KqKLvYvKQuwCZ8CRcxT1JfSNAqWm6534LsQUnvbMNeTcOkc
         nQw50SnytOAm46+DNEas7VXiPSl9nK37F/GqCmD6nwE3kErLdzDbJ5V8UTBzEQ9uwQ5k
         HNMGWzYFicfSmYPywPGNrNM7/9CG/qmup+BgtyFSHcQ5sx2SHVKgJp5ZWMNvZVClJjWg
         gMpsqDZ6vj+0J32pOFGqaW/Hiurv3khTYDf+sc4zjREiQhM1tp72ON1mXL+tHngzC2zh
         3Irk0O9J/Ty4dzgrU75DHvjf+pfUzwascp2xK+8TlT+bMvrtSb5yZSurV3oMnQHvEgsS
         W+BA==
X-Gm-Message-State: AGi0Pub0nUVhwKMvufDJZYNG4QtCZq32xQzeZFgF45oTaoLWGV1WCZZi
        JPLUneL2EAHxy+rSXkcUfzUqk9DrTos=
X-Google-Smtp-Source: APiQypKUcnnytIGM2wn/odlVBvvnKz1gy03LB0EZt3MMj6rUtiVm4dzoyP886GmhOPzQBrhDOmbqtw==
X-Received: by 2002:a05:6512:1046:: with SMTP id c6mr335101lfb.115.1586880881907;
        Tue, 14 Apr 2020 09:14:41 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-131.NA.cust.bahnhof.se. [98.128.181.131])
        by smtp.gmail.com with ESMTPSA id a26sm9330669ljn.22.2020.04.14.09.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 09:14:40 -0700 (PDT)
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
Subject: [PATCH 14/19] mmc: sdricoh_cs: Respect the cmd->busy_timeout from the mmc core
Date:   Tue, 14 Apr 2020 18:14:08 +0200
Message-Id: <20200414161413.3036-15-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200414161413.3036-1-ulf.hansson@linaro.org>
References: <20200414161413.3036-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Using a fixed 1s polling timeout for all commands is a bit problematic.

For some commands it means waiting longer than needed for the polling to be
aborted, which may not a big issue, but still. For other commands, like for
an erase (CMD38) that uses a R1B response, may require longer timeouts than
1s. In these cases, we may end up treating the command as it failed, while
it just needed some more time to complete successfully.

Fix the problem by respecting the cmd->busy_timeout, which is provided by
the mmc core.

Note that, even if the sdricoh_cs driver may currently not support HW busy
detection on DAT0, some comments in the code refer to that the HW may
support it. Therefore, it seems better to be proactive in this case.

Cc: Sascha Sommer <saschasommer@freenet.de>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sdricoh_cs.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdricoh_cs.c b/drivers/mmc/host/sdricoh_cs.c
index d7a191f14337..dfd395ff7c3e 100644
--- a/drivers/mmc/host/sdricoh_cs.c
+++ b/drivers/mmc/host/sdricoh_cs.c
@@ -156,7 +156,7 @@ static int sdricoh_query_status(struct sdricoh_host *host, unsigned int wanted)
 
 static int sdricoh_mmc_cmd(struct sdricoh_host *host, struct mmc_command *cmd)
 {
-	unsigned int status;
+	unsigned int status, timeout_us;
 	int ret;
 	unsigned char opcode = cmd->opcode;
 
@@ -178,9 +178,12 @@ static int sdricoh_mmc_cmd(struct sdricoh_host *host, struct mmc_command *cmd)
 	if (!opcode)
 		return 0;
 
+	timeout_us = cmd->busy_timeout ? cmd->busy_timeout * 1000 :
+		SDRICOH_CMD_TIMEOUT_US;
+
 	ret = readl_poll_timeout(host->iobase + R21C_STATUS, status,
 			sdricoh_status_ok(host, status, STATUS_CMD_FINISHED),
-			32, SDRICOH_CMD_TIMEOUT_US);
+			32, timeout_us);
 
 	/*
 	 * Don't check for timeout status in the loop, as it's not always reset
-- 
2.20.1

