Return-Path: <SRS0=djOR=56=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD25C2BA19
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Apr 2020 16:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C85BE20732
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Apr 2020 16:14:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZEexuQi/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389811AbgDNQOk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 14 Apr 2020 12:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390413AbgDNQOb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Apr 2020 12:14:31 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA443C0610D5
        for <linux-mmc@vger.kernel.org>; Tue, 14 Apr 2020 09:14:28 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id j14so180593lfg.9
        for <linux-mmc@vger.kernel.org>; Tue, 14 Apr 2020 09:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MbZ0bEn9Rkc/WddH3A2e/7d/+RZVhN7mNCvo/MSHe3k=;
        b=ZEexuQi/A2O3CvayF+xs3mZjQ7ctNr77NL88nKPyhYIfba/s1GZuKnyt7YOYQLlhvF
         14o/+QF0aB52arqna+S6vf5YYH2caKXTWSCH0jihMDUwbyl/01ttUld4onk1crr1CGgs
         yh2h6J9e8EU/xa+iHKQmOpeiUC1DYFvGQ1kJaw8XyxEuVDxqTyh7CIoZ7zpRbT4GAyPw
         IgmlxC1TiP/19sq1GYu+bsaV9/RKs2bmnh2IVLuOg/3ZwhUY7f9kmclduJOK46v6vMNS
         IGQcb2+kTu+mNHDWUsnsYm4ARypBCDB2n2cY03HJ72hq9nS8YkHHp7A7L/TCiwBIX5xL
         oHuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MbZ0bEn9Rkc/WddH3A2e/7d/+RZVhN7mNCvo/MSHe3k=;
        b=crOR78YI8rTYmbq6K+mUR8MEYc7Y5WD5ciSMVjRQ3bGbT4mTtvYfgPlbd/YYZACl+a
         7lsk15jD4kloG0editpxaw+6X5H4APuZfZH7U7PulZhsESsbMyu7IV+fV8VT0n2ohzIS
         mkeiACxSArIMucYHWAv0DxnCkhc/p+1P5CPrwY8sY2uHhl1b8GXE1T4xy6nzukxlVP43
         HfulRFQHfm2pjnYQ4SmVPK1idhRY9BLkvHwbElZk81gzBOsRm3K2avbIsCHtLJLJezVV
         gZBX/foRGrUYxFM3BelL6zKgI30kLhjHHI+DZUiS5Geg1Hym6LilgxmJZ/C5kuesdjDp
         oECA==
X-Gm-Message-State: AGi0PuZw29b5zC4+YrEyFbpTBrbhBUU1Qctvym9yunvGF1cFz5fbLvI8
        m4aB03xkftS/jB7MSkEMX5ARjnQNfT0=
X-Google-Smtp-Source: APiQypIxTTwRXx9V/9uIe1PK0wt899qbViA+d4WR7UWfvLYqgI6bQ3LbehyqfhP0/7toD588uaw9CA==
X-Received: by 2002:a05:6512:3e2:: with SMTP id n2mr340858lfq.129.1586880865981;
        Tue, 14 Apr 2020 09:14:25 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-131.NA.cust.bahnhof.se. [98.128.181.131])
        by smtp.gmail.com with ESMTPSA id a26sm9330669ljn.22.2020.04.14.09.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 09:14:25 -0700 (PDT)
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
Subject: [PATCH 05/19] mmc: usdhi6rol0: Inform the mmc core about the maximum busy timeout
Date:   Tue, 14 Apr 2020 18:13:59 +0200
Message-Id: <20200414161413.3036-6-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200414161413.3036-1-ulf.hansson@linaro.org>
References: <20200414161413.3036-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
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
4s timeout used by usdhi6rol0. In this way, we let the mmc core validate
the needed timeout, which may lead to that it converts from a R1B into a R1
response and then use CMD13 to poll for busy completion.

In other words, this change enables support for commands with longer busy
periods than 4s, like erase (CMD38) for example.

Cc: Jesper Nilsson <jesper.nilsson@axis.com>
Cc: Lars Persson <lars.persson@axis.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/usdhi6rol0.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/usdhi6rol0.c b/drivers/mmc/host/usdhi6rol0.c
index 9a0b1e4e405d..369b8dee2e3d 100644
--- a/drivers/mmc/host/usdhi6rol0.c
+++ b/drivers/mmc/host/usdhi6rol0.c
@@ -136,6 +136,8 @@
 
 #define USDHI6_MIN_DMA 64
 
+#define USDHI6_REQ_TIMEOUT_MS 4000
+
 enum usdhi6_wait_for {
 	USDHI6_WAIT_FOR_REQUEST,
 	USDHI6_WAIT_FOR_CMD,
@@ -1763,7 +1765,12 @@ static int usdhi6_probe(struct platform_device *pdev)
 	host		= mmc_priv(mmc);
 	host->mmc	= mmc;
 	host->wait	= USDHI6_WAIT_FOR_REQUEST;
-	host->timeout	= msecs_to_jiffies(4000);
+	host->timeout	= msecs_to_jiffies(USDHI6_REQ_TIMEOUT_MS);
+	/*
+	 * We use a fixed timeout of 4s, hence inform the core about it. A
+	 * future improvement should instead respect the cmd->busy_timeout.
+	 */
+	mmc->max_busy_timeout = USDHI6_REQ_TIMEOUT_MS;
 
 	host->pinctrl = devm_pinctrl_get(&pdev->dev);
 	if (IS_ERR(host->pinctrl)) {
-- 
2.20.1

