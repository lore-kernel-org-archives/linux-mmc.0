Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93B3C61DA4
	for <linux-mmc@archiver.kernel.org>; Sat, 11 Mar 2023 15:27:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjCKP1s (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 11 Mar 2023 10:27:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjCKP1r (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 11 Mar 2023 10:27:47 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B026122396
        for <linux-mmc@vger.kernel.org>; Sat, 11 Mar 2023 07:27:45 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id r27so10398782lfe.10
        for <linux-mmc@vger.kernel.org>; Sat, 11 Mar 2023 07:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678548463;
        h=cc:to:subject:date:from:in-reply-to:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F7N4XcDM0EGKh1CMHgzJCQlyNXmM/HdEL/4Dosq+GKE=;
        b=Ys0qCPSy7du4KBjmtpWLCQ2qOApKGHhyrzgcTcHRv+z6p59zUoTF6WA3XoEIhDcNbP
         CvRgbY6GXMSsQmtiAJ46Bf+NAF0iiAaTGqX3Gq3cnif7Ka6K7zeDoOiW6NFjBnARRkVD
         RcQujSJS9/ffBmQAcW0y0hLGjzsDFvCVvnHXYDdjY1fyAaG1qX2GejcJDahYusUri5ps
         VL5UTx7wJfI2Api0ZGArfysJ3ACRC4lkG94NI9r0SRWPCwe42w7gjK2PiVf76B0AVQ36
         Ng9SLSOhjyvSCH7RnSR0wtNiXfffkqhd4h6ihyUqOEcA9CMJjD+nlIEJiQLvSeXlGlqo
         5yvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678548463;
        h=cc:to:subject:date:from:in-reply-to:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F7N4XcDM0EGKh1CMHgzJCQlyNXmM/HdEL/4Dosq+GKE=;
        b=DiCDmVCsZaRzaRRPqmEP7EeGb3W8T3aIeauF+M/dqDZpToLciv4sM9aKdiZ6caHhiD
         NId3Z484QpdsyQWWKbiXnFzyNBR1WUV2IJCzv+6nOsbwfLhhHTs4j7dPuvidOUWgJuGM
         gV/cWpypu89ADPtHGD/9Y3TdTeisnTnASXrbzU+EY9Z21vOCLMt6PzqDUtTxu2wfIiIK
         0cZ1HKw7vic3Z4r7w+ahJCWrDNVmw5hdsZParO32Lr5GB6polHt7z1OzYxUVpwwiZnOX
         Il5TF/XW9F9ZmZMj5KFM7vC5pvWEjRKwtJt3V9J/H6dlW2DnEh6ylIZi2gJ6mIcNo7xV
         adRw==
X-Gm-Message-State: AO0yUKV6V4shFAtC9i8GKyBVkKc6HvaZFqh8KaSo+Mi9KirgR/ls4OIl
        tRUCnk5MpfkbRpwf5lUfUdD1bL5Xpv9iHRyy41Y=
X-Google-Smtp-Source: AK7set/Y+li+fH1s+mwAynk9EwWYgNLrKpnbEZ2L6sZ2dxkgWKocnLlGW1kySS1cbDYcwcWx8pZaYg==
X-Received: by 2002:ac2:488f:0:b0:4b5:2bbc:e119 with SMTP id x15-20020ac2488f000000b004b52bbce119mr10173477lfc.65.1678548463409;
        Sat, 11 Mar 2023 07:27:43 -0800 (PST)
Received: from 0002-dw_mmc-add-an-option-to-force-32-bit-accesses-to-64-.patch (46-138-144-249.dynamic.spd-mgts.ru. [46.138.144.249])
        by smtp.gmail.com with ESMTPSA id o5-20020a056512050500b004d0b1327b75sm345506lfb.61.2023.03.11.07.27.42
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 07:27:43 -0800 (PST)
Message-Id: <1678548256.0817535-2-sleirsgoevy@gmail.com>
In-Reply-To: <1678548256.0817535-0-sleirsgoevy@gmail.com>
From:   Sergey Lisov <sleirsgoevy@gmail.com>
Date:   Sat, 11 Mar 2023 18:22:52 +0300
Subject: [PATCH 2/2] dw_mmc: add an option to force 32-bit accesses to 64-bit
 device registers
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

---
 drivers/mmc/host/dw_mmc.c | 125 +++++++++++++++++++++++++++++++++++++-
 drivers/mmc/host/dw_mmc.h |   2 +
 2 files changed, 125 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 581614196..eee430620 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2575,6 +2575,119 @@ static void dw_mci_pull_data64(struct dw_mci *host, void *buf, int cnt)
 	}
 }
 
+/*
+  Some dw_mmc devices have 64-bit FIFOs, but expect them to be
+  accessed using two 32-bit accesses. If such controller is used
+  with a 64-bit kernel, this has to be done explicitly.
+
+  XXX: Is this issue specific to Exynos7?
+*/
+
+static inline uint64_t mci_fifo_readq_32(void __iomem *addr)
+{
+	uint64_t ans;
+	uint32_t proxy[2];
+
+	proxy[0] = mci_fifo_readl(addr);
+	proxy[1] = mci_fifo_readl(addr+4);
+	memcpy(&ans, proxy, 8);
+	return ans;
+}
+
+static inline void mci_fifo_writeq_32(void __iomem *addr, uint64_t value)
+{
+	uint32_t proxy[2];
+
+	memcpy(proxy, &value, 8);
+	mci_fifo_writel(addr, proxy[0]);
+	mci_fifo_writel(addr+4, proxy[1]);
+}
+
+static void dw_mci_push_data64_32(struct dw_mci *host, void *buf, int cnt)
+{
+	struct mmc_data *data = host->data;
+	int init_cnt = cnt;
+
+	/* try and push anything in the part_buf */
+	if (unlikely(host->part_buf_count)) {
+		int len = dw_mci_push_part_bytes(host, buf, cnt);
+
+		buf += len;
+		cnt -= len;
+
+		if (host->part_buf_count == 8) {
+			mci_fifo_writeq_32(host->fifo_reg, host->part_buf);
+			host->part_buf_count = 0;
+		}
+	}
+#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
+	if (unlikely((unsigned long)buf & 0x7)) {
+		while (cnt >= 8) {
+			u64 aligned_buf[16];
+			int len = min(cnt & -8, (int)sizeof(aligned_buf));
+			int items = len >> 3;
+			int i;
+			/* memcpy from input buffer into aligned buffer */
+			memcpy(aligned_buf, buf, len);
+			buf += len;
+			cnt -= len;
+			/* push data from aligned buffer into fifo */
+			for (i = 0; i < items; ++i)
+				mci_fifo_writeq_32(host->fifo_reg, aligned_buf[i]);
+		}
+	} else
+#endif
+	{
+		u64 *pdata = buf;
+
+		for (; cnt >= 8; cnt -= 8)
+			mci_fifo_writeq_32(host->fifo_reg, *pdata++);
+		buf = pdata;
+	}
+	/* put anything remaining in the part_buf */
+	if (cnt) {
+		dw_mci_set_part_bytes(host, buf, cnt);
+		/* Push data if we have reached the expected data length */
+		if ((data->bytes_xfered + init_cnt) ==
+		    (data->blksz * data->blocks))
+			mci_fifo_writeq_32(host->fifo_reg, host->part_buf);
+	}
+}
+
+static void dw_mci_pull_data64_32(struct dw_mci *host, void *buf, int cnt)
+{
+#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
+	if (unlikely((unsigned long)buf & 0x7)) {
+		while (cnt >= 8) {
+			/* pull data from fifo into aligned buffer */
+			u64 aligned_buf[16];
+			int len = min(cnt & -8, (int)sizeof(aligned_buf));
+			int items = len >> 3;
+			int i;
+
+			for (i = 0; i < items; ++i)
+				aligned_buf[i] = mci_fifo_readq_32(host->fifo_reg);
+
+			/* memcpy from aligned buffer into output buffer */
+			memcpy(buf, aligned_buf, len);
+			buf += len;
+			cnt -= len;
+		}
+	} else
+#endif
+	{
+		u64 *pdata = buf;
+
+		for (; cnt >= 8; cnt -= 8)
+			*pdata++ = mci_fifo_readq_32(host->fifo_reg);
+		buf = pdata;
+	}
+	if (cnt) {
+		host->part_buf = mci_fifo_readq_32(host->fifo_reg);
+		dw_mci_pull_final_bytes(host, buf, cnt);
+	}
+}
+
 static void dw_mci_pull_data(struct dw_mci *host, void *buf, int cnt)
 {
 	int len;
@@ -3239,6 +3352,9 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
 	if (device_property_present(dev, "fifo-watermark-aligned"))
 		host->wm_aligned = true;
 
+	if (device_property_present(dev, "fifo-access-32bit"))
+		host->quirks |= DW_MMC_QUIRK_FIFO64_32;
+
 	if (!device_property_read_u32(dev, "clock-frequency", &clock_frequency))
 		pdata->bus_hz = clock_frequency;
 
@@ -3367,8 +3483,13 @@ int dw_mci_probe(struct dw_mci *host)
 		width = 16;
 		host->data_shift = 1;
 	} else if (i == 2) {
-		host->push_data = dw_mci_push_data64;
-		host->pull_data = dw_mci_pull_data64;
+		if ((host->quirks & DW_MMC_QUIRK_FIFO64_32)) {
+			host->push_data = dw_mci_push_data64_32;
+			host->pull_data = dw_mci_pull_data64_32;
+		} else {
+			host->push_data = dw_mci_push_data64;
+			host->pull_data = dw_mci_pull_data64;
+		}
 		width = 64;
 		host->data_shift = 3;
 	} else {
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 4ed81f94f..edd642b92 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -280,6 +280,8 @@ struct dw_mci_board {
 
 /* Support for longer data read timeout */
 #define DW_MMC_QUIRK_EXTENDED_TMOUT            BIT(0)
+/* Force 32-bit access to the FIFO */
+#define DW_MMC_QUIRK_FIFO64_32                 BIT(1)
 
 #define DW_MMC_240A		0x240a
 #define DW_MMC_280A		0x280a
-- 
2.38.3


