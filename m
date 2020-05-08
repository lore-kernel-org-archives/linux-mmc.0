Return-Path: <SRS0=NqgV=6W=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98628C47247
	for <linux-mmc@archiver.kernel.org>; Fri,  8 May 2020 09:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77FC8215A4
	for <linux-mmc@archiver.kernel.org>; Fri,  8 May 2020 09:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c7Msaojw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgEHJwf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 8 May 2020 05:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbgEHJwe (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 8 May 2020 05:52:34 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCBCC05BD43
        for <linux-mmc@vger.kernel.org>; Fri,  8 May 2020 02:52:34 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id u15so1033831ljd.3
        for <linux-mmc@vger.kernel.org>; Fri, 08 May 2020 02:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4TJAm+9iRwtFh5TlrP2asksTQquFny7nfEfVBEpyuw8=;
        b=c7Msaojwv00ZdbXSdNCabebkEe++MednrzhUl3DMwXQem1gVAmWmN6Q2nLJorbp0oo
         AHJ7j0FrtapDVBhPj45nzqgECClW37RbnRtg1jTX/OcmzsmSEYoAEl+22drLA1L38h/F
         V72ZlJLhZII3/g7z0QeCtuFNM5bpMBiJi8xXUabJ3YBsZPftogdGmZORQ0y4MCHkBqgt
         0BbD6E9JThlpsClq+Jyy5nvZ267EmmiZG0NjkYb7w+2rmXVHEZ+A8gpIYbhGCIuwZWrG
         qgesNSFmDk3tKa2qEGz174wyq8J1IDrzJ6ZfrvylCTxSzA02+39gPvP+SxHgutYYJ7ek
         9p7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4TJAm+9iRwtFh5TlrP2asksTQquFny7nfEfVBEpyuw8=;
        b=G4xQMEOD5Apy7RlnRcZ0qgiynwpdBj7JyYXFuXw6KglIp3Gm5Mcurh1dAlJRgOEPM9
         yfIXkTvBz5Uxq+/Fq+BiyhwyCFrTJreGjXzF//lxiMe2xpfLtzESI4W1g0xO4pMgKBtn
         ocmuCKtlQC5dvYOaQZVx3Ks0eehe2vSg6qFj9dLWQYudXTncE3xgLytuIr7IARMiu2VJ
         M/OhLuyZDyh5LH8CVI6apXUH2L5Rus/SWbFtveuI9GzX9EwzQ7cFTKrM7tRtb/e34oyd
         VCVD5UntawYNDdVW5Hv626u5AqEBh/invqpc7H7zJqhysprsrlRPHemgXITCzre1ytok
         u2uQ==
X-Gm-Message-State: AOAM532G1epxlk88doB/Bd5zPf9WFQjUVHgoQHvMibBhxYj0LA5ral3N
        IukFbfqVMzBOd8PWNozV5N+DVaN1dsY=
X-Google-Smtp-Source: ABdhPJz4u10vEjx1Wn3f64pWzn2t909DNsFV/HrElxLnIrccwUZtWv9ihIG8S1A1PnzbPDg8o1x6QQ==
X-Received: by 2002:a2e:9b0f:: with SMTP id u15mr1146568lji.272.1588931551949;
        Fri, 08 May 2020 02:52:31 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-7.NA.cust.bahnhof.se. [98.128.181.7])
        by smtp.gmail.com with ESMTPSA id t16sm882846lff.72.2020.05.08.02.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 02:52:30 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sascha Sommer <saschasommer@freenet.de>
Subject: [PATCH v2 14/19] mmc: sdricoh_cs: Respect the cmd->busy_timeout from the mmc core
Date:   Fri,  8 May 2020 11:52:28 +0200
Message-Id: <20200508095228.14230-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Using a fixed 1s polling timeout for all commands is a bit problematic.

For some commands it means waiting longer than needed for the polling to be
aborted, which may not a big issue, but still. For other commands, like for
an erase (CMD38) that uses a R1B response, may require longer timeouts than
1s. In these cases, we may end up treating the command as it failed, while
it just needed some more time to complete successfully.

Fix the problem by respecting the cmd->busy_timeout, which is provided by
the mmc core.

Note that, even if the sdricoh_cs driver may currently not support HW busy
detection on DAT0, some comments in the code refer to that the HW may
support it. Therefore, it seems better to be proactive in this case.

Cc: Sascha Sommer <saschasommer@freenet.de>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- Rebased, no changes.

---
 drivers/mmc/host/sdricoh_cs.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdricoh_cs.c b/drivers/mmc/host/sdricoh_cs.c
index 0594b5ffe151..76a8cd3a186f 100644
--- a/drivers/mmc/host/sdricoh_cs.c
+++ b/drivers/mmc/host/sdricoh_cs.c
@@ -157,7 +157,7 @@ static int sdricoh_query_status(struct sdricoh_host *host, unsigned int wanted)
 
 static int sdricoh_mmc_cmd(struct sdricoh_host *host, struct mmc_command *cmd)
 {
-	unsigned int status;
+	unsigned int status, timeout_us;
 	int ret;
 	unsigned char opcode = cmd->opcode;
 
@@ -179,9 +179,12 @@ static int sdricoh_mmc_cmd(struct sdricoh_host *host, struct mmc_command *cmd)
 	if (!opcode)
 		return 0;
 
+	timeout_us = cmd->busy_timeout ? cmd->busy_timeout * 1000 :
+		SDRICOH_CMD_TIMEOUT_US;
+
 	ret = read_poll_timeout(sdricoh_readl, status,
 			sdricoh_status_ok(host, status, STATUS_CMD_FINISHED),
-			32, SDRICOH_CMD_TIMEOUT_US, false,
+			32, timeout_us, false,
 			host, R21C_STATUS);
 
 	/*
-- 
2.20.1

