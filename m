Return-Path: <SRS0=djOR=56=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3249C2BA19
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Apr 2020 16:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB1B920678
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Apr 2020 16:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F3rQk/4Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390667AbgDNQPI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 14 Apr 2020 12:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391334AbgDNQOt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Apr 2020 12:14:49 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32CCDC061A0C
        for <linux-mmc@vger.kernel.org>; Tue, 14 Apr 2020 09:14:49 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id h6so233272lfc.0
        for <linux-mmc@vger.kernel.org>; Tue, 14 Apr 2020 09:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fV7yLQCho5m6+2k47darI60VgKdimEIQlNdusOHvHrI=;
        b=F3rQk/4Z//sOg6fzVR2r3vntsIFgxeadDpOTTo0em3oUxUnS2xswqmPCK1NziVLsdm
         g7MbLjEwesW79tQ/fqcyYUi87aZCcSGCNff2Gt9+bh4saviZsOfOARZKLBHkodig+xaf
         amCWUOxEnVwrTX5NxrCVc0xjQZXlENrPinN0kbShXtk83w9yddamVgXUFFK9hPqpVuOC
         Zmy8f3g1owvRV8RQe9DE48mfnTrrmmcz/KzsBgs9xZuqbqCnE9oMOJbalSZ1tVdRtOtn
         jJRidQakHPpD6C5dZrhKY8uQeO0oNeBD4qMXG2kWdvGjTb0J54jcFXjq4BhdCjGFsRYv
         3yMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fV7yLQCho5m6+2k47darI60VgKdimEIQlNdusOHvHrI=;
        b=IMEXzYgRWm4k6hGuPedPqHDJpV03oAkxWOBF3/SNJwI6Xn+Dh8RmjdtvO1My+BevZ0
         0xNOknFzNtvib1D84ngpDdPcJiVcTw+5IUOSw/VW9WlXNAjsFevjHKXV/zmTBVgp4+LK
         +v3uTTSsEwtaUZXHhKD+kNO+Ea9yduW0PAiqgIe4bnYcYXDpztfgKFjACC8Mit1N2sWy
         T4L5OGmGoA4RN4Vdpc7X+GBo20rWSDmbfpUofaI4WRqSVXsVTR0a5xdwM4b5Z624kzSF
         vhiOMeApsiQXbgh3DiDGpWkxI6RqKwVpPbwlycuGe+ROt0SX1Kb/mco0lRKhf4KFwO3v
         9dbA==
X-Gm-Message-State: AGi0Pua/CzujCuy88Usb7+AFSxt2PeD0spU76H86qwXkZkcSKuK3W/2F
        PXtPq3WXSTcxcnzp3tHxnxTWEx+4MDM=
X-Google-Smtp-Source: APiQypIx3GuWzm2apEhzDNWzcBGMOHlPS4R60kqm/Gp8FkwUtC+CSX7LB9PF6MpLnCwT97E6W+xm7w==
X-Received: by 2002:a05:6512:3081:: with SMTP id z1mr359841lfd.102.1586880887299;
        Tue, 14 Apr 2020 09:14:47 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-131.NA.cust.bahnhof.se. [98.128.181.131])
        by smtp.gmail.com with ESMTPSA id a26sm9330669ljn.22.2020.04.14.09.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 09:14:46 -0700 (PDT)
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
Subject: [PATCH 17/19] mmc: mmc_spi: Add/rename defines for timeouts
Date:   Tue, 14 Apr 2020 18:14:11 +0200
Message-Id: <20200414161413.3036-18-ulf.hansson@linaro.org>
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

Clarify the use of r1b_timeout, by renaming it to MMC_SPI_R1B_TIMEOUT_MS
and by dropping the corresponding confusing comment about it.

Additionally, let's also add a new define, MMC_SPI_INIT_TIMEOUT_MS and use
it during the initialization. Even if these two defines are given the same
value, the split makes it easier to understand them.

Cc: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/mmc_spi.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index 951f76dc1ddd..5768fe9f8f6f 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -77,14 +77,8 @@
 
 #define MMC_SPI_BLOCKSIZE	512
 
-
-/* These fixed timeouts come from the latest SD specs, which say to ignore
- * the CSD values.  The R1B value is for card erase (e.g. the "I forgot the
- * card's password" scenario); it's mostly applied to STOP_TRANSMISSION after
- * reads which takes nowhere near that long.  Older cards may be able to use
- * shorter timeouts ... but why bother?
- */
-#define r1b_timeout		(HZ * 3)
+#define MMC_SPI_R1B_TIMEOUT_MS	3000
+#define MMC_SPI_INIT_TIMEOUT_MS	3000
 
 /* One of the critical speed parameters is the amount of data which may
  * be transferred in one command. If this value is too low, the SD card
@@ -347,7 +341,8 @@ static int mmc_spi_response_get(struct mmc_spi_host *host,
 		while (cp < end && *cp == 0)
 			cp++;
 		if (cp == end)
-			mmc_spi_wait_unbusy(host, r1b_timeout);
+			mmc_spi_wait_unbusy(host,
+				msecs_to_jiffies(MMC_SPI_R1B_TIMEOUT_MS));
 		break;
 
 	/* SPI R2 == R1 + second status byte; SEND_STATUS
@@ -1118,7 +1113,7 @@ static void mmc_spi_initsequence(struct mmc_spi_host *host)
 	/* Try to be very sure any previous command has completed;
 	 * wait till not-busy, skip debris from any old commands.
 	 */
-	mmc_spi_wait_unbusy(host, r1b_timeout);
+	mmc_spi_wait_unbusy(host, msecs_to_jiffies(MMC_SPI_INIT_TIMEOUT_MS));
 	mmc_spi_readbytes(host, 10);
 
 	/*
-- 
2.20.1

