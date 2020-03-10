Return-Path: <SRS0=AZQG=43=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE47C18E5A
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Mar 2020 15:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E18F215A4
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Mar 2020 15:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j/MqCVvH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgCJPdw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 10 Mar 2020 11:33:52 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40651 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbgCJPdw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Mar 2020 11:33:52 -0400
Received: by mail-lj1-f194.google.com with SMTP id 19so11812004ljj.7
        for <linux-mmc@vger.kernel.org>; Tue, 10 Mar 2020 08:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GFF5Nn+0MYGNKIt8ggfC3I2q2J2gXyLFnHV/fd1EhtU=;
        b=j/MqCVvH17KM8gW1kqrm22z+IZnEON6jMprpfTXFef3hwZzBL/5WAe/3AdQmRut44P
         uE9EZfoKSXp6bNBoCpNmkPmzcOzDyAAMLwwXnkXYhltJXzDirX1mUsEAGe5XfUsdFPMc
         MEsDi86NBxIuRq5anIInjaWiBP/7hw2xNqWSBLrFlkj71pjeqd8YhbKJXNU+QEtHLEA4
         eVhearQSqCxRkE92r1r5r5rtFaElLAfNHzr4mHC5dhwnzxSoxJaNfPCfq+LbVA4uyz9C
         UIzG7htevwJ6oZTs52ZmtrT/4c2NbklYogsaUxD987R9bYOpGG1RDGWqNcPNkcfWQxtE
         aFxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GFF5Nn+0MYGNKIt8ggfC3I2q2J2gXyLFnHV/fd1EhtU=;
        b=Rg0MtS5mGAxjtSfaKStZ7K0daspvNGLmacGV1dYOjr/s1W0fbC56gE19UPearEgjX7
         m444Y4s3OEHEq94L9AYQlJjGIiuzJ2gRCRCBOb4R7dnBd9jD+GS/GXHb7MT/Dc4rlK1M
         nAwM7b2qfZzq6qNSzOfywk5GS2U+IPWj9Mdrjct+lsKMyKIdLG76h/EVJQz62bQckzdq
         5R02f83dJUnSbn6cKzyq8obJi8qDtVsWHQjGWLE+6SiIydzU9lJQTX6VX7fKNCEAl70N
         pJwTVqMG8fj+44JKGsxj48rACWFFxQcKWlKEmKy91iuix2gcq5ia19UD5g1GLxT9Gcrq
         JRCQ==
X-Gm-Message-State: ANhLgQ01Rmad8ywzqrDog2E8lHlDbGc4Tjaolz9JMCtFjEHgmLL1UpPW
        Z6iWA4YN66v4UJH7TtRej2CFUtj/E50=
X-Google-Smtp-Source: ADFU+vtmiH30+Gm0I+Xbs8uD729V2mXSp7zVFQvsuP5yXIuBa5z2yMtZD6BoHHuDJ5/la1sxw6jVOA==
X-Received: by 2002:a2e:b1c2:: with SMTP id e2mr4080968lja.288.1583854429815;
        Tue, 10 Mar 2020 08:33:49 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id c22sm17283776lfi.41.2020.03.10.08.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 08:33:49 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Shawn Lin <shawn.lin@rock-chips.com>, mirq-linux@rere.qmqm.pl,
        Bitan Biswas <bbiswas@nvidia.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Jon Hunter <jonathanh@nvidia.com>, stable@vger.kernel.org
Subject: [PATCH 2/4] mmc: core: Respect MMC_CAP_NEED_RSP_BUSY for erase/trim/discard
Date:   Tue, 10 Mar 2020 16:33:38 +0100
Message-Id: <20200310153340.5593-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200310153340.5593-1-ulf.hansson@linaro.org>
References: <20200310153340.5593-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

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
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index aa54d359dab7..a971c4bcc442 100644
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

