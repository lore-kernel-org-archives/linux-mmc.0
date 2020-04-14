Return-Path: <SRS0=djOR=56=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C0DC2BA19
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Apr 2020 16:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15B5020678
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Apr 2020 16:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UHJb2dW0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390532AbgDNQPA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 14 Apr 2020 12:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391335AbgDNQOv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Apr 2020 12:14:51 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D621EC061A0E
        for <linux-mmc@vger.kernel.org>; Tue, 14 Apr 2020 09:14:50 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id m8so437732lji.1
        for <linux-mmc@vger.kernel.org>; Tue, 14 Apr 2020 09:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zv/IOLWsE6pD23wlMRMWXhfDzTXImiUoTlOV8wP43+4=;
        b=UHJb2dW0l0J4LUncRFQvg4oVtCEMMEfdDnMzVHl4Wb88nTNDhPXS4ozS1vm9XGcZKt
         IfvNexRyTE2Spm1kKol/wWU5pDiYw4m2kvaJwON0+Cn+sYc9eZr4ZXmAwEI4s7BQT5Xs
         n6R34d2p7c4RmwmKSkxWQPtAhfZYxDm4JcKywmEP53UH7c4snGkwu5yip74qUrGOgCaC
         ymVnyf1IjMOoOQ/3XLz1JxXM7EYgZp6TGmNPcOFkWCEGOQdOwTEynckvodv06Llu7uyL
         3ShoitgMKzNxKKUb9Wn1670P/aBKI/3rPTLthFCyPv5fY7yLYrjkMvbCPBH94Pyh0fdS
         nPPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zv/IOLWsE6pD23wlMRMWXhfDzTXImiUoTlOV8wP43+4=;
        b=APFxyIZBcQiZeT8JJgBBUj0MhpFB0cJYuKjbdvmq5497IJX43BIktJUYf4PUjdHOb3
         Xu7NTJbphFbhSEyMp+nKEMajXSTjGN1YTCt5IJwJX8pzXiXQ7VayFlso3SXC1YDfxOgl
         Xx6M1nKU6LUQkfp+rM1KCFLHG0f4C1p4BY+N/+19ayfPUE9wi9eS8rZK692O5mc5jfk/
         HBjNdAv79YsnumOCpRgn7qPm6ZZa4CIQ640QVZp3r/1nD7CqABQOaKjvGvdDwZYt9zho
         u59hNx6rE2q2rLofBljT+7RMwRbA2OKdka9Dzmk4vPaS0cYm8O7LLMGIW25PbtDN/ceG
         dLFA==
X-Gm-Message-State: AGi0PubhTJlEPGu6uS0OkZsc7vgVwma/BCCq9/EZPqif8iVGIb3AoulI
        GH4k7YXyoumhIIoMCZVJ0HcF6gfqpHA=
X-Google-Smtp-Source: APiQypLsgjIE3PF75iBeDOhwcxLS1kxYncfn8xlwnEfL4bMgnXmWOTMFNs0FTXbcxwkDIQPy+TzD7g==
X-Received: by 2002:a2e:9813:: with SMTP id a19mr510612ljj.215.1586880889001;
        Tue, 14 Apr 2020 09:14:49 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-131.NA.cust.bahnhof.se. [98.128.181.131])
        by smtp.gmail.com with ESMTPSA id a26sm9330669ljn.22.2020.04.14.09.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 09:14:48 -0700 (PDT)
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
Subject: [PATCH 18/19] mmc: mmc_spi: Respect the cmd->busy_timeout from the mmc core
Date:   Tue, 14 Apr 2020 18:14:12 +0200
Message-Id: <20200414161413.3036-19-ulf.hansson@linaro.org>
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

Using a fixed 3s polling timeout for all commands with R1B responses is a
bit problematic.

For some commands it means waiting longer than needed for the polling to be
aborted, which may not a big issue, but still. For other commands, like for
an erase (CMD38), may require longer timeouts than 3s. In these cases, we
may end up treating the command as it failed, while it just needed some
more time to complete successfully.

Fix the problem by respecting the cmd->busy_timeout, which is provided by
the mmc core.

Cc: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/mmc_spi.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index 5768fe9f8f6f..39bb1e30c2d7 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -242,6 +242,7 @@ static char *maptype(struct mmc_command *cmd)
 static int mmc_spi_response_get(struct mmc_spi_host *host,
 		struct mmc_command *cmd, int cs_on)
 {
+	unsigned long timeout_ms;
 	u8	*cp = host->data->status;
 	u8	*end = cp + host->t.len;
 	int	value = 0;
@@ -340,9 +341,11 @@ static int mmc_spi_response_get(struct mmc_spi_host *host,
 		/* maybe we read all the busy tokens already */
 		while (cp < end && *cp == 0)
 			cp++;
-		if (cp == end)
-			mmc_spi_wait_unbusy(host,
-				msecs_to_jiffies(MMC_SPI_R1B_TIMEOUT_MS));
+		if (cp == end) {
+			timeout_ms = cmd->busy_timeout ? cmd->busy_timeout :
+				MMC_SPI_R1B_TIMEOUT_MS;
+			mmc_spi_wait_unbusy(host, msecs_to_jiffies(timeout_ms));
+		}
 		break;
 
 	/* SPI R2 == R1 + second status byte; SEND_STATUS
-- 
2.20.1

