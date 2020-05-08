Return-Path: <SRS0=NqgV=6W=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 426E6C38A2A
	for <linux-mmc@archiver.kernel.org>; Fri,  8 May 2020 09:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DBFD21473
	for <linux-mmc@archiver.kernel.org>; Fri,  8 May 2020 09:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OZhK7txA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbgEHJwR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 8 May 2020 05:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgEHJwR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 8 May 2020 05:52:17 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9F6C05BD43
        for <linux-mmc@vger.kernel.org>; Fri,  8 May 2020 02:52:17 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id e25so1018633ljg.5
        for <linux-mmc@vger.kernel.org>; Fri, 08 May 2020 02:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Kj0gLXRuliK3KdID/M87B7g/98tNYDKPX2QUn3XOTQs=;
        b=OZhK7txAGLD+FSfIpWbIoCZ0NEyJBgp/BtS++3PsuU1LgWgEHgTWM4a3k4nF2Q6Yw7
         oYFe1+dnKTQNn7bUOSbVdXydIta7K+DEKKgIVrH719Fx3KeUR4rGn/+8B8wHr/nIxxxd
         aE7L8xJHuwYiJcOeHPhLL+5Z1IcpW/5Neuz/e3sF7pIENLRs6Xot5alcb5mjxHJilxiW
         UAfuBKJgGZH/+6nEGSp4gCImy1IwFnUJwqjLEtTEJXCvrwYyjSSNo8dl0hX6gG0AASpD
         gkjdyK29xioHXidw1lt6uK1jR3KWISfPCN1HkxggdzBzQ1rpLnnFSNUm+37GBd1ZDuQk
         vzyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Kj0gLXRuliK3KdID/M87B7g/98tNYDKPX2QUn3XOTQs=;
        b=mSxLTNsLkKaTbcePu5lQgft5Sn4TE4den93QUlEa/uLcZ9iDtTqK7g2hY/ikpVJOst
         XvpNIjqpbXg8igkvLF+1Nw97MfELgo2eVE6V5v7aGzq5IANZu/6z+whuz56qKy+UpbUA
         epV1lSef82rh5SL7gXth7b6aaeJqG+d7XgPi/opph6cdS/N4pXhBas0xAciOVfkC4ela
         9xc3rksU69HoGhN/5QndhpE8Dat40L5PvMdGIJHdISOkFSUwfBaQy/VdIDBNEj+fTONA
         ohr5m5Qn9+Yt1fymNPDS9yEd8/1KjTX5IuNSKfQk7YqgX5TKEwQA5tMeWtpohYkh347h
         BOxA==
X-Gm-Message-State: AOAM530PoLDB0wsO+fSAPudZLZGhnoV+SYM2PWFsGO+w6/8jwE2iKVr2
        1EmMwQ8vZ7pVi43SD4fPChDEj6wINLs=
X-Google-Smtp-Source: ABdhPJwKJB8uOVbN/pIbEuDd4HOoQ+C6BSyPbgNfn+VuvpOjHLllMfAT7oWr8g3IVoR3TkCia0SmRQ==
X-Received: by 2002:a2e:2c11:: with SMTP id s17mr1136801ljs.119.1588931535130;
        Fri, 08 May 2020 02:52:15 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-7.NA.cust.bahnhof.se. [98.128.181.7])
        by smtp.gmail.com with ESMTPSA id x24sm804019lji.52.2020.05.08.02.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 02:52:13 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sascha Sommer <saschasommer@freenet.de>
Subject: [PATCH v2 12/19] mmc: sdricoh_cs: Throttle polling rate for data transfers
Date:   Fri,  8 May 2020 11:52:10 +0200
Message-Id: <20200508095210.14123-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Rather than to poll in a busy-loop, let's convert into using
read_poll_timeout() and insert a small delay between each polling attempts.
In particular, this avoids hogging the CPU.

Additionally, to convert to read_poll_timeout() we also need to switch from
using a specific number of polling attempts, into a specific timeout in us
instead. The previous 100000 attempts, is translated into a total timeout
of total 1s, as that seemed like reasonable value to pick.

Cc: Sascha Sommer <saschasommer@freenet.de>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- Use read_poll_timeout() instead of readl_poll_timeout(), as to
	preserve the debug print in sdricoh_readl().

---
 drivers/mmc/host/sdricoh_cs.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/sdricoh_cs.c b/drivers/mmc/host/sdricoh_cs.c
index 97ef7d71375a..8392158e2e9f 100644
--- a/drivers/mmc/host/sdricoh_cs.c
+++ b/drivers/mmc/host/sdricoh_cs.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/ioport.h>
+#include <linux/iopoll.h>
 #include <linux/scatterlist.h>
 
 #include <pcmcia/cistpl.h>
@@ -59,7 +60,7 @@ static unsigned int switchlocked;
 
 /* timeouts */
 #define CMD_TIMEOUT       100000
-#define TRANSFER_TIMEOUT  100000
+#define SDRICOH_DATA_TIMEOUT_US	1000000
 
 /* list of supported pcmcia devices */
 static const struct pcmcia_device_id pcmcia_ids[] = {
@@ -123,21 +124,24 @@ static inline unsigned int sdricoh_readb(struct sdricoh_host *host,
 	return value;
 }
 
+static bool sdricoh_status_ok(struct sdricoh_host *host, unsigned int status,
+			      unsigned int wanted)
+{
+	sdricoh_writel(host, R2E4_STATUS_RESP, status);
+	return status & wanted;
+}
+
 static int sdricoh_query_status(struct sdricoh_host *host, unsigned int wanted)
 {
-	unsigned int loop;
+	int ret;
 	unsigned int status = 0;
-	unsigned int timeout = TRANSFER_TIMEOUT;
 	struct device *dev = host->dev;
 
-	for (loop = 0; loop < timeout; loop++) {
-		status = sdricoh_readl(host, R21C_STATUS);
-		sdricoh_writel(host, R2E4_STATUS_RESP, status);
-		if (status & wanted)
-			break;
-	}
-
-	if (loop == timeout) {
+	ret = read_poll_timeout(sdricoh_readl, status,
+				sdricoh_status_ok(host, status, wanted),
+				32, SDRICOH_DATA_TIMEOUT_US, false,
+				host, R21C_STATUS);
+	if (ret) {
 		dev_err(dev, "query_status: timeout waiting for %x\n", wanted);
 		return -ETIMEDOUT;
 	}
-- 
2.20.1

