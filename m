Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD28DC61DA4
	for <linux-mmc@archiver.kernel.org>; Sat, 11 Mar 2023 22:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjCKWld (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 11 Mar 2023 17:41:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjCKWlc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 11 Mar 2023 17:41:32 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D334C3800E
        for <linux-mmc@vger.kernel.org>; Sat, 11 Mar 2023 14:41:30 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id o5-20020a05600c510500b003ec0e4ec6deso2403453wms.3
        for <linux-mmc@vger.kernel.org>; Sat, 11 Mar 2023 14:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678574489;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wvi3jPUfvsG2XAyxzKd1y6BonpPYutSXSWHpo/fL0wc=;
        b=UlBqPGHn+3ofxU+WKh3yGDSgIzg2cKgA6CYZLwZ/bK5xcl2Y9xhsfNj4xsNj6T91zE
         kioPWV+y+s/EJ3uaHP40JlZf+NReJ8Gw0HHE2y5MXDZFuXcj/sS7TzsnYI1Qe0k7NcS8
         aNTwEMDt/jNFmxb6idkfRb/iOD3kNlbHBVW9LxUcOHMrz2r2QfKw4x9JQ326Ko0hNUlv
         /dQ7kVmnX3Nr4wnol6Wqg6di5zAAMvhhOx+OcCnuuGqC3pTM1lA7bqf0ILQrRKS0jvkQ
         jTbPPsikDrN9/M671jHlOj670cKsdKdFfXN0x0VCPzAs0qL4F/MqljMZSHC2POZSbEgh
         9+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678574489;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wvi3jPUfvsG2XAyxzKd1y6BonpPYutSXSWHpo/fL0wc=;
        b=PPCi5ZGo6N0ITlhc9Q8hgPMWZb1GdbC+m03cePqeWE2lEso6t0GOfyYQBfBWHhB8UJ
         doHHE9qfObw0IiFD0kPvwC6/dgH52IEBq/ZRwn76Fd34EPMdG9fYjVOfOtlnjX8Z0ieX
         CHx2STLh6+FtdXMWVIIBVsfOHZVUoF3C4Q0nzWEjw/vcuzF6NbRWccCFysaKdF8Xs2so
         F3sm47/Fo4H9GvEhkfkEj8jWnSkQwEathNKyhL7k4Ofpl/crroIRbZ+gRZASxoEtee1U
         B81gITgF7ZluSqhVmF3flGVVRDxQ4iqYMxt4a7oLtQFjM8X6wNs3/hFFvmESsCYG6TUy
         TWvA==
X-Gm-Message-State: AO0yUKU4u5/6/97g53eIbzM57wr4Zz2HiQIWPQRBICp5KdJ9Lem8HBZF
        bslwNMk0+kvL/MyH79e7TNA=
X-Google-Smtp-Source: AK7set/RS/KQURYnNMFxCihTikNsE4hDaQL7PcvQmNglCk3NS/q4wQuwccfe37QcVjfQxoCpwaPQgQ==
X-Received: by 2002:a05:600c:5492:b0:3eb:2f3b:4478 with SMTP id iv18-20020a05600c549200b003eb2f3b4478mr6924348wmb.15.1678574489292;
        Sat, 11 Mar 2023 14:41:29 -0800 (PST)
Received: from ?IPV6:2a01:c22:7697:7600:79dc:4e28:a7d7:a00c? (dynamic-2a01-0c22-7697-7600-79dc-4e28-a7d7-a00c.c22.pool.telefonica.de. [2a01:c22:7697:7600:79dc:4e28:a7d7:a00c])
        by smtp.googlemail.com with ESMTPSA id b12-20020adff90c000000b002c71d206329sm3418842wrr.55.2023.03.11.14.41.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Mar 2023 14:41:28 -0800 (PST)
Message-ID: <71586432-360f-9b92-17f6-b05a8a971bc2@gmail.com>
Date:   Sat, 11 Mar 2023 23:39:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: [PATCH 1/2] mmc: core: add helpers mmc_regulator_enable/disable_vqmmc
Content-Language: en-US
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <9ae6f90e-e1ea-d088-cdae-7dd8a541f00f@gmail.com>
In-Reply-To: <9ae6f90e-e1ea-d088-cdae-7dd8a541f00f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

There's a number of drivers (e.g. dw_mmc, meson-gx, mmci, sunxi) using
the same mechanism and a private flag vqmmc_enabled to deal with
enabling/disabling the vqmmc regulator.

Move this to the core and create new helpers mmc_regulator_enable_vqmmc
and mmc_regulator_disable_vqmmc.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/mmc/core/regulator.c | 41 ++++++++++++++++++++++++++++++++++++
 include/linux/mmc/host.h     |  3 +++
 2 files changed, 44 insertions(+)

diff --git a/drivers/mmc/core/regulator.c b/drivers/mmc/core/regulator.c
index 4fad81cd5..005247a49 100644
--- a/drivers/mmc/core/regulator.c
+++ b/drivers/mmc/core/regulator.c
@@ -274,3 +274,44 @@ int mmc_regulator_get_supply(struct mmc_host *mmc)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(mmc_regulator_get_supply);
+
+/**
+ * mmc_regulator_enable_vqmmc - enable VQMMC regulator for a host
+ * @mmc: the host to regulate
+ *
+ * Returns 0 or errno. Enables the regulator for vqmmc.
+ * Keeps track of the enable status for ensuring that calls to
+ * regulator_enable/disable are balanced.
+ */
+int mmc_regulator_enable_vqmmc(struct mmc_host *mmc)
+{
+	int ret = 0;
+
+	if (!IS_ERR(mmc->supply.vqmmc) && !mmc->vqmmc_enabled) {
+		ret = regulator_enable(mmc->supply.vqmmc);
+		if (ret < 0)
+			dev_err(mmc_dev(mmc), "enabling vqmmc regulator failed\n");
+		else
+			mmc->vqmmc_enabled = true;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mmc_regulator_enable_vqmmc);
+
+/**
+ * mmc_regulator_disable_vqmmc - disable VQMMC regulator for a host
+ * @mmc: the host to regulate
+ *
+ * Returns 0 or errno. Disables the regulator for vqmmc.
+ * Keeps track of the enable status for ensuring that calls to
+ * regulator_enable/disable are balanced.
+ */
+void mmc_regulator_disable_vqmmc(struct mmc_host *mmc)
+{
+	if (!IS_ERR(mmc->supply.vqmmc) && mmc->vqmmc_enabled) {
+		regulator_disable(mmc->supply.vqmmc);
+		mmc->vqmmc_enabled = false;
+	}
+}
+EXPORT_SYMBOL_GPL(mmc_regulator_disable_vqmmc);
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 812e6b583..461d15438 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -450,6 +450,7 @@ struct mmc_host {
 	unsigned int		retune_paused:1; /* re-tuning is temporarily disabled */
 	unsigned int		retune_crc_disable:1; /* don't trigger retune upon crc */
 	unsigned int		can_dma_map_merge:1; /* merging can be used */
+	unsigned int		vqmmc_enabled:1; /* vqmmc regulator is enabled */
 
 	int			rescan_disable;	/* disable card detection */
 	int			rescan_entered;	/* used with nonremovable devices */
@@ -598,6 +599,8 @@ static inline int mmc_regulator_set_vqmmc(struct mmc_host *mmc,
 #endif
 
 int mmc_regulator_get_supply(struct mmc_host *mmc);
+int mmc_regulator_enable_vqmmc(struct mmc_host *mmc);
+void mmc_regulator_disable_vqmmc(struct mmc_host *mmc);
 
 static inline int mmc_card_is_removable(struct mmc_host *host)
 {
-- 
2.39.2


