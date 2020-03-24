Return-Path: <SRS0=tDGl=5J=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF28C2BAEE
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Mar 2020 18:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC4EC20719
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Mar 2020 18:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wz90s44M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgCXSHt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Mar 2020 14:07:49 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46052 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727976AbgCXSHt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Mar 2020 14:07:49 -0400
Received: by mail-lj1-f196.google.com with SMTP id t17so8971683ljc.12
        for <linux-mmc@vger.kernel.org>; Tue, 24 Mar 2020 11:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jV/7nbfuaKTyqKa8OwvFG6+JXR2maNrlTVAP3xkJ9Sg=;
        b=Wz90s44MGzWvrsmz1uJcwRY+mxF8cBzMgpjGFrN9rk1gU6p+cEh3/WTyNYu8wAX6qq
         GHyWZLIRkAVWTghZx3jAnctO9lpI3+M7XwZ2IUQxuxz797B+syG6+1QXN3XzlZV2om3s
         jDeIxAgfklfEViDCFHjbR4SEaholGlgx2hFN4lYo9dBxRKcWRhObbCbrO1WDKkH+UfeH
         USXkpiCN6EisNwrJPT8xWclP3rIZxViyQCOnBVp45gBziBaOgsWOgdO/G7U+uYMXl+lH
         KxzRpnHn/4jvYlk8IIA13VAI/latgqTgnswkcAHp0ynQ7pHzibAVIKxitXlUBQUFoQUy
         qBEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jV/7nbfuaKTyqKa8OwvFG6+JXR2maNrlTVAP3xkJ9Sg=;
        b=G0ZsK0GiNSrfFWMXcaHBDoYDkM+7zTB8RBnN8rXro3FWMYHOUO7j+m6OPgDdy+OM1U
         kM98vZKXp55I8xMN22Tao0qH0D2iEvGreQJpLWuygu9l4BOtLktfJ+jOfi61Qtsssta9
         vB7xNLWy2zJWwAy+lGQdJ42uB4QAt1dBpv6h1RjCCe54Nn3ejji2WWMJlZ+cR7bfkwTd
         GMC7Xfm7ushKsfCc/OC85totC9SS3LG1rCfJ4hYiCvsE/LDeDeEiCPV+MM+CupUx6yDk
         ynMeyOtCdWBPTVbpAzm55oAFtMmzLBeMby9tKtMDSg6ZR/fON6qYL5s+ISuhJsrhR/Bd
         zI8w==
X-Gm-Message-State: ANhLgQ11HVIHb6AQEzfmYBmsQkfNWw7GOY571AYkgk4UJszzRenECimn
        uxFDh1i8zQAFpVQw7kdAGTLLvQ==
X-Google-Smtp-Source: ADFU+vt4gv+yP19jGJNzIU2UapMY/Nc94lp4crc7owbZtBdlHAq8CUjoKgNdxStfdm1v4pQsJX92OA==
X-Received: by 2002:a2e:3210:: with SMTP id y16mr18008504ljy.49.1585073265680;
        Tue, 24 Mar 2020 11:07:45 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id 3sm12113809ljq.18.2020.03.24.11.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 11:07:45 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>
Subject: [PATCH 5.4.28 2/5] mmc: core: Respect MMC_CAP_NEED_RSP_BUSY for erase/trim/discard
Date:   Tue, 24 Mar 2020 19:07:35 +0100
Message-Id: <20200324180738.28892-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200324180738.28892-1-ulf.hansson@linaro.org>
References: <20200324180738.28892-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

[ Upstream commit 43cc64e5221cc6741252b64bc4531dd1eefb733d ]

The busy timeout that is computed for each erase/trim/discard operation,
can become quite long and may thus exceed the host->max_busy_timeout. If
that becomes the case, mmc_do_erase() converts from using an R1B response
to an R1 response, as to prevent the host from doing HW busy detection.

However, it has turned out that some hosts requires an R1B response no
matter what, so let's respect that via checking MMC_CAP_NEED_RSP_BUSY. Note
that, if the R1B gets enforced, the host becomes fully responsible of
managing the needed busy timeout, in one way or the other.

Suggested-by: Sowjanya Komatineni <skomatineni@nvidia.com>
Cc: <stable@vger.kernel.org>
Tested-by: Anders Roxell <anders.roxell@linaro.org>
Tested-by: Sowjanya Komatineni <skomatineni@nvidia.com>
Tested-by: Faiz Abbas <faiz_abbas@ti.com>
Tested-By: Peter Geis <pgwipeout@gmail.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index abf8f5eb0a1c..26644b7ec13e 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1732,8 +1732,11 @@ static int mmc_do_erase(struct mmc_card *card, unsigned int from,
 	 * the erase operation does not exceed the max_busy_timeout, we should
 	 * use R1B response. Or we need to prevent the host from doing hw busy
 	 * detection, which is done by converting to a R1 response instead.
+	 * Note, some hosts requires R1B, which also means they are on their own
+	 * when it comes to deal with the busy timeout.
 	 */
-	if (card->host->max_busy_timeout &&
+	if (!(card->host->caps & MMC_CAP_NEED_RSP_BUSY) &&
+	    card->host->max_busy_timeout &&
 	    busy_timeout > card->host->max_busy_timeout) {
 		cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
 	} else {
-- 
2.20.1

