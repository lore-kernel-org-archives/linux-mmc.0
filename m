Return-Path: <SRS0=djOR=56=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59FD7C352BE
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Apr 2020 16:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3842620732
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Apr 2020 16:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m7tzsSdo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391335AbgDNQPB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 14 Apr 2020 12:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390667AbgDNQOx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Apr 2020 12:14:53 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBEACC061A0F
        for <linux-mmc@vger.kernel.org>; Tue, 14 Apr 2020 09:14:52 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id l11so204839lfc.5
        for <linux-mmc@vger.kernel.org>; Tue, 14 Apr 2020 09:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bpyge4k8Iz/MW6vpPqOyXsMz3UoNxf4ygGN/PrDN23s=;
        b=m7tzsSdoqidUMOYYffWIVvNzzOkmdfg+BlltbgNDyDHYItaxuxu7vlYresXdqk6vQv
         D1vtkIKdiPxe0VmBocbrJb8+RR2jsB5/PR4o9cSrD0CBQ+Deo18au7HngD4aapz8uN5s
         wNrIqMOeMKLHkGPs6aTOR9HucmlEVNvLYIYwIWk+dcPCMXefe5E35RhttGIciUVbUY7R
         w0mJd6ufoGcywW0DjWwpcn1mICnTQ7g9bhZpqe8Uw6i+m7KAsSDOvfNer0KNkWMFmjxy
         Tz9cgFFhelwwDFL8Banrz9p9aK/Z7NLsgIRfpHDyQRvGg/VJqaFDWl9jXElVKKXXe6e4
         36kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bpyge4k8Iz/MW6vpPqOyXsMz3UoNxf4ygGN/PrDN23s=;
        b=JTzbPbQAaipu96ts641SmoXOLcDUMZHetfomuqP5S6cqYQuiwRjsb9bxxWurW2fTN4
         EfNoyw3wSn71dcPzk8G1PnEqDVz/L+0+q4qxzrx8yRhdKb5QBSbNtnGYeJoZgcCK83W/
         2CbxLnN8si/vUDQW98BJsoAXyVOIYaTPjlxBVaL3xvGqE+QB+1DjNSxC3dzLtIrHihPV
         +D1pUy99bD9gSx6oVwDMDc0GnGHmEnvW9TcwlHtdsuCW/7aSHvpwCSVYj1vpJKXqgkuL
         SY/5DKlrbJGi5TYHnR2BTruHtwqM1PSkupEmNfMHLh2KYk/NAvMXnpNRA60sTX7kPtAL
         G9QA==
X-Gm-Message-State: AGi0PualjVE4AJUfGQHv8aA2/B5A40RaEymzO4KXfv708FXLGJiBp9v0
        PW5ffw8qIfbODMdSbPKUUNDO5SKNhlw=
X-Google-Smtp-Source: APiQypKs1XralZ2xpuJEJsfyXQSt7ex/4mhrOaimKzrhLIPk2A27zZq8+qJo3Rovpcol1PZ3P4LfzQ==
X-Received: by 2002:ac2:550e:: with SMTP id j14mr349553lfk.188.1586880890888;
        Tue, 14 Apr 2020 09:14:50 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-131.NA.cust.bahnhof.se. [98.128.181.131])
        by smtp.gmail.com with ESMTPSA id a26sm9330669ljn.22.2020.04.14.09.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 09:14:50 -0700 (PDT)
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
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        greybus-dev@lists.linaro.org
Subject: [PATCH 19/19] staging: greybus: sdio: Respect the cmd->busy_timeout from the mmc core
Date:   Tue, 14 Apr 2020 18:14:13 +0200
Message-Id: <20200414161413.3036-20-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200414161413.3036-1-ulf.hansson@linaro.org>
References: <20200414161413.3036-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Using a fixed 1s timeout for all commands is a bit problematic.

For some commands it means waiting longer than needed for the timeout to
expire, which may not a big issue, but still. For other commands, like for
an erase (CMD38) that uses a R1B response, may require longer timeouts than
1s. In these cases, we may end up treating the command as it failed, while
it just needed some more time to complete successfully.

Fix the problem by respecting the cmd->busy_timeout, which is provided by
the mmc core.

Cc: Rui Miguel Silva <rmfrfs@gmail.com>
Cc: Johan Hovold <johan@kernel.org>
Cc: Alex Elder <elder@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: greybus-dev@lists.linaro.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/staging/greybus/sdio.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/greybus/sdio.c b/drivers/staging/greybus/sdio.c
index 68c5718be827..c4b16bb5c1a4 100644
--- a/drivers/staging/greybus/sdio.c
+++ b/drivers/staging/greybus/sdio.c
@@ -411,6 +411,7 @@ static int gb_sdio_command(struct gb_sdio_host *host, struct mmc_command *cmd)
 	struct gb_sdio_command_request request = {0};
 	struct gb_sdio_command_response response;
 	struct mmc_data *data = host->mrq->data;
+	unsigned int timeout_ms;
 	u8 cmd_flags;
 	u8 cmd_type;
 	int i;
@@ -469,9 +470,12 @@ static int gb_sdio_command(struct gb_sdio_host *host, struct mmc_command *cmd)
 		request.data_blksz = cpu_to_le16(data->blksz);
 	}
 
-	ret = gb_operation_sync(host->connection, GB_SDIO_TYPE_COMMAND,
-				&request, sizeof(request), &response,
-				sizeof(response));
+	timeout_ms = cmd->busy_timeout ? cmd->busy_timeout :
+		GB_OPERATION_TIMEOUT_DEFAULT;
+
+	ret = gb_operation_sync_timeout(host->connection, GB_SDIO_TYPE_COMMAND,
+					&request, sizeof(request), &response,
+					sizeof(response), timeout_ms);
 	if (ret < 0)
 		goto out;
 
-- 
2.20.1

