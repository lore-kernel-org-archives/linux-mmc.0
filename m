Return-Path: <SRS0=92ZL=3Y=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59CE7C3F68F
	for <linux-mmc@archiver.kernel.org>; Tue,  4 Feb 2020 08:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A42021744
	for <linux-mmc@archiver.kernel.org>; Tue,  4 Feb 2020 08:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vDKmHIT5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgBDIzQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 4 Feb 2020 03:55:16 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34137 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgBDIzQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Feb 2020 03:55:16 -0500
Received: by mail-lf1-f66.google.com with SMTP id l18so11666593lfc.1
        for <linux-mmc@vger.kernel.org>; Tue, 04 Feb 2020 00:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2girTLUrGbScTtnIlZ6XuD1dV3M/k01nSyAhQZV11Z4=;
        b=vDKmHIT5SDHsU9AK2bliTZLOcwGrBErh4K4eL0mY7bbEi0vVlSIXMd85Kh8qHNxpan
         2RA/AFaZDs26iPqQBKFN09w4b53IsxcInpI0DEqU/pC0c00qPcwlqZZ45L73qnICUFTP
         uBeahzGzY1XOdmPcO4SS6kOFPA3XScC4JRKhPY0LV0VrTB7xvKWaW9fmAvnTZOQcM04U
         8ZAD7GUDMwXLIQYWfhHikG+YOnwUlztoPMlVK2eB/6bwq5+rr7GS2vzDfWSwQx5wehd0
         rajVNGMphU0qdpGKOCR7kZOkjDxHT387OyzmgiipcbpKJ0pTMa47ScXGnUXgq+3wMcBX
         AwSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2girTLUrGbScTtnIlZ6XuD1dV3M/k01nSyAhQZV11Z4=;
        b=XvIA8YjVpmYgaLZKJWVblA/PdU965B2x76lYuDN10bt904AsU1sf0H89N3pqXYTXKO
         wzPOAFRPTJ0xivbierjGDQl5CB6qWkiQWwss+lPkkyErC2WDTBVzL4IvyErKdd0s/wFs
         EC9t3t4slTDkq/m1zDLrdNhS+xQi3aV8aaUBkaSPnkoTcvHnPPgyHSFLP6YS57vBOTei
         jnlekfOKqe6au5DiUkT+I5Zq8CTjKrCv6wo5+rPOXswkCNDzrCi80oWFtn5BzzOrZ92i
         CyF+H+FDmOOKjcR2+yTovD3cIkIfsDUqccjGI1r0Kd+7pDMUa2hka1832SsVDy9FTaUc
         hP9Q==
X-Gm-Message-State: APjAAAUnAOWwICjnU8gFNSLA84WaHFtrirkUagb2KkDMIb4VWs3O/Ts7
        UNr5ZD1RQK8kC8RIuHN98jWdYjdqVB0=
X-Google-Smtp-Source: APXvYqwItyiLwKsf8ISebzKyLOSOTh9kkAWc+OYwODu5zqEDn0xrZfc6wmeVnXoaphVk6c0c4RoJng==
X-Received: by 2002:a19:c014:: with SMTP id q20mr14543505lff.208.1580806514216;
        Tue, 04 Feb 2020 00:55:14 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id n2sm11156283ljj.1.2020.02.04.00.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 00:55:13 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Shawn Lin <shawn.lin@rock-chips.com>, mirq-linux@rere.qmqm.pl
Subject: [PATCH 05/12] mmc: core: Split up mmc_poll_for_busy()
Date:   Tue,  4 Feb 2020 09:54:42 +0100
Message-Id: <20200204085449.32585-6-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200204085449.32585-1-ulf.hansson@linaro.org>
References: <20200204085449.32585-1-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

To make the code more readable, move the part that gets the busy status of
the card out into a separate function, mmc_busy_status(). Then call it from
mmc_poll_for_busy().

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/mmc_ops.c | 47 +++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 1c5b23d99b77..c17b13aacc6e 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -444,6 +444,34 @@ int mmc_switch_status(struct mmc_card *card, bool crc_err_fatal)
 	return mmc_switch_status_error(card->host, status);
 }
 
+static int mmc_busy_status(struct mmc_card *card, bool retry_crc_err,
+			   bool *busy)
+{
+	struct mmc_host *host = card->host;
+	u32 status = 0;
+	int err;
+
+	if (host->ops->card_busy) {
+		*busy = host->ops->card_busy(host);
+		return 0;
+	}
+
+	err = mmc_send_status(card, &status);
+	if (retry_crc_err && err == -EILSEQ) {
+		*busy = true;
+		return 0;
+	}
+	if (err)
+		return err;
+
+	err = mmc_switch_status_error(card->host, status);
+	if (err)
+		return err;
+
+	*busy = R1_CURRENT_STATE(status) == R1_STATE_PRG;
+	return 0;
+}
+
 static int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
 			bool send_status, bool retry_crc_err)
 {
@@ -451,7 +479,6 @@ static int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
 	int err;
 	unsigned long timeout;
 	unsigned int udelay = 32, udelay_max = 32768;
-	u32 status = 0;
 	bool expired = false;
 	bool busy = false;
 
@@ -473,21 +500,9 @@ static int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
 		 */
 		expired = time_after(jiffies, timeout);
 
-		if (host->ops->card_busy) {
-			busy = host->ops->card_busy(host);
-		} else {
-			err = mmc_send_status(card, &status);
-			if (retry_crc_err && err == -EILSEQ) {
-				busy = true;
-			} else if (err) {
-				return err;
-			} else {
-				err = mmc_switch_status_error(host, status);
-				if (err)
-					return err;
-				busy = R1_CURRENT_STATE(status) == R1_STATE_PRG;
-			}
-		}
+		err = mmc_busy_status(card, retry_crc_err, &busy);
+		if (err)
+			return err;
 
 		/* Timeout if the device still remains busy. */
 		if (expired && busy) {
-- 
2.17.1

