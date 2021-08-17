Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A221C19F3A
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Aug 2021 22:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A38C6103A
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Aug 2021 22:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236413AbhHQWn0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 17 Aug 2021 18:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236375AbhHQWnZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Aug 2021 18:43:25 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101F6C061764;
        Tue, 17 Aug 2021 15:42:51 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id u16so400105wrn.5;
        Tue, 17 Aug 2021 15:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ffflbpl+4vtDALct8DDSj0ySXf+/wPRBLjk61pGOG1w=;
        b=Ngvmipbl4OXygdD1yplC0sSm51ZAMsBofymYRUIPI2R5/G56v7rAZxIlQqxaM1QUSb
         KeutvoaEJSimT+0h49TYh2CLmJGYeC3wwERvMdNpaT31Xy7VZ9qTbVLBP+VT101XCzA+
         ifPzbEGGiq3jqn7AoFLQVSYACS/qdAsooibXevuNS4JqvpzwLg6N4x7NrG8q2m0znw/s
         OpzzVDvPTizPq0R9Wo/CfmFcHVGBkeYkCXMtfdqS5BlClHwtPAQfvzz4dNa1xn1ZBmPk
         FEFPATFwPn3xUeAYRANhcIFhTq8Y/f4UXQU50Oh8oPB2J0mciiDg5SwN/nXsWSm8Jiyk
         8jcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ffflbpl+4vtDALct8DDSj0ySXf+/wPRBLjk61pGOG1w=;
        b=S2YPee99Ym7YLxrx9Ejvj5Cx4GcE5ajyPDla/7+FdYEzH77mcy+8yD6LjLV912thLk
         9rtPn+1iYNPh2NXi1WdC7Rza8AOM086nDXsj96Gz+aClLmoiZBhrTTRfz/DNWzM0Mr9n
         JUloDstuLZMV5l/ajn7qo8bvZkqYjXkYhfnxhrjRJDbstR1k0lCYK29tOieazF7O6wAK
         4XQJaiUARdSaj/VLZxCSomBbwHbN6oZKs8ATwjfmzlmnNiHdyjDaVHvPNAMTILzFi+lx
         Lu77Xv3JIyQ6gPUOSlGYC49bsyQUugSoBw3hymrHvjN2mLTTFXcN8qPeKImGXb7SPBRU
         A11w==
X-Gm-Message-State: AOAM531InXt3nF4dZaYc1UyYIGDsFWzx/qAVUasDxQnRD8DIx6F+5mDG
        hqFarev2NSBUxIyv/4YtZho=
X-Google-Smtp-Source: ABdhPJymxKM0HD6Y5FZpwLInrie03xLslp+zG0y0kBWFiQUF1syuqhv40A8fK0dtFAibk5Y8AsvAAw==
X-Received: by 2002:adf:c681:: with SMTP id j1mr6682332wrg.119.1629240169686;
        Tue, 17 Aug 2021 15:42:49 -0700 (PDT)
Received: from localhost.localdomain (ip5f5bec31.dynamic.kabel-deutschland.de. [95.91.236.49])
        by smtp.gmail.com with ESMTPSA id a3sm3976850wrx.38.2021.08.17.15.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 15:42:49 -0700 (PDT)
From:   Bean Huo <huobean@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bean Huo <beanhuo@micron.com>
Subject: [PATCH v1 2/2] mmc: core: Let BKOPS timeout readable/writable via sysfs
Date:   Wed, 18 Aug 2021 00:42:08 +0200
Message-Id: <20210817224208.153652-3-huobean@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210817224208.153652-1-huobean@gmail.com>
References: <20210817224208.153652-1-huobean@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

For special cases, the application in the userspace wants to change
BKOPS operation timeout value, also, wants eMMC back to R1_STATE_TRAN
after BKOPS timeouts. A fixed BKOPS timeout value(120s) is no longer
feasible, therefore, it is better to let the user controls its timeout
value.

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 drivers/mmc/core/mmc.c     | 32 ++++++++++++++++++++++++++++++++
 drivers/mmc/core/mmc_ops.c |  3 +--
 include/linux/mmc/card.h   |  1 +
 3 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 838726b68ff3..617ff18b5b0e 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -29,6 +29,7 @@
 #define DEFAULT_CMD6_TIMEOUT_MS	500
 #define MIN_CACHE_EN_TIMEOUT_MS 1600
 #define CACHE_FLUSH_TIMEOUT_MS 30000 /* 30s */
+#define MMC_BKOPS_TIMEOUT_MS	(120 * 1000) /* 120s */
 
 static const unsigned int tran_exp[] = {
 	10000,		100000,		1000000,	10000000,
@@ -836,6 +837,35 @@ static ssize_t mmc_dsr_show(struct device *dev,
 
 static DEVICE_ATTR(dsr, S_IRUGO, mmc_dsr_show, NULL);
 
+static ssize_t bkops_timeout_ms_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct mmc_card *card = mmc_dev_to_card(dev);
+	return sysfs_emit(buf, "%d\n", card->bkops_timeout_ms);
+}
+
+static ssize_t bkops_timeout_ms_store(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf, size_t len)
+{
+	struct mmc_card *card = mmc_dev_to_card(dev);
+	unsigned int new;
+	int ret;
+
+	ret = kstrtouint(buf, 0, &new);
+	if (ret < 0)
+		return ret;
+
+	if (new == 0)
+		return -EINVAL;
+
+	card->bkops_timeout_ms = new;
+
+	return len;
+}
+
+static DEVICE_ATTR_RW(bkops_timeout_ms);
+
 static struct attribute *mmc_std_attrs[] = {
 	&dev_attr_cid.attr,
 	&dev_attr_csd.attr,
@@ -862,6 +892,7 @@ static struct attribute *mmc_std_attrs[] = {
 	&dev_attr_rca.attr,
 	&dev_attr_dsr.attr,
 	&dev_attr_cmdq_en.attr,
+	&dev_attr_bkops_timeout_ms.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(mmc_std);
@@ -1624,6 +1655,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 		card->ocr = ocr;
 		card->type = MMC_TYPE_MMC;
 		card->rca = 1;
+		card->bkops_timeout_ms = MMC_BKOPS_TIMEOUT_MS;
 		memcpy(card->raw_cid, cid, sizeof(card->raw_cid));
 	}
 
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 0c54858e89c0..9af5e4671de2 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -19,7 +19,6 @@
 #include "host.h"
 #include "mmc_ops.h"
 
-#define MMC_BKOPS_TIMEOUT_MS		(120 * 1000) /* 120s */
 #define MMC_SANITIZE_TIMEOUT_MS		(240 * 1000) /* 240s */
 
 static const u8 tuning_blk_pattern_4bit[] = {
@@ -958,7 +957,7 @@ void mmc_run_bkops(struct mmc_card *card)
 	 * urgent levels by using an asynchronous background task, when idle.
 	 */
 	err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
-			 EXT_CSD_BKOPS_START, 1, MMC_BKOPS_TIMEOUT_MS);
+			 EXT_CSD_BKOPS_START, 1, card->bkops_timeout_ms);
 	/*
 	 * If the BKOPS timed out, the card is probably still busy in the
 	 * R1_STATE_PRG. Rather than continue to wait, let's try to abort
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 74e6c0624d27..9e038d212067 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -294,6 +294,7 @@ struct mmc_card {
 
 	bool			reenable_cmdq;	/* Re-enable Command Queue */
 
+	unsigned int            bkops_timeout_ms;
 	unsigned int		erase_size;	/* erase size in sectors */
  	unsigned int		erase_shift;	/* if erase unit is power 2 */
  	unsigned int		pref_erase;	/* in sectors */
-- 
2.25.1

