Return-Path: <SRS0=92ZL=3Y=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A2C9C2D0B1
	for <linux-mmc@archiver.kernel.org>; Tue,  4 Feb 2020 08:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D07832087E
	for <linux-mmc@archiver.kernel.org>; Tue,  4 Feb 2020 08:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bAo8GMut"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgBDIzV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 4 Feb 2020 03:55:21 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41461 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgBDIzV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Feb 2020 03:55:21 -0500
Received: by mail-lj1-f196.google.com with SMTP id h23so17694849ljc.8
        for <linux-mmc@vger.kernel.org>; Tue, 04 Feb 2020 00:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HwDebRrklVLgKidfwiVAchc7w1c7H8+6yL91Fz1oklE=;
        b=bAo8GMut8ZjWRtKyXCSHaye3xTLNgyT6mpHK8vINZrV1rELokXMV+JtCngT6qEUsQP
         g4spROSGU0INQUEgvlRSPPj9I6KUwxtQ39wuooKIBZURGjFjkzeCxDIQCq3jsMFaBMZO
         AZh4pCU8crJNa+Yk+M/kbCuiFzZ2jTUnmySYZfNdRgE2ncVEN5+D97YSjVWhbSFI/QZf
         ZpLjVG2KX3J4Tpxwp7Jce01stmchbl6rLhBXd7ojON/4ht63tPj3ter9til6gIHkkn/c
         vW7mxZdjci2OlijwIsHRd9UEyDv9zYOO8Wg5WxpTjXpeMNF9n+zqtypPbmn7IMgO2/xJ
         180Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HwDebRrklVLgKidfwiVAchc7w1c7H8+6yL91Fz1oklE=;
        b=YcsDVSuuvrIFtIj0wTEP+HHJMTl8X/HBtusrzalSUo7nROk8yHG1p0QOKt/iRQt+ZV
         WsieTQ4Myopd9aVn6BUlW7mmywHxvgmvUYaZ1ZB7dvc9y1Hyt9e24WXYvnBeTN4aUonL
         mcXWuJIN+I11RtM/NuNxO6i2cqD0KAIqRPtYQUVUtwAYBtbtBBbNvVmN4mNh6olnRklx
         oBbW5kETRTVAOKfq3K9TY5wTqmagpdE3dqGPVOsEhYNR/mlpAUfLXwuIfhv2RZRbg1wA
         L8JjceeuRVBXdODmR4REqtsJ7XA9TJnYytVTfSDVcsUMBzGG8yLDIiXgCc0+X13l7BZ+
         sa7g==
X-Gm-Message-State: APjAAAVYzQ19Wh/HiVhN9shKyYx1ulCXZuc/RQmlVR3H+dLYxOBXForb
        UPI9scNWTQN+kZQP16rD8LSGpS+HCdo=
X-Google-Smtp-Source: APXvYqzIqvoS373Ujxxhc+HIzb+LltY67F8iDrdbGB2IDZ7FD8K3h8fWuQDTv3CaYNLN6e/+kslrvA==
X-Received: by 2002:a2e:9a01:: with SMTP id o1mr17111793lji.247.1580806517553;
        Tue, 04 Feb 2020 00:55:17 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id n2sm11156283ljj.1.2020.02.04.00.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 00:55:16 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Shawn Lin <shawn.lin@rock-chips.com>, mirq-linux@rere.qmqm.pl
Subject: [PATCH 07/12] mmc: core: Update CMD13 busy check for CMD6 commands
Date:   Tue,  4 Feb 2020 09:54:44 +0100
Message-Id: <20200204085449.32585-8-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200204085449.32585-1-ulf.hansson@linaro.org>
References: <20200204085449.32585-1-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Through mmc_poll_for_busy() a CMD13 may be sent to get the status of the
(e)MMC card. If the state of the card is R1_STATE_PRG, the card is
considered as being busy, which means we continue to poll with CMD13. This
seems to be sufficient, but it's also unnecessary fragile, as it means a
new command/request could potentially be sent to the card when it's in an
unknown state.

To try to improve the situation, but also to move towards a more consistent
CMD13 polling behaviour in the mmc core, let's deploy the same policy we
use for regular I/O write requests. In other words, let's check that card
returns to the R1_STATE_TRAN and that the R1_READY_FOR_DATA bit is set in
the CMD13 response, before exiting the polling loop.

Note that, potentially this changed behaviour could lead to unnecessary
waiting for the timeout to expire, if the card for some reason, moves to an
unexpected error state. However, as we bail out from the polling loop when
R1_SWITCH_ERROR bit is set or when the CMD13 fails, this shouldn't be an
issue.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/mmc_ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index c17b13aacc6e..c14e24570b4e 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -468,7 +468,7 @@ static int mmc_busy_status(struct mmc_card *card, bool retry_crc_err,
 	if (err)
 		return err;
 
-	*busy = R1_CURRENT_STATE(status) == R1_STATE_PRG;
+	*busy = !mmc_ready_for_data(status);
 	return 0;
 }
 
-- 
2.17.1

