Return-Path: <SRS0=Q3VJ=3W=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD1EC35249
	for <linux-mmc@archiver.kernel.org>; Sun,  2 Feb 2020 15:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 693082067C
	for <linux-mmc@archiver.kernel.org>; Sun,  2 Feb 2020 15:01:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=orbital-systems-com.20150623.gappssmtp.com header.i=@orbital-systems-com.20150623.gappssmtp.com header.b="P0NfYSym"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgBBPBG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 2 Feb 2020 10:01:06 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39548 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbgBBPBG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 2 Feb 2020 10:01:06 -0500
Received: by mail-wr1-f65.google.com with SMTP id y11so14686934wrt.6
        for <linux-mmc@vger.kernel.org>; Sun, 02 Feb 2020 07:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=orbital-systems-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QfE+mOgK8l29lZ6DrOiVFpgy+skIY9cxGqE2U9hsz78=;
        b=P0NfYSymu45Inr6BtWaAq/CTZ6or9og2T7siDhDweDSfkPc1BbSFkfFpH1XFQHrUJE
         HixIuBSKkH7q0re+MskXTiXKrfVf1KSCZ/D9fRAQDJ5xw6W3kcREdlDj7f7viWeufn39
         LUZp4Lm90yWaN4g93PHOTDzEaZ9/CGs7UafV8g5Uzr/lyeEGRdvdbR6HLRHG1yOOLg5E
         +bHftwy3nQsUSUyxnhRiOENNnnfnnUgL9ZiZqEh5Gb9aoWiyg8zdRd1iN1pWCe+Xvqgg
         LqJnX7t26Jd87caa6kDbWf2eK5Z5kzIGt8XTY9Lqd0fXFPOKLWjmaNCWiaA6+BCJINr1
         YF9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QfE+mOgK8l29lZ6DrOiVFpgy+skIY9cxGqE2U9hsz78=;
        b=LTRNqUltWnz9CS1rgC+wwiLH0g9MbFlKmOYnrxqFm/ggixHPmPeQxFnU0djCsqQjtg
         29hbV4lH79SvrzgoP9qEwmlLSxV9cIh9mmAOKCVnOuPt5BUzCqUh+qjjWccblX+nzaiG
         ghutRwxpLpQq5RwRznQrkzBhUrr8NBConrmgFQUZE9WDT7xpJvP05kfsSnQMkLBOhkQG
         6E88K5oUbBidtpczvB4seupHWWtisn2cBkAyWC7+EZoaYnmuat58R8UMk/UU3Dmz08za
         1QtLQaEpqJiv1o6SaxYHe6KuIjf1OvMlk1UoeKvtNZzj5FoW8yJyV/SsA8/UfOcrdJG+
         W7BA==
X-Gm-Message-State: APjAAAXKTvJq8p6gSjEO4/6rlaLs/6wbUpVNTVMc9wXsAzh9QKrHdTAZ
        FR9GiGiqrRnNb6wPA8N++7AQPruGOsMFaPcG
X-Google-Smtp-Source: APXvYqx6DyD8OGJbnEG4v7JpmN2z0xz05XouNBn4VaiOAKskFEOKyq6Pfhei3++cQ9zF/t1bbF+pOA==
X-Received: by 2002:a5d:62d1:: with SMTP id o17mr10829255wrv.9.1580655664350;
        Sun, 02 Feb 2020 07:01:04 -0800 (PST)
Received: from localhost.net ([2001:67c:1810:f051:2345:9ab3:d50f:7149])
        by smtp.gmail.com with ESMTPSA id g25sm24995904wmh.3.2020.02.02.07.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 07:01:03 -0800 (PST)
From:   Jonas Danielsson <jonas@orbital-systems.com>
X-Google-Original-From: Jonas Danielsson <jonas@threetimestwo.org>
To:     linux-mmc@vger.kernel.org
Cc:     jonas@orbital-systems.com,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: atmel-mci: Add error injection via debugfs
Date:   Sun,  2 Feb 2020 16:00:48 +0100
Message-Id: <20200202150049.677553-1-jonas@threetimestwo.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Jonas Danielsson <jonas@orbital-systems.com>

This functionality was useful for us while debugging issues with
a vendor wifi-driver that misbehaved on the SDIO bus.

This will allow you to check how SDIO clients handle mmc
command and data errors.

Signed-off-by: Jonas Danielsson <jonas@orbital-systems.com>
---
 drivers/mmc/host/atmel-mci.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index a9dad641c..11289c8e5 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -328,6 +328,8 @@ struct atmel_mci {
 	u32			data_status;
 	u32			stop_cmdr;
 
+	bool force_cmd_error;
+	bool force_data_error;
 	struct tasklet_struct	tasklet;
 	unsigned long		pending_events;
 	unsigned long		completed_events;
@@ -618,6 +620,14 @@ static void atmci_init_debugfs(struct atmel_mci_slot *slot)
 	if (!node)
 		goto err;
 
+	node = debugfs_create_bool("force_cmd_error", 644, root, &host->force_cmd_error);
+	if (!node)
+		goto err;
+
+	node = debugfs_create_bool("force_data_error", 644, root, &host->force_data_error);
+	if (!node)
+		goto err;
+
 	node = debugfs_create_u32("state", S_IRUSR, root, (u32 *)&host->state);
 	if (!node)
 		goto err;
@@ -1807,7 +1817,12 @@ static void atmci_tasklet_func(unsigned long priv)
 				 * If there is a command error don't start
 				 * data transfer.
 				 */
-				if (mrq->cmd->error) {
+				if (mrq->cmd->error || host->force_cmd_error) {
+					if (host->force_cmd_error) {
+						dev_info(&host->pdev->dev, "FSM: forced cmd error!\n");
+						host->force_cmd_error = false;
+						mrq->cmd->error = -EINVAL;
+					}
 					host->stop_transfer(host);
 					host->data = NULL;
 					atmci_writel(host, ATMCI_IDR,
@@ -1939,7 +1954,11 @@ static void atmci_tasklet_func(unsigned long priv)
 			atmci_writel(host, ATMCI_IDR, ATMCI_TXRDY | ATMCI_RXRDY
 			                   | ATMCI_DATA_ERROR_FLAGS);
 			status = host->data_status;
-			if (unlikely(status)) {
+			if (unlikely(status) || host->force_data_error) {
+				if (data && host->force_data_error) {
+					dev_info(&host->pdev->dev, "FSM: forced data error!\n");
+					host->force_data_error = false;
+				}
 				host->stop_transfer(host);
 				host->data = NULL;
 				if (data) {
@@ -2519,6 +2538,7 @@ static int atmci_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	host->pdev = pdev;
+	host->force_data_error = host->force_cmd_error = false;
 	spin_lock_init(&host->lock);
 	INIT_LIST_HEAD(&host->queue);
 
-- 
2.23.0

