Return-Path: <SRS0=djOR=56=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F61DC2BA19
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Apr 2020 16:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13FF220678
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Apr 2020 16:15:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qe5pJo5d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390553AbgDNQOf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 14 Apr 2020 12:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389811AbgDNQO0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Apr 2020 12:14:26 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4AEC061A10
        for <linux-mmc@vger.kernel.org>; Tue, 14 Apr 2020 09:14:24 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id k21so426341ljh.2
        for <linux-mmc@vger.kernel.org>; Tue, 14 Apr 2020 09:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/u7NC6yDRYNMvCAgPxU0HxDtYNDMqbE9FekEfbQcOQI=;
        b=Qe5pJo5dEPudnBkoPikQMvE6hJ5ljLrOG38fGhfx5vrpBWxgRFNkeMDiieUT4RPMKa
         5tTXHjKo6VeyWJDk8FlOCDwYNQzttV9GQEzosgU1ZSjFxvd+Dq26m5WuGJeOZ8f9NqzE
         jaqiLnetGzYTiXYEo1xZkCXVigQlaMmQ2J7s8IEL4zGBbBWp2DPjlI8o6u97IGuaJp/8
         Oc5ZmJSfEV2qR74c1BtvuVO8zmNBb41B6VdWHFJOTInSFFij49C0Cu7s7+ATtWogKlIJ
         3aXD5TmWUp01eerr7G4uhVPyPv73AFEUABXEBFz7G0RZj12RgibE/4NZFBiqSYvAv1Ru
         VKIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/u7NC6yDRYNMvCAgPxU0HxDtYNDMqbE9FekEfbQcOQI=;
        b=BTZJoLUg5D4i/Gh8uWepeQSHw695cyIskjkXIxzmM7OOEgXcfZJanLcStfFIiISr4N
         x7UZMnERAcB5T2iYggJ1yapvPl+BtOXjHHaFCU5dpGHvZNje0RhZztbGuWFnzKVwB7uw
         zgjpR9crEAf2PlZrLGJN6zeuTFJOlbc0kFoNJHip3tpG+CXs3wNx4MLDgoLuAAoEZvXz
         bHt0hvhfBJ4qwDoCAIINsY9YIt0yoLqiZO+CB819pQlXOdWIFCvQI7reSTHFSqI5DmLn
         KTC0SdHa0YPepGm79Labwy9DnyFeDVlvS4k4+F42AFHuBu1DJetVWT4Os9ljxmrpcZzb
         0Iaw==
X-Gm-Message-State: AGi0PuYppaNcBfmqSOwygO878aHQtpfcGFoR7xqnr40DxS+sQSlYDqNw
        J/PGWTFjiJ8w0jd+zRUdhpp33bAAjE4=
X-Google-Smtp-Source: APiQypIgOtfZ87J/KQSZFiapD6CrLOavQOnvdrCDtYDXFD5vzNbytd1wC7vz/1FKmxXrpSQWSVJX1w==
X-Received: by 2002:a2e:a179:: with SMTP id u25mr568229ljl.192.1586880862780;
        Tue, 14 Apr 2020 09:14:22 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-131.NA.cust.bahnhof.se. [98.128.181.131])
        by smtp.gmail.com with ESMTPSA id a26sm9330669ljn.22.2020.04.14.09.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 09:14:22 -0700 (PDT)
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
Subject: [PATCH 03/19] mmc: atmel-mci: Respect the cmd->busy_timeout from the mmc core
Date:   Tue, 14 Apr 2020 18:13:57 +0200
Message-Id: <20200414161413.3036-4-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200414161413.3036-1-ulf.hansson@linaro.org>
References: <20200414161413.3036-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Using a fixed 2s timeout for all commands is a bit problematic.

For some commands it means waiting longer than needed for the timer to
expire, which may not a big issue, but still. For other commands, like for
an erase (CMD38) that uses a R1B response, may require longer timeouts than
2s. In these cases, we may end up treating the command as it failed, while
it just needed some more time to complete successfully.

Fix the problem by respecting the cmd->busy_timeout, which is provided by
the mmc core.

Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/atmel-mci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 7292970065b6..5cb692687698 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -809,6 +809,9 @@ static u32 atmci_prepare_command(struct mmc_host *mmc,
 static void atmci_send_command(struct atmel_mci *host,
 		struct mmc_command *cmd, u32 cmd_flags)
 {
+	unsigned int timeout_ms = cmd->busy_timeout ? cmd->busy_timeout :
+		ATMCI_CMD_TIMEOUT_MS;
+
 	WARN_ON(host->cmd);
 	host->cmd = cmd;
 
@@ -819,8 +822,7 @@ static void atmci_send_command(struct atmel_mci *host,
 	atmci_writel(host, ATMCI_ARGR, cmd->arg);
 	atmci_writel(host, ATMCI_CMDR, cmd_flags);
 
-	mod_timer(&host->timer,
-		  jiffies + msecs_to_jiffies(ATMCI_CMD_TIMEOUT_MS));
+	mod_timer(&host->timer, jiffies + msecs_to_jiffies(timeout_ms));
 }
 
 static void atmci_send_stop_cmd(struct atmel_mci *host, struct mmc_data *data)
-- 
2.20.1

