Return-Path: <SRS0=djOR=56=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D34C2BA19
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Apr 2020 16:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FD3520678
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Apr 2020 16:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TEUP/ysJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389809AbgDNQQc (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 14 Apr 2020 12:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389806AbgDNQOW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Apr 2020 12:14:22 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37A9C061A0E
        for <linux-mmc@vger.kernel.org>; Tue, 14 Apr 2020 09:14:21 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id k21so426131ljh.2
        for <linux-mmc@vger.kernel.org>; Tue, 14 Apr 2020 09:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fwu9S7UAM+VTYbloegyIHMb4QE63ILc3ZmogPOBkYSU=;
        b=TEUP/ysJDXAn4KxMntEmfuWp7e1ntkd972BMMHUAMu5RSVy9NFcLzJ/MNbN2sAhr9K
         z68Bs0twoY/mOuLSNUVJzJ6T3O897odoityS+fUX07CGspTf0xdXFoQRV/Rdg+sU1bAK
         XpT/snLZrvR1mU33DD9m0MZSoEBCsJ37ao2b0JENZmJOFWI74Lb5IDTYWSD3ECBwQpmX
         eta9GEbIYs9lcYyoJjvV/HTmqbjvRJiG3iYhgCJ2CuKykyA5KbvAHaojHmINJL/0hlJc
         XvzMZPk3tFXppWXMn6J1hPvgYoFDtmsZfURKfoZcFhtTNg4RYPJnzs1/vtHVyPTZeUrJ
         OkkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fwu9S7UAM+VTYbloegyIHMb4QE63ILc3ZmogPOBkYSU=;
        b=lZ2T/+/bFzn7p0KZD+e4CyfHdY/iz7cqabojMvs/67nr+rb9BWgUXHeeiOFCY3dM9o
         9RnR2xOBhvGo2NEHNt5PoLsGnXI6mKQBq3Lf75HJzOBHplp5Ur0s4PMJt4+nopEhT57i
         thFx4j3vv1RsFm9bmq41eGqPmpdZK5X+mP9P/1KtudZPWLbBEb2KkE4Q4pUQn5yzSGRK
         CbNLk2Yd++PXvOGOcKoMjrnwCzbrG4YzL/VC6tD0EDgXScYisS6kWOjkLhqMgOedAWZ+
         Af7yBjprluU2m1cM2nKuWzxYhUlhCA0InhRkMoeMbHSrIS/27HqIzGLw5KS8wmTc3jzM
         rv5A==
X-Gm-Message-State: AGi0PuYGwYuvAZ7Yvuqt+/oizXFt+WW6xyTdQz+HfHl5U9zoXCyVG7oz
        oW1Z3acwRO5TDpsa4o0xAMtOkvn14v4=
X-Google-Smtp-Source: APiQypJM/eUdzwtHvKRnjzHusrgxtMlGcKRC7NKmQ0OWpE9gTPFZ6P//cvxf2cOs7EDedBN2qOKVPw==
X-Received: by 2002:a2e:9713:: with SMTP id r19mr553910lji.89.1586880859671;
        Tue, 14 Apr 2020 09:14:19 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-131.NA.cust.bahnhof.se. [98.128.181.131])
        by smtp.gmail.com with ESMTPSA id a26sm9330669ljn.22.2020.04.14.09.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 09:14:19 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Bruce Chang <brucechang@via.com.tw>,
        Harald Welte <HaraldWelte@viatech.com>,
        Alex Dubov <oakad@yahoo.com>,
        Sascha Sommer <saschasommer@freenet.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        mirq-linux@rere.qmqm.pl, Jesper Nilsson <jesper.nilsson@axis.com>,
        Lars Persson <lars.persson@axis.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [PATCH 01/19] mmc: atmel-mci: Keep timer enabled when queuing a next request
Date:   Tue, 14 Apr 2020 18:13:55 +0200
Message-Id: <20200414161413.3036-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200414161413.3036-1-ulf.hansson@linaro.org>
References: <20200414161413.3036-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

When atmci_request_end() is about to finish a request for one slot, there
is a possibility that there is new request queued for another slot. If this
turns out to be the case, the new request is started and the timer is
re-programmed for it.

Although, a few lines below in atmci_request_end(), this timer becomes
deleted, likely corresponding to the other recently completed request. This
looks wrong, so let's fix it.

Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/atmel-mci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index aeaaa5314924..0472df8391b5 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -1557,6 +1557,8 @@ static void atmci_request_end(struct atmel_mci *host, struct mmc_request *mrq)
 
 	WARN_ON(host->cmd || host->data);
 
+	del_timer(&host->timer);
+
 	/*
 	 * Update the MMC clock rate if necessary. This may be
 	 * necessary if set_ios() is called when a different slot is
@@ -1583,8 +1585,6 @@ static void atmci_request_end(struct atmel_mci *host, struct mmc_request *mrq)
 		host->state = STATE_IDLE;
 	}
 
-	del_timer(&host->timer);
-
 	spin_unlock(&host->lock);
 	mmc_request_done(prev_mmc, mrq);
 	spin_lock(&host->lock);
-- 
2.20.1

