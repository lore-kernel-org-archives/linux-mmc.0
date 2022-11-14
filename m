Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E287C433FE
	for <linux-mmc@archiver.kernel.org>; Mon, 14 Nov 2022 09:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236974AbiKNJko (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 14 Nov 2022 04:40:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236946AbiKNJkR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Nov 2022 04:40:17 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0033C1EADD
        for <linux-mmc@vger.kernel.org>; Mon, 14 Nov 2022 01:40:11 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id bj12so26745680ejb.13
        for <linux-mmc@vger.kernel.org>; Mon, 14 Nov 2022 01:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/E7DQv1w5VxBWNYYy8b3rJwQQFYjed72q0l2u49VmFw=;
        b=mV1Xk5oqlPhbGM675526QGnANRWzR3kkuCK7FjmV9soqIRzH7cFh2DRZEQaq7RKsl8
         +sp0+OlHXt7xWppuqpq+9kMfLz+Fmc1qs3Ui6Tm3NaeH3UUyC7VtVRIhGjQmi9WLftgZ
         lRFGpWsBqHXodsusA1zkb0pMPsxHbH1JYQYcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/E7DQv1w5VxBWNYYy8b3rJwQQFYjed72q0l2u49VmFw=;
        b=JqcuMDuERcUc3uXTzCHYPpmMh6gD4Kj2hYnByRVsxf1kvlB2eXrukssPqdfwtlRFmF
         Gz5/XHvLRxpGQ7EQYufZCY9z1NN+0AO7f27/6/34YQTho6FBgkQxbuuUiIVWhHS3W7cA
         MIeHP3oEe/JBKExRvB/VTlZcaUFD8vZS0wwr3mcgbNtXyMI07CovWNneGSwOhGAYck/1
         lmJB7nUCSOnAdsX4sOvJw4KGCw5/m93ULIGQ1CltjUKfKsPDeTi51fk5VuFnwEU/ZGDF
         aM0UN5xB7de02qdPtFGV09gJLPaAFzAFKOV2NRxHs/QSIUReRpAothL76ptCjRbhTTSU
         z1Iw==
X-Gm-Message-State: ANoB5pm1MNokmOd2YOW1KaEmelKUnHTdv1UNNwGlo6NdJZhUCPRSM+UU
        07LGfkY3yMyQgQ4cYc4Yo9o6Rg==
X-Google-Smtp-Source: AA0mqf5rOmZDPmo+r9tZg7mKbD10KNVdVuxgpnD4x2FxOInLKSsw/pvFBCDxNyjJ0tF2dI6SUBll/Q==
X-Received: by 2002:a17:906:8d06:b0:78d:8d70:8bf8 with SMTP id rv6-20020a1709068d0600b0078d8d708bf8mr9312698ejc.15.1668418810409;
        Mon, 14 Nov 2022 01:40:10 -0800 (PST)
Received: from localhost.localdomain (vpn.streamunlimited.com. [91.114.0.140])
        by smtp.gmail.com with ESMTPSA id 26-20020a170906311a00b007ae693cd265sm3928068ejx.150.2022.11.14.01.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 01:40:09 -0800 (PST)
From:   Peter Suti <peter.suti@streamunlimited.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Peter Suti <peter.suti@streamunlimited.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: meson-gx: fix SDIO interrupt handling
Date:   Mon, 14 Nov 2022 10:38:57 +0100
Message-Id: <20221114093857.491695-1-peter.suti@streamunlimited.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

With the interrupt support introduced in commit 066ecde sometimes the
Marvell-8987 wifi chip entered a deadlock using the marvell-sd-uapsta-8987
vendor driver. The cause seems to be that sometimes the interrupt handler
handles 2 IRQs and one of them disables the interrupts which are not reenabled
when all interrupts are finished. To work around this, disable all interrupts
when we are in the IRQ context and reenable them when the current IRQ is handled.

Fixes: 066ecde ("mmc: meson-gx: add SDIO interrupt support")

Signed-off-by: Peter Suti <peter.suti@streamunlimited.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 6e5ea0213b47..972024d57d1c 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -950,6 +950,10 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
 	struct mmc_command *cmd;
 	u32 status, raw_status;
 	irqreturn_t ret = IRQ_NONE;
+	unsigned long flags;
+
+	spin_lock_irqsave(&host->lock, flags);
+	__meson_mmc_enable_sdio_irq(host->mmc, 0);
 
 	raw_status = readl(host->regs + SD_EMMC_STATUS);
 	status = raw_status & (IRQ_EN_MASK | IRQ_SDIO);
@@ -958,11 +962,11 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
 		dev_dbg(host->dev,
 			"Unexpected IRQ! irq_en 0x%08lx - status 0x%08x\n",
 			 IRQ_EN_MASK | IRQ_SDIO, raw_status);
-		return IRQ_NONE;
+		goto out_unlock;
 	}
 
 	if (WARN_ON(!host))
-		return IRQ_NONE;
+		goto out_unlock;
 
 	/* ack all raised interrupts */
 	writel(status, host->regs + SD_EMMC_STATUS);
@@ -970,17 +974,16 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
 	cmd = host->cmd;
 
 	if (status & IRQ_SDIO) {
-		spin_lock(&host->lock);
-		__meson_mmc_enable_sdio_irq(host->mmc, 0);
 		sdio_signal_irq(host->mmc);
-		spin_unlock(&host->lock);
 		status &= ~IRQ_SDIO;
-		if (!status)
+		if (!status) {
+			spin_unlock_irqrestore(&host->lock, flags);
 			return IRQ_HANDLED;
+		}
 	}
 
 	if (WARN_ON(!cmd))
-		return IRQ_NONE;
+		goto out_unlock;
 
 	cmd->error = 0;
 	if (status & IRQ_CRC_ERR) {
@@ -1023,6 +1026,10 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
 	if (ret == IRQ_HANDLED)
 		meson_mmc_request_done(host->mmc, cmd->mrq);
 
+out_unlock:
+	__meson_mmc_enable_sdio_irq(host->mmc, 1);
+	spin_unlock_irqrestore(&host->lock, flags);
+
 	return ret;
 }
 
-- 
2.25.1

