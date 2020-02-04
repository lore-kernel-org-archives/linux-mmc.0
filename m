Return-Path: <SRS0=92ZL=3Y=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A360C3524B
	for <linux-mmc@archiver.kernel.org>; Tue,  4 Feb 2020 08:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FEE421775
	for <linux-mmc@archiver.kernel.org>; Tue,  4 Feb 2020 08:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i3tDDc6a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbgBDIzK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 4 Feb 2020 03:55:10 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36082 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgBDIzK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Feb 2020 03:55:10 -0500
Received: by mail-lj1-f194.google.com with SMTP id r19so17696812ljg.3
        for <linux-mmc@vger.kernel.org>; Tue, 04 Feb 2020 00:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vtYL82EUWBDkrP3xF+FQMsvWNrmcMg1IbbGdl9pmLKg=;
        b=i3tDDc6aNncLBfno+CF9PvHHIe9LC37uz8BU1mB3hoQjRPMCyA818sMS4QVXOcITDi
         aOBr76AxjAgP4blPOM3eCJR0SxfLPTy85Rr0UiFmTzEKvFd5b3XdDiwjAZt8qOYGE8ND
         IO1KjvhW3hCtFLSUF9qIv9GUP6vPICSxs3XNonFVP80OlpRJm3EbL1se7otV6D40R8cZ
         NSbx38+HRnS9/w3MOWOIeKWUOUiirgbNduhbQ6ACapMlhaj6lKhwk+o1ODXS2Wu+IxNf
         8yk7rHwj0ccApMqFxv1+q7GJoNjTdQ3anAyimt7kN0IC2moA0yE98rpZ6r4nIb0yAanW
         PJ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vtYL82EUWBDkrP3xF+FQMsvWNrmcMg1IbbGdl9pmLKg=;
        b=ZGQ6f3NviKrb2oiJmD9wUaWcxfyfGjWOY7uyl0ZEBIo0TQhxuCpjL2Zmqsa729oVE9
         w0x1XICxOkt3iJVgIH4cZDImozO8A2AehEJ/fHcTjeelZp5KbBKGKunTKWr5uSde0ONh
         Q/n/CDEu5dI3PMbd8MudNMNGP+z8QSA5dI8zKP7UPpPy6jQOssOJ4Q2EpFTayHMZvAfY
         fDl3afRtQolJ8LEWFZ+pwWcQNPLhAqQFl0EFbKUT219P1sUlQntf2AH3+JBEuXd3509O
         xVHn5Gto2p+42SaUwkCTYC2CBIUgfvagrujXNr1fhDcJD4TBjqQyPi4G5B8NbpbTe4Sl
         DK6A==
X-Gm-Message-State: APjAAAWoCzkc+D5IfogberCaP99wp2062QL0h6ab0EBDBR70Gt8MXjxQ
        jMXIN1UdM2MoYK8bOa9QEBWkntRsekk=
X-Google-Smtp-Source: APXvYqz5spGAUW9o4w2qNMgMVIQ2JfXKXFKTIuPHMl1XH50sWB5BNVu+ybfkyBGD2CiytzzUTFHinQ==
X-Received: by 2002:a05:651c:102c:: with SMTP id w12mr16795849ljm.53.1580806508034;
        Tue, 04 Feb 2020 00:55:08 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id n2sm11156283ljj.1.2020.02.04.00.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 00:55:07 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Shawn Lin <shawn.lin@rock-chips.com>, mirq-linux@rere.qmqm.pl
Subject: [PATCH 01/12] mmc: core: Throttle polling rate for CMD6
Date:   Tue,  4 Feb 2020 09:54:38 +0100
Message-Id: <20200204085449.32585-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200204085449.32585-1-ulf.hansson@linaro.org>
References: <20200204085449.32585-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

In mmc_poll_for_busy() we loop continuously, either by sending a CMD13 or
by invoking the ->card_busy() host ops, as to detect when the card stops
signaling busy. This behaviour is problematic as it may cause CPU hogging,
especially when the busy signal time reaches beyond a few ms.

Let's fix the issue by adding a throttling mechanism, that inserts a
usleep_range() in between the polling attempts. The sleep range starts at
16-32us, but increases for each loop by a factor of 2, up until the range
reaches ~32-64ms. In this way, we are able to keep the loop fine-grained
enough for short busy signaling times, while also not hogging the CPU for
longer times.

Note that, this change is inspired by the similar throttling mechanism that
we already use for mmc_do_erase().

Reported-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/mmc_ops.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index da425ee2d9bf..446a37cc2a86 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -456,6 +456,7 @@ static int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
 	struct mmc_host *host = card->host;
 	int err;
 	unsigned long timeout;
+	unsigned int udelay = 32, udelay_max = 32768;
 	u32 status = 0;
 	bool expired = false;
 	bool busy = false;
@@ -500,6 +501,13 @@ static int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
 				mmc_hostname(host), __func__);
 			return -ETIMEDOUT;
 		}
+
+		/* Throttle the polling rate to avoid hogging the CPU. */
+		if (busy) {
+			usleep_range(udelay, udelay * 2);
+			if (udelay < udelay_max)
+				udelay *= 2;
+		}
 	} while (busy);
 
 	return 0;
-- 
2.17.1

