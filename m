Return-Path: <SRS0=h93R=44=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271CEC18E5A
	for <linux-mmc@archiver.kernel.org>; Wed, 11 Mar 2020 09:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECFCE20848
	for <linux-mmc@archiver.kernel.org>; Wed, 11 Mar 2020 09:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uin1HPcf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbgCKJUp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 11 Mar 2020 05:20:45 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33952 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728255AbgCKJUp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Mar 2020 05:20:45 -0400
Received: by mail-lf1-f66.google.com with SMTP id i19so1067866lfl.1
        for <linux-mmc@vger.kernel.org>; Wed, 11 Mar 2020 02:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gzGrKjx7T6bMEuJHSdVpyuDphTMIQkVy9Cv5wxaqPB0=;
        b=uin1HPcfChLr7/kvEoXUMG9V77Sy64D58DUXUt5FD+Av68kNHXx9UzkxkTIB1ltLHF
         OaFD1x9gaQ5czvUXMyDnPpzqfRqnOz5B9Rqz/Vq3dgFdikwcco9QWil5fV8G4xIMPSd6
         F4N/NvlHdcBVzcsQtVpGzGLaaKcl+ij3EZKgtcP0dNAkZ5iiTpU/Y0eAJA9ZSbAcTCcE
         URWRgtwwHzYDq/uu3tZHmiMxZavmxG+ngiSgFU3is365Q+FUsq5ffzHEjUbVS1P+ImVh
         Q+HB4rGtanTTejopcUyemcUxlRiOhtDyUg4/TiKSvC/6TWDj/pxS8o+knypUNWLcag/h
         lqFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gzGrKjx7T6bMEuJHSdVpyuDphTMIQkVy9Cv5wxaqPB0=;
        b=fAmumrhUktTMDZYqylvhs1ePbTS3pfys9V7TR+YMU7AJoT+EyK0qUFeTNm3UbrGsfe
         QrCr3s0D40kvFHMSZmUq+zg6/vnXIoQHG1ytiANzEej62l/wQEfJCUDi7g9a0aqRAhov
         NG6u30p3Hmh4+9+LQFgSIueKJBuCFTs+EbzDQrtD+9re1qkcHKwjizJYm1ZQ60qrmGqF
         vvVwqR+zSerJttMt75xZRFrilAy99BG6t9aGgaaujKpP7x+W5dlacn/73VQVcJXGJnR6
         dUiAjU5qop0PLuBIvkr50FASQoUPhAotvjQ/b5uTnq07JyrwqZjQ8dDKlY1Pbq9aZIan
         s4gw==
X-Gm-Message-State: ANhLgQ35AcGbarla8iiPcx4fOSjsp9WxvnzLcJUrE2qLE8H9fvRII4UG
        EsWfkXrh43+uKWvwiZPFjwzBnQ6wVYI=
X-Google-Smtp-Source: ADFU+vtZ+9l/EWWD6Wh6gxr/y5f9nLAAX9h4wbaqzGjDjekloDtJQpTBZX60pH/YmP5E/up8uDrXTA==
X-Received: by 2002:ac2:58ee:: with SMTP id v14mr1571246lfo.62.1583918442381;
        Wed, 11 Mar 2020 02:20:42 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id e2sm23169178ljp.55.2020.03.11.02.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 02:20:41 -0700 (PDT)
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
Subject: [PATCH] mmc: core: Respect MMC_CAP_NEED_RSP_BUSY for eMMC sleep command
Date:   Wed, 11 Mar 2020 10:20:36 +0100
Message-Id: <20200311092036.16084-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The busy timeout for the CMD5 to put the eMMC into sleep state, is specific
to the card. Potentially the timeout may exceed the host->max_busy_timeout.
If that becomes the case, mmc_sleep() converts from using an R1B response
to an R1 response, as to prevent the host from doing HW busy detection.

However, it has turned out that some hosts requires an R1B response no
matter what, so let's respect that via checking MMC_CAP_NEED_RSP_BUSY. Note
that, if the R1B gets enforced, the host becomes fully responsible of
managing the needed busy timeout, in one way or the other.

Suggested-by: Sowjanya Komatineni <skomatineni@nvidia.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/mmc.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index f6912ded652d..de14b5845f52 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1910,9 +1910,12 @@ static int mmc_sleep(struct mmc_host *host)
 	 * If the max_busy_timeout of the host is specified, validate it against
 	 * the sleep cmd timeout. A failure means we need to prevent the host
 	 * from doing hw busy detection, which is done by converting to a R1
-	 * response instead of a R1B.
+	 * response instead of a R1B. Note, some hosts requires R1B, which also
+	 * means they are on their own when it comes to deal with the busy
+	 * timeout.
 	 */
-	if (host->max_busy_timeout && (timeout_ms > host->max_busy_timeout)) {
+	if (!(host->caps & MMC_CAP_NEED_RSP_BUSY) && host->max_busy_timeout &&
+	    (timeout_ms > host->max_busy_timeout)) {
 		cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
 	} else {
 		cmd.flags = MMC_RSP_R1B | MMC_CMD_AC;
-- 
2.20.1

