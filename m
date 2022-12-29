Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97DB6C3DA79
	for <linux-mmc@archiver.kernel.org>; Thu, 29 Dec 2022 20:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233854AbiL2UFI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 29 Dec 2022 15:05:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233861AbiL2UFG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Dec 2022 15:05:06 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5587413EB5
        for <linux-mmc@vger.kernel.org>; Thu, 29 Dec 2022 12:05:05 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id o31-20020a17090a0a2200b00223fedffb30so19832881pjo.3
        for <linux-mmc@vger.kernel.org>; Thu, 29 Dec 2022 12:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lA6khbYwNTUEkyhgFPN6yUEAH+2Z3l7izmoOYpawnMY=;
        b=BMMNNSCPn2qhoE9uGm4q6zrLXVMvzRWmjNRiDjcnpHxoVYmr4H+RDr5TfSgSbKSeeY
         CNSfknKs2ijddQagcIl9TJW/ul9xMSxhQ/Wuawj0loG7XQxjyOw3giiJF1hIXFQWq5hy
         6ql18QO1JzCf5ccMtQGiUhZt0FllnANDTUGio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lA6khbYwNTUEkyhgFPN6yUEAH+2Z3l7izmoOYpawnMY=;
        b=WqnPf7YjzQA+YYrR5dY8CuqUFweF9m7hyQ/roHsWCnZJnwWfzDEmH/hMzZwCkNQbKY
         Al6WoTkI4Ie2JWu4FCezDqQhXGHFpPSQdzGop1lFDguixxceOsO0Ksy/K24nCyj04o4V
         twruYo2EPSMOcyJzyL1zyFkE29aK3MvLPPD//fJ80DEQwGQDJMUVnIrMNQg7MAEcgKXB
         AbJw6K2u9nrO8/s0qDhk+AHCKzyKzwl7Upd6fw+o7RXGoI58du3yUppbsb1iKa8I/wA0
         oIummucRaXrMb7uDDx68hv7TYM87qyDX6yTJHcGZjC/O7WZAjN4HaBLwlkVAe6/jzM5O
         42QQ==
X-Gm-Message-State: AFqh2koQjpmJltCbBnUhJf6YgmeexDwglIhqmUxFpU//ylOcr0PStFK0
        3UVnxCZ+F/w3wDyryLeW76mCUA==
X-Google-Smtp-Source: AMrXdXtDdcoBE8iBS3xNoIhIbIPoZH6cfi+bNg4YggYsyXWMRDsuQC9k3AjS032M55xFYRpLDlKSrw==
X-Received: by 2002:a17:902:a510:b0:192:48d1:f06c with SMTP id s16-20020a170902a51000b0019248d1f06cmr27429481plq.35.1672344304934;
        Thu, 29 Dec 2022 12:05:04 -0800 (PST)
Received: from doug-ryzen-5700G.. ([192.183.212.197])
        by smtp.gmail.com with ESMTPSA id w17-20020a170902e89100b00189ac5a2340sm13438589plg.124.2022.12.29.12.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 12:05:04 -0800 (PST)
From:   Doug Brown <doug@schmorgal.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Doug Brown <doug@schmorgal.com>
Subject: [PATCH v3 6/8] mmc: sdhci-pxav2: add SDIO card IRQ workaround for PXA168 V1 controller
Date:   Thu, 29 Dec 2022 12:04:09 -0800
Message-Id: <20221229200411.295339-7-doug@schmorgal.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221229200411.295339-1-doug@schmorgal.com>
References: <20221229200411.295339-1-doug@schmorgal.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The PXA168 has a documented silicon bug that causes SDIO card IRQs to be
missed. Implement the first half of the suggested workaround, which
involves resetting the data port logic and issuing a dummy CMD0 to
restart the clock.

Signed-off-by: Doug Brown <doug@schmorgal.com>
---
 drivers/mmc/host/sdhci-pxav2.c | 56 +++++++++++++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-pxav2.c
index b10f55b478fc..10fa9de14ad4 100644
--- a/drivers/mmc/host/sdhci-pxav2.c
+++ b/drivers/mmc/host/sdhci-pxav2.c
@@ -20,6 +20,8 @@
 #include <linux/slab.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/mmc/sdio.h>
+#include <linux/mmc/mmc.h>
 
 #include "sdhci.h"
 #include "sdhci-pltfm.h"
@@ -41,6 +43,10 @@
 #define MMC_CARD		0x1000
 #define MMC_WIDTH		0x0100
 
+struct sdhci_pxav2_host {
+	struct mmc_request *sdio_mrq;
+};
+
 static void pxav2_reset(struct sdhci_host *host, u8 mask)
 {
 	struct platform_device *pdev = to_platform_device(mmc_dev(host->mmc));
@@ -89,6 +95,52 @@ static u16 pxav1_readw(struct sdhci_host *host, int reg)
 	return readw(host->ioaddr + reg);
 }
 
+static u32 pxav1_irq(struct sdhci_host *host, u32 intmask)
+{
+	struct sdhci_pxav2_host *pxav2_host = sdhci_pltfm_priv(sdhci_priv(host));
+	struct mmc_request *sdio_mrq;
+
+	if (pxav2_host->sdio_mrq && (intmask & SDHCI_INT_CMD_MASK)) {
+		/* The dummy CMD0 for the SDIO workaround just completed */
+		sdhci_writel(host, intmask & SDHCI_INT_CMD_MASK, SDHCI_INT_STATUS);
+		intmask &= ~SDHCI_INT_CMD_MASK;
+		sdio_mrq = pxav2_host->sdio_mrq;
+		pxav2_host->sdio_mrq = NULL;
+		mmc_request_done(host->mmc, sdio_mrq);
+	}
+
+	return intmask;
+}
+
+static void pxav1_request_done(struct sdhci_host *host, struct mmc_request *mrq)
+{
+	u16 tmp;
+	struct sdhci_pxav2_host *pxav2_host;
+
+	/* If this is an SDIO command, perform errata workaround for silicon bug */
+	if (mrq->cmd && !mrq->cmd->error &&
+	    (mrq->cmd->opcode == SD_IO_RW_DIRECT ||
+	     mrq->cmd->opcode == SD_IO_RW_EXTENDED)) {
+		/* Reset data port */
+		tmp = readw(host->ioaddr + SDHCI_TIMEOUT_CONTROL);
+		tmp |= 0x400;
+		writew(tmp, host->ioaddr + SDHCI_TIMEOUT_CONTROL);
+
+		/* Clock is now stopped, so restart it by sending a dummy CMD0 */
+		pxav2_host = sdhci_pltfm_priv(sdhci_priv(host));
+		pxav2_host->sdio_mrq = mrq;
+		sdhci_writel(host, 0, SDHCI_ARGUMENT);
+		sdhci_writew(host, 0, SDHCI_TRANSFER_MODE);
+		sdhci_writew(host, SDHCI_MAKE_CMD(MMC_GO_IDLE_STATE, SDHCI_CMD_RESP_NONE),
+			     SDHCI_COMMAND);
+
+		/* Don't finish this request until the dummy CMD0 finishes */
+		return;
+	}
+
+	mmc_request_done(host->mmc, mrq);
+}
+
 static void pxav2_mmc_set_bus_width(struct sdhci_host *host, int width)
 {
 	u8 ctrl;
@@ -118,10 +170,12 @@ struct sdhci_pxa_variant {
 static const struct sdhci_ops pxav1_sdhci_ops = {
 	.read_w        = pxav1_readw,
 	.set_clock     = sdhci_set_clock,
+	.irq           = pxav1_irq,
 	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
 	.set_bus_width = pxav2_mmc_set_bus_width,
 	.reset         = pxav2_reset,
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
+	.request_done  = pxav1_request_done,
 };
 
 static const struct sdhci_pxa_variant __maybe_unused pxav1_variant = {
@@ -193,7 +247,7 @@ static int sdhci_pxav2_probe(struct platform_device *pdev)
 	int ret;
 	struct clk *clk, *clk_core;
 
-	host = sdhci_pltfm_init(pdev, NULL, 0);
+	host = sdhci_pltfm_init(pdev, NULL, sizeof(struct sdhci_pxav2_host));
 	if (IS_ERR(host))
 		return PTR_ERR(host);
 
-- 
2.34.1

