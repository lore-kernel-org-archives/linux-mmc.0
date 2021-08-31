Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B52C432BE
	for <linux-mmc@archiver.kernel.org>; Tue, 31 Aug 2021 11:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57D7A60F6B
	for <linux-mmc@archiver.kernel.org>; Tue, 31 Aug 2021 11:02:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241124AbhHaLDD (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 31 Aug 2021 07:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbhHaLDD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 31 Aug 2021 07:03:03 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E63BC061575
        for <linux-mmc@vger.kernel.org>; Tue, 31 Aug 2021 04:02:08 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id w19-20020a17090aaf9300b00191e6d10a19so2099106pjq.1
        for <linux-mmc@vger.kernel.org>; Tue, 31 Aug 2021 04:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+xjZYk6uNy4ZGkIZN40uDZFqPEfdCLB0M2J0sE1v5D8=;
        b=DQIGWZo1EJekke7YkCqnCmJgFYrQNxZdr2/VJPB9onVNUpoqPffHqM4CE7vxAPjb7C
         WIGpFvemdaE8C8LS+/qoQDn0bviPUKO72VYxmJ6kNpnacnH8GYg3f1/L8y5bCW1PWXQZ
         P9YOLBttomkctSGAStWoV84q8vmctXwu9YN7K5V+2aKVgJbI2KdjvnIjLfBHh1gT5SnO
         n5+BYVnlHXgKzf+kXWf2OoIHf11pKTLwiuyguwsU8w9fyBGWecamiznzQu+LB6wpqED0
         VaikWcsqQ6XXGQFfRgxZjdCCggVxtoE4Rkg6kjmT6Awhf4mLYlE6ByiRkS083Z/+Ksyc
         yDXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+xjZYk6uNy4ZGkIZN40uDZFqPEfdCLB0M2J0sE1v5D8=;
        b=pfbqXe8v+CaDKL/1+mJt0iaaavy3RoYi/1EeUAy0FKvPBe+x2Qa9T9Yz7i3o8zswPA
         VSnN5snP5p45opdmKbdNQUqlW/zcWpEHQm2qQLj33S3WIAGTQZNk/zAuDPKgPfSsBHP1
         8HyaLtEu/4sfNw4/YNBL8UOWSfxKUWIhB9zS6xDvrzLD3opTk+naXxdPMpWjt7iZVS6r
         CJUjFkuDtL0iM8B6sRAAzSYeq+1a/38ZLJXtQiRSyfBxfo9YPWhmkxoRIMmRGaAlbtw8
         zdB3al45cK72bqeAmJDmOsd+SKeEsOh7u8n2JKqe8LK0yyWbAr9uHSFdcNv7jY/8hOll
         irqQ==
X-Gm-Message-State: AOAM531UsXL3k+8qRYYlBDAE7CZsfvwjyeThNdv+l6oduJA/ec/mvlYD
        WP3h+FXAX2sz7OTfH7hB1jg=
X-Google-Smtp-Source: ABdhPJzJcfMxOoECu9db+pX8n9YjQPO8uZIlHLww17KcYvoAzsO7dmyupJLqx68/vMjiQMNLMvmVtg==
X-Received: by 2002:a17:90a:4285:: with SMTP id p5mr4833238pjg.162.1630407727800;
        Tue, 31 Aug 2021 04:02:07 -0700 (PDT)
Received: from localhost.localdomain (60-251-58-169.HINET-IP.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id q4sm2429546pjd.52.2021.08.31.04.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 04:02:07 -0700 (PDT)
From:   Jason Lai <jasonlai.genesyslogic@gmail.com>
To:     ulf.hansson@linaro.org, takahiro.akashi@linaro.org,
        adrian.hunter@intel.com
Cc:     Jason Lai <jason.lai@genesyslogic.com.tw>,
        linux-mmc@vger.kernel.org, ben.chuang@genesyslogic.com.tw,
        greg.tu@genesyslogic.com.tw
Subject: [PATCH 4/7] mmc: core: Extend support for mmc regulators with a
Date:   Tue, 31 Aug 2021 19:02:03 +0800
Message-Id: <20210831110203.50669-1-jasonlai.genesyslogic@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Jason Lai <jason.lai@genesyslogic.com.tw>

From: Ulf Hansson <ulf.hansson@linaro.org>

To allow an additional external regulator to be controlled by an mmc host
driver, let's add support for a vqmmc2 regulator to the mmc core.

For an SD UHS-II interface the vqmmc2 regulator may correspond to the so
called vdd2 supply, as described by the SD spec. Initially, only 1.8V is
needed, hence limit the new helper function, mmc_regulator_set_vqmmc2() to
this too.

Note that, to allow for flexibility mmc host drivers need to manage the
enable/disable of the vqmmc2 regulator themselves, while the regulator is
looked up through the common mmc_regulator_get_supply().

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/regulator.c | 33 +++++++++++++++++++++++++++++++++
 include/linux/mmc/host.h     |  8 ++++++++
 2 files changed, 41 insertions(+)

diff --git a/drivers/mmc/core/regulator.c b/drivers/mmc/core/regulator.c
index 609201a46..640eb46e8 100644
--- a/drivers/mmc/core/regulator.c
+++ b/drivers/mmc/core/regulator.c
@@ -223,6 +223,32 @@ int mmc_regulator_set_vqmmc(struct mmc_host *mmc, struct mmc_ios *ios)
 }
 EXPORT_SYMBOL_GPL(mmc_regulator_set_vqmmc);
 
+/**
+ * mmc_regulator_set_vqmmc2 - Set vqmmc2 as per the ios->vqmmc2_voltage
+ * @mmc: The mmc host to regulate
+ * @ios: The io bus settings
+ *
+ * Sets a new voltage level for the vqmmc2 regulator, which may correspond to
+ * the vdd2 regulator for an SD UHS-II interface. This function is expected to
+ * be called by mmc host drivers.
+ *
+ * Returns a negative error code on failure, zero if the voltage level was
+ * changed successfully or a positive value if the level didn't need to change.
+ */
+int mmc_regulator_set_vqmmc2(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	if (IS_ERR(mmc->supply.vqmmc2))
+		return -EINVAL;
+
+	switch (ios->vqmmc2_voltage) {
+	case MMC_VQMMC2_VOLTAGE_180:
+		return mmc_regulator_set_voltage_if_supported(
+			mmc->supply.vqmmc2, 1700000, 1800000, 1950000);
+	default:
+		return -EINVAL;
+	}
+}
+EXPORT_SYMBOL_GPL(mmc_regulator_set_vqmmc2);
+
 #else
 
 static inline int mmc_regulator_get_ocrmask(struct regulator *supply)
@@ -249,6 +275,7 @@ int mmc_regulator_get_supply(struct mmc_host *mmc)
 
 	mmc->supply.vmmc = devm_regulator_get_optional(dev, "vmmc");
 	mmc->supply.vqmmc = devm_regulator_get_optional(dev, "vqmmc");
+	mmc->supply.vqmmc2 = devm_regulator_get_optional(dev, "vqmmc2");
 
 	if (IS_ERR(mmc->supply.vmmc)) {
 		if (PTR_ERR(mmc->supply.vmmc) == -EPROBE_DEFER)
@@ -268,6 +295,12 @@ int mmc_regulator_get_supply(struct mmc_host *mmc)
 		dev_dbg(dev, "No vqmmc regulator found\n");
 	}
 
+	if (IS_ERR(mmc->supply.vqmmc2)) {
+		if (PTR_ERR(mmc->supply.vqmmc2) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+		dev_dbg(dev, "No vqmmc2 regulator found\n");
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(mmc_regulator_get_supply);
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 91065ab7f..69f8c8a8f 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -303,6 +303,7 @@ struct mmc_pwrseq;
 struct mmc_supply {
 	struct regulator *vmmc;		/* Card power supply */
 	struct regulator *vqmmc;	/* Optional Vccq supply */
+	struct regulator *vqmmc2;	/* Optional supply for phy */
 };
 
 struct mmc_ctx {
@@ -580,6 +581,7 @@ int mmc_regulator_set_ocr(struct mmc_host *mmc,
 			struct regulator *supply,
 			unsigned short vdd_bit);
 int mmc_regulator_set_vqmmc(struct mmc_host *mmc, struct mmc_ios *ios);
+int mmc_regulator_set_vqmmc2(struct mmc_host *mmc, struct mmc_ios *ios);
 #else
 static inline int mmc_regulator_set_ocr(struct mmc_host *mmc,
 				 struct regulator *supply,
@@ -593,6 +595,12 @@ static inline int mmc_regulator_set_vqmmc(struct mmc_host *mmc,
 {
 	return -EINVAL;
 }
+
+static inline int mmc_regulator_set_vqmmc2(struct mmc_host *mmc,
+					   struct mmc_ios *ios)
+{
+	return -EINVAL;
+}
 #endif
 
 int mmc_regulator_get_supply(struct mmc_host *mmc);
-- 
2.32.0

