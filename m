Return-Path: <SRS0=djOR=56=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA0AC2BA19
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Apr 2020 16:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56DE220678
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Apr 2020 16:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FYSixSDX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390865AbgDNQQS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 14 Apr 2020 12:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389812AbgDNQO0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Apr 2020 12:14:26 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D1DC061A41
        for <linux-mmc@vger.kernel.org>; Tue, 14 Apr 2020 09:14:26 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id h25so369572lja.10
        for <linux-mmc@vger.kernel.org>; Tue, 14 Apr 2020 09:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AYdnh8axE7O5nxAM7j16STUfeW8l+S8DGrk3gV3Ki2w=;
        b=FYSixSDXj+uVpRBQsmoBKTzaDrieN3wjrMbhC5q+4fYMmL0/CTBKEqebCgrrDsU3OU
         zPl2xwzZRdr1opCFuBqL1MOVlL7r6jndWmP4bsQNDAGy/fk3hiry8bXZgwoSp+IITSMv
         HrzYz57d4D+qfvswMF5sA8ZyFDwUAHUJr74vY03RvVP7h/BQ71dIZcauFmMSnmXUrbCz
         Fxs36SiY3EZO+qP6sAM8I6TPdZDYXk1/AM7DIhDRJwrwJuobTNOnKS+qN9LPsfrQGwUw
         iGqIKy7zqrtF1U13H/iS9Mi/nAfzrpcKbCSWyqrdKdgnTWpg75F6OxyzPpOoiQy9qNYl
         q7SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AYdnh8axE7O5nxAM7j16STUfeW8l+S8DGrk3gV3Ki2w=;
        b=n1wZ9h6J2MC0dK8GxqdHsK8tRxReLNUD4ue3RevAfoYHhyjBiQMhAuZiMvqXZoZiSN
         7LyPK9scqVIITBu9EahPBauJpd2bXNPp7ywMbPt8eS4kpoo0BCXRj2V0fUUfru58izoT
         hwOVrjC0iNh7AyyrYSfdIouQ88rqN/RT9XTXvI5+N5OngDt8QJpj64C0tsfCzm8y/Eq5
         jHZLbYN+lZcY8egi5Nhc5HSEe24txD7yt90FCYP6ujZbiz6hnN5yo0BsW+X4xuVsLba8
         ZaOzMNL+U1MT9VLUMTKS00nZ2i69vtarQ7wR0jlDJXToc4fkzXaRei4M6GtnICjc83B/
         mofw==
X-Gm-Message-State: AGi0PubpdJUxq8pJMdKUuHOdwDchXzCvMxWNLS8ndPJ7dx+7pMaQZ6B6
        KG/XSvBEdjmu4REu/uWELozqRxdvd6c=
X-Google-Smtp-Source: APiQypL8YkNs8e6IfWiesvrfd+ebEKIwH++gg0sGm7nmkBjls88mayVolw3CRNdAwNLZSh7TJrLLoA==
X-Received: by 2002:a2e:a303:: with SMTP id l3mr569214lje.166.1586880864266;
        Tue, 14 Apr 2020 09:14:24 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-131.NA.cust.bahnhof.se. [98.128.181.131])
        by smtp.gmail.com with ESMTPSA id a26sm9330669ljn.22.2020.04.14.09.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 09:14:23 -0700 (PDT)
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
Subject: [PATCH 04/19] mmc: jz4740: Inform the mmc core about the maximum busy timeout
Date:   Tue, 14 Apr 2020 18:13:58 +0200
Message-Id: <20200414161413.3036-5-ulf.hansson@linaro.org>
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
5s timeout used by jz4740. In this way, we let the mmc core validate the
needed timeout, which may lead to that it converts from a R1B into a R1
response and then use CMD13 to poll for busy completion.

In other words, this change enables support for commands with longer busy
periods than 5s, like erase (CMD38) for example.

Cc: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/jz4740_mmc.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index fbae87d1f017..cba7a6fcd178 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -108,6 +108,7 @@
 #define	JZ_MMC_LPM_LOW_POWER_MODE_EN BIT(0)
 
 #define JZ_MMC_CLK_RATE 24000000
+#define JZ_MMC_REQ_TIMEOUT_MS 5000
 
 enum jz4740_mmc_version {
 	JZ_MMC_JZ4740,
@@ -440,7 +441,8 @@ static unsigned int jz4740_mmc_poll_irq(struct jz4740_mmc_host *host,
 
 	if (timeout == 0) {
 		set_bit(0, &host->waiting);
-		mod_timer(&host->timeout_timer, jiffies + 5*HZ);
+		mod_timer(&host->timeout_timer,
+			  jiffies + msecs_to_jiffies(JZ_MMC_REQ_TIMEOUT_MS));
 		jz4740_mmc_set_irq_enabled(host, irq, true);
 		return true;
 	}
@@ -893,7 +895,8 @@ static void jz4740_mmc_request(struct mmc_host *mmc, struct mmc_request *req)
 
 	host->state = JZ4740_MMC_STATE_READ_RESPONSE;
 	set_bit(0, &host->waiting);
-	mod_timer(&host->timeout_timer, jiffies + 5*HZ);
+	mod_timer(&host->timeout_timer,
+		  jiffies + msecs_to_jiffies(JZ_MMC_REQ_TIMEOUT_MS));
 	jz4740_mmc_send_command(host, req->cmd);
 }
 
@@ -1023,6 +1026,12 @@ static int jz4740_mmc_probe(struct platform_device* pdev)
 	mmc->f_min = mmc->f_max / 128;
 	mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
 
+	/*
+	 * We use a fixed timeout of 5s, hence inform the core about it. A
+	 * future improvement should instead respect the cmd->busy_timeout.
+	 */
+	mmc->max_busy_timeout = JZ_MMC_REQ_TIMEOUT_MS;
+
 	mmc->max_blk_size = (1 << 10) - 1;
 	mmc->max_blk_count = (1 << 15) - 1;
 	mmc->max_req_size = mmc->max_blk_size * mmc->max_blk_count;
-- 
2.20.1

