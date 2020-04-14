Return-Path: <SRS0=djOR=56=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E69EC2BA19
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Apr 2020 16:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 337FF20678
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Apr 2020 16:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zjda40N9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391334AbgDNQP0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 14 Apr 2020 12:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391324AbgDNQOg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Apr 2020 12:14:36 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F78C061A10
        for <linux-mmc@vger.kernel.org>; Tue, 14 Apr 2020 09:14:36 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id 131so168851lfh.11
        for <linux-mmc@vger.kernel.org>; Tue, 14 Apr 2020 09:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=80KaipN4E9vrj55eH79AaG72UG5XrIIdifniUA7tIgQ=;
        b=zjda40N94dMtZ05lDEBld1dw0zmn8kOXTcFruxfBvztIxnN3/i0t9iyLcIdEHWEMeT
         LIHVtPtiuW3LjC4Hji3TPIU01Nc4MMVy1huwdKkweZa1chhPnUInVOfIreIwnRkno6oI
         w0W0yqPBCq1zWSYWDKcUBYQOSSpv/rhtGq+Bknf1CXDbbOTyicGDstNXVD9y4PzXSHon
         +w3FrYUNvasodr5remaYOXk6xpRe1v5KyMpJwg+SPHxnjKHbd2lrM2i7jhxu6XKjNAw8
         r/bWx1Q0Z5bxEyambleM/Tq+/vY+xC6yrxuv6BTnDVnTLpGPujv9D9Ee4QhmDvyMNsdy
         G5xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=80KaipN4E9vrj55eH79AaG72UG5XrIIdifniUA7tIgQ=;
        b=NlJkLd4F+cB5D6Vkw+scMfXCBmHanirl/OzhaGAvG1DAaQ5gWdmybk3NwJykLqi0F9
         j4S6oQXps7MYmdUAhnWuwHIApMnHeVsO36NIMOzRRzVFhe+VGqDvlmnWR8RnoDzMPTVe
         KxcqrdLI0gCTeIFKvv3GgdWGyGNhSxt6/5scptX9Qj/R2A68CIw918GMvZwUdRBNfO+V
         hCA8jb/8yc12XJ21MfTN3sxXIZpqLKOevQkh+6KaT3wzWX8fpRZ1htvJXKTdOWL8di4X
         xZtk0/w48TMcBDI1gAK0F+8PzKTKS9FCA3vczYbjpNsbF4zC/srXay1Tk/gSdoFcBLxY
         osfg==
X-Gm-Message-State: AGi0PuY+UbWoux0Ep8j/D9sZ2rekyU46plY1K47u9oJ7TCZiGMeMpkZx
        1BqvLyU9aC2T84R7tiBixjhA+WB1oNo=
X-Google-Smtp-Source: APiQypKrhjdd2yd3xyPYdZQTdhlyhXKzzJglPXxGZ8H0YJAaXPYdcgoGYo2D4jnefw8dyN9f9FYD6w==
X-Received: by 2002:a19:dc05:: with SMTP id t5mr332133lfg.73.1586880874527;
        Tue, 14 Apr 2020 09:14:34 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-131.NA.cust.bahnhof.se. [98.128.181.131])
        by smtp.gmail.com with ESMTPSA id a26sm9330669ljn.22.2020.04.14.09.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 09:14:33 -0700 (PDT)
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
Subject: [PATCH 10/19] mmc: sdricoh_cs: Move MMC_APP_CMD handling to sdricoh_mmc_cmd()
Date:   Tue, 14 Apr 2020 18:14:04 +0200
Message-Id: <20200414161413.3036-11-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200414161413.3036-1-ulf.hansson@linaro.org>
References: <20200414161413.3036-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Move MMC_APP_CMD specific handling to be managed by sdricoh_mmc_cmd(), as
this makes the code a bit cleaner.

Cc: Sascha Sommer <saschasommer@freenet.de>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sdricoh_cs.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/sdricoh_cs.c b/drivers/mmc/host/sdricoh_cs.c
index a41c0660abbf..e7d74db95b57 100644
--- a/drivers/mmc/host/sdricoh_cs.c
+++ b/drivers/mmc/host/sdricoh_cs.c
@@ -149,16 +149,25 @@ static int sdricoh_query_status(struct sdricoh_host *host, unsigned int wanted,
 
 }
 
-static int sdricoh_mmc_cmd(struct sdricoh_host *host, unsigned char opcode,
-			   unsigned int arg)
+static int sdricoh_mmc_cmd(struct sdricoh_host *host, struct mmc_command *cmd)
 {
 	unsigned int status;
 	int result = 0;
 	unsigned int loop = 0;
+	unsigned char opcode = cmd->opcode;
+
 	/* reset status reg? */
 	sdricoh_writel(host, R21C_STATUS, 0x18);
+
+	/* MMC_APP_CMDs need some special handling */
+	if (host->app_cmd) {
+		opcode |= 64;
+		host->app_cmd = 0;
+	} else if (opcode == MMC_APP_CMD)
+		host->app_cmd = 1;
+
 	/* fill parameters */
-	sdricoh_writel(host, R204_CMD_ARG, arg);
+	sdricoh_writel(host, R204_CMD_ARG, cmd->arg);
 	sdricoh_writel(host, R200_CMD, (0x10000 << 8) | opcode);
 	/* wait for command completion */
 	if (opcode) {
@@ -250,28 +259,20 @@ static void sdricoh_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	struct mmc_command *cmd = mrq->cmd;
 	struct mmc_data *data = cmd->data;
 	struct device *dev = host->dev;
-	unsigned char opcode = cmd->opcode;
 	int i;
 
 	dev_dbg(dev, "=============================\n");
-	dev_dbg(dev, "sdricoh_request opcode=%i\n", opcode);
+	dev_dbg(dev, "sdricoh_request opcode=%i\n", cmd->opcode);
 
 	sdricoh_writel(host, R21C_STATUS, 0x18);
 
-	/* MMC_APP_CMDs need some special handling */
-	if (host->app_cmd) {
-		opcode |= 64;
-		host->app_cmd = 0;
-	} else if (opcode == MMC_APP_CMD)
-		host->app_cmd = 1;
-
 	/* read/write commands seem to require this */
 	if (data) {
 		sdricoh_writew(host, R226_BLOCKSIZE, data->blksz);
 		sdricoh_writel(host, R208_DATAIO, 0);
 	}
 
-	cmd->error = sdricoh_mmc_cmd(host, opcode, cmd->arg);
+	cmd->error = sdricoh_mmc_cmd(host, cmd);
 
 	/* read response buffer */
 	if (cmd->flags & MMC_RSP_PRESENT) {
-- 
2.20.1

