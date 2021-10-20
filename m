Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36902C433FE
	for <linux-mmc@archiver.kernel.org>; Wed, 20 Oct 2021 10:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F020610FF
	for <linux-mmc@archiver.kernel.org>; Wed, 20 Oct 2021 10:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbhJTKbn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 20 Oct 2021 06:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbhJTKbn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Oct 2021 06:31:43 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C83C06161C
        for <linux-mmc@vger.kernel.org>; Wed, 20 Oct 2021 03:29:28 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 145so11667586ljj.1
        for <linux-mmc@vger.kernel.org>; Wed, 20 Oct 2021 03:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/FuRIXAF4mrPwG+ZHHhikoeSd7OTNEOOMYIygH7Yo04=;
        b=iPLuR+8gwSNZd6AuFhQ1Uie5MEVNjdrq4sMve9XqdwN6rrc/pSOmExwAo/TFCY0w+X
         nwKu83h44fYGoEW4W708mb6K8sDgDcs2jp60Hl+6P4dWFZphofrvsidy/OIgT/bwnTiM
         Garwk0S3Ti8A+clLSFPZO2ODpWpU+SICp+VpnAyux1+OrqW95+kyyR+RujuWRUAjifzZ
         9wx1Y+j9WQFocuG89haQTW+pfd7gJ4WRtLglbGP7neGa6P+bHKso4GAHp3ZGIuhrY58i
         ha0UMO/HiKypOxJRUmXrJoBGlNWKpJzQltKUkQmaRNfkGeYrLe/1nNoReSzvXbPBmt5A
         XsQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/FuRIXAF4mrPwG+ZHHhikoeSd7OTNEOOMYIygH7Yo04=;
        b=o7rDY69uXs3EE0P+P5SmwErJAWLH0dPHqnxXMChvl54o8LSOzYLpqfEDl7WJso6ShJ
         XqW87vI9hAZ+PEVB1kqbQ1EImtvxzLovEJ+COONr+MPnIqpBbStU3GsViMggCOViQJAg
         Z9txreadOvCwa160D5KNso5mQx8Byje7iHncP/Mpdp3kGnCzd3DC/6OwdJqXunAiEkCG
         NB4PHAY7lgBtZ1he4DeaQZf+E2U5j6Z1T2aq0JxLwYmbFBiJLTpCSkQ81vvqnTtYCGXs
         yo7XDFufKSwxSSdFFixGz3xk1i+TZZ87A9fYtNXQIlXF9oPc+JgcKLNrs2loPlt+USSG
         JLHw==
X-Gm-Message-State: AOAM531sDMG+L2k4myR4PHjgWhzmcL4PiajXBJ+6lDi1LXvc2ctMvX1M
        c2nSlwt9yh44YaCGTRAPjFi+QL4K0Ocbrw==
X-Google-Smtp-Source: ABdhPJw2uTcCvKkapBHvjuVhv6Fi4/aV/cEhgvolT8M+MqRJuYfQSFIYnfINSGnjsb4D0Zl4R3lK6w==
X-Received: by 2002:a2e:a40f:: with SMTP id p15mr12964426ljn.497.1634725766611;
        Wed, 20 Oct 2021 03:29:26 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-129-146.NA.cust.bahnhof.se. [155.4.129.146])
        by smtp.gmail.com with ESMTPSA id x10sm160343lff.44.2021.10.20.03.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 03:29:25 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Jaehoon Chung <jh80.chung@samsung.com>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] mmc: dw_mmc: Drop use of ->init_card() callback
Date:   Wed, 20 Oct 2021 12:29:07 +0200
Message-Id: <20211020102907.70195-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

For dw_mmc, the ->init_card() callback is being used to turn on/off
automatic internal clock gating for powersave, which is needed to properly
support SDIO irqs on DAT1.

However, using the ->init_card() comes with a drawback in this case, as it
means that the powersave feature becomes disabled, no matter whether the
SDIO irqs becomes turned on or not. To improve the behaviour, let's change
into using the ->enable_sdio_irq() callback instead. This works fine,
because dw_mmc uses sdio_signal_irq() to signal the irqs, thus the
->enable_sdio_irq() is never executed from within atomic context.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/dw_mmc.c | 39 +++++++++++++++++----------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 1e8f1bb3cad7..d977f34f6b55 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1611,37 +1611,32 @@ static void dw_mci_hw_reset(struct mmc_host *mmc)
 	usleep_range(200, 300);
 }
 
-static void dw_mci_init_card(struct mmc_host *mmc, struct mmc_card *card)
+static void dw_mci_prepare_sdio_irq(struct dw_mci_slot *slot, bool prepare)
 {
-	struct dw_mci_slot *slot = mmc_priv(mmc);
 	struct dw_mci *host = slot->host;
+	const u32 clken_low_pwr = SDMMC_CLKEN_LOW_PWR << slot->id;
+	u32 clk_en_a_old;
+	u32 clk_en_a;
 
 	/*
 	 * Low power mode will stop the card clock when idle.  According to the
 	 * description of the CLKENA register we should disable low power mode
 	 * for SDIO cards if we need SDIO interrupts to work.
 	 */
-	if (mmc->caps & MMC_CAP_SDIO_IRQ) {
-		const u32 clken_low_pwr = SDMMC_CLKEN_LOW_PWR << slot->id;
-		u32 clk_en_a_old;
-		u32 clk_en_a;
 
-		clk_en_a_old = mci_readl(host, CLKENA);
-
-		if (card->type == MMC_TYPE_SDIO ||
-		    card->type == MMC_TYPE_SD_COMBO) {
-			set_bit(DW_MMC_CARD_NO_LOW_PWR, &slot->flags);
-			clk_en_a = clk_en_a_old & ~clken_low_pwr;
-		} else {
-			clear_bit(DW_MMC_CARD_NO_LOW_PWR, &slot->flags);
-			clk_en_a = clk_en_a_old | clken_low_pwr;
-		}
+	clk_en_a_old = mci_readl(host, CLKENA);
+	if (prepare) {
+		set_bit(DW_MMC_CARD_NO_LOW_PWR, &slot->flags);
+		clk_en_a = clk_en_a_old & ~clken_low_pwr;
+	} else {
+		clear_bit(DW_MMC_CARD_NO_LOW_PWR, &slot->flags);
+		clk_en_a = clk_en_a_old | clken_low_pwr;
+	}
 
-		if (clk_en_a != clk_en_a_old) {
-			mci_writel(host, CLKENA, clk_en_a);
-			mci_send_cmd(slot, SDMMC_CMD_UPD_CLK |
-				     SDMMC_CMD_PRV_DAT_WAIT, 0);
-		}
+	if (clk_en_a != clk_en_a_old) {
+		mci_writel(host, CLKENA, clk_en_a);
+		mci_send_cmd(slot, SDMMC_CMD_UPD_CLK | SDMMC_CMD_PRV_DAT_WAIT,
+			     0);
 	}
 }
 
@@ -1669,6 +1664,7 @@ static void dw_mci_enable_sdio_irq(struct mmc_host *mmc, int enb)
 	struct dw_mci_slot *slot = mmc_priv(mmc);
 	struct dw_mci *host = slot->host;
 
+	dw_mci_prepare_sdio_irq(slot, enb);
 	__dw_mci_enable_sdio_irq(slot, enb);
 
 	/* Avoid runtime suspending the device when SDIO IRQ is enabled */
@@ -1790,7 +1786,6 @@ static const struct mmc_host_ops dw_mci_ops = {
 	.execute_tuning		= dw_mci_execute_tuning,
 	.card_busy		= dw_mci_card_busy,
 	.start_signal_voltage_switch = dw_mci_switch_voltage,
-	.init_card		= dw_mci_init_card,
 	.prepare_hs400_tuning	= dw_mci_prepare_hs400_tuning,
 };
 
-- 
2.25.1

