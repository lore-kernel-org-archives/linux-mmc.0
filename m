Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E24C54EBC
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Jan 2023 02:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbjALCY5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 11 Jan 2023 21:24:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236498AbjALCY4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Jan 2023 21:24:56 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C80D4566D
        for <linux-mmc@vger.kernel.org>; Wed, 11 Jan 2023 18:24:55 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id w3so18793526ply.3
        for <linux-mmc@vger.kernel.org>; Wed, 11 Jan 2023 18:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JqnrbwiHxmibFqxmAWk3pItN8pUg9Fc0T7KvyJk3MHA=;
        b=By0dV16AQJ393CmfPzBzI7loLXoHylovtVMfbGrMQlAUGUwGVdw5F95X5MHaY5jjUI
         t8/qTyednhP3OFtSdURzG1R87On9MiMNVwvJ85qa4/o45ESPksiZIP8JSvjsd0QDoDSm
         mBwWv3BVvr2J1yP3Q445BU1mPVEt3O9/9wMKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JqnrbwiHxmibFqxmAWk3pItN8pUg9Fc0T7KvyJk3MHA=;
        b=pgSUIL2soJqtzWmWCqTNXXdyfzaHhPMB13FB/tXmfSGyF9MnQSbRbogkPziOiXVZuC
         jCnCBU2O/H6t8+3pWCV+Y8IRY8OSBXl9uHhN1fJr0TXd2EU+mICBzzWnWAhQCgeZDjMs
         WX+7HKBEyAmMVhN1sz2d/cIERQWpfY8Bo7kRqzNpooBdFBn/q/67wF1kCF8ck7VXPwfC
         ZOA6yYGcC7bA3BujzgBxeWuVNjX9l2n3k3Wk1tiOYu2S4zJ17SiGZ+auNtXCq8UwEc3d
         2y6vbnF+OkRcYt+QKrJpsgm+XZ03KvOkPlvvVLy/Y6cD5b0y3eccgpkkTCdX7hHV6nWF
         bOzw==
X-Gm-Message-State: AFqh2kpClTFZ3AKXKn43jOEyx0bm2u91x7HLrsUzvu0l9n2p8zDGiQFQ
        p6SZdICo9F+NU5j0C0sLlHkW7A==
X-Google-Smtp-Source: AMrXdXtj0r5lVhOcYI3BbSawnnXp2LHCm/rQXj+n1PPJ62/3KeAHRhqCHF//NfoCuKojrrcLUibGKQ==
X-Received: by 2002:a05:6a20:4417:b0:b2:310a:9fd2 with SMTP id ce23-20020a056a20441700b000b2310a9fd2mr6562808pzb.43.1673490295006;
        Wed, 11 Jan 2023 18:24:55 -0800 (PST)
Received: from doug-ryzen-5700G.. ([192.183.212.197])
        by smtp.gmail.com with ESMTPSA id a1-20020a1709027e4100b00193020e8a90sm10759135pln.294.2023.01.11.18.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 18:24:54 -0800 (PST)
From:   Doug Brown <doug@schmorgal.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Doug Brown <doug@schmorgal.com>
Subject: [PATCH v4 6/8] mmc: sdhci-pxav2: add SDIO card IRQ workaround for PXA168 V1 controller
Date:   Wed, 11 Jan 2023 18:24:14 -0800
Message-Id: <20230112022416.8474-7-doug@schmorgal.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230112022416.8474-1-doug@schmorgal.com>
References: <20230112022416.8474-1-doug@schmorgal.com>
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
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
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

