Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B1DC433DB
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Feb 2021 00:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C83D564DC4
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Feb 2021 00:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbhBOAdf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 14 Feb 2021 19:33:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbhBOAde (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 14 Feb 2021 19:33:34 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B64C061574
        for <linux-mmc@vger.kernel.org>; Sun, 14 Feb 2021 16:32:54 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id b14so2587123eju.7
        for <linux-mmc@vger.kernel.org>; Sun, 14 Feb 2021 16:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=PO9xITa8m86XY7L90MwQMdUAFlWh0K6Ens06FizbCYw=;
        b=B80pB9V5LpSAc6RK4tiokT7ZqxJk9QVsetfWHZA1AV+d6hLQ56txjD1BTCcsAT13f1
         kdFgvGXsmcD34Wfu+oFzPJ8ualkE8C2AXQ/mpD1hpJYdT8Z8LSQmtWTODgxGcHdCDCPZ
         zdWVkUhQdqMBCBdj18bCwuylk2q3u7fJc5JyLb0iMAlAcwyatx1okxeADJkB6z5LH1Xa
         AKBteirTy9eu4o3VvMr1Uo72/Zy+OfbZIGzHKsz1OpDh10d3+8rDChIm+T7iqVBtDjAD
         RofdtkOLuNAX4J8jrs5wudT7bMWSGD5Mpus2pfUGGIx4MR2qrSjSYxg1Ew6hPCtHGe7V
         l4IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=PO9xITa8m86XY7L90MwQMdUAFlWh0K6Ens06FizbCYw=;
        b=PSb5YYK6hFCNnHgMlLHqdZo+nSmXG0fX8bSXJAytycPTf9hM7yK00itltpmrXHWmL8
         KymG+JMCGJzOdcZkPd36oPgg+QSAGmtFlc907ntcO2jTr9VK3HnQt8vBw37uN3yYK+3P
         wZGxmlIqs2c9t/I1ZNDFK0gZIi/39/kKmcGfq5Rq3fSVd9qgQb8ZP0B+VNZUasv/BPCU
         Hsmj7/pOX7fuVTp9N7odFQuIowpmyYphpscOGE0/ONStZYmUAp6ioTlxHSQjFYLgOeGO
         rp32XGZa4iB9hfsgrgVSTg/6K0FnqHv3F/o85vDU4o/5OylCtWMkHqFcJKdgscTS1mee
         wbOQ==
X-Gm-Message-State: AOAM532Q7JF/3DqhIVB3a4R8ZDGW/2iXkd3l+W9Gsyzhg6p8z/yQ2XL9
        olnHBoBe4mJudEwQ4hsTcKJMFxOeH68=
X-Google-Smtp-Source: ABdhPJwKzs3SqOAwJR0Bi5y9cgyb6fgZsAoJT6m4S8QPkA7N4dCnY/Le0D+kT676Hsh9GK8qLWR7QA==
X-Received: by 2002:a17:906:311b:: with SMTP id 27mr12400929ejx.7.1613349172804;
        Sun, 14 Feb 2021 16:32:52 -0800 (PST)
Received: from lupo-laptop (host-79-32-153-26.retail.telecomitalia.it. [79.32.153.26])
        by smtp.gmail.com with ESMTPSA id f11sm876969eje.107.2021.02.14.16.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Feb 2021 16:32:52 -0800 (PST)
From:   Luca Porzio <porzio@gmail.com>
X-Google-Original-From: Luca Porzio <lporzio@micron.com>
Date:   Mon, 15 Feb 2021 01:32:51 +0100
To:     linux-mmc@vger.kernel.org
Cc:     Zhan Liu <zliua@micron.com>, Luca Porzio <lporzio@micron.com>
Subject: [RFC PATCH 2/2] Make cmdq_en attribute writeable
Message-ID: <20210215003249.GA12303@lupo-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

cmdq_en attribute in sysfs now can now be written.
When 0 is written:
  CMDQ is disabled and kept disabled across device reboots.
When 1 is written:
  CMDQ mode is instantly reneabled (if supported).

Signed-off-by: Luca Porzio <lporzio@micron.com>
Signed-off-by: Zhan Liu <zliua@micron.com>
---
 drivers/mmc/core/mmc.c   | 152 ++++++++++++++++++++++++++++++---------
 include/linux/mmc/card.h |   1 +
 2 files changed, 118 insertions(+), 35 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 0d80b72ddde8..5c7d5bac5c00 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -794,7 +794,120 @@ MMC_DEV_ATTR(enhanced_rpmb_supported, "%#x\n",
 MMC_DEV_ATTR(rel_sectors, "%#x\n", card->ext_csd.rel_sectors);
 MMC_DEV_ATTR(ocr, "0x%08x\n", card->ocr);
 MMC_DEV_ATTR(rca, "0x%04x\n", card->rca);
-MMC_DEV_ATTR(cmdq_en, "%d\n", card->ext_csd.cmdq_en);
+
+
+/* Setup command queue mode and CQE if underling hw supports it
+ * and assuming force_disable_cmdq has not been set.
+ */
+static int mmc_cmdq_setup(struct mmc_host *host, struct mmc_card *card)
+{
+	int err;
+
+	/* Check HW support */
+	if (!card->ext_csd.cmdq_support || !(host->caps2 & MMC_CAP2_CQE))
+		card->force_disable_cmdq = true;
+
+	/* Enable/Disable  CMDQ mode */
+	if (!card->ext_csd.cmdq_en && !card->force_disable_cmdq) {
+		err = mmc_cmdq_enable(card);
+		if (err && err != -EBADMSG)
+			return err;
+		if (err) {
+			pr_warn("%s: Enabling CMDQ failed\n",
+			    mmc_hostname(card->host));
+			card->ext_csd.cmdq_support = false;
+			card->ext_csd.cmdq_depth = 0;
+		}
+
+	} else if (card->ext_csd.cmdq_en && card->force_disable_cmdq) {
+		err = mmc_cmdq_disable(card);
+		if (err) {
+			pr_warn("%s: Disabling CMDQ failed, error %d\n",
+			    mmc_hostname(card->host), err);
+			err = 0;
+		}
+	}
+
+	/*
+	 * In some cases (e.g. RPMB or mmc_test), the Command Queue must be
+	 * disabled for a time, so a flag is needed to indicate to re-enable the
+	 * Command Queue.
+	 */
+	card->reenable_cmdq = card->ext_csd.cmdq_en;
+
+	/* Enable/Disable Host CQE */
+	if (!card->force_disable_cmdq) {
+
+		if (host->cqe_ops && !host->cqe_enabled) {
+			err = host->cqe_ops->cqe_enable(host, card);
+			if (!err) {
+				host->cqe_enabled = true;
+
+				if (card->ext_csd.cmdq_en) {
+					pr_info("%s: Command Queue Engine enabled\n",
+					    mmc_hostname(host));
+				} else {
+					host->hsq_enabled = true;
+					pr_info("%s: Host Software Queue enabled\n",
+					    mmc_hostname(host));
+				}
+			}
+		}
+
+	} else {
+
+		if (host->cqe_enabled) {
+			host->cqe_ops->cqe_disable(host);
+			host->cqe_enabled = false;
+			pr_info("%s: Command Queue Engine disabled\n",
+			    mmc_hostname(host));
+		}
+
+		host->hsq_enabled = false;
+		err = 0;
+	}
+
+	return err;
+}
+
+
+static ssize_t cmdq_en_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct mmc_card *card = mmc_dev_to_card(dev);
+
+	return sprintf(buf, "%d\n", card->ext_csd.cmdq_en);
+}
+
+static ssize_t cmdq_en_store(struct device *dev, struct device_attribute *attr,
+				 const char *buf, size_t count)
+{
+	struct mmc_card *card = mmc_dev_to_card(dev);
+	struct mmc_host *host = card->host;
+	unsigned long enable;
+	int err;
+
+	if (!card || kstrtoul(buf, 0, &enable))
+		return -EINVAL;
+	if (!card->ext_csd.cmdq_support)
+		return -EOPNOTSUPP;
+
+	enable = !!enable;
+	if (enable == card->ext_csd.cmdq_en)
+		return count;
+
+	mmc_get_card(card, NULL);
+	card->force_disable_cmdq = !enable;
+	err = mmc_cmdq_setup(host, card);
+	mmc_put_card(card, NULL);
+
+	if (err)
+		return err;
+	else
+		return count;
+}
+
+static DEVICE_ATTR_RW(cmdq_en);
+
 
 static ssize_t mmc_fwrev_show(struct device *dev,
 			      struct device_attribute *attr,
@@ -1838,40 +1951,9 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	 * Enable Command Queue if supported. Note that Packed Commands cannot
 	 * be used with Command Queue.
 	 */
-	card->ext_csd.cmdq_en = false;
-	if (card->ext_csd.cmdq_support && host->caps2 & MMC_CAP2_CQE) {
-		err = mmc_cmdq_enable(card);
-		if (err && err != -EBADMSG)
-			goto free_card;
-		if (err) {
-			pr_warn("%s: Enabling CMDQ failed\n",
-				mmc_hostname(card->host));
-			card->ext_csd.cmdq_support = false;
-			card->ext_csd.cmdq_depth = 0;
-		}
-	}
-	/*
-	 * In some cases (e.g. RPMB or mmc_test), the Command Queue must be
-	 * disabled for a time, so a flag is needed to indicate to re-enable the
-	 * Command Queue.
-	 */
-	card->reenable_cmdq = card->ext_csd.cmdq_en;
-
-	if (host->cqe_ops && !host->cqe_enabled) {
-		err = host->cqe_ops->cqe_enable(host, card);
-		if (!err) {
-			host->cqe_enabled = true;
-
-			if (card->ext_csd.cmdq_en) {
-				pr_info("%s: Command Queue Engine enabled\n",
-					mmc_hostname(host));
-			} else {
-				host->hsq_enabled = true;
-				pr_info("%s: Host Software Queue enabled\n",
-					mmc_hostname(host));
-			}
-		}
-	}
+	err = mmc_cmdq_setup(host, card);
+	if (err)
+		goto free_card;
 
 	if (host->caps2 & MMC_CAP2_AVOID_3_3V &&
 	    host->ios.signal_voltage == MMC_SIGNAL_VOLTAGE_330) {
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index f9ad35dd6012..e554bb0cf722 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -272,6 +272,7 @@ struct mmc_card {
 #define MMC_QUIRK_BROKEN_HPI	(1<<13)		/* Disable broken HPI support */
 
 	bool			reenable_cmdq;	/* Re-enable Command Queue */
+	bool			force_disable_cmdq; /* Keep Command Queue disabled */
 
 	unsigned int		erase_size;	/* erase size in sectors */
  	unsigned int		erase_shift;	/* if erase unit is power 2 */
-- 
2.17.1

