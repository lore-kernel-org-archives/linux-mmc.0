Return-Path: <SRS0=djOR=56=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB6FC2BB85
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Apr 2020 16:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA3C720732
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Apr 2020 16:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="buxlIUSI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390521AbgDNQOp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 14 Apr 2020 12:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391331AbgDNQOj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Apr 2020 12:14:39 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8420C061A41
        for <linux-mmc@vger.kernel.org>; Tue, 14 Apr 2020 09:14:38 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id x23so226942lfq.1
        for <linux-mmc@vger.kernel.org>; Tue, 14 Apr 2020 09:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dn6VxHUGEp0h+lDNMYkyjs+eaTbjGnRrBr6whuUgNLQ=;
        b=buxlIUSIrT5D15k/542DUXpz3fkzEN7p3nMlmm4+M9/tfJXHRqSt4i808UTYsF4ecC
         b1iA3PBYRCEHvf8U9R5IJeFK+t77fe1e2XXP9XHyi41wic7CobmwoG2BKB2lCjL1eQmF
         x4dhYhNI7Xg4mouw8mLpSdPYMz5nEAsWQfH3zTU6rsufrLnAQzey4+Lc92abqlBFlaoL
         jDuNvlwK2tP9ecPGtAZBgzsL6dmm+/v59kxJw2+/I+USS4Kg/gg1kF7pe50/w3hTfeug
         qF91C+pBuw1yRFAcOBrVctk22aqzDLKH8i/BP0476eHlxNmqMUDn9yLQQIsGNnVGIVRW
         jIBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dn6VxHUGEp0h+lDNMYkyjs+eaTbjGnRrBr6whuUgNLQ=;
        b=VEGOIZCunXf1D+XET0icJsBtI8POGn1/nb3krs2bOHUh18CIh1iUhhjvhWtDadlnz/
         46nN/BXmytsA0tDbp+QQOVgKqSTKcCVoXN3FYaEZpxrgtdEytfgMkuKC0N1ywYZ6bFKD
         zghh75I7wR2SolxjcMdYGeNvyDzqV2dfMBXB2du6u4EjBFsMD4UiegvGtmtcvJ41n7m1
         osySGLwzeflf1R6KZj7T8BwZ/AU08/kXusgFroYA22nK6IZUTiLUnr8RQIMp9mg13x5W
         /VnTj8LP4ZJLfNlio2Jj38LH3LYNKPUx77iz7dQONbQop+dyFEWRoEyLFu/vSkrov6UV
         pjxw==
X-Gm-Message-State: AGi0PuZiWC6LZuAGg4X7FZQWkHE52WeBT63X1DBf731obQC7FIcPY2D0
        7kEC2oUyvzRc5L/jEapk6OgQRtPeIyc=
X-Google-Smtp-Source: APiQypKJTgim6xv0zsXWcwFDb65pajvh4mKxX6sFBD2V6xhmJiRhFw0cmT67s7GB4L7mKrTfgH0m5w==
X-Received: by 2002:a19:dcc:: with SMTP id 195mr325522lfn.193.1586880876481;
        Tue, 14 Apr 2020 09:14:36 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-131.NA.cust.bahnhof.se. [98.128.181.131])
        by smtp.gmail.com with ESMTPSA id a26sm9330669ljn.22.2020.04.14.09.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 09:14:35 -0700 (PDT)
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
Subject: [PATCH 11/19] mmc: sdricoh_cs: Drop redundant in-parameter to sdricoh_query_status()
Date:   Tue, 14 Apr 2020 18:14:05 +0200
Message-Id: <20200414161413.3036-12-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200414161413.3036-1-ulf.hansson@linaro.org>
References: <20200414161413.3036-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The in-parameter timeout is always set to TRANSFER_TIMEOUT by the callers
of sdricoh_query_status(), hence let's drop it.

Cc: Sascha Sommer <saschasommer@freenet.de>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sdricoh_cs.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdricoh_cs.c b/drivers/mmc/host/sdricoh_cs.c
index e7d74db95b57..97ef7d71375a 100644
--- a/drivers/mmc/host/sdricoh_cs.c
+++ b/drivers/mmc/host/sdricoh_cs.c
@@ -123,11 +123,13 @@ static inline unsigned int sdricoh_readb(struct sdricoh_host *host,
 	return value;
 }
 
-static int sdricoh_query_status(struct sdricoh_host *host, unsigned int wanted,
-				unsigned int timeout){
+static int sdricoh_query_status(struct sdricoh_host *host, unsigned int wanted)
+{
 	unsigned int loop;
 	unsigned int status = 0;
+	unsigned int timeout = TRANSFER_TIMEOUT;
 	struct device *dev = host->dev;
+
 	for (loop = 0; loop < timeout; loop++) {
 		status = sdricoh_readl(host, R21C_STATUS);
 		sdricoh_writel(host, R2E4_STATUS_RESP, status);
@@ -215,8 +217,7 @@ static int sdricoh_blockio(struct sdricoh_host *host, int read,
 	u32 data = 0;
 	/* wait until the data is available */
 	if (read) {
-		if (sdricoh_query_status(host, STATUS_READY_TO_READ,
-						TRANSFER_TIMEOUT))
+		if (sdricoh_query_status(host, STATUS_READY_TO_READ))
 			return -ETIMEDOUT;
 		sdricoh_writel(host, R21C_STATUS, 0x18);
 		/* read data */
@@ -232,8 +233,7 @@ static int sdricoh_blockio(struct sdricoh_host *host, int read,
 			}
 		}
 	} else {
-		if (sdricoh_query_status(host, STATUS_READY_TO_WRITE,
-						TRANSFER_TIMEOUT))
+		if (sdricoh_query_status(host, STATUS_READY_TO_WRITE))
 			return -ETIMEDOUT;
 		sdricoh_writel(host, R21C_STATUS, 0x18);
 		/* write data */
@@ -323,8 +323,7 @@ static void sdricoh_request(struct mmc_host *mmc, struct mmc_request *mrq)
 
 		sdricoh_writel(host, R208_DATAIO, 1);
 
-		if (sdricoh_query_status(host, STATUS_TRANSFER_FINISHED,
-					TRANSFER_TIMEOUT)) {
+		if (sdricoh_query_status(host, STATUS_TRANSFER_FINISHED)) {
 			dev_err(dev, "sdricoh_request: transfer end error\n");
 			cmd->error = -EINVAL;
 		}
-- 
2.20.1

