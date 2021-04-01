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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F156C433B4
	for <linux-mmc@archiver.kernel.org>; Thu,  1 Apr 2021 17:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0ACD8610D2
	for <linux-mmc@archiver.kernel.org>; Thu,  1 Apr 2021 17:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234406AbhDARsa (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 1 Apr 2021 13:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235282AbhDARq0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Apr 2021 13:46:26 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C05C08EA72;
        Thu,  1 Apr 2021 06:29:05 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id kt15so2853382ejb.12;
        Thu, 01 Apr 2021 06:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oae4ls4BhwnbmVn/1Lh6LcnL14vfnBaIytV3du8Rujk=;
        b=VYTo7HseSWsBQLyvUd7Iu017MMZOPuzh8TeFsU0W24YQDYEygsl8zouH2Km+H5v8J6
         ay05F6+QBHlFNxiTsR6gmT3BV1JV1kImfnNWbT5Lks2bfSwfHLDw6bJUfE3+8PErEerM
         hgUlTp4HOAROQXeJUuN+WJFcILkKTZ/KIxzqCmjh8scWG/GaoLvSEpHr10blUpCfzLte
         e5sgRZKAdyC9Hg9HomiPwd510wYCjiSOCUXiOKwNNgtjWuKxblkVmT/3cbAGH3QkUwf7
         GuylkYFFXiutJz/RmEgb7VGcbWYDHZm3IkUTjngcD7G0JftUYScbpp9Hv7itGMFskUGA
         w7xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oae4ls4BhwnbmVn/1Lh6LcnL14vfnBaIytV3du8Rujk=;
        b=eTjR9DbzXfPM331O4syHDorw3sOg2DxfJlIusszruyZtHw8qxnWeZraoFl/UaTCBH9
         AHzVVq+1F3jXXktzbo/9iJqJYMtfTbuNMXu+F1e5UZ6ZSzYSsN1nksTruS0+8qwbsBEa
         oHNILnGrwCP0BNJfdwKSa6BeeTR5LLOGTp24TvDKacItKs/T6uAKXS3smoKo4xvUEjMb
         AP/gZ4Zb0lOBoFDiQSP8Ch1AqxtKraqyZHCGiQx5sSoTf2gr1YFCCrbY+QgCPvysAzYs
         ye5oTJnzKDRq1+nMI+W7iY2gOBQ3PiymRNlBROHtvvihBvDXcUhPBegm60XDtmOSlPJb
         7yXQ==
X-Gm-Message-State: AOAM5334xpz7p3lZqKIW/r1TT7veK2TJhZ54NIYdcK/TDShDEcnjjNvq
        08DAcq5bNTjfb0t5Y6An+CI=
X-Google-Smtp-Source: ABdhPJz25tOy2sqcUWqCR9fOAwcYwyHVph0hSckovigQCs6mgZ9r6xWWYbwu2Q0QnCLAAaUi8NY3uw==
X-Received: by 2002:a17:906:948d:: with SMTP id t13mr8861426ejx.402.1617283744008;
        Thu, 01 Apr 2021 06:29:04 -0700 (PDT)
Received: from localhost.localdomain (ip5f5bec5d.dynamic.kabel-deutschland.de. [95.91.236.93])
        by smtp.gmail.com with ESMTPSA id cf4sm3488399edb.19.2021.04.01.06.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 06:29:03 -0700 (PDT)
From:   Bean Huo <huobean@gmail.com>
To:     ulf.hansson@linaro.org, yoshihiro.shimoda.uh@renesas.com,
        wsa+renesas@sang-engineering.com, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bean Huo <beanhuo@micron.com>
Subject: [PATCH v2 1/2] mmc: core: Let sanitize timeout readable/writable via sysfs
Date:   Thu,  1 Apr 2021 15:28:52 +0200
Message-Id: <20210401132853.105448-2-huobean@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210401132853.105448-1-huobean@gmail.com>
References: <20210401132853.105448-1-huobean@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

As the density increases, the 4-minute timeout value for
sanitize is no longer feasible. At the same time, devices
of different densities have different timeout values, and it is
difficult to obtain a unified standard timeout value. Therefore,
it is better to let the user explicitly change  sanitize timeout
value according to the eMMC density on the board.

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 drivers/mmc/core/mmc.c     | 34 ++++++++++++++++++++++++++++++++++
 drivers/mmc/core/mmc_ops.c |  3 +--
 include/linux/mmc/card.h   |  1 +
 3 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 8741271d3971..3885cc1780ac 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -28,6 +28,7 @@
 
 #define DEFAULT_CMD6_TIMEOUT_MS	500
 #define MIN_CACHE_EN_TIMEOUT_MS 1600
+#define MMC_SANITIZE_TIMEOUT_MS	(240 * 1000) /* 240s */
 
 static const unsigned int tran_exp[] = {
 	10000,		100000,		1000000,	10000000,
@@ -835,6 +836,37 @@ static ssize_t mmc_dsr_show(struct device *dev,
 
 static DEVICE_ATTR(dsr, S_IRUGO, mmc_dsr_show, NULL);
 
+static ssize_t sanitize_timeout_ms_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct mmc_card *card = mmc_dev_to_card(dev);
+
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
@@ -861,6 +893,7 @@ static struct attribute *mmc_std_attrs[] = {
 	&dev_attr_rca.attr,
 	&dev_attr_dsr.attr,
 	&dev_attr_cmdq_en.attr,
+	&dev_attr_sanitize_timeout_ms.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(mmc_std);
@@ -1623,6 +1656,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
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

