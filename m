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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 745C0C433ED
	for <linux-mmc@archiver.kernel.org>; Thu,  1 Apr 2021 18:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43F0A601FC
	for <linux-mmc@archiver.kernel.org>; Thu,  1 Apr 2021 18:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234914AbhDAS1W (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 1 Apr 2021 14:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237207AbhDASNs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Apr 2021 14:13:48 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF08C0610E0;
        Thu,  1 Apr 2021 05:43:55 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id u9so2665115ejj.7;
        Thu, 01 Apr 2021 05:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lcEuUjal7BUJYrQNsQV7J457GVK5iZ7rvTt0MXCe5+Q=;
        b=rlZS0vfzuisrsC0sE4xGWumAmDHrQ6etsWS90ZaIJslYpZfo6nFbCEdDy9xtu6eESC
         6M+oqk1CgMA7FVQVZbemeodBX4f9+NVQLE4a2mIpJ34PXtej7Dsinby2fUGJAxfe46R5
         LmPjgj4N27/YA+3buMUAh34HKh1UXr3gBBA5f8ECdJavkk2QFkQQjs8s3oxzTJeUPUxh
         6Z9cpupZf55VP/Mzgxu3Z3mIGPmjyslUu8F95cbtdlAf5rBvG001MWNA9q+oLfZZlik4
         zKnERHRC5m/jzQijpIg4APaPjFT6Udjrx89Pk7+UCXn40ygCQqMAA4/HIAs/Kt6h7PTO
         ZQJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lcEuUjal7BUJYrQNsQV7J457GVK5iZ7rvTt0MXCe5+Q=;
        b=tXJDJbNT12Onmscoyl+wdx/FXRONAhQzZihk9G62QsPgOUMO/tRDqr4fCfNg8BrDQ6
         L2r+etA3co/DIE/4hM6l7S5W8sQjXb4qeujfgplM/eWwf56UFl9daQ0n6Ev+obEBpLrm
         609032QvHnnthYQ7ZsAb0SSb8bvbGN5PLO9fZrP5cwpOX6pO/xMoaBVWmtUqNIINzyq8
         whF89NtakB5hZR0ltGslFcraa/FnMPFV5UZ8aGhdz/+JFd5XvBbnyOGEWi8+bqY2zKB4
         RXGV43vmnHCQffCBjzgNrmjru9wy8edB6rUhva01GnmnE4N2OMH05xFvJGL3D/VmW6w4
         +kGQ==
X-Gm-Message-State: AOAM532VcUO9jAcRem1Ly8XtptecXrJHNFwV9v4O8tFyeYl/EA5RFBg4
        EHf9YJ2FHtIZpbXqA+e5ry8=
X-Google-Smtp-Source: ABdhPJzh2FdSgrW53c8lzHBZm4eQi/j46u2X1Xif3YbuJrWU72pOfoKnRuzgE/PwPK6Yvy8jZt38Ow==
X-Received: by 2002:a17:906:7c57:: with SMTP id g23mr8694125ejp.195.1617281034028;
        Thu, 01 Apr 2021 05:43:54 -0700 (PDT)
Received: from localhost.localdomain (ip5f5bec5d.dynamic.kabel-deutschland.de. [95.91.236.93])
        by smtp.gmail.com with ESMTPSA id v8sm3469939edq.76.2021.04.01.05.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 05:43:53 -0700 (PDT)
From:   Bean Huo <huobean@gmail.com>
To:     ulf.hansson@linaro.org, yoshihiro.shimoda.uh@renesas.com,
        wsa+renesas@sang-engineering.com, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bean Huo <beanhuo@micron.com>
Subject: [PATCH v1 1/2] mmc: core: Let sanitize timeout readable/writable via sysfs
Date:   Thu,  1 Apr 2021 14:43:42 +0200
Message-Id: <20210401124343.102915-2-huobean@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210401124343.102915-1-huobean@gmail.com>
References: <20210401124343.102915-1-huobean@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

As the density increases, the 4-minute timeout value for
disinfection is no longer feasible. At the same time, devices
of different densities have different timeout values, and it is
difficult to obtain a unified standard timeout value. Therefore,
it is better to let the user controls its cleaning timeout value.

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 drivers/mmc/core/mmc.c     | 33 +++++++++++++++++++++++++++++++++
 drivers/mmc/core/mmc_ops.c |  3 +--
 include/linux/mmc/card.h   |  1 +
 3 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 8741271d3971..4e4b3592d3d6 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -28,6 +28,7 @@
 
 #define DEFAULT_CMD6_TIMEOUT_MS	500
 #define MIN_CACHE_EN_TIMEOUT_MS 1600
+#define MMC_SANITIZE_TIMEOUT_MS	(240 * 1000) /* 240s */
 
 static const unsigned int tran_exp[] = {
 	10000,		100000,		1000000,	10000000,
@@ -835,6 +836,36 @@ static ssize_t mmc_dsr_show(struct device *dev,
 
 static DEVICE_ATTR(dsr, S_IRUGO, mmc_dsr_show, NULL);
 
+static ssize_t sanitize_timeout_ms_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct mmc_card *card = mmc_dev_to_card(dev);
+	return sysfs_emit(buf, "%d\n", card->sanitize_timeout_ms);
+}
+
+static ssize_t sanitize_timeout_ms_store(struct device *dev,
+					 struct device_attribute *attr,
+					 const char *buf, size_t len)
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
+	card->sanitize_timeout_ms = new;
+
+	return len;
+}
+static DEVICE_ATTR_RW(sanitize_timeout_ms);
+
+
 static struct attribute *mmc_std_attrs[] = {
 	&dev_attr_cid.attr,
 	&dev_attr_csd.attr,
@@ -861,6 +892,7 @@ static struct attribute *mmc_std_attrs[] = {
 	&dev_attr_rca.attr,
 	&dev_attr_dsr.attr,
 	&dev_attr_cmdq_en.attr,
+	&dev_attr_sanitize_timeout_ms.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(mmc_std);
@@ -1623,6 +1655,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 		card->ocr = ocr;
 		card->type = MMC_TYPE_MMC;
 		card->rca = 1;
+		card->sanitize_timeout_ms = MMC_SANITIZE_TIMEOUT_MS;
 		memcpy(card->raw_cid, cid, sizeof(card->raw_cid));
 	}
 
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index f413474f0f80..40a4f9e22d30 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -21,7 +21,6 @@
 
 #define MMC_BKOPS_TIMEOUT_MS		(120 * 1000) /* 120s */
 #define MMC_CACHE_FLUSH_TIMEOUT_MS	(30 * 1000) /* 30s */
-#define MMC_SANITIZE_TIMEOUT_MS		(240 * 1000) /* 240s */
 
 static const u8 tuning_blk_pattern_4bit[] = {
 	0xff, 0x0f, 0xff, 0x00, 0xff, 0xcc, 0xc3, 0xcc,
@@ -1025,7 +1024,7 @@ int mmc_sanitize(struct mmc_card *card)
 	mmc_retune_hold(host);
 
 	err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_SANITIZE_START,
-			 1, MMC_SANITIZE_TIMEOUT_MS);
+			 1, card->sanitize_timeout_ms);
 	if (err)
 		pr_err("%s: Sanitize failed err=%d\n", mmc_hostname(host), err);
 
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index f9ad35dd6012..9db0dcd9661e 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -273,6 +273,7 @@ struct mmc_card {
 
 	bool			reenable_cmdq;	/* Re-enable Command Queue */
 
+	unsigned int            sanitize_timeout_ms;
 	unsigned int		erase_size;	/* erase size in sectors */
  	unsigned int		erase_shift;	/* if erase unit is power 2 */
  	unsigned int		pref_erase;	/* in sectors */
-- 
2.25.1

