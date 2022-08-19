Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D559C32771
	for <linux-mmc@archiver.kernel.org>; Fri, 19 Aug 2022 21:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349982AbiHSVO2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 19 Aug 2022 17:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbiHSVO1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Aug 2022 17:14:27 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6866C7E80A
        for <linux-mmc@vger.kernel.org>; Fri, 19 Aug 2022 14:14:26 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a7so11038513ejp.2
        for <linux-mmc@vger.kernel.org>; Fri, 19 Aug 2022 14:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=XN8Fhnia+RiwvuPKmGvKwSm6gbVuPj9Uos7pnCgzshw=;
        b=LBxR7hLFZLuTrfTZm9YXi0oJn7bp/IDy2floLNvMQMELuDyvzBGe2sN1FpbUJEX0tq
         LZiJbPPsWpmkyWounNmonv57I5Bij+eV9EwO0u9YtcS0rOZsUOVeoVGrazfesqSJ6qEY
         nRiaLcGnVHD6edigwwKeO6Kn3c94aWO7R347M/n7z9INvxcACjsDk681W7r22s6pw+Jr
         GyILTCDo0xC3qiglxzvmP9dhkEw6Xb3yKjnpTuikRtwh1s8wuQBfqC5LvcDxJwwBfeuJ
         Asa/wYIocvhXpFI5IM/6KYnkSqULm5+uDznPamdZqV9FzLaZOn9YR9dJ5p6PzjKxQLfL
         OuWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=XN8Fhnia+RiwvuPKmGvKwSm6gbVuPj9Uos7pnCgzshw=;
        b=CiXlUH5NEpQkoHO8qCD2IpWAGMg1IXGC0xN7mnH77hf3/zhVI0Jasa419Q9SpebqCA
         n6OUpYSjy7OCuk5j8ukZ3QZBmQ4eVgu9qgDCUHQTkOTap40ZqIn5oyKG1ZDVlFstF2M9
         HHaP9N1gOa5QTqgHklnr3TopEIrcvMOAwmCT2oKWNEdgnA2NvVtpoClViekPx7mdvmYL
         /y+QpHrD1/TOvUcQZNOxxT0azwGM1yIu7u5kxRxUDv2DoASwtM3oITyKvQT35DVBH/0+
         hh/LmjFR8IuVK13LRvCG9BrSggNeO8d2AnvJOyvfy0llTuxuaJZ2lorkbOdTzrvGDJbc
         HODA==
X-Gm-Message-State: ACgBeo2FyNQ/hgOpXGdpt9F+SzAcEsJS7c0FALsts+5Hj4G1JMBRTU2C
        dPVEkTJMOzkvm/LdUcn9pqTsYNiiRoE=
X-Google-Smtp-Source: AA6agR7mAT5dFb/lyg08h4fwzJD+3e+be+cF1wbAXMyl8vh3yHWQXbTayQ5Mhsz54dTxv9dn04i2xg==
X-Received: by 2002:a17:907:2cd5:b0:731:6a6b:209b with SMTP id hg21-20020a1709072cd500b007316a6b209bmr5945965ejc.315.1660943664672;
        Fri, 19 Aug 2022 14:14:24 -0700 (PDT)
Received: from ?IPV6:2a01:c23:c5ac:3600:6819:de7b:5db7:493? (dynamic-2a01-0c23-c5ac-3600-6819-de7b-5db7-0493.c23.pool.telefonica.de. [2a01:c23:c5ac:3600:6819:de7b:5db7:493])
        by smtp.googlemail.com with ESMTPSA id l25-20020aa7d959000000b0043cf0d56a61sm3685872eds.8.2022.08.19.14.14.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 14:14:24 -0700 (PDT)
Message-ID: <c1e81dfd-23f1-10d2-7099-a47ad869c1f9@gmail.com>
Date:   Fri, 19 Aug 2022 23:12:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: [PATCH v2 1/2] mmc: meson-gx: adjust and revive constant IRQ_EN_MASK
Content-Language: en-US
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>
References: <b94b7f5b-1095-33a5-b1a0-20a6e2281bce@gmail.com>
In-Reply-To: <b94b7f5b-1095-33a5-b1a0-20a6e2281bce@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Constant IRQ_EN_MASK has no user currently. In preparation of adding
SDIO interrupt support, revive it and adjust it to our needs.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- patch added to series
---
 drivers/mmc/host/meson-gx-mmc.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index dbc9fac8f..9a4da2544 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -101,8 +101,7 @@
 #define   IRQ_RESP_STATUS BIT(14)
 #define   IRQ_SDIO BIT(15)
 #define   IRQ_EN_MASK \
-	(IRQ_CRC_ERR | IRQ_TIMEOUTS | IRQ_END_OF_CHAIN | IRQ_RESP_STATUS |\
-	 IRQ_SDIO)
+	(IRQ_CRC_ERR | IRQ_TIMEOUTS | IRQ_END_OF_CHAIN)
 
 #define SD_EMMC_CMD_CFG 0x50
 #define SD_EMMC_CMD_ARG 0x54
@@ -940,17 +939,16 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
 	struct meson_host *host = dev_id;
 	struct mmc_command *cmd;
 	struct mmc_data *data;
-	u32 irq_en, status, raw_status;
+	u32 status, raw_status;
 	irqreturn_t ret = IRQ_NONE;
 
-	irq_en = readl(host->regs + SD_EMMC_IRQ_EN);
 	raw_status = readl(host->regs + SD_EMMC_STATUS);
-	status = raw_status & irq_en;
+	status = raw_status & IRQ_EN_MASK;
 
 	if (!status) {
 		dev_dbg(host->dev,
-			"Unexpected IRQ! irq_en 0x%08x - status 0x%08x\n",
-			 irq_en, raw_status);
+			"Unexpected IRQ! irq_en 0x%08lx - status 0x%08x\n",
+			 IRQ_EN_MASK, raw_status);
 		return IRQ_NONE;
 	}
 
@@ -1230,10 +1228,8 @@ static int meson_mmc_probe(struct platform_device *pdev)
 
 	/* clear, ack and enable interrupts */
 	writel(0, host->regs + SD_EMMC_IRQ_EN);
-	writel(IRQ_CRC_ERR | IRQ_TIMEOUTS | IRQ_END_OF_CHAIN,
-	       host->regs + SD_EMMC_STATUS);
-	writel(IRQ_CRC_ERR | IRQ_TIMEOUTS | IRQ_END_OF_CHAIN,
-	       host->regs + SD_EMMC_IRQ_EN);
+	writel(IRQ_EN_MASK, host->regs + SD_EMMC_STATUS);
+	writel(IRQ_EN_MASK, host->regs + SD_EMMC_IRQ_EN);
 
 	ret = request_threaded_irq(host->irq, meson_mmc_irq,
 				   meson_mmc_irq_thread, IRQF_ONESHOT,
-- 
2.37.2


