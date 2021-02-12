Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49711C433DB
	for <linux-mmc@archiver.kernel.org>; Fri, 12 Feb 2021 13:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1204C64E6C
	for <linux-mmc@archiver.kernel.org>; Fri, 12 Feb 2021 13:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbhBLNQn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 12 Feb 2021 08:16:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbhBLNQf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 12 Feb 2021 08:16:35 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D86C061756
        for <linux-mmc@vger.kernel.org>; Fri, 12 Feb 2021 05:15:54 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id v24so13022856lfr.7
        for <linux-mmc@vger.kernel.org>; Fri, 12 Feb 2021 05:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kNfUMwXJsoKHQeXptuNd1laxxutYEsENQDplczxMvTQ=;
        b=U9kMLvw3+66zo/Cb7/7B/Wi9DPJ1U99GxpEBsXoOmEJprfaYXcEgHpkmqKQ0rr6d2y
         0j2RpI96LKVXj13MN/JKUC/Z54BVszxQMLKZp/kXlAf9Q+Ty8/TwO52jwvaK9MEUSbjw
         evQ8U9UqkwwsH3cO2AlIIkPDN6558cjFCzMhdcn8bRVOfdN+MO19R4qG0nBrklS/ghbq
         admRir1yUYAxvX5JugAavEEUJdDCMvYlu9J7AcgPD9gjd6TNFWrHlxFuQPuboPKabObG
         FOvbvsizTmCJETdlac9jL34X41zzPtMpdgE5H8UsqaiVeeb7FtnwmZVrc5/PwbB47hPc
         T5Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kNfUMwXJsoKHQeXptuNd1laxxutYEsENQDplczxMvTQ=;
        b=pzQUwQpaKRUbLZ7KTywYTz+Gb6wFuQnXgxhBfghaz1soiH5BF3JA9WiLAlrL6NwDym
         HR7qmOlD3wKgFjNEU9nTtbAuOBQUyk9pPI5gC3DzpVZ3UhlIOc/HnEFGedQEyYsvnGzF
         WhDkx+zdbqvItSGYc2Wv+WA6FivyTvqdVOvFliXetuOUjvvcFA5NZJ4p7mCFrpWSMxVx
         ReFez5iFXveXS+YEFetooDBSCbCdepLB0gXd0FoSmt2K1fnv5M0kDg0yuF959QZTzNmG
         QxKMRLyUUI5W98suCZLgubqdweKubTGjNH1p20M8Ta+bDmZAqDisOdy+SxMcDeHs57bL
         KMlA==
X-Gm-Message-State: AOAM5338uwZFzkZeqp2NJZRcX6yzaSHgpKOQxo+WTPE4wr8myDxIWYj4
        xTisX5axaXr1r67hu2j2fz5Tsao8RmOwFphB
X-Google-Smtp-Source: ABdhPJyxYldTkDjFUhavPJDFmo5SZNs+btDvyxYX7E1iHc4y/uxolj8FTbGLfyHIHdOMV46UosYMog==
X-Received: by 2002:a19:78a:: with SMTP id 132mr1505818lfh.382.1613135752096;
        Fri, 12 Feb 2021 05:15:52 -0800 (PST)
Received: from localhost.localdomain (h-98-128-181-28.NA.cust.bahnhof.se. [98.128.181.28])
        by smtp.gmail.com with ESMTPSA id w21sm971448lfu.132.2021.02.12.05.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 05:15:50 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Pierre Ossman <pierre@ossman.eu>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mmc: core: Drop superfluous validations in mmc_hw|sw_reset()
Date:   Fri, 12 Feb 2021 14:15:32 +0100
Message-Id: <20210212131532.236775-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <p2/0002-mmc-core-Drop-reference-counting-of-the-bus_ops.patch>
References: <p2/0002-mmc-core-Drop-reference-counting-of-the-bus_ops.patch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The mmc_hw|sw_reset() APIs are designed to be called solely from upper
layers, which means drivers that operates on top of the struct mmc_card,
like the mmc block device driver and an SDIO functional driver.

Additionally, as long as the struct mmc_host has a valid pointer to a
struct mmc_card, the corresponding host->bus_ops pointer stays valid and
assigned.

For these reasons, let's drop the superfluous reference counting and the
redundant validations in mmc_hw|sw_reset().

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Note, ideally mmc_hw|sw_reset() shall be converted to take a struct mmc_card*
as an in-parameter, rather than the current struct mmc_host*, but that is left
to a future/separate change.

---
 drivers/mmc/core/block.c |  2 +-
 drivers/mmc/core/core.c  | 21 +--------------------
 2 files changed, 2 insertions(+), 21 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index b877f62df366..b7d3f5a73388 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -947,7 +947,7 @@ static int mmc_blk_reset(struct mmc_blk_data *md, struct mmc_host *host,
 	md->reset_done |= type;
 	err = mmc_hw_reset(host);
 	/* Ensure we switch back to the correct partition */
-	if (err != -EOPNOTSUPP) {
+	if (err) {
 		struct mmc_blk_data *main_md =
 			dev_get_drvdata(&host->card->dev);
 		int part_err;
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 1136b859ddd8..2e41fa598bd6 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2080,18 +2080,7 @@ int mmc_hw_reset(struct mmc_host *host)
 {
 	int ret;
 
-	if (!host->card)
-		return -EINVAL;
-
-	mmc_bus_get(host);
-	if (!host->bus_ops || host->bus_dead || !host->bus_ops->hw_reset) {
-		mmc_bus_put(host);
-		return -EOPNOTSUPP;
-	}
-
 	ret = host->bus_ops->hw_reset(host);
-	mmc_bus_put(host);
-
 	if (ret < 0)
 		pr_warn("%s: tried to HW reset card, got error %d\n",
 			mmc_hostname(host), ret);
@@ -2104,18 +2093,10 @@ int mmc_sw_reset(struct mmc_host *host)
 {
 	int ret;
 
-	if (!host->card)
-		return -EINVAL;
-
-	mmc_bus_get(host);
-	if (!host->bus_ops || host->bus_dead || !host->bus_ops->sw_reset) {
-		mmc_bus_put(host);
+	if (!host->bus_ops->sw_reset)
 		return -EOPNOTSUPP;
-	}
 
 	ret = host->bus_ops->sw_reset(host);
-	mmc_bus_put(host);
-
 	if (ret)
 		pr_warn("%s: tried to SW reset card, got error %d\n",
 			mmc_hostname(host), ret);
-- 
2.25.1

