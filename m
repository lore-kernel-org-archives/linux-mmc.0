Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3DF5C61DA4
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Feb 2023 21:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjBNVoU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 14 Feb 2023 16:44:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231564AbjBNVoR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Feb 2023 16:44:17 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA7C29400;
        Tue, 14 Feb 2023 13:44:15 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id sa10so43438977ejc.9;
        Tue, 14 Feb 2023 13:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6BIfz99riEO+C0c4evMHPspzVHbaE2cc0ey+M44tW6k=;
        b=pSoLA/FHrOhJh6EPr92JseA5V/Jc+lfvCdTbkaQQ2inTHx7KHtOkqlVTUYNQVnRqF3
         0tGS08tpOdKONsn+GZ05zOujHC0Di2IJ//kO7dIJ0ltgQ0WQF+Tlt5/jXn4ZaSLWBYcL
         tpw6kQxcMcvx9dOpIz7w/mAdrFds7v+Yjs0QMaEQw9FsA2m+0T2rkUZok4YPWG+nqX+G
         6UeqSqMg5DBArfueJ0Fh9aukoXRfHTSFbKKZarGv+xiJDwWWOiYRtjNihO3dmLqMEkp3
         gvS72fqASMYhqU0yPcIQ9/jBbqX00FSggC+w6JOb3rn+7tjuRnsAwLTT4TMZyFQraS5L
         cnpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6BIfz99riEO+C0c4evMHPspzVHbaE2cc0ey+M44tW6k=;
        b=h/pZkYgC36cuqzJMwqqgcJxlLvVMU3IC1ogDL9zDMT3iAvBeMyYXeR3mozatkqHJLQ
         islM+sU5GkrwcJygineBMfOolnrVI3u50r6VW0ZgW3WJ86Q5xrh0j43bgiTFR+fHByLJ
         jVhasRBm6acwdXvh0gTmp3kYsZ5D8lUgAdMcBXoAMZ0zQXdSErb2IrXB5IZIFfdMtvtq
         NfQYTx8hz6J2jZsTkgzacIWW1UVlrRUfMDV4m8Lp6TrVa8zhgNCso9HIm1KJo0KwsNLO
         m9fHXNso9I020p+vlYBOkt3iqSK5UuoRnCBmiTAkA3YmKZVHCIw/0UV9sRKzK3C61USb
         PAKQ==
X-Gm-Message-State: AO0yUKUzMwlW9uz5rkZMVvglIXo3tui0fCmhGJGUNhngOebC+W3CRfto
        wCQDfxi/3t5PrvdKeGqxYlI=
X-Google-Smtp-Source: AK7set+ItZXr1gbL0Bkw184xQW8mS3DVV4Kc6GhdErI/smY1OAbxoR/8UgxLWioNqlYnDeR9Dqm6zw==
X-Received: by 2002:a17:906:8699:b0:890:4731:d1bc with SMTP id g25-20020a170906869900b008904731d1bcmr4077934ejx.38.1676411053926;
        Tue, 14 Feb 2023 13:44:13 -0800 (PST)
Received: from ?IPV6:2a01:c22:7234:f800:b56b:f43d:948c:eede? (dynamic-2a01-0c22-7234-f800-b56b-f43d-948c-eede.c22.pool.telefonica.de. [2a01:c22:7234:f800:b56b:f43d:948c:eede])
        by smtp.googlemail.com with ESMTPSA id f20-20020a170906c09400b00872c0bccab2sm8715145ejz.35.2023.02.14.13.44.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 13:44:13 -0800 (PST)
Message-ID: <5777f38b-465f-ce48-a87f-5eb8b3c57b0a@gmail.com>
Date:   Tue, 14 Feb 2023 22:41:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: [PATCH v2 1/3] mmc: core: support setting card detect interrupt from
 drivers
Content-Language: en-US
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <15df9ef0-9b73-ca5a-d3cf-0585cd135bc5@gmail.com>
In-Reply-To: <15df9ef0-9b73-ca5a-d3cf-0585cd135bc5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On certain platforms like Amlogic Meson gpiod_to_irq() isn't supported
due to the design of gpio / interrupt controller. Therefore provide an
option for drivers to pass the card detect interrupt number
(retrieved e.g. from device tree) to mmc core.

Suggested-by refers to the mechanism to pass and store the interrupt.

Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- use another mechanism for passing and storing the cd interrupt
---
 drivers/mmc/core/slot-gpio.c  | 17 ++++++++++++++++-
 include/linux/mmc/slot-gpio.h |  1 +
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
index dd2a4b6ab..2a2d949a9 100644
--- a/drivers/mmc/core/slot-gpio.c
+++ b/drivers/mmc/core/slot-gpio.c
@@ -23,6 +23,7 @@ struct mmc_gpio {
 	char *ro_label;
 	char *cd_label;
 	u32 cd_debounce_delay_ms;
+	int cd_irq;
 };
 
 static irqreturn_t mmc_gpio_cd_irqt(int irq, void *dev_id)
@@ -53,12 +54,24 @@ int mmc_gpio_alloc(struct mmc_host *host)
 	ctx->ro_label = devm_kasprintf(host->parent, GFP_KERNEL, "%s ro", devname);
 	if (!ctx->ro_label)
 		return -ENOMEM;
+	ctx->cd_irq = -EINVAL;
 	host->slot.handler_priv = ctx;
 	host->slot.cd_irq = -EINVAL;
 
 	return 0;
 }
 
+void mmc_gpio_set_cd_irq(struct mmc_host *host, int irq)
+{
+	struct mmc_gpio *ctx = host->slot.handler_priv;
+
+	if (!ctx || irq < 0)
+		return;
+
+	ctx->cd_irq = irq;
+}
+EXPORT_SYMBOL(mmc_gpio_set_cd_irq);
+
 int mmc_gpio_get_ro(struct mmc_host *host)
 {
 	struct mmc_gpio *ctx = host->slot.handler_priv;
@@ -98,7 +111,9 @@ void mmc_gpiod_request_cd_irq(struct mmc_host *host)
 	 * Do not use IRQ if the platform prefers to poll, e.g., because that
 	 * IRQ number is already used by another unit and cannot be shared.
 	 */
-	if (!(host->caps & MMC_CAP_NEEDS_POLL))
+	if (ctx->cd_irq >= 0)
+		irq = ctx->cd_irq;
+	else if (!(host->caps & MMC_CAP_NEEDS_POLL))
 		irq = gpiod_to_irq(ctx->cd_gpio);
 
 	if (irq >= 0) {
diff --git a/include/linux/mmc/slot-gpio.h b/include/linux/mmc/slot-gpio.h
index 4ae2f2908..5d3d15e97 100644
--- a/include/linux/mmc/slot-gpio.h
+++ b/include/linux/mmc/slot-gpio.h
@@ -15,6 +15,7 @@ struct mmc_host;
 
 int mmc_gpio_get_ro(struct mmc_host *host);
 int mmc_gpio_get_cd(struct mmc_host *host);
+void mmc_gpio_set_cd_irq(struct mmc_host *host, int irq);
 int mmc_gpiod_request_cd(struct mmc_host *host, const char *con_id,
 			 unsigned int idx, bool override_active_level,
 			 unsigned int debounce);
-- 
2.39.1


