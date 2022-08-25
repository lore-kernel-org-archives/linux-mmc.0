Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BFDBECAA2B
	for <linux-mmc@archiver.kernel.org>; Thu, 25 Aug 2022 19:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234886AbiHYT4f (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 25 Aug 2022 15:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232114AbiHYT4b (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 25 Aug 2022 15:56:31 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1756F579
        for <linux-mmc@vger.kernel.org>; Thu, 25 Aug 2022 12:56:29 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id s11so27442286edd.13
        for <linux-mmc@vger.kernel.org>; Thu, 25 Aug 2022 12:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=XN8Fhnia+RiwvuPKmGvKwSm6gbVuPj9Uos7pnCgzshw=;
        b=K9I9qpYQPf4nHjuN9RIOzoBgLqNbBoBeMzw72fNZV8iMRUrRrIIl3t7j232eODpnZV
         Eq+FJrHHiHWrDmleJn4up/l66lAgEiglix95/G/4BjAcdnIGkjJ2aUvC9hEAyhlHbITL
         whDZE3WXZpep3yNywu1JdFI9kf2v+Q8mfACdr+Nnd+MWm9XIgUzc8WorEUQi7BA/ANhE
         ED5EW4mPYBEVS0pBVJiGlE7wvtu860fM8YVIr3jGPQ0lS+Fk8Qoe+e/C4x6sHgzEuAtM
         eR6/cD7P24OVcEr1RDryjhxF+qJBYrc2XEM4DBZPW+cj6fa9Ihre0q1gdfaHVjNgJiub
         vn1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=XN8Fhnia+RiwvuPKmGvKwSm6gbVuPj9Uos7pnCgzshw=;
        b=FPNR/DvTPfHFWnIkq/uauaVmxTpB7DAF87YHdVXhnJHegcCaljRXNCtVZMFW0j3Snx
         pthN5nAiqpwxse+8AwspMqVeYoQRDAgWI6t6o58AhnvZhf0RTpPN6IwNeTurdKyVbpah
         DDmpB4vuXx3OiHxNirwc26I/Rclp7PbAcY0EsyNTcVHT3xnegHhTaVRLcV03TX4j1H4D
         XMhHIVDqDReLUzYmimIIeXB43ikossLi4OyS+jylPzNxvMBCaazJ4ZOAvEgph+UETuIt
         n3S3XHQjm9R8u963Kv9ndsfzOLgQGV4sTYbE/s39VRwEm7Xrj49fMstC8SSf5hfhSTWq
         oUXQ==
X-Gm-Message-State: ACgBeo2jbP41t5mxuFqlGnxY2EsEJm0SpX46v4WMVI3XqQbjrpr2JtaB
        mPXD8xgZefix4X7XH4QIH38=
X-Google-Smtp-Source: AA6agR5HAs9gjlt6XNA3kcLQhmB17AxuDEFUbOoC838NcmtZykmGaVx9+5pQ1pVjsNoqLX36b6beoQ==
X-Received: by 2002:a05:6402:2802:b0:43a:9098:55a0 with SMTP id h2-20020a056402280200b0043a909855a0mr4414990ede.179.1661457388407;
        Thu, 25 Aug 2022 12:56:28 -0700 (PDT)
Received: from ?IPV6:2a01:c22:72a6:5f00:b844:7c7d:e964:bb65? (dynamic-2a01-0c22-72a6-5f00-b844-7c7d-e964-bb65.c22.pool.telefonica.de. [2a01:c22:72a6:5f00:b844:7c7d:e964:bb65])
        by smtp.googlemail.com with ESMTPSA id kf24-20020a17090776d800b0072b51fb36f7sm16382ejc.196.2022.08.25.12.56.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 12:56:27 -0700 (PDT)
Message-ID: <8056622f-2adf-4763-7423-9ccdf4ca78e1@gmail.com>
Date:   Thu, 25 Aug 2022 21:53:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: [PATCH v3 1/2] mmc: meson: adjust and re-use constant IRQ_EN_MASK
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
References: <72459a46-fd20-60d8-a7e7-076d8f321816@gmail.com>
In-Reply-To: <72459a46-fd20-60d8-a7e7-076d8f321816@gmail.com>
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



