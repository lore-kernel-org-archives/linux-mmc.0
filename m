Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C54B5C54EED
	for <linux-mmc@archiver.kernel.org>; Sun, 29 Jan 2023 23:10:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234004AbjA2XK4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 29 Jan 2023 18:10:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjA2XK4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 29 Jan 2023 18:10:56 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0586F18B20
        for <linux-mmc@vger.kernel.org>; Sun, 29 Jan 2023 15:10:55 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id v13so9357240eda.11
        for <linux-mmc@vger.kernel.org>; Sun, 29 Jan 2023 15:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xXcahrTpEcHakTb1PxvBW7NnUoqs5ML+Ax9G8+xTpOo=;
        b=YijHuSSFkceumoCasRb9wWLGPPv6n0kzmEuQ4kok7nb/jPmn0c2KUKiRQq8MZ4iHcS
         TmzwdBRtJAqU+GfIGZDnGNRRMOeqhqae+DZ+ypiPkbJspZM50XeaYPSZtCEUrmngtCIa
         vQH/SxmwQUXqGh+5Q/UFXMTpC4/cAaEedIsaoFuCnMmVYnWlnooO8WHZiHiy6swTH5Yp
         09TO3q0+m/YJFe/4qxxY9VTY5x4SDmFaAdBQd63ukCj8bxTSEJTEvp3xtbAmGX3ebl62
         5CMIOE3S7tkbsCzCfCPSumW8QqtTpNcDHNUQmcbQkLXYhrGhxoM4gDyff0Tj5A4gwipX
         pHmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xXcahrTpEcHakTb1PxvBW7NnUoqs5ML+Ax9G8+xTpOo=;
        b=O/oT7ahhPUtvF3V5zs8x0dYxeP7bCuR7MrfIzzrDexSv/iVaudPOBRoYhFJaSaLFJl
         Hhss45Lj892gNHonu44qUlIut7A6wYo6Sp9IQEY6SJut+YVbEZVI8mmtaSPb/OmmZECa
         4tqWHb3l4vWcWOPuTaCyS010eGKSYdTnloipBfkq74lb7Tpl6Rd1nQPljxhXysKEf7r2
         UxFWY+DABM1we5n2K5CscJKN0fiuU7RWaUabtZa8CEvav63doJ75lCA9yzJ80s8I0L/y
         MpsFYqb73ng8BzprW2Xe+11B6l8y8RF2uyU/Spq7ZjUqNjNuWZmo5emYlt5CQsqAvF9j
         kiWQ==
X-Gm-Message-State: AO0yUKUj0w9mei9xhJJQD1PSM28cZ/Ou3tvXR3hBi2PY+XEMoy0IpLNU
        9L/nLGQiupflIpSDREj+g/A=
X-Google-Smtp-Source: AK7set8l4bLKRYd3u8nhlm3xuNXlamvmBI17VqNVo7b97Qc0K9huFD8rt9ZgamaTA+sqXQ77V+zBZg==
X-Received: by 2002:a05:6402:24a0:b0:4a0:8f4e:52dd with SMTP id q32-20020a05640224a000b004a08f4e52ddmr24320224eda.17.1675033853437;
        Sun, 29 Jan 2023 15:10:53 -0800 (PST)
Received: from ?IPV6:2a01:c23:c5b5:3100:78bb:34b6:bd6e:6fb4? (dynamic-2a01-0c23-c5b5-3100-78bb-34b6-bd6e-6fb4.c23.pool.telefonica.de. [2a01:c23:c5b5:3100:78bb:34b6:bd6e:6fb4])
        by smtp.googlemail.com with ESMTPSA id i1-20020a056402054100b0049ef05260besm5888588edx.59.2023.01.29.15.10.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Jan 2023 15:10:52 -0800 (PST)
Message-ID: <a0f895b3-f895-f256-1274-a61571264617@gmail.com>
Date:   Mon, 30 Jan 2023 00:04:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: [PATCH 1/2] mmc: core: support platform interrupt as card detect
 interrupt
Content-Language: en-US
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <dfb90ca4-1f62-e3ed-2ce4-a7b5f661e36d@gmail.com>
In-Reply-To: <dfb90ca4-1f62-e3ed-2ce4-a7b5f661e36d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On certain platforms like Amlogic Meson gpiod_to_irq() isn't supported
due to the design of gpio / interrupt controller. Therefore provide an
option to specify the cd interrupt e.g. by device tree. The host
controller can store the interrupt in cd_irq for use by
mmc_gpiod_request_cd_irq().

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/mmc/core/slot-gpio.c | 2 +-
 include/linux/mmc/host.h     | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
index dd2a4b6ab..69c22a997 100644
--- a/drivers/mmc/core/slot-gpio.c
+++ b/drivers/mmc/core/slot-gpio.c
@@ -99,7 +99,7 @@ void mmc_gpiod_request_cd_irq(struct mmc_host *host)
 	 * IRQ number is already used by another unit and cannot be shared.
 	 */
 	if (!(host->caps & MMC_CAP_NEEDS_POLL))
-		irq = gpiod_to_irq(ctx->cd_gpio);
+		irq = host->cd_irq > 0 ? host->cd_irq : gpiod_to_irq(ctx->cd_gpio);
 
 	if (irq >= 0) {
 		if (!ctx->cd_gpio_isr)
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 8fdd3cf97..e998e919e 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -470,6 +470,7 @@ struct mmc_host {
 
 	struct delayed_work	detect;
 	int			detect_change;	/* card detect flag */
+	int			cd_irq;		/* for use by mmc_gpiod_request_cd_irq */
 	struct mmc_slot		slot;
 
 	const struct mmc_bus_ops *bus_ops;	/* current bus driver */
-- 
2.39.1


