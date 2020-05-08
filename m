Return-Path: <SRS0=NqgV=6W=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92595C38A2A
	for <linux-mmc@archiver.kernel.org>; Fri,  8 May 2020 09:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71DDF20A8B
	for <linux-mmc@archiver.kernel.org>; Fri,  8 May 2020 09:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NMJTr4se"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgEHJw0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 8 May 2020 05:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgEHJwZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 8 May 2020 05:52:25 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BAD2C05BD43
        for <linux-mmc@vger.kernel.org>; Fri,  8 May 2020 02:52:24 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id u6so1018612ljl.6
        for <linux-mmc@vger.kernel.org>; Fri, 08 May 2020 02:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oGYd9AQdlcl1pmEoCpIEqwK9BJV8M5Www8GEN3oe3Ig=;
        b=NMJTr4seavNIw4MU48DBNqlL2h3DmB9iiou0clJEgkDlBHjlexF0pA4JwH2dtezgNj
         qzN5yqpjoYCuEklNGZun92vnduKttdI8mQVj3zygoS4PsCBZfuddQxgJUriLuVnPSWG4
         gOKf+WINBzHRjlC28YLZ+J5tnTeD4bTVTrolmIiLwbloDsAmjoJQ/DimqFjOLrARIGe/
         qKhE13cy5BM32+8URt2LgIN69y14RjRB1evcfBPSHtBBf3fXUUqYxv8i0AYmywFPFqbt
         Z0BfwYaX/LMeQ8dpNEvX5wf/sSFijmpkFM4/OV7GRED8Zx+fx9tTp0UcaS34EPBV5LQu
         PWSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oGYd9AQdlcl1pmEoCpIEqwK9BJV8M5Www8GEN3oe3Ig=;
        b=Kfj4RpKsgoqakSONx6lPiDtuPR+5W/N9ZtDpSIv2W+F0jeNWcQFtKwlz9afwUPrD3S
         pVTQnbnVTGV6Uk/kinbZZ6cI1B19VcxMNF7ulxpzCDTUjYlAp6orMWpHM4QcYafEXkK2
         pboc97xHPjeWdGAFcWGI6pum3WXv+WLZAOpSLtGnfx2JM4w8N9KE58oXbbru9uKPwU8F
         L/kpVAs0Mj0eKKEkaa5YcXLd1CwB1NNyCnvkNjbXter6P2KQA/D02b2BmbwA6jrfll73
         tV4Kd3JuINPJ5dGfX1kMy9ppTW8vfqDSb6XZ+D3PBpPkIBwBU4JAL6XYFzhWJ2DHpt5I
         PB3g==
X-Gm-Message-State: AOAM5333zItu2sLfRnc7hnwoQBOdOAjd5H6qUFCn7hMNIUYXjq6T2VSL
        Y6lC7IHuyJpw3txk2KF9A4GtJHvPXT4=
X-Google-Smtp-Source: ABdhPJwCCb++sgF0Td/juhrOMNNZRkLd9l8oaoFT7HL2UEXXsKf8Y5+u0M/vD6BBBablFsIbR883Cw==
X-Received: by 2002:a2e:8017:: with SMTP id j23mr1094276ljg.22.1588931542491;
        Fri, 08 May 2020 02:52:22 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-7.NA.cust.bahnhof.se. [98.128.181.7])
        by smtp.gmail.com with ESMTPSA id j29sm902171lfp.90.2020.05.08.02.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 02:52:21 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sascha Sommer <saschasommer@freenet.de>
Subject: [PATCH v2 13/19] mmc: sdricoh_cs: Throttle polling rate for commands
Date:   Fri,  8 May 2020 11:52:18 +0200
Message-Id: <20200508095218.14177-1-ulf.hansson@linaro.org>
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
 drivers/mmc/host/sdricoh_cs.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/host/sdricoh_cs.c b/drivers/mmc/host/sdricoh_cs.c
index 8392158e2e9f..0594b5ffe151 100644
--- a/drivers/mmc/host/sdricoh_cs.c
+++ b/drivers/mmc/host/sdricoh_cs.c
@@ -59,7 +59,7 @@ static unsigned int switchlocked;
 #define STATUS_BUSY              0x40000000
 
 /* timeouts */
-#define CMD_TIMEOUT       100000
+#define SDRICOH_CMD_TIMEOUT_US	1000000
 #define SDRICOH_DATA_TIMEOUT_US	1000000
 
 /* list of supported pcmcia devices */
@@ -158,8 +158,7 @@ static int sdricoh_query_status(struct sdricoh_host *host, unsigned int wanted)
 static int sdricoh_mmc_cmd(struct sdricoh_host *host, struct mmc_command *cmd)
 {
 	unsigned int status;
-	int result = 0;
-	unsigned int loop = 0;
+	int ret;
 	unsigned char opcode = cmd->opcode;
 
 	/* reset status reg? */
@@ -175,24 +174,24 @@ static int sdricoh_mmc_cmd(struct sdricoh_host *host, struct mmc_command *cmd)
 	/* fill parameters */
 	sdricoh_writel(host, R204_CMD_ARG, cmd->arg);
 	sdricoh_writel(host, R200_CMD, (0x10000 << 8) | opcode);
+
 	/* wait for command completion */
-	if (opcode) {
-		for (loop = 0; loop < CMD_TIMEOUT; loop++) {
-			status = sdricoh_readl(host, R21C_STATUS);
-			sdricoh_writel(host, R2E4_STATUS_RESP, status);
-			if (status  & STATUS_CMD_FINISHED)
-				break;
-		}
-		/* don't check for timeout in the loop it is not always
-		   reset correctly
-		*/
-		if (loop == CMD_TIMEOUT || status & STATUS_CMD_TIMEOUT)
-			result = -ETIMEDOUT;
+	if (!opcode)
+		return 0;
 
-	}
+	ret = read_poll_timeout(sdricoh_readl, status,
+			sdricoh_status_ok(host, status, STATUS_CMD_FINISHED),
+			32, SDRICOH_CMD_TIMEOUT_US, false,
+			host, R21C_STATUS);
 
-	return result;
+	/*
+	 * Don't check for timeout status in the loop, as it's not always reset
+	 * correctly.
+	 */
+	if (ret || status & STATUS_CMD_TIMEOUT)
+		return -ETIMEDOUT;
 
+	return 0;
 }
 
 static int sdricoh_reset(struct sdricoh_host *host)
-- 
2.20.1

