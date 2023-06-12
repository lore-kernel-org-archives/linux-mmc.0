Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F8FC7EE2F
	for <linux-mmc@archiver.kernel.org>; Mon, 12 Jun 2023 14:37:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbjFLOhj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 12 Jun 2023 10:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232370AbjFLOhi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Jun 2023 10:37:38 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF2E93
        for <linux-mmc@vger.kernel.org>; Mon, 12 Jun 2023 07:37:37 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f63ea7bfb6so4930551e87.3
        for <linux-mmc@vger.kernel.org>; Mon, 12 Jun 2023 07:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686580655; x=1689172655;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C6VYNnggALQS+aWwxSlOdeJ3Ss1vnAASO8xpvHWuOR4=;
        b=iq3CtyQ0v2x65MJKNjmwyusAnmWdc3YdPzJhb4TJEl50Ji4zTcp1XAigCth96DUNEW
         Mf98VWYjW78HjpSWotOQBkgr79EC8J3uizfhypyRh2uN6lghP9xUgSuaosWnFuc3GKBT
         LRhPfQsiO1yYKC/EXGPa885rZYPl8rEUilfdJK3Uf9jK4vwSvINMuQ/0D9l194nw9cZf
         9Zz4J1uPSAhXNinrbXddJG71ycOVg81+mcACGWGA4gKz6CudHSuJuiY9j80PhBH6buYl
         yXOSgB1sxI2PGVwJHezl/y64sP5jvYkhq3f1CZzyBkK+/7iOCWGXqbYZijTcyCIj+TpK
         KYNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686580655; x=1689172655;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C6VYNnggALQS+aWwxSlOdeJ3Ss1vnAASO8xpvHWuOR4=;
        b=TPcBhMKE6oCUCVT0WbLFoDRJ3FBn933fPNkwYYurq92Q6qba0kKoEaafYK5BcTmhhl
         HCW/9oXPNSCSkhNqMQdMg4msQmP0TTqurf35b0q4C/s9zGlcw4az4U64OL7Cz0JGgior
         96n2eKp0ePh3uDqZ5ZeXwtFmIll+rQnIoX6NZV8mOn1gruNAjOTn5NebvG19I0HncdCn
         6ZOSIvrMovWH02cSc2dDokuZRMoFiUVG3Pn2HqAR53HrToD5qH8AU1GiiaJuMsweU0NN
         Gw12zH3XyeQkMk0rRw/ZSPBYpQ7/yqRzGBHt5QlH8MK21/xb/YZR0011k8lGPyjmRhSO
         92mA==
X-Gm-Message-State: AC+VfDx+MM/JpBoqTkrtPx6nnxHQyMrFZaHIHtHQSG1zdU8nu+c8A17/
        5dJSt4XBhhON4Tni3RK1iCCMcDcUQOSKVn+4dds=
X-Google-Smtp-Source: ACHHUZ5jBcipLE/CZfT0xT0vHUGzu3gcFssZk0gdU78Acur4exUlhXP8LW724H1A93PiVTgcKP33Qw==
X-Received: by 2002:a19:7409:0:b0:4f6:29cf:c0d6 with SMTP id v9-20020a197409000000b004f629cfc0d6mr4296732lfe.9.1686580655357;
        Mon, 12 Jun 2023 07:37:35 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id w23-20020ac254b7000000b004f60be0c687sm1473282lfk.122.2023.06.12.07.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 07:37:34 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marek Vasut <marex@denx.de>,
        Yann Gautier <yann.gautier@foss.st.com>,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH] mmc: mmci: Set PROBE_PREFER_ASYNCHRONOUS
Date:   Mon, 12 Jun 2023 16:37:30 +0200
Message-Id: <20230612143730.210390-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

All mmc host driver should have enabled the asynchronous probe option, but
it seems like we missed to set it for mmci, so let's do that now.

Fixes: 21b2cec61c04 ("mmc: Set PROBE_PREFER_ASYNCHRONOUS for drivers that existed in v4.4")
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/mmci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index f2b2e8b0574e..97a77eefb11a 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -2455,6 +2455,7 @@ static struct amba_driver mmci_driver = {
 	.drv		= {
 		.name	= DRIVER_NAME,
 		.pm	= &mmci_dev_pm_ops,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe		= mmci_probe,
 	.remove		= mmci_remove,
-- 
2.34.1

