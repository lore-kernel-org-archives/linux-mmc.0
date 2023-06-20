Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA56EB64D7
	for <linux-mmc@archiver.kernel.org>; Tue, 20 Jun 2023 09:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjFTJLy (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 20 Jun 2023 05:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjFTJLm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Jun 2023 05:11:42 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E99B170F
        for <linux-mmc@vger.kernel.org>; Tue, 20 Jun 2023 02:11:29 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f841b7a697so5378952e87.3
        for <linux-mmc@vger.kernel.org>; Tue, 20 Jun 2023 02:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687252287; x=1689844287;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m4+L4CTwwQ+ZhSr/odNzt9Vvo5+byorLKpIFMbqnX5g=;
        b=Hh0Q4yCV95j2uH3RQjYYy0Z3Batk1TUI/uGeyHLRB7UEpYpXsi9f/BdIIfofGDb9r/
         +AKVQeHeiJRjmZ7wPNMMzM2V1joTIolnG1XgNOEa5Y6EMnXoiK2UY3dWRrUlXiaiEtDs
         7wud02mRArubEk1v5E0Q2AlQH0y5k+c3Zt6RRFmr80WthQFNL2cheocvNW6bv/uv9iT/
         Y9seCrl4LsEmurXEHPAzZOkzwjhL8jAxXH2eSyN36eMgr0bIgN1oBz8VzSvXqWu6HeoO
         AiHaFAor+IvGMVc40gPjZEahDvn3cyeNHPKBvR0U2Nyf5vdTqEXHnQUmF7yR8zV4m4oR
         UOqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687252287; x=1689844287;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m4+L4CTwwQ+ZhSr/odNzt9Vvo5+byorLKpIFMbqnX5g=;
        b=JEy1v3gvGO8GA8DHY7sAsU+1kyU+fhLAS6+v2QUmsXAwfsM7vn/7hFhultk29DohFP
         oAVAgyFSLgm5u40EJaQFvvvB4CcFWlAxVSDAHKAcz6JAc9CH9AcdtNxHzIPKqRFHC0v1
         SXu8R0TRYhKvW6NCF9QZt66yaF/ztm5+JHvIG4dxz70MYiZttUuF8mQZqr7++Ao86BxZ
         NepMVDM7zcAXsf3i7qombF95IHo/NbrkNHsKxVVzYHNTSCsVN/5zHfT9Eys8JdgOmR0c
         lphgNVLta3LGpWIZHk7FfUEA7KvfTeMfHhCrJxAZGvYYdqdY60q1GhXsO+P38XDWeamn
         mgUA==
X-Gm-Message-State: AC+VfDxEvTjkV2gK3Dnaj+VA/WFWMbeyzdrGpdICU6CbmfvcXQs4SR9F
        9NCzn2RwipHxBJ/UZvBoUGROYR9Qlj/nSP7lpiE=
X-Google-Smtp-Source: ACHHUZ5X4x4NIXoeixKVqxFdVUy6DdwPTVv4+ye47BMHGLhpm7OA3infrLIcUqQ6Zgvra5aEhkvhHA==
X-Received: by 2002:ac2:5b05:0:b0:4f4:c62c:c542 with SMTP id v5-20020ac25b05000000b004f4c62cc542mr6862162lfn.37.1687252287552;
        Tue, 20 Jun 2023 02:11:27 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id w15-20020ac2598f000000b004f854f93a8fsm291126lfn.18.2023.06.20.02.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 02:11:26 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marek Vasut <marex@denx.de>,
        Yann Gautier <yann.gautier@foss.st.com>
Subject: [PATCH] mmc: mmci: Add support for SW busy-end timeouts
Date:   Tue, 20 Jun 2023 11:11:13 +0200
Message-Id: <20230620091113.33393-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The ux500 variant doesn't have a HW based timeout to use for busy-end IRQs.
To avoid hanging and waiting for the card to stop signaling busy, let's
schedule a delayed work, according to the corresponding cmd->busy_timeout
for the command. If work gets to run, let's kick the IRQ handler to
completed the currently running request/command.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Tested-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/mmci.c             | 50 ++++++++++++++++++++++++++---
 drivers/mmc/host/mmci.h             |  3 +-
 drivers/mmc/host/mmci_stm32_sdmmc.c |  3 +-
 3 files changed, 49 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 8a661ea1a2d1..61d761646462 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -37,6 +37,7 @@
 #include <linux/pinctrl/consumer.h>
 #include <linux/reset.h>
 #include <linux/gpio/consumer.h>
+#include <linux/workqueue.h>
 
 #include <asm/div64.h>
 #include <asm/io.h>
@@ -682,7 +683,8 @@ static void ux500_busy_clear_mask_done(struct mmci_host *host)
  *                     |                 |
  *                    IRQ1              IRQ2
  */
-static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
+static bool ux500_busy_complete(struct mmci_host *host, struct mmc_command *cmd,
+				u32 status, u32 err_msk)
 {
 	void __iomem *base = host->base;
 	int retries = 10;
@@ -726,6 +728,8 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 				       host->variant->busy_detect_mask,
 				       base + MMCIMASK0);
 				host->busy_state = MMCI_BUSY_WAITING_FOR_START_IRQ;
+				schedule_delayed_work(&host->ux500_busy_timeout_work,
+				      msecs_to_jiffies(cmd->busy_timeout));
 				goto out_ret_state;
 			}
 			retries--;
@@ -753,6 +757,7 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 		} else {
 			dev_dbg(mmc_dev(host->mmc),
 				"lost busy status when waiting for busy start IRQ\n");
+			cancel_delayed_work(&host->ux500_busy_timeout_work);
 			ux500_busy_clear_mask_done(host);
 		}
 		break;
@@ -761,6 +766,7 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 		if (!(status & host->variant->busy_detect_flag)) {
 			host->busy_status |= status & (MCI_CMDSENT | MCI_CMDRESPEND);
 			writel(host->variant->busy_detect_mask, base + MMCICLEAR);
+			cancel_delayed_work(&host->ux500_busy_timeout_work);
 			ux500_busy_clear_mask_done(host);
 		} else {
 			dev_dbg(mmc_dev(host->mmc),
@@ -1277,6 +1283,7 @@ static void
 mmci_start_command(struct mmci_host *host, struct mmc_command *cmd, u32 c)
 {
 	void __iomem *base = host->base;
+	bool busy_resp = cmd->flags & MMC_RSP_BUSY;
 	unsigned long long clks;
 
 	dev_dbg(mmc_dev(host->mmc), "op %02x arg %08x flags %08x\n",
@@ -1304,10 +1311,11 @@ mmci_start_command(struct mmci_host *host, struct mmc_command *cmd, u32 c)
 	host->busy_status = 0;
 	host->busy_state = MMCI_BUSY_DONE;
 
-	if (host->variant->busy_timeout && cmd->flags & MMC_RSP_BUSY) {
-		if (!cmd->busy_timeout)
-			cmd->busy_timeout = 10 * MSEC_PER_SEC;
+	/* Assign a default timeout if the core does not provide one */
+	if (busy_resp && !cmd->busy_timeout)
+		cmd->busy_timeout = 10 * MSEC_PER_SEC;
 
+	if (busy_resp && host->variant->busy_timeout) {
 		if (cmd->busy_timeout > host->mmc->max_busy_timeout)
 			clks = (unsigned long long)host->mmc->max_busy_timeout * host->cclk;
 		else
@@ -1448,7 +1456,7 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
 
 	/* Handle busy detection on DAT0 if the variant supports it. */
 	if (busy_resp && host->variant->busy_detect)
-		if (!host->ops->busy_complete(host, status, err_msk))
+		if (!host->ops->busy_complete(host, cmd, status, err_msk))
 			return;
 
 	host->cmd = NULL;
@@ -1495,6 +1503,34 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
 	}
 }
 
+/*
+ * This busy timeout worker is used to "kick" the command IRQ if a
+ * busy detect IRQ fails to appear in reasonable time. Only used on
+ * variants with busy detection IRQ delivery.
+ */
+static void ux500_busy_timeout_work(struct work_struct *work)
+{
+	struct mmci_host *host = container_of(work, struct mmci_host,
+					ux500_busy_timeout_work.work);
+	unsigned long flags;
+	u32 status;
+
+	spin_lock_irqsave(&host->lock, flags);
+
+	if (host->cmd) {
+		dev_dbg(mmc_dev(host->mmc), "timeout waiting for busy IRQ\n");
+
+		/* If we are still busy let's tag on a cmd-timeout error. */
+		status = readl(host->base + MMCISTATUS);
+		if (status & host->variant->busy_detect_flag)
+			status |= MCI_CMDTIMEOUT;
+
+		mmci_cmd_irq(host, host->cmd, status);
+	}
+
+	spin_unlock_irqrestore(&host->lock, flags);
+}
+
 static int mmci_get_rx_fifocnt(struct mmci_host *host, u32 status, int remain)
 {
 	return remain - (readl(host->base + MMCIFIFOCNT) << 2);
@@ -2309,6 +2345,10 @@ static int mmci_probe(struct amba_device *dev,
 			goto clk_disable;
 	}
 
+	if (host->variant->busy_detect)
+		INIT_DELAYED_WORK(&host->ux500_busy_timeout_work,
+				  ux500_busy_timeout_work);
+
 	writel(MCI_IRQENABLE | variant->start_err, host->base + MMCIMASK0);
 
 	amba_set_drvdata(dev, mmc);
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 12a7bbd3ce26..69b2439842dd 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -393,7 +393,7 @@ struct mmci_host_ops {
 	void (*dma_error)(struct mmci_host *host);
 	void (*set_clkreg)(struct mmci_host *host, unsigned int desired);
 	void (*set_pwrreg)(struct mmci_host *host, unsigned int pwr);
-	bool (*busy_complete)(struct mmci_host *host, u32 status, u32 err_msk);
+	bool (*busy_complete)(struct mmci_host *host, struct mmc_command *cmd, u32 status, u32 err_msk);
 	void (*pre_sig_volt_switch)(struct mmci_host *host);
 	int (*post_sig_volt_switch)(struct mmci_host *host, struct mmc_ios *ios);
 };
@@ -451,6 +451,7 @@ struct mmci_host {
 	void			*dma_priv;
 
 	s32			next_cookie;
+	struct delayed_work	ux500_busy_timeout_work;
 };
 
 #define dma_inprogress(host)	((host)->dma_in_progress)
diff --git a/drivers/mmc/host/mmci_stm32_sdmmc.c b/drivers/mmc/host/mmci_stm32_sdmmc.c
index 953d1be4e379..f07cfbeafe2e 100644
--- a/drivers/mmc/host/mmci_stm32_sdmmc.c
+++ b/drivers/mmc/host/mmci_stm32_sdmmc.c
@@ -372,7 +372,8 @@ static u32 sdmmc_get_dctrl_cfg(struct mmci_host *host)
 	return datactrl;
 }
 
-static bool sdmmc_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
+static bool sdmmc_busy_complete(struct mmci_host *host, struct mmc_command *cmd,
+				u32 status, u32 err_msk)
 {
 	void __iomem *base = host->base;
 	u32 busy_d0, busy_d0end, mask, sdmmc_status;
-- 
2.34.1

