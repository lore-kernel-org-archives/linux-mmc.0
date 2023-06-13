Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA4ACEB64DB
	for <linux-mmc@archiver.kernel.org>; Tue, 13 Jun 2023 20:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbjFMUej (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 13 Jun 2023 16:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbjFMUeh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Jun 2023 16:34:37 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD1918C
        for <linux-mmc@vger.kernel.org>; Tue, 13 Jun 2023 13:34:36 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f6370ddd27so7478088e87.0
        for <linux-mmc@vger.kernel.org>; Tue, 13 Jun 2023 13:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686688475; x=1689280475;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WWKwNW1e3O9pZLa+y32ctA1ee6HTYoouSwcC3BybN+g=;
        b=QGYyuzZVnU4QISKkli0HiuDScYZ0QZySflKskizSHBN5975GKBU+mutVM0U4ZQFblc
         KaGOU177Qyww9UK4GjhWfvaXcOCzfvFvRRRZl1SvL50WA7RPGs3QNPiH8PtNpK+hzkAl
         ZyONkLmrX0PKFHLznDmCLx8FJXsgYf+7bfGNXqvGOVsYXw0gwfv0FwUc1MrHj+gyltUa
         N/cyE2fYEwpAt/zHipR/VyvVzcUntXHdbR3Z+2jxKZjsCJv2st95kz/ex2f8YjVzcLCk
         HVDGz3WCnY27BjVyATcXTZkQmevlc5N3yXrLcKOEnML+bELFQkYK9M6/8s4wd8tVmQ7n
         +DCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686688475; x=1689280475;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WWKwNW1e3O9pZLa+y32ctA1ee6HTYoouSwcC3BybN+g=;
        b=eVBa567ANGvIL47pet+6+1Cv9Ku7vdbhnte33y9v/My1+rt4Tc3f9cUNmWYlv9tfSI
         64/os27euqPw+YkrcgFNKaweOCOh+X4C5Cvusv0IqMLhPfagcbmkKnm2Pk35sIXvzn5Q
         tTFYtlL44U19M29cTzyowJg04Fd5YjR6oHxHHngs0sRmuDSbl8tJdRaXFePRbGvwWq9K
         iX/QyWQDAEU65XP3wGrHrLfUtFj+UW5a2X3WeukC1V4jcdr3P19WtTD2yIuZo61s7eZY
         UJxovmALjNmc9zgkRAB4kB+xxlgPtY+oWqFuHCiwC7VHEUVHVGyT9LepxdZnr0iA5bfI
         mUNg==
X-Gm-Message-State: AC+VfDw5nOq1UCMKvcjX6UTGz2i5mkpea6JgyUFTqhApvm8ARMRm/Qgv
        FY0isjCjmpcHTKcpSGqwvAvrnA==
X-Google-Smtp-Source: ACHHUZ7prTJM/cGdgP+zQZasvHAkCXCCG4a+f1mqLSPuOoGkDIe5m1jILBW1YnsOGQAb2JtZJSglTw==
X-Received: by 2002:a19:ab01:0:b0:4f1:3bd7:e53a with SMTP id u1-20020a19ab01000000b004f13bd7e53amr6432996lfe.49.1686688474801;
        Tue, 13 Jun 2023 13:34:34 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id l12-20020a19c20c000000b004f26f699e9dsm1897813lfc.184.2023.06.13.13.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 13:34:34 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 13 Jun 2023 22:34:26 +0200
Subject: [PATCH v4 10/10] mmc: mmci: Add busydetect timeout
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230405-pl180-busydetect-fix-v4-10-df9c8c504353@linaro.org>
References: <20230405-pl180-busydetect-fix-v4-0-df9c8c504353@linaro.org>
In-Reply-To: <20230405-pl180-busydetect-fix-v4-0-df9c8c504353@linaro.org>
To:     Yann Gautier <yann.gautier@foss.st.com>,
        Stefan Hansson <newbyte@disroot.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     linux-mmc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.2
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add a timeout for busydetect IRQs using a delayed work.
It might happen (and does happen) on Ux500 that the first
busy detect IRQ appears and not the second one. This will
make the host hang indefinitely waiting for the second
IRQ to appear.

Calculate the busy timeout unconditionally in
mmci_start_command() using the code developed for STM32
and use this as a timeout for the command.

This makes the eMMC work again on Skomer.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v3->v4:
- Use the calculated command busy timeout from the core
  or the same calculated default as for STM32.
ChangeLog v2->v3:
- Rebased.
ChangeLog v1->v2:
- No changes
---
 drivers/mmc/host/mmci.c | 30 +++++++++++++++++++++++++++---
 drivers/mmc/host/mmci.h |  1 +
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 478f71dc7f34..12df1c231177 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -37,6 +37,7 @@
 #include <linux/pinctrl/consumer.h>
 #include <linux/reset.h>
 #include <linux/gpio/consumer.h>
+#include <linux/workqueue.h>
 
 #include <asm/div64.h>
 #include <asm/io.h>
@@ -740,6 +741,8 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 			host->busy_status |= status & (MCI_CMDSENT | MCI_CMDRESPEND);
 			writel(host->variant->busy_detect_mask, base + MMCICLEAR);
 			host->busy_state = MMCI_BUSY_WAITING_FOR_END_IRQ;
+			schedule_delayed_work(&host->busy_timeout_work,
+					      msecs_to_jiffies(host->cmd->busy_timeout));
 		} else {
 			dev_dbg(mmc_dev(host->mmc),
 				"lost busy status when waiting for busy start IRQ\n");
@@ -751,6 +754,7 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 		if (status & host->variant->busy_detect_flag) {
 			host->busy_status |= status & (MCI_CMDSENT | MCI_CMDRESPEND);
 			writel(host->variant->busy_detect_mask, base + MMCICLEAR);
+			cancel_delayed_work_sync(&host->busy_timeout_work);
 			ux500_busy_clear_mask_done(host);
 		} else {
 			dev_dbg(mmc_dev(host->mmc),
@@ -1295,10 +1299,11 @@ mmci_start_command(struct mmci_host *host, struct mmc_command *cmd, u32 c)
 	host->busy_status = 0;
 	host->busy_state = MMCI_BUSY_DONE;
 
-	if (host->variant->busy_timeout && cmd->flags & MMC_RSP_BUSY) {
-		if (!cmd->busy_timeout)
-			cmd->busy_timeout = 10 * MSEC_PER_SEC;
+	/* Assign a default timeout if the core does not provide one */
+	if (!cmd->busy_timeout)
+		cmd->busy_timeout = 10 * MSEC_PER_SEC;
 
+	if (host->variant->busy_timeout && cmd->flags & MMC_RSP_BUSY) {
 		if (cmd->busy_timeout > host->mmc->max_busy_timeout)
 			clks = (unsigned long long)host->mmc->max_busy_timeout * host->cclk;
 		else
@@ -1486,6 +1491,22 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
 	}
 }
 
+/*
+ * This busy timeout worker is used to "kick" the command IRQ if a
+ * busy detect IRQ fails to appear in reasonable time. Only used on
+ * variants with busy detection IRQ delivery.
+ */
+static void busy_timeout_work(struct work_struct *work)
+{
+	struct mmci_host *host =
+		container_of(work, struct mmci_host, busy_timeout_work.work);
+	u32 status;
+
+	dev_dbg(mmc_dev(host->mmc), "timeout waiting for busy IRQ\n");
+	status = readl(host->base + MMCISTATUS);
+	mmci_cmd_irq(host, host->cmd, status);
+}
+
 static int mmci_get_rx_fifocnt(struct mmci_host *host, u32 status, int remain)
 {
 	return remain - (readl(host->base + MMCIFIFOCNT) << 2);
@@ -2299,6 +2320,9 @@ static int mmci_probe(struct amba_device *dev,
 			goto clk_disable;
 	}
 
+	if (host->variant->busy_detect && host->ops->busy_complete)
+		INIT_DELAYED_WORK(&host->busy_timeout_work, busy_timeout_work);
+
 	writel(MCI_IRQENABLE | variant->start_err, host->base + MMCIMASK0);
 
 	amba_set_drvdata(dev, mmc);
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 12a7bbd3ce26..95d3d0a6049b 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -451,6 +451,7 @@ struct mmci_host {
 	void			*dma_priv;
 
 	s32			next_cookie;
+	struct delayed_work	busy_timeout_work;
 };
 
 #define dma_inprogress(host)	((host)->dma_in_progress)

-- 
2.40.1

