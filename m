Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD9DC61DA4
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Mar 2023 01:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjCJBEH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 9 Mar 2023 20:04:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCJBEG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Mar 2023 20:04:06 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B81B1009DD
        for <linux-mmc@vger.kernel.org>; Thu,  9 Mar 2023 17:04:04 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id v11so3951721plz.8
        for <linux-mmc@vger.kernel.org>; Thu, 09 Mar 2023 17:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678410244;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7wv4L4R+E0m/FoUu36iHA75ZGOsZN+ELTTFM9oiUR9I=;
        b=JJcsvNpUpUecz8800ih3zVYl5IR6DFOUc1Nt0BFZKALEgHmKogghvOVetimj2ZUKOE
         n22P4gA/ECjsXotLJgHfAA1Oi6l4fdQQ5bXOAjg1E63D/IQOyHdAQ3dozShnUIZADSOy
         hkVWPBFrXJ81ZJp6nFiITTy6oppr5EZ4xfFL0OO5tzuNc2N4sB0pekh1snoqmxgbRf7e
         OmTxGbg4eOY8X2JWXNhTOyqavGDNnp7YSgPKz+1wcMUwLMRZ7AIVYVejBccQ4Fyy6Ly8
         er0ukAYcG2nVdprpl4h0NZSVqNs5Yy9ummOWz/q1/Di1Y9txbByqUBqYqBeZFNvsxMeJ
         FEhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678410244;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7wv4L4R+E0m/FoUu36iHA75ZGOsZN+ELTTFM9oiUR9I=;
        b=N2M8xR6xJ7HZH++KBe0pDxRyF9FdmuwjmOfRyU8mTX4huJtgs3dRdtugFBeLd6g7Mk
         pYNvkP0lfStsTQetSLKrTrIZWU8yFZFOHbU4SIM8xWzd5YrQpjSgvTiLTCdKjJXIKqe2
         aHkRIv+CXQXeuTgkLNWmlmdQCW17+QoMWaxlab3xFaOsv2Hy0/TgZNPvO8SaG4cgD0dH
         0LJWjZXEe0MCp5NnaRpcTidnUNeN3LxIY/uyBG9qroK55QbnnrO18annVJkDVNRIa7UI
         gLsGOjF2CmpEGUBshN1IYJL6uiEwgVLfMe6ptG6YxkgpYrPM01Y+thUt3xb2REDWY0w0
         1GJQ==
X-Gm-Message-State: AO0yUKXR9d5g+YhUfvCRXwaIKOoqPP8lp0866qQW74lyc6Ue2gSE+58J
        e8tXDkyuMh6Xallr7J71vYq38cfD3OE=
X-Google-Smtp-Source: AK7set8KKK25yJnpBrNQwOrVCuhHjDj6dStlMmBmP6Qv/f5psG02zzPSwXpl0LplSTXTdchvTOJghw==
X-Received: by 2002:a17:902:cf4e:b0:19a:a815:2877 with SMTP id e14-20020a170902cf4e00b0019aa8152877mr1007747plg.6.1678410243971;
        Thu, 09 Mar 2023 17:04:03 -0800 (PST)
Received: from anarsoul-xps15.lan ([2604:3d08:7780:e52::398])
        by smtp.gmail.com with ESMTPSA id z8-20020a1709027e8800b0019cb6222691sm225763pla.133.2023.03.09.17.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 17:04:03 -0800 (PST)
From:   Vasily Khoruzhick <anarsoul@gmail.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH] mmc: sdhci-of-dwcmshc: properly determine max clock on Rockchip
Date:   Thu,  9 Mar 2023 17:03:49 -0800
Message-Id: <20230310010349.509132-1-anarsoul@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Currently .get_max_clock returns the current clock rate for cclk_emmc
on rk35xx, thus max clock gets set to whatever bootloader set it to.

In case of u-boot, it is intentionally reset to 50 MHz if it boots
from eMMC, see mmc_deinit() in u-boot sources. As a result, HS200 and
HS400 modes are never selected by Linux, because dwcmshc_rk35xx_postinit
clears appropriate caps if host->mmc->f_max is < 52MHz

cclk_emmc is not a fixed clock on rk35xx, so using
sdhci_pltfm_clk_get_max_clock is not appropriate here.

Implement rk35xx_get_max_clock that returns actual max clock for cclk_emmc.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index d1490469184b..e68cd87998c8 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -126,6 +126,13 @@ static unsigned int dwcmshc_get_max_clock(struct sdhci_host *host)
 		return pltfm_host->clock;
 }
 
+static unsigned int rk35xx_get_max_clock(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+
+	return clk_round_rate(pltfm_host->clk, ULONG_MAX);
+}
+
 static void dwcmshc_check_auto_cmd23(struct mmc_host *mmc,
 				     struct mmc_request *mrq)
 {
@@ -343,7 +350,7 @@ static const struct sdhci_ops sdhci_dwcmshc_rk35xx_ops = {
 	.set_clock		= dwcmshc_rk3568_set_clock,
 	.set_bus_width		= sdhci_set_bus_width,
 	.set_uhs_signaling	= dwcmshc_set_uhs_signaling,
-	.get_max_clock		= sdhci_pltfm_clk_get_max_clock,
+	.get_max_clock		= rk35xx_get_max_clock,
 	.reset			= rk35xx_sdhci_reset,
 	.adma_write_desc	= dwcmshc_adma_write_desc,
 };
-- 
2.39.2

