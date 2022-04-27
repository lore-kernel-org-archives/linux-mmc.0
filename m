Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F53AC433F5
	for <linux-mmc@archiver.kernel.org>; Wed, 27 Apr 2022 12:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235101AbiD0NBN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 27 Apr 2022 09:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234956AbiD0NBN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Apr 2022 09:01:13 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053912C4A6D
        for <linux-mmc@vger.kernel.org>; Wed, 27 Apr 2022 05:58:02 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id p12so2994737lfs.5
        for <linux-mmc@vger.kernel.org>; Wed, 27 Apr 2022 05:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X80gnM4oc5KK6p9tJPUWOtoPo8Q+cREOs7ydgjCCrlg=;
        b=vcVCj1F3AYmY4zRPzvewZRkxjbHII34wH69ltcp0rxebFsPr40kqCSfQIvzOCOnquj
         3rKtdYHv34EAogMkVBvRxiYDzUXwnXKkEI/Yenhd+s1KP66WPtCo6ls2ld1V4BzHM0nb
         1tcMaBn9h87kVzEeEkypgYPww5GBVfQZ8+noUo7szvJtFyxfI7sA2gXI55LKFFz1xM/h
         zzfVhDq+W9FJbL92fl6DxrLd51uF8i/e6uF/sXhr4E4dvsuqGDc37hacoCpo7hi1Y4gC
         wSnU/pQxtb6iUZnTjbRtMWL7Fmqhu2Z6GWpdIt1c0Lq3z0gyPTl3WVwkg7hrLaePv6Cf
         9i4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X80gnM4oc5KK6p9tJPUWOtoPo8Q+cREOs7ydgjCCrlg=;
        b=NsFJMeHsvjHr7UHnIHDn3n5khicdnvZEixZGj6UzHVPwn760IS3uUJqOJvDjlGUkGy
         N5dCfuV4Dcq3WHV2g84dIRsEGJQHbnS+HVTjcoi5W4z38aBNm9kdvb8rB6B77YuZJU1J
         pMjfP4albvu0rlTQcoqcgKsdmP5LpqFmRjLXncv3QPX1g5dl5AA1skcmiD9sosn+C1c7
         s2Ad4oWrhmEa160PHDdCfe4SIIFE/xAxut/9PNMr3ok8BBVAhWEO57OwcXKMpEqhZU/x
         N7G7Ey07CVPW/pUTLlGKSoK+EzFXur3JJstklRAbcFz7Ub1XTPcfgupOq4s7fnQ00HZp
         +y1g==
X-Gm-Message-State: AOAM531u2cBkZAPmf8BN1Gn0Njc9gjfVv7RMrpTMfFQ8NG/iSP01IY55
        BQuFG4M7d2TIjfLdoPy6g4xKL62Hmu5GJQ==
X-Google-Smtp-Source: ABdhPJyeXv6CZSm1tuf6L/iDUEpGVNI7lWVPhM7LwreXrFqlSPTcAyfLvfUqUHcFmhTlQcaAijL5HQ==
X-Received: by 2002:a05:6512:332d:b0:472:9a2:6e27 with SMTP id l13-20020a056512332d00b0047209a26e27mr10310417lfe.611.1651064279955;
        Wed, 27 Apr 2022 05:57:59 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id x7-20020a056512046700b0047201f1343asm1225659lfd.258.2022.04.27.05.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 05:57:59 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] mmc: mmci: Remove custom ios handler
Date:   Wed, 27 Apr 2022 14:55:57 +0200
Message-Id: <20220427125557.1608825-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The custom boardfile ios handler isn't used anywhere in the
kernel. Delete it.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/mmci.c   | 4 ----
 include/linux/amba/mmci.h | 6 ------
 2 files changed, 10 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index f3cf3152a397..01159eaf8694 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1748,10 +1748,6 @@ static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	unsigned long flags;
 	int ret;
 
-	if (host->plat->ios_handler &&
-		host->plat->ios_handler(mmc_dev(mmc), ios))
-			dev_err(mmc_dev(mmc), "platform ios_handler failed\n");
-
 	switch (ios->power_mode) {
 	case MMC_POWER_OFF:
 		if (!IS_ERR(mmc->supply.vmmc))
diff --git a/include/linux/amba/mmci.h b/include/linux/amba/mmci.h
index c92ebc39fc1f..6f96dc2209c0 100644
--- a/include/linux/amba/mmci.h
+++ b/include/linux/amba/mmci.h
@@ -13,17 +13,11 @@
  * @ocr_mask: available voltages on the 4 pins from the block, this
  * is ignored if a regulator is used, see the MMC_VDD_* masks in
  * mmc/host.h
- * @ios_handler: a callback function to act on specfic ios changes,
- * used for example to control a levelshifter
- * mask into a value to be binary (or set some other custom bits
- * in MMCIPWR) or:ed and written into the MMCIPWR register of the
- * block.  May also control external power based on the power_mode.
  * @status: if no GPIO line was given to the block in this function will
  * be called to determine whether a card is present in the MMC slot or not
  */
 struct mmci_platform_data {
 	unsigned int ocr_mask;
-	int (*ios_handler)(struct device *, struct mmc_ios *);
 	unsigned int (*status)(struct device *);
 };
 
-- 
2.35.1

