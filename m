Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF272C05027
	for <linux-mmc@archiver.kernel.org>; Sun, 12 Feb 2023 21:54:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjBLVyf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 12 Feb 2023 16:54:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjBLVyd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 12 Feb 2023 16:54:33 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA5EF741
        for <linux-mmc@vger.kernel.org>; Sun, 12 Feb 2023 13:54:32 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id v13so10552098eda.11
        for <linux-mmc@vger.kernel.org>; Sun, 12 Feb 2023 13:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Qha8qrOtRQul9zEnOYzqLrmbz40JcVU27T/LLl1YA0=;
        b=iShYEslGDEbVYb0FHuwGgh10PnxM3ep1oXkDU3iUWSTJoFKkfwE8bPISmrCp5Dwkie
         zZefRiroutaJe2CuAM92egUfFsRNW3EhtY44GmE6N3Z0cDVrVy2OsNreuJAs69Q1Ml4B
         Y2j3UAr1GT1cVvc6UjPL4jSqVRPtR/3jEOH/WiEVr39+xh0ZELoFc//5D4lk6ctLA5vg
         eiaNTA/2MZtOArR1W/s7+6lFrEEFa4qm5IKXm9WgMLjgRWPrrJXv0P2n9MAbgTd8fSvl
         R51MKcZEEgF5G69/vN3eOqtOO+n56HcrnEhKXCbzWl8St4M04cO84ZFuuo4e3ni1lVdu
         3OUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6Qha8qrOtRQul9zEnOYzqLrmbz40JcVU27T/LLl1YA0=;
        b=Lx6rS040IXItjNYeZn6svvNMqtIZITgxxKEVxvGhxDLO7TYxGo+7LAGpF2UCa435da
         ltMVHnMAdDJ2pfUGQHu0jFAXxwedLhclFcoR2lin7Hgb6WGfYcXGB1JvnC6Bv9B2i2RO
         bvAhiyJDeaDbNF65fhq062NMSFUoh3W8fX9V/cyynOfMVfiByxr9PaG0weAqrBnQyVRw
         9eeVuCcsPG+mklNU/VTBuRay2lBgjVijTMaKWN1RU8WcHYPCw15rbLcnm0ttHejQsNPN
         rKiWd466Is307xwFH6w3BvyYZym1lUMD9t8zILtlFVtPCzbv9QVt00lIYWwsVA6hnFvV
         nRWg==
X-Gm-Message-State: AO0yUKULTtaMPaH+ceM4JEVw0fOZd9XKTn366PWIarW899zlkTD3nb7w
        lygK1guE4fxMm1MP6o18MZg=
X-Google-Smtp-Source: AK7set9gtN42qoq+WZ6BAwH02EDZ+b/8eUq1z6bXvcF2fuHg09Bt848oY1AZ2oavxyRqlxPKbNtsjA==
X-Received: by 2002:a50:d613:0:b0:4aa:a280:55b5 with SMTP id x19-20020a50d613000000b004aaa28055b5mr5452016edi.20.1676238870961;
        Sun, 12 Feb 2023 13:54:30 -0800 (PST)
Received: from ?IPV6:2a01:c23:bdd2:4300:1932:303f:b63a:5a0e? (dynamic-2a01-0c23-bdd2-4300-1932-303f-b63a-5a0e.c23.pool.telefonica.de. [2a01:c23:bdd2:4300:1932:303f:b63a:5a0e])
        by smtp.googlemail.com with ESMTPSA id t23-20020a50ab57000000b004acbf1d8412sm1637291edc.1.2023.02.12.13.54.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Feb 2023 13:54:30 -0800 (PST)
Message-ID: <16502040-3beb-a3cc-b28d-28184fba0f10@gmail.com>
Date:   Sun, 12 Feb 2023 22:43:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] mmc: meson-gx: remove meson_mmc_get_cd
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

MMC core only checks whether return value of .get_cd() equals zero.
Therefore -ENOSYS and 1 are effectively the same and the function
can be removed.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 6d5caf233..1d761f33d 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -1064,20 +1064,6 @@ static irqreturn_t meson_mmc_irq_thread(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-/*
- * NOTE: we only need this until the GPIO/pinctrl driver can handle
- * interrupts.  For now, the MMC core will use this for polling.
- */
-static int meson_mmc_get_cd(struct mmc_host *mmc)
-{
-	int status = mmc_gpio_get_cd(mmc);
-
-	if (status == -ENOSYS)
-		return 1; /* assume present */
-
-	return status;
-}
-
 static void meson_mmc_cfg_init(struct meson_host *host)
 {
 	u32 cfg = 0;
@@ -1146,7 +1132,7 @@ static void meson_mmc_ack_sdio_irq(struct mmc_host *mmc)
 static const struct mmc_host_ops meson_mmc_ops = {
 	.request	= meson_mmc_request,
 	.set_ios	= meson_mmc_set_ios,
-	.get_cd         = meson_mmc_get_cd,
+	.get_cd         = mmc_gpio_get_cd,
 	.pre_req	= meson_mmc_pre_req,
 	.post_req	= meson_mmc_post_req,
 	.execute_tuning = meson_mmc_resampling_tuning,
-- 
2.39.1

