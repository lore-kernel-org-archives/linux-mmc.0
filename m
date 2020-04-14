Return-Path: <SRS0=djOR=56=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6025C2BA19
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Apr 2020 16:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2EC920678
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Apr 2020 16:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ewtb/Sjv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbgDNQPK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 14 Apr 2020 12:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391331AbgDNQOq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Apr 2020 12:14:46 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D4AC061A0E
        for <linux-mmc@vger.kernel.org>; Tue, 14 Apr 2020 09:14:46 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id l14so404924ljj.5
        for <linux-mmc@vger.kernel.org>; Tue, 14 Apr 2020 09:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/312L/upfEChd0s382iQNZQsylwgFpiUnUGKm/8Pqvw=;
        b=ewtb/Sjv8qGxJkOLX8vFzllchdK+d63Agydpogc3xu9EWnW7sINf01LNLZr5F8lZ7m
         VKx/mY1H0STlDsoXdidmIqKXssqv59IO3BKPS7vPf8WeK/2LEoT/REqBM5zoPOK8KSx4
         hKzh3bTWZ7G9jFv33mXoUF9O8eFD2SpEjbItujfK2lcvzT8XdjC3Zp+oC/owtYVLIhkd
         8wSbxrI0cSuqD/hqScIH0hts1KqMvhcUSau+VTEZFQPZxTBGB1Trbce0a85Ghy4MNHgN
         poMPTZnQ/juiYaOjvLAKVzP1bn0QnZOUErsCG9jXqoHPzSsBeSa82hRjyem2wyIaptSS
         SafA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/312L/upfEChd0s382iQNZQsylwgFpiUnUGKm/8Pqvw=;
        b=IELHO1qAWKPP5DC+pstroNeC6K0PKgk7IOzYAZ8xskjox/vOQphBmGdj2As+rm+CVQ
         dyIfkMQo0xcWVoVZU84dhnga5RdXYKB2Lneaho+ilsA+X8DgZBs6Q+yQtwLZ5PVam0Jh
         Jgp4hpf2y4moR0lr1IRyOak5rQVItIcL+OIllqSj4ixSsUDHTfvumdh718yzfT+C1epx
         E0u6latxWEBq17KvCoqLfQSNjDIM9ausdUvK0mvTZtecwfAY9pZBjIH0maz5xd4HCLgv
         RHpX1mNER/Ya1wwVUMeps4v/SPomVxVtBrT+LAemzMGF51AOPcwDOgcjcu3/6yS7svrJ
         GQxw==
X-Gm-Message-State: AGi0PuaEHMkw3yCtHYoqZ+DT2d1CXiV9zuM0FA3ACHFvXwmqPeK7XFUe
        Zo8N270Rm3sAx8b9XQTok2ceNQVTeoQ=
X-Google-Smtp-Source: APiQypK+AncAZzjPieY0AwSjLMdIGFpdociGqq4Q/Jmw54Oy3dhS1HYlzAy2E9ByK9t60IfuE7yAKQ==
X-Received: by 2002:a05:651c:48a:: with SMTP id s10mr537009ljc.226.1586880883857;
        Tue, 14 Apr 2020 09:14:43 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-131.NA.cust.bahnhof.se. [98.128.181.131])
        by smtp.gmail.com with ESMTPSA id a26sm9330669ljn.22.2020.04.14.09.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 09:14:42 -0700 (PDT)
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
Subject: [PATCH 15/19] mmc: tifm_sd: Inform the mmc core about the maximum busy timeout
Date:   Tue, 14 Apr 2020 18:14:09 +0200
Message-Id: <20200414161413.3036-16-ulf.hansson@linaro.org>
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
1s timeout used by tifm_sd. In this way, we let the mmc core validate the
needed timeout, which may lead to that it converts from a R1B into a R1
response and then use CMD13 to poll for busy completion.

In other words, this change enables support for commands with longer busy
periods than 1s, like erase (CMD38) for example.

Cc: Alex Dubov <oakad@yahoo.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/tifm_sd.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/tifm_sd.c b/drivers/mmc/host/tifm_sd.c
index 54271b92ee59..5987656e0474 100644
--- a/drivers/mmc/host/tifm_sd.c
+++ b/drivers/mmc/host/tifm_sd.c
@@ -73,6 +73,8 @@ module_param(fixed_timeout, bool, 0644);
 
 #define TIFM_MMCSD_MAX_BLOCK_SIZE  0x0800UL
 
+#define TIFM_MMCSD_REQ_TIMEOUT_MS  1000
+
 enum {
 	CMD_READY    = 0x0001,
 	FIFO_READY   = 0x0002,
@@ -959,7 +961,12 @@ static int tifm_sd_probe(struct tifm_dev *sock)
 	host = mmc_priv(mmc);
 	tifm_set_drvdata(sock, mmc);
 	host->dev = sock;
-	host->timeout_jiffies = msecs_to_jiffies(1000);
+	host->timeout_jiffies = msecs_to_jiffies(TIFM_MMCSD_REQ_TIMEOUT_MS);
+	/*
+	 * We use a fixed request timeout of 1s, hence inform the core about it.
+	 * A future improvement should instead respect the cmd->busy_timeout.
+	 */
+	mmc->max_busy_timeout = TIFM_MMCSD_REQ_TIMEOUT_MS;
 
 	tasklet_init(&host->finish_tasklet, tifm_sd_end_cmd,
 		     (unsigned long)host);
-- 
2.20.1

