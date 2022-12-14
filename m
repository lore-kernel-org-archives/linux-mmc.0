Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA756C001B2
	for <linux-mmc@archiver.kernel.org>; Wed, 14 Dec 2022 13:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238391AbiLNNsH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 14 Dec 2022 08:48:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiLNNsG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Dec 2022 08:48:06 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F69264A6
        for <linux-mmc@vger.kernel.org>; Wed, 14 Dec 2022 05:48:03 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id d131so21462552ybh.4
        for <linux-mmc@vger.kernel.org>; Wed, 14 Dec 2022 05:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rduJSBHNOfADwB39FsLCzXunOBvEcaJu6tUh95KODL4=;
        b=fdwnhavsGqlgQt7e1eaz36uYU8Z77IBoLK4pevJAqvSoZWgxTQUVZ6VtElmj0yFLJF
         Ufo+Nsy/BTv1p3N4pQUL4uYYI8A3yXLzI6rGOnVNy7F45EiZT39czJ9slCdQnpiP4cXz
         PUbm5mvjGFiV7BXlDC5zbiTWA9nhEzN8QR1gM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rduJSBHNOfADwB39FsLCzXunOBvEcaJu6tUh95KODL4=;
        b=jUWIou5UgVLO4cewN3wnRJVZ0JTmkBRHM0CpfbhjFx3JQyTdHgcyZDkDTQmTyfeb/H
         I4nTOwLHON13/f3ZKUnzU8HAIzXuapvNjXkEDK+NCbRyjT+phRrVlrwHoSyhgAVVUHwu
         N+1HAnIsLaw1suItvrnNGyyrnHtOy2Kx0iHCqxkFTWUsOwn0NvGIpuuIBuR7e5XvRhr9
         e0Y+7FO44FvqA8WFMqu88cQcHd8EHPnKUn3kfdmeV/04mJQvG4zl00qXS9z687jyocgj
         KCG1CklpYzbLc9Cg6RCEuPjmylaBM9lITDmo2aqsGqHHwGB6fkEvaq7LExbCRFlW2ouy
         I+SQ==
X-Gm-Message-State: ANoB5pn7TK/oj6rfEYrFriltAi0sj7Yy46NuUHSZoRDSLyT1bn3Gs5L+
        su26fKhwuhRwo611kFbKqRprTiHoFs13X46o
X-Google-Smtp-Source: AA0mqf5CDWDQUpYOHhb4MnlcEthGXqB5EMVH+jnlo0LHvdsh2lxNCgqVkA31Re7Rk3wPzDy53O2N/g==
X-Received: by 2002:a05:6902:147:b0:724:6d18:6c36 with SMTP id p7-20020a056902014700b007246d186c36mr11589008ybh.23.1671025683021;
        Wed, 14 Dec 2022 05:48:03 -0800 (PST)
Received: from localhost.localdomain (vpn.streamunlimited.com. [91.114.0.140])
        by smtp.gmail.com with ESMTPSA id f10-20020a05620a408a00b006eeb3165565sm10139602qko.80.2022.12.14.05.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 05:48:02 -0800 (PST)
From:   Peter Suti <peter.suti@streamunlimited.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Peter Suti <peter.suti@streamunlimited.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v3] mmc: meson-gx: fix SDIO interrupt handling
Date:   Wed, 14 Dec 2022 14:46:21 +0100
Message-Id: <20221214134620.3028726-1-peter.suti@streamunlimited.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <52861a84-0fe2-37f0-d66a-145f2ebe1d79@gmail.com>
References: <52861a84-0fe2-37f0-d66a-145f2ebe1d79@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

With the interrupt support introduced in commit 066ecde sometimes the
Marvell-8987 wifi chip got stuck using the marvell-sd-uapsta-8987
vendor driver. The cause seems to be that after sending ack to all interrupts
the IRQ_SDIO still happens, but it is ignored.

To work around this, recheck the IRQ_SDIO after meson_mmc_request_done().

Inspired by 9e2582e ("mmc: mediatek: fix SDIO irq issue") which used a
similar fix to handle lost interrupts.

Fixes: 066ecde ("mmc: meson-gx: add SDIO interrupt support")

Signed-off-by: Peter Suti <peter.suti@streamunlimited.com>
---
Changes in v2:
	- use spin_lock instead of spin_lock_irqsave
	- only reenable interrupts if they were enabled already

Changes in v3:
	- Rework the patch based on feedback from Heiner Kallweit.
		The IRQ does not happen on 2 CPUs and the hard IRQ is not re-entrant.
		But still one SDIO IRQ is lost without this change.
		After the ack, reading the SD_EMMC_STATUS BIT(15) is set, but 
		meson_mmc_irq() is never called again.

		The fix is similar to Mediatek msdc_recheck_sdio_irq().
		That platform also loses an IRQ in some cases it seems.

 drivers/mmc/host/meson-gx-mmc.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 6e5ea0213b47..7d3ee2f9a7f6 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -1023,6 +1023,22 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
 	if (ret == IRQ_HANDLED)
 		meson_mmc_request_done(host->mmc, cmd->mrq);
 
+	/*
+	* Sometimes after we ack all raised interrupts,
+	* an IRQ_SDIO can still be pending, which can get lost.
+	*
+	* To prevent this, recheck the IRQ_SDIO here and schedule
+	* it to be processed.
+	*/
+	raw_status = readl(host->regs + SD_EMMC_STATUS);
+	status = raw_status & (IRQ_EN_MASK | IRQ_SDIO);
+	if (status & IRQ_SDIO) {
+		spin_lock(&host->lock);
+		__meson_mmc_enable_sdio_irq(host->mmc, 0);
+		sdio_signal_irq(host->mmc);
+		spin_unlock(&host->lock);
+	}
+
 	return ret;
 }
 
-- 
2.25.1

