Return-Path: <SRS0=djOR=56=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C305AC2BA19
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Apr 2020 16:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E8C32076B
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Apr 2020 16:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f8tt1y6f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390413AbgDNQOn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 14 Apr 2020 12:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390521AbgDNQOe (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Apr 2020 12:14:34 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD6CC061A0C
        for <linux-mmc@vger.kernel.org>; Tue, 14 Apr 2020 09:14:31 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id k28so173678lfe.10
        for <linux-mmc@vger.kernel.org>; Tue, 14 Apr 2020 09:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Drk5vikO+eMqgoiRlkCCu1nIyTRzBQ4eNzUPfgIrlk0=;
        b=f8tt1y6fsUG4FuFOTOxcmCUl1y8XY4OykCcWGg3sdeQ3pDiqvmiZ7kVd2xkOinMQX/
         Lr5HBkGlDH2aWz/Biy5r5L/ia7J1Hr1kPq7pZswKNjxGgVYq5JV7KgijmMcbQqt7Xr9J
         WKx52zGAU2O3ULVisvpbNXtcsPHWX76fGbfOgKw1tOvsqQbvM32ZPAZs/7ir4cqv9bfx
         OILu4jihPtYoWNQxbW7GhW2Poh53TEXuvzqGvV+7NfTJK6o4MlkbamvHA/KtCwhz5exH
         Bf7eE7DrkKIxqD/fk2qUAdye4LYKJsvQsR5mlGn/ZPnX129uX/GURaKVEKYNePDO5mxF
         8X3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Drk5vikO+eMqgoiRlkCCu1nIyTRzBQ4eNzUPfgIrlk0=;
        b=kbct+xAqbXWawIa6QJ34Oh5APIprIzL55dXQJa+agPk4GQ4QnN7a1sAzkc3lGYnZdx
         BcZ0WYkdfZXcRVFOKkV7nNJY+kxqFyfuiC6f2wRjG+oCgAhuFG7t4mCW2Wk2fdaAibuN
         LxtX2i0WARw/0TbmN7zFcM0LrDY8e+zc+CIo5J0oyFTpqz6k75YbV+dTqKNRa4LZE92A
         RmpFou5KTlFNvwwjiSRyRSP4MK1YTtciCkYqa8q8QTTUeHUMBEghklkEQWjrpTXTevRG
         i2r9aOuq76mA3RXLu+lkhQcimMHOoSUqfZ0pJEwCJDSgd2s1fteQNAQRqbzros6J18eS
         Fsew==
X-Gm-Message-State: AGi0PuZotk1Lm1dQVYQErEPGDxxlgw+ExpdB0YZZJ22vNElvhYIBDHMT
        zNGbqs4pieYzpOHLZSiNadqF6DRSVFA=
X-Google-Smtp-Source: APiQypJgAn6RWPcdZxUy7YdttREG6dpFC9F1so2iARfkwl8BaVEyPKJpOcK0U7i9LQV4UmYygU+KxQ==
X-Received: by 2002:ac2:46ea:: with SMTP id q10mr370834lfo.128.1586880869221;
        Tue, 14 Apr 2020 09:14:29 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-131.NA.cust.bahnhof.se. [98.128.181.131])
        by smtp.gmail.com with ESMTPSA id a26sm9330669ljn.22.2020.04.14.09.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 09:14:28 -0700 (PDT)
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
Subject: [PATCH 07/19] mmc: owl-mmc: Respect the cmd->busy_timeout from the mmc core
Date:   Tue, 14 Apr 2020 18:14:01 +0200
Message-Id: <20200414161413.3036-8-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200414161413.3036-1-ulf.hansson@linaro.org>
References: <20200414161413.3036-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

For commands that doesn't involve to prepare a data transfer, owl-mmc is
using a fixed 30s response timeout. This is a bit problematic.

For some commands it means waiting longer than needed for the completion to
expire, which may not a big issue, but still. For other commands, like for
an erase (CMD38) that uses a R1B response, may require longer timeouts than
30s. In these cases, we may end up treating the command as it failed, while
it just needed some more time to complete successfully.

Fix the problem by respecting the cmd->busy_timeout, which is provided by
the mmc core.

Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/owl-mmc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/owl-mmc.c b/drivers/mmc/host/owl-mmc.c
index 01ffe51f413d..5e20c099fe03 100644
--- a/drivers/mmc/host/owl-mmc.c
+++ b/drivers/mmc/host/owl-mmc.c
@@ -92,6 +92,8 @@
 #define OWL_SD_STATE_RC16ER		BIT(1)
 #define OWL_SD_STATE_CRC7ER		BIT(0)
 
+#define OWL_CMD_TIMEOUT_MS		30000
+
 struct owl_mmc_host {
 	struct device *dev;
 	struct reset_control *reset;
@@ -172,6 +174,7 @@ static void owl_mmc_send_cmd(struct owl_mmc_host *owl_host,
 			     struct mmc_command *cmd,
 			     struct mmc_data *data)
 {
+	unsigned long timeout;
 	u32 mode, state, resp[2];
 	u32 cmd_rsp_mask = 0;
 
@@ -239,7 +242,10 @@ static void owl_mmc_send_cmd(struct owl_mmc_host *owl_host,
 	if (data)
 		return;
 
-	if (!wait_for_completion_timeout(&owl_host->sdc_complete, 30 * HZ)) {
+	timeout = msecs_to_jiffies(cmd->busy_timeout ? cmd->busy_timeout :
+		OWL_CMD_TIMEOUT_MS);
+
+	if (!wait_for_completion_timeout(&owl_host->sdc_complete, timeout)) {
 		dev_err(owl_host->dev, "CMD interrupt timeout\n");
 		cmd->error = -ETIMEDOUT;
 		return;
-- 
2.20.1

