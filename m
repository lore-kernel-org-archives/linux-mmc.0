Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 648BCC6FD1F
	for <linux-mmc@archiver.kernel.org>; Sat, 11 Mar 2023 22:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjCKW1Z (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 11 Mar 2023 17:27:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCKW1Y (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 11 Mar 2023 17:27:24 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B39265104
        for <linux-mmc@vger.kernel.org>; Sat, 11 Mar 2023 14:27:23 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id ay8so359870wmb.1
        for <linux-mmc@vger.kernel.org>; Sat, 11 Mar 2023 14:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678573642;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AkJp2eQU+ExfF0KULASIZkwRu5oZ8n8SVM659vX9mHo=;
        b=lbuJ+7x1MA+h/dKfSw81vTMEze+95PO7Mf4QMzOAmJjnFDcQ04SUj4EGtOuHtD60TO
         yB0QCymlEJ0g9QVQZ9f/46N7RlQwfSyZYinsh5XdNMcb+KSM1DwO5zjV91dZ1p5sy9KK
         TqHBK6vfsu8MDunYJXPflzGvAF1o98NpyxqjUK+E38aXEjEZKgPrQFjb3mIgVQQ6hczX
         0JfsueMnqswQLIPnVnlwU5hkdLEKmG31J2OqLZohBoIuJPLcSNpGDOmbgFhwinPikmJQ
         l7seyv6JTKROkvTxuRMNYrmWD85TzPyy26ze+4GnPiJbrMojyxO3V1WkILMOCHOlVDm7
         XyWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678573642;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AkJp2eQU+ExfF0KULASIZkwRu5oZ8n8SVM659vX9mHo=;
        b=C8bFOqNtCthWYRM7VmGlxJqMcRy773YITK1WpAOQnQ3iuvq1ujoA3jzxaa/nv8lffL
         IbZfJGXkrO9F0EpyOsLOzzd3Mi4tAveAHVD/1L6yBv2KwCKqkOzYieF1ZZKI+CtkQ6Ok
         oH2PeYo1cw69KnAf8ogi3Iqdj0RDn3PNta7MDi97XFHNm5V5GudGaIXBkx7qL7BmhtyY
         ySZxTFKyQYv1/kZV2OOf+SEm5HpolfYn3k7Wl1+G8ZJpaEnO7e4aut6HgnL+Ur+g9Hxz
         cRZIIfkBHInes1TFNj70/ent/6lKGiNRVH5p69zNZ+S3+3dIR0qFUpCQ1Kqk69P2LXp2
         bgpQ==
X-Gm-Message-State: AO0yUKXgID7J0h/IV450d+RcZH8u8J/EDX+SGyQRHta9+I+TmI9ITJeQ
        2skY9L9gV7ESbHhSac/ZqKfGUssq66U=
X-Google-Smtp-Source: AK7set+ckb9zNk2lx2eD6Kxng1xXGiWMSX3COAHoKhx1wY6M4OBI6oa48ASD1Jw5Bm6j92WJmgIQ1g==
X-Received: by 2002:a05:600c:512a:b0:3eb:55d2:9c4c with SMTP id o42-20020a05600c512a00b003eb55d29c4cmr5453272wms.16.1678573641711;
        Sat, 11 Mar 2023 14:27:21 -0800 (PST)
Received: from ?IPV6:2a01:c22:7697:7600:79dc:4e28:a7d7:a00c? (dynamic-2a01-0c22-7697-7600-79dc-4e28-a7d7-a00c.c22.pool.telefonica.de. [2a01:c22:7697:7600:79dc:4e28:a7d7:a00c])
        by smtp.googlemail.com with ESMTPSA id k17-20020a05600c0b5100b003e1f6e18c95sm3945031wmr.21.2023.03.11.14.27.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Mar 2023 14:27:21 -0800 (PST)
Message-ID: <858a592b-ebf4-99b4-74fc-21b4ad3382f8@gmail.com>
Date:   Sat, 11 Mar 2023 23:27:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] mmc: meson-gx: simplify usage of mmc_regulator_set_ocr
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

After 087592395a96 ("mmc: core: Allow invalid regulator in
mmc_regulator_set_ocr()") we can remove the checks here.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 2b963a81c..28e04dc4e 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -604,8 +604,7 @@ static void meson_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	 */
 	switch (ios->power_mode) {
 	case MMC_POWER_OFF:
-		if (!IS_ERR(mmc->supply.vmmc))
-			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
+		mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
 
 		if (!IS_ERR(mmc->supply.vqmmc) && host->vqmmc_enabled) {
 			regulator_disable(mmc->supply.vqmmc);
@@ -615,8 +614,7 @@ static void meson_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		break;
 
 	case MMC_POWER_UP:
-		if (!IS_ERR(mmc->supply.vmmc))
-			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, ios->vdd);
+		mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, ios->vdd);
 
 		break;
 
-- 
2.39.2

