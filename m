Return-Path: <SRS0=02U7=DE=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5374EC2D0A8
	for <linux-mmc@archiver.kernel.org>; Sun, 27 Sep 2020 02:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D0FC239D0
	for <linux-mmc@archiver.kernel.org>; Sun, 27 Sep 2020 02:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TLV5QSB6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbgI0Cz2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 26 Sep 2020 22:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbgI0Cz2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 26 Sep 2020 22:55:28 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CC5C0613CE;
        Sat, 26 Sep 2020 19:55:28 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x22so6371366pfo.12;
        Sat, 26 Sep 2020 19:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5wQP8gxQEhJdX16HDBnel4UAqpoVYdnXnUfTDSEGDPM=;
        b=TLV5QSB6+iZuhDv9OY2xSlGaq8eRNcvDh6j54iejbe3kxpC5JScz5CFzsoi/mD+4jl
         iTMBq+BmsjzF7XCyAbtciTRKtcd6hDSkGUoXwXqDYRPXWKEp/GCcFRzmngBUu9EoSDY3
         lc8IfwTVimvx7467szsdWVWljZX6X/u3NSgebzhfoj9QXPSJrGumpj+fbsjU9HYqg+s0
         AJC7DLcHkOE4PHkrseXxzGia9GtcoJy4Tdz9atmceMWqgBiBRALHljUx174OriXS+Q54
         GhkkvXtSyxFfkGFGGZ6pdfcjlxQO+ECqik0JAc/PkFX1cH47yZrDi3aA4eKbRc5PU8su
         axnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5wQP8gxQEhJdX16HDBnel4UAqpoVYdnXnUfTDSEGDPM=;
        b=esCGYPEw5BZSjiJGsJYFZEFmRKkLsr5NE6K1gGRMn/X2Q/tNXCKlM9+7bu3Xd5eJl2
         U/m9z3jEIrb6a7feQGVywRuqFsRMChjpcYYVczoWlciMpgBMWHzswtIW6wAeUVsC0BPR
         LHL9ltV1zAWivfO5SyewDkCgq2lMG5JQ/Van/x4svhDpKrN8LR5S0Fx/z2biTcXDkyt3
         j651vTJ5ByS8ibjUPBg1rSNcobzOOjnGd8kmRvm500r3GOEALraNJX9Yxp2wWoFPCHoV
         sj0utMoczePRnVt5DVOCubPMGNxHIwa6Ftwfx+/T/3Dsw/tZ7zDzIHeCy2R/uou8U7Lk
         DHKQ==
X-Gm-Message-State: AOAM53170xHVXE4Y5KI8VDR6VSnTLd3GwZW5PEkDbNeI4ctN4BUdqx/c
        /tfRRD20lMW3/q8mQjCbPNp+ruZn5UuUEv7e
X-Google-Smtp-Source: ABdhPJyHYKFECut/kiN4Y/hWA1pDsB1jKEgeA/WxE9DXAIAO0u9D9OR094Z+1KPAsxMMnnYwK1Rs7A==
X-Received: by 2002:a63:8c6:: with SMTP id 189mr4623552pgi.207.1601175327606;
        Sat, 26 Sep 2020 19:55:27 -0700 (PDT)
Received: from buster.buster.your.domain ([2402:b801:2840:8200:21e:6ff:fe42:5032])
        by smtp.gmail.com with ESMTPSA id x13sm6685025pfj.199.2020.09.26.19.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2020 19:55:27 -0700 (PDT)
From:   Brad Harper <bjharper@gmail.com>
To:     linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Brad Harper <bjharper@gmail.com>
Subject: [PATCH v2 1/1] mmc: host: meson-gx-mmc: fix possible deadlock condition for preempt_rt
Date:   Sat, 26 Sep 2020 22:54:18 -0400
Message-Id: <20200927025418.12382-2-bjharper@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200927025418.12382-1-bjharper@gmail.com>
References: <20200927025418.12382-1-bjharper@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

---
 drivers/mmc/host/meson-gx-mmc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 08a3b1c05..3ba8f988d 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -146,6 +146,7 @@ struct sd_emmc_desc {
 };
 
 struct meson_host {
+	spinlock_t		lock;
 	struct	device		*dev;
 	struct	meson_mmc_data *data;
 	struct	mmc_host	*mmc;
@@ -1051,6 +1052,7 @@ static int meson_mmc_probe(struct platform_device *pdev)
 	host->mmc = mmc;
 	host->dev = &pdev->dev;
 	dev_set_drvdata(&pdev->dev, host);
+	spin_lock_init(&host->lock);
 
 	/* The G12A SDIO Controller needs an SRAM bounce buffer */
 	host->dram_access_quirk = device_property_read_bool(&pdev->dev,
@@ -1139,7 +1141,7 @@ static int meson_mmc_probe(struct platform_device *pdev)
 	       host->regs + SD_EMMC_IRQ_EN);
 
 	ret = request_threaded_irq(host->irq, meson_mmc_irq,
-				   meson_mmc_irq_thread, IRQF_ONESHOT,
+				   meson_mmc_irq_thread, 0,
 				   dev_name(&pdev->dev), host);
 	if (ret)
 		goto err_init_clk;
-- 
2.20.1

