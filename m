Return-Path: <SRS0=djOR=56=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C368C2BB85
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Apr 2020 16:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECE1820678
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Apr 2020 16:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ybNoaVLx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390614AbgDNQQa (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 14 Apr 2020 12:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389809AbgDNQOY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Apr 2020 12:14:24 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34145C061A0F
        for <linux-mmc@vger.kernel.org>; Tue, 14 Apr 2020 09:14:23 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id q19so375081ljp.9
        for <linux-mmc@vger.kernel.org>; Tue, 14 Apr 2020 09:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7LduVD2uZS35fq7b3rWpwMCdk3E6T3OQ5w3znT1sZ0o=;
        b=ybNoaVLxsmcOKKwqgU+D19pNdmFWVntSm7VVsTsiO3lwWfS4JurMrNdeAZ2GrbhEe1
         QETjMX/gguWOx+2iYkbixlWIVdMgjqxCyOg0JJY2MvLsd4bTHEi0K2I2b9l03sxGrnSc
         z1nXqYtPsd5MFWYWB18Brf2T8MeAzmlZgUZvsaAwirI5Miua992hGKAJzW9drNqxPfXJ
         JOljET2+mk2U94PVMnCKfFBH9n85M7QU3Jxcm6PQsBPyco8rQJlcs7TPnLeNWz0L1ulv
         TaaVUoWMN71z3U1r2FJHqZvjqXm/b4p8IoBHy1zzqJaR1ESYhOu6brNolBo2xLlZxO4e
         rNYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7LduVD2uZS35fq7b3rWpwMCdk3E6T3OQ5w3znT1sZ0o=;
        b=AMAZUXm4H8BtyoeF/qIc21AazFXcaBqWLUVrF6bzMQvZGnbMq8s2IdGxAwkBt22Z1N
         19p/077heaEOUsXN701CgxmYU3OTgjH/y7ml9Ui5RZuNVmLF59ARaBnC+FxnIPOR/6D9
         +iHcTUU32r3vquK8el+2WfUEx43hJ/5uRRWqy7EBF8Lv23H5LHaNv26Prw+89g/uzJSv
         OkKKR0xVV5z9eiatoFUZHZl5qtkBQcKSJfk7T5bpYEj/7r2EDygSZzpXhqddldbPvjB6
         7YUh1cqWvLZdWNWu0w4WOhvPQE48AvZny0Nj2GmLlaSFNLmKSIoXtaOr0sGu7x7nsS5S
         T4aA==
X-Gm-Message-State: AGi0PuYeQNY5Q3y1L8f8CYemSJ2FKpfKnHJ28BYmSZzWTsdfKc7bKj3z
        8tyxlVcVVZCj2on8NSttcAKf/jBVcac=
X-Google-Smtp-Source: APiQypKCPWSEYnixJRTEMXCdwuSakasGvOelofBOLCza141ICejNMneeXisEP2I4gmISHO2Rr1Zcsw==
X-Received: by 2002:a2e:8e3a:: with SMTP id r26mr534954ljk.171.1586880861230;
        Tue, 14 Apr 2020 09:14:21 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-131.NA.cust.bahnhof.se. [98.128.181.131])
        by smtp.gmail.com with ESMTPSA id a26sm9330669ljn.22.2020.04.14.09.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 09:14:20 -0700 (PDT)
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
Subject: [PATCH 02/19] mmc: atmel-mci: Set the timer per command rather than per request
Date:   Tue, 14 Apr 2020 18:13:56 +0200
Message-Id: <20200414161413.3036-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200414161413.3036-1-ulf.hansson@linaro.org>
References: <20200414161413.3036-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Setting the timer on a per request basis, is rather limiting as the timer
really depends on what commands that is to be sent as part of the request.

Therefore improve the behaviour by programming the timer per command basis
instead.

Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/atmel-mci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 0472df8391b5..7292970065b6 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -169,6 +169,7 @@
 #define	atmci_writel(port, reg, value)			\
 	__raw_writel((value), (port)->regs + reg)
 
+#define ATMCI_CMD_TIMEOUT_MS	2000
 #define AUTOSUSPEND_DELAY	50
 
 #define ATMCI_DATA_ERROR_FLAGS	(ATMCI_DCRCE | ATMCI_DTOE | ATMCI_OVRE | ATMCI_UNRE)
@@ -817,6 +818,9 @@ static void atmci_send_command(struct atmel_mci *host,
 
 	atmci_writel(host, ATMCI_ARGR, cmd->arg);
 	atmci_writel(host, ATMCI_CMDR, cmd_flags);
+
+	mod_timer(&host->timer,
+		  jiffies + msecs_to_jiffies(ATMCI_CMD_TIMEOUT_MS));
 }
 
 static void atmci_send_stop_cmd(struct atmel_mci *host, struct mmc_data *data)
@@ -1314,8 +1318,6 @@ static void atmci_start_request(struct atmel_mci *host,
 	 * prepared yet.)
 	 */
 	atmci_writel(host, ATMCI_IER, iflags);
-
-	mod_timer(&host->timer, jiffies +  msecs_to_jiffies(2000));
 }
 
 static void atmci_queue_request(struct atmel_mci *host,
-- 
2.20.1

