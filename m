Return-Path: <SRS0=92ZL=3Y=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122E5C2D0B1
	for <linux-mmc@archiver.kernel.org>; Tue,  4 Feb 2020 08:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEC172087E
	for <linux-mmc@archiver.kernel.org>; Tue,  4 Feb 2020 08:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ViWufv1X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgBDIzO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 4 Feb 2020 03:55:14 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35090 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgBDIzO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Feb 2020 03:55:14 -0500
Received: by mail-lj1-f194.google.com with SMTP id q8so17692432ljb.2
        for <linux-mmc@vger.kernel.org>; Tue, 04 Feb 2020 00:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0GJq9tA3Io62JheI7iBf2w6LOIrqQ/a6e8cUoQjZMmA=;
        b=ViWufv1Xr+96Cd+lNIA+1z8HqQv1biss1J2rnTS0V+hDssQrciUWVmRT9y+QhIWMj0
         IK3TUARrTJxGz3wD+hzZDHnamKkWUiD0ecRfCJX9bjqMlZnyHhC1lASK4VG9+5352YsH
         S799L2WwarvSuDMYYPgZFKbEQlT9gkJQ8WZDijpa44DQAT8fh3PXbEWqypTK9vlzxf9c
         T0s/mDqtT7pF5AWxKWWFskWyEb3Q6AtRrp3gSr2VTjSNmV/VjrLsxk/56vl+oQIOD8xX
         0FGkFcMiCsFUtuCZu8KsS0VJKSghpJ0IVbKGidDi3p3hTahwZ/+C/RjQeBg/t6w7efIm
         J/6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0GJq9tA3Io62JheI7iBf2w6LOIrqQ/a6e8cUoQjZMmA=;
        b=gBBEptLeN0HfhJVURR9KbWK+syv3zZgaKL6688dzvIDOAd/l/m16wPK0LT0EF+3fU4
         weBmM7tNcwEgeeR7IXb3ZV64FtTS/47TrFEAxY9BqTr8t0jUa5iReYLuHQrdRcnL9z6t
         n+tTSSeCuGQC7nhryhiZ9WhKLEZ0b12UciGJookB25N8FdBwkvGT3IN14nY0pTkEkkYK
         nxBFonH6tDhi4Y+InUmb3wEj12+oA5IPZqaMHOYlnk+uf2H71S8XaqomHn6aiRBrDBH5
         pMYt9uyEz2XpmpCVeDzQdRjfAYTnMs6je1vKzDa6GR1EJQw55HTAhltJcuK6/QhJwr1G
         mtzA==
X-Gm-Message-State: APjAAAU99iNtz4ojb3UEKi/Ly3Q98+lo3UOE7vyOiTq/GGv1M/LsYZLb
        kvccJ371NT0rpAs6yP+NT2stH3S3l8Q=
X-Google-Smtp-Source: APXvYqygbLawlcN0vVzBEz9H+kbNUCy252g+HSsYbyPjhrnKq/k+OTmLVe4pOiopdtj2tpFKQPRaTA==
X-Received: by 2002:a2e:b80e:: with SMTP id u14mr17053415ljo.17.1580806511074;
        Tue, 04 Feb 2020 00:55:11 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id n2sm11156283ljj.1.2020.02.04.00.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 00:55:10 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Shawn Lin <shawn.lin@rock-chips.com>, mirq-linux@rere.qmqm.pl
Subject: [PATCH 03/12] mmc: core: Extend mmc_switch_status() to rid of __mmc_switch_status()
Date:   Tue,  4 Feb 2020 09:54:40 +0100
Message-Id: <20200204085449.32585-4-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200204085449.32585-1-ulf.hansson@linaro.org>
References: <20200204085449.32585-1-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

To simplify code, let's extend mmc_switch_status() to cope with needs
addressed in __mmc_switch_status(). Then move all users to the updated
mmc_switch_status() API and drop __mmc_switch_status() altogether.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/mmc.c     | 16 ++++++++--------
 drivers/mmc/core/mmc_ops.c |  9 ++-------
 drivers/mmc/core/mmc_ops.h |  3 +--
 3 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index f6912ded652d..8a1f64065a47 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1173,7 +1173,7 @@ static int mmc_select_hs400(struct mmc_card *card)
 	max_dtr = card->ext_csd.hs_max_dtr;
 	mmc_set_clock(host, max_dtr);
 
-	err = mmc_switch_status(card);
+	err = mmc_switch_status(card, true);
 	if (err)
 		goto out_err;
 
@@ -1211,7 +1211,7 @@ static int mmc_select_hs400(struct mmc_card *card)
 	if (host->ops->hs400_complete)
 		host->ops->hs400_complete(host);
 
-	err = mmc_switch_status(card);
+	err = mmc_switch_status(card, true);
 	if (err)
 		goto out_err;
 
@@ -1249,7 +1249,7 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
 
 	mmc_set_timing(host, MMC_TIMING_MMC_DDR52);
 
-	err = mmc_switch_status(card);
+	err = mmc_switch_status(card, true);
 	if (err)
 		goto out_err;
 
@@ -1265,7 +1265,7 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
 	if (host->ops->hs400_downgrade)
 		host->ops->hs400_downgrade(host);
 
-	err = mmc_switch_status(card);
+	err = mmc_switch_status(card, true);
 	if (err)
 		goto out_err;
 
@@ -1285,7 +1285,7 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
 	 * failed. If there really is a problem, we would expect tuning will
 	 * fail and the result ends up the same.
 	 */
-	err = __mmc_switch_status(card, false);
+	err = mmc_switch_status(card, false);
 	if (err)
 		goto out_err;
 
@@ -1366,7 +1366,7 @@ static int mmc_select_hs400es(struct mmc_card *card)
 	}
 
 	mmc_set_timing(host, MMC_TIMING_MMC_HS);
-	err = mmc_switch_status(card);
+	err = mmc_switch_status(card, true);
 	if (err)
 		goto out_err;
 
@@ -1407,7 +1407,7 @@ static int mmc_select_hs400es(struct mmc_card *card)
 	if (host->ops->hs400_enhanced_strobe)
 		host->ops->hs400_enhanced_strobe(host, &host->ios);
 
-	err = mmc_switch_status(card);
+	err = mmc_switch_status(card, true);
 	if (err)
 		goto out_err;
 
@@ -1468,7 +1468,7 @@ static int mmc_select_hs200(struct mmc_card *card)
 		 * switch failed. If there really is a problem, we would expect
 		 * tuning will fail and the result ends up the same.
 		 */
-		err = __mmc_switch_status(card, false);
+		err = mmc_switch_status(card, false);
 
 		/*
 		 * mmc_select_timing() assumes timing has not changed if
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 35df97fe9cdc..d2371612d536 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -430,7 +430,7 @@ static int mmc_switch_status_error(struct mmc_host *host, u32 status)
 }
 
 /* Caller must hold re-tuning */
-int __mmc_switch_status(struct mmc_card *card, bool crc_err_fatal)
+int mmc_switch_status(struct mmc_card *card, bool crc_err_fatal)
 {
 	u32 status;
 	int err;
@@ -444,11 +444,6 @@ int __mmc_switch_status(struct mmc_card *card, bool crc_err_fatal)
 	return mmc_switch_status_error(card->host, status);
 }
 
-int mmc_switch_status(struct mmc_card *card)
-{
-	return __mmc_switch_status(card, true);
-}
-
 static int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
 			bool send_status, bool retry_crc_err)
 {
@@ -594,7 +589,7 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 		mmc_set_timing(host, timing);
 
 	if (send_status) {
-		err = mmc_switch_status(card);
+		err = mmc_switch_status(card, true);
 		if (err && timing)
 			mmc_set_timing(host, old_timing);
 	}
diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
index 8f2f9475716d..09dee8a466a0 100644
--- a/drivers/mmc/core/mmc_ops.h
+++ b/drivers/mmc/core/mmc_ops.h
@@ -29,8 +29,7 @@ int mmc_bus_test(struct mmc_card *card, u8 bus_width);
 int mmc_interrupt_hpi(struct mmc_card *card);
 int mmc_can_ext_csd(struct mmc_card *card);
 int mmc_get_ext_csd(struct mmc_card *card, u8 **new_ext_csd);
-int mmc_switch_status(struct mmc_card *card);
-int __mmc_switch_status(struct mmc_card *card, bool crc_err_fatal);
+int mmc_switch_status(struct mmc_card *card, bool crc_err_fatal);
 int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 		unsigned int timeout_ms, unsigned char timing,
 		bool use_busy_signal, bool send_status,	bool retry_crc_err);
-- 
2.17.1

