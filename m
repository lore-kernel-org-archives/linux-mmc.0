Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E1DEB64DC
	for <linux-mmc@archiver.kernel.org>; Fri, 16 Jun 2023 08:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240464AbjFPIau (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 16 Jun 2023 04:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241806AbjFPIaq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Jun 2023 04:30:46 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B95C2D72
        for <linux-mmc@vger.kernel.org>; Fri, 16 Jun 2023 01:30:45 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f64fb05a8aso533558e87.0
        for <linux-mmc@vger.kernel.org>; Fri, 16 Jun 2023 01:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686904243; x=1689496243;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TKSfFjErQqrA4N+AgDBWwU9EqGS/Y9GhjAuAbiYkf/A=;
        b=lJp1deBjvOtAoLHVmyF8tziPljobz5sX4gqcf3XUrQaXYLZ+n+XtL1QeG7OAk7Ay9O
         M9iB6WKFlxeDpwkiRU11vP2bjvU/nSrVziTEBCYVLO3itjrdN5K/aCRO4upNardE2xds
         pm8BWc4LlGPs0O0SavCx9TURPStpvTStdqhrsf7GUFbKppPp/QcUtIryAzrFjdZAiHxv
         FUmPjwwPgKgwL2AaDGNNMstB1QEF58Y/GY8mWd9h13D97hyny1sCKAQvwTVdp1PnOuiv
         WubAXxfGfkdxb2Dd4U82vu+rviH35CUaG6r4kqUkpv6BpeYK5kOe88an/faQSwYy5Vg7
         yCwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686904243; x=1689496243;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TKSfFjErQqrA4N+AgDBWwU9EqGS/Y9GhjAuAbiYkf/A=;
        b=hZF5EUUfPabKzcBZYzGDtvtFpowvpV7RoGBPQ6FxbiPk7zwBXdvV8/9CErjhnMzbP4
         w9pSVnesqRDJ9SDTNJ+pAnuilPIeW8RSbedzgNVc/7k6gsAQXRXs5CSJrW5gFaBpMtv5
         4tIKE+hOO4hsEmwK3h4c20qaj/0EtAnzRxJe7N6nZ/1mXqZ3zEiMNfqu2vJsmPjkIrl7
         tFutz2BdL1n2gREN68uxRV4/SiAHHv/wCtU2AJ/ESPS4qOq2VbC9bKCmIWpGEqbArZH3
         MScJQOs5BgBQu+kj6enbOF2x7Cqs1/yFS4+FPLQwZW0xzGHzvARfRLaHwpSVgvraDxCc
         Nopg==
X-Gm-Message-State: AC+VfDw1cIAKQctTJpfOMILbE9ivxE0OuPyd6SW7h7kLhfpFazxq9zmc
        ap2ZpXrmE/hg26NJRJLIP5dbqQ==
X-Google-Smtp-Source: ACHHUZ78mZiFnu3XwZGmaHeF12C0NqYoXkJ5x9w6amIE0Fv0MQnjxaaBVgSQLpQTBJRfgqzbBd9qzw==
X-Received: by 2002:a19:500d:0:b0:4f6:20b1:ef81 with SMTP id e13-20020a19500d000000b004f620b1ef81mr811165lfb.36.1686904243379;
        Fri, 16 Jun 2023 01:30:43 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id j8-20020ac25508000000b004eb44c2ab6bsm2918106lfk.294.2023.06.16.01.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 01:30:42 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 16 Jun 2023 10:30:41 +0200
Subject: [PATCH v6 9/9] mmc: mmci: Break out a helper function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230405-pl180-busydetect-fix-v6-9-b850ec8019f3@linaro.org>
References: <20230405-pl180-busydetect-fix-v6-0-b850ec8019f3@linaro.org>
In-Reply-To: <20230405-pl180-busydetect-fix-v6-0-b850ec8019f3@linaro.org>
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

These four lines clearing, masking and resetting the state
of the busy detect state machine is repeated five times in
the code so break this out to a small helper so things are
easier to read.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v4->v6:
- No changes.
ChangeLog v3->v4:
- No changes.
ChangeLog v2->v3:
- Rebased.
ChangeLog v1->v2:
- No changes
---
 drivers/mmc/host/mmci.c | 37 +++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index f7522c3fe849..a08d96918cae 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -654,6 +654,17 @@ static u32 ux500v2_get_dctrl_cfg(struct mmci_host *host)
 	return MCI_DPSM_ENABLE | (host->data->blksz << 16);
 }
 
+static void ux500_busy_clear_mask_done(struct mmci_host *host)
+{
+	void __iomem *base = host->base;
+
+	writel(host->variant->busy_detect_mask, base + MMCICLEAR);
+	writel(readl(base + MMCIMASK0) &
+	       ~host->variant->busy_detect_mask, base + MMCIMASK0);
+	host->busy_state = MMCI_BUSY_DONE;
+	host->busy_status = 0;
+}
+
 /*
  * ux500_busy_complete() - this will wait until the busy status
  * goes off, saving any status that occur in the meantime into
@@ -668,11 +679,7 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 
 	if (status & err_msk) {
 		/* Stop any ongoing busy detection if an error occurs */
-		writel(host->variant->busy_detect_mask, base + MMCICLEAR);
-		writel(readl(base + MMCIMASK0) &
-		       ~host->variant->busy_detect_mask, base + MMCIMASK0);
-		host->busy_state = MMCI_BUSY_DONE;
-		host->busy_status = 0;
+		ux500_busy_clear_mask_done(host);
 		goto out_ret_state;
 	}
 
@@ -714,10 +721,7 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 			retries--;
 		}
 		dev_dbg(mmc_dev(host->mmc), "no busy signalling in time\n");
-		writel(host->variant->busy_detect_mask, base + MMCICLEAR);
-		writel(readl(base + MMCIMASK0) &
-		       ~host->variant->busy_detect_mask, base + MMCIMASK0);
-		host->busy_state = MMCI_BUSY_DONE;
+		ux500_busy_clear_mask_done(host);
 		break;
 
 	/*
@@ -739,27 +743,20 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
 		} else {
 			dev_dbg(mmc_dev(host->mmc),
 				"lost busy status when waiting for busy start IRQ\n");
-			writel(host->variant->busy_detect_mask, base + MMCICLEAR);
-			writel(readl(base + MMCIMASK0) &
-			       ~host->variant->busy_detect_mask, base + MMCIMASK0);
-			host->busy_state = MMCI_BUSY_DONE;
-			host->busy_status = 0;
+			ux500_busy_clear_mask_done(host);
 		}
 		break;
 
 	case MMCI_BUSY_WAITING_FOR_END_IRQ:
 		if (!(status & host->variant->busy_detect_flag)) {
 			host->busy_status |= status & (MCI_CMDSENT | MCI_CMDRESPEND);
-			host->busy_state = MMCI_BUSY_DONE;
+			writel(host->variant->busy_detect_mask, base + MMCICLEAR);
+			ux500_busy_clear_mask_done(host);
 		} else {
 			dev_dbg(mmc_dev(host->mmc),
 				"busy status still asserted when handling busy end IRQ\n");
 			/* Force clear the spurious IRQ */
-			writel(host->variant->busy_detect_mask, base + MMCICLEAR);
-			writel(readl(base + MMCIMASK0) &
-			       ~host->variant->busy_detect_mask, base + MMCIMASK0);
-			host->busy_state = MMCI_BUSY_DONE;
-			host->busy_status = 0;
+			ux500_busy_clear_mask_done(host);
 		}
 		break;
 

-- 
2.40.1

