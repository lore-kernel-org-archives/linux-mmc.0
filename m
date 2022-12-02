Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34893C47088
	for <linux-mmc@archiver.kernel.org>; Fri,  2 Dec 2022 03:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbiLBDOI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 1 Dec 2022 22:14:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbiLBDOG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Dec 2022 22:14:06 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2569D49D0
        for <linux-mmc@vger.kernel.org>; Thu,  1 Dec 2022 19:14:04 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id 140so3723488pfz.6
        for <linux-mmc@vger.kernel.org>; Thu, 01 Dec 2022 19:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7l6khAS5kZJeevGyt1f61D1fLNE5NcUTY+h391E+lYw=;
        b=cXdLRRlPA8b7zzp73NUYpBUJOFrn8QaX9iD3nutbOgp8i67M1sbVaKn7pD+DyXR1mC
         8aFGMWE21F039KuhS9+kalSaxTAocxWgfOSZiXe2sXzCSoWaby36sH7eezhYquu+zUer
         /3NKDLOc/pPZu6NjDfsMqcm5Eb094W99hn+v4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7l6khAS5kZJeevGyt1f61D1fLNE5NcUTY+h391E+lYw=;
        b=2zWTiuI2Nv7KhoNueFI14NcTqet0botfpdjLCYIhjIepR0mqkga6+DAOTW9ZNc0awK
         lAAw15fIJEKZwg4bBmoS9DowlVxr270p2X/NcUUHxSdpv2KyLZNL6nJ/tzHcZ6E4ZpsP
         B2GlzRTzvoEdne6aVhAuy5EZhbQSU927sNPratdC3mDFRBsGDxqzf/KKDZv4qrvsIbAy
         S2Tt2aTa1DxlvtYVlMKWFyJXHJf+jHSaexqep6Ne2kCbWObH46iXmkYxGev24irsn91m
         aSS0jYTlqZ8ynkzRMMLHSstvvJRTWkR5eqn8KNpj2kH1y1ZoLpjm35A5WN0NZGrXceiX
         GaoA==
X-Gm-Message-State: ANoB5pn/XgBxOw6lrXb8EBNUo5vObu/la4Hu9AQaR9Ufc+eze4PWVBc4
        +z51028SmBFrxWw6nkV1gSqkNQ==
X-Google-Smtp-Source: AA0mqf4FEOMssNSDt45kcwYDkNOdWpL35r7m3AD2kfzFD/pqnNPuLnWSeb34nwFT5tXFDc1Yq6L+VQ==
X-Received: by 2002:a63:565e:0:b0:46e:bcc1:a28f with SMTP id g30-20020a63565e000000b0046ebcc1a28fmr43618294pgm.408.1669950844118;
        Thu, 01 Dec 2022 19:14:04 -0800 (PST)
Received: from doug-ryzen-5700G.. ([192.183.212.197])
        by smtp.gmail.com with ESMTPSA id jx24-20020a17090b46d800b00213202d77d9sm3708410pjb.43.2022.12.01.19.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 19:14:03 -0800 (PST)
From:   Doug Brown <doug@schmorgal.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Doug Brown <doug@schmorgal.com>
Subject: [PATCH v2 6/8] mmc: sdhci-pxav2: add SDIO card IRQ workaround for PXA168 V1 controller
Date:   Thu,  1 Dec 2022 19:13:28 -0800
Message-Id: <20221202031330.94130-7-doug@schmorgal.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221202031330.94130-1-doug@schmorgal.com>
References: <20221202031330.94130-1-doug@schmorgal.com>
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
 drivers/mmc/host/sdhci-pxav2.c | 49 ++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-pxav2.c
index 1f0c3028987a..912b2aad9f2e 100644
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
@@ -43,6 +45,7 @@
 
 struct sdhci_pxav2_host {
 	struct clk *clk_core;
+	struct mmc_request *sdio_mrq;
 };
 
 static void pxav2_reset(struct sdhci_host *host, u8 mask)
@@ -93,6 +96,50 @@ static u16 pxav1_readw(struct sdhci_host *host, int reg)
 	return readw(host->ioaddr + reg);
 }
 
+static u32 pxav1_irq(struct sdhci_host *host, u32 intmask)
+{
+	struct sdhci_pxav2_host *pxav2_host = sdhci_pltfm_priv(sdhci_priv(host));
+
+	if (pxav2_host->sdio_mrq && (intmask & SDHCI_INT_CMD_MASK)) {
+		/* The dummy CMD0 for the SDIO workaround just completed */
+		sdhci_writel(host, intmask & SDHCI_INT_CMD_MASK, SDHCI_INT_STATUS);
+		intmask &= ~SDHCI_INT_CMD_MASK;
+		mmc_request_done(host->mmc, pxav2_host->sdio_mrq);
+		pxav2_host->sdio_mrq = NULL;
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
@@ -117,10 +164,12 @@ static void pxav2_mmc_set_bus_width(struct sdhci_host *host, int width)
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
 
 static const struct sdhci_ops pxav2_sdhci_ops = {
-- 
2.34.1

