Return-Path: <SRS0=po4a=5W=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 077E2C2BA19
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Apr 2020 11:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9FEF206C3
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Apr 2020 11:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YWZSUjDb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbgDFLnr (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 6 Apr 2020 07:43:47 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43034 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbgDFLnr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Apr 2020 07:43:47 -0400
Received: by mail-lf1-f67.google.com with SMTP id n20so11498613lfl.10
        for <linux-mmc@vger.kernel.org>; Mon, 06 Apr 2020 04:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+rDLzUevramGwgT1ja8IcYx/VVAorK0hGjIaFXoByyQ=;
        b=YWZSUjDb8korgV4OE6/BogHH4jCKPO9q4FwciJSasVCNbjVB9RyDUITYVprQbsQUOa
         JyP1QUXUMu8o3OrynIFkOQ/AHq+cTX/VI5Bwbub17YIUtmtvGB5DecIn6J4B/m0p9Am5
         3xsARwH+CPlxPZGDNKLgNl/gbmhrwXVAZuS7w1Y4A/GemZ8+1LAQzMZXP9R1b5auRdSE
         Div5K+Zpl6EooToW4XiSan3ATGMuHkXZ5QVogNq2UFw+7Mt1/8Qo/RCsap5mApGw3nv8
         EamKYbXE369ck8jxcgaiavogI/H3iIAQX8N1g15zaPz+ecQY7y0zQnP2MwqTLkwGUOy4
         1BkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+rDLzUevramGwgT1ja8IcYx/VVAorK0hGjIaFXoByyQ=;
        b=TpSHplJoXqmR2GbLV3yyRx8cmFI3Du3+z5kyUc32RI2CatAZ1zrsRfVNIVQVA7uh6Y
         eqjWTrl3YtBkM3a4mgEhA6xs5DImtdIccMlEJKvX23mzFhkhS7Cjd6NdYK9kyBWesx9D
         JD449B2vA3OxzEpXEU2XxvLtGYN1kof8D5p/sdFOadzmXdi5o/iQRrM8b0buDfXvtDna
         OmGTDLU1/BMHMQH11VDvWhHGBFwWv1wNMLqWyIgf720u6wrsu1ejmxTcLkxOtG2+Hqay
         9Akv401U6v8PoV1WVKoU73xFw76rjpTW3782nx/17ELMnoG5TnXpwxYfYBtDEgaNHPh8
         6tXg==
X-Gm-Message-State: AGi0PuaCrtiJTwecyEnsyr8AZVtSPtdVigWQjwCPLaE8l1l6qblHg+6f
        x4y0z9PBy0p/NiRlXxmEHQz/THzo3+E=
X-Google-Smtp-Source: APiQypJfaJlMtPDK610vq7golIjlVgbmCThjzLIZjbSF6Y1OY4T6+VrxtX2hOmLv6iMcGl1c+eud/w==
X-Received: by 2002:a19:5217:: with SMTP id m23mr9208431lfb.202.1586173424274;
        Mon, 06 Apr 2020 04:43:44 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id x29sm8336021lfn.64.2020.04.06.04.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 04:43:43 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH] mmc: au1xmmc: Drop redundant code in au1xmmc_send_command()
Date:   Mon,  6 Apr 2020 13:43:37 +0200
Message-Id: <20200406114337.8802-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The in-parameter "wait" is always set to 0 by the caller, hence just drop
it and its corresponding code.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/au1xmmc.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/host/au1xmmc.c b/drivers/mmc/host/au1xmmc.c
index 8823680ca42c..9bb1910268ca 100644
--- a/drivers/mmc/host/au1xmmc.c
+++ b/drivers/mmc/host/au1xmmc.c
@@ -259,7 +259,7 @@ static void au1xmmc_tasklet_finish(unsigned long param)
 	au1xmmc_finish_request(host);
 }
 
-static int au1xmmc_send_command(struct au1xmmc_host *host, int wait,
+static int au1xmmc_send_command(struct au1xmmc_host *host,
 				struct mmc_command *cmd, struct mmc_data *data)
 {
 	u32 mmccmd = (cmd->opcode << SD_CMD_CI_SHIFT);
@@ -302,9 +302,6 @@ static int au1xmmc_send_command(struct au1xmmc_host *host, int wait,
 	__raw_writel(cmd->arg, HOST_CMDARG(host));
 	wmb(); /* drain writebuffer */
 
-	if (wait)
-		IRQ_OFF(host, SD_CONFIG_CR);
-
 	__raw_writel((mmccmd | SD_CMD_GO), HOST_CMD(host));
 	wmb(); /* drain writebuffer */
 
@@ -312,19 +309,6 @@ static int au1xmmc_send_command(struct au1xmmc_host *host, int wait,
 	while (__raw_readl(HOST_CMD(host)) & SD_CMD_GO)
 		/* nop */;
 
-	/* Wait for the command to come back */
-	if (wait) {
-		u32 status = __raw_readl(HOST_STATUS(host));
-
-		while (!(status & SD_STATUS_CR))
-			status = __raw_readl(HOST_STATUS(host));
-
-		/* Clear the CR status */
-		__raw_writel(SD_STATUS_CR, HOST_STATUS(host));
-
-		IRQ_ON(host, SD_CONFIG_CR);
-	}
-
 	return 0;
 }
 
@@ -711,7 +695,7 @@ static void au1xmmc_request(struct mmc_host* mmc, struct mmc_request* mrq)
 	}
 
 	if (!ret)
-		ret = au1xmmc_send_command(host, 0, mrq->cmd, mrq->data);
+		ret = au1xmmc_send_command(host, mrq->cmd, mrq->data);
 
 	if (ret) {
 		mrq->cmd->error = ret;
-- 
2.20.1

