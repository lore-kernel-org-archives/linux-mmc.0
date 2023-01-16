Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2667AC677F1
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Jan 2023 19:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbjAPToo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Jan 2023 14:44:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233710AbjAPTon (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Jan 2023 14:44:43 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408442C66C
        for <linux-mmc@vger.kernel.org>; Mon, 16 Jan 2023 11:44:42 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id jn22so31277901plb.13
        for <linux-mmc@vger.kernel.org>; Mon, 16 Jan 2023 11:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p1/rux+dB2ue+u77r+Lmx539KLyGVCKrU+T8EBWwu5M=;
        b=CydmbJdsei6OFAeI2GGDrf/oSjrqJBYxHdg3KwV1fhsSU6AKm2pY4m98oLPM2wjZ6H
         CBH0fhnbui8iLgSSYMBomOvtpWLSNujIYdLXvhlE0pF1943cZfFppPOZdqpT9aI1jmKs
         tRFPjWEWOZ+wc3Pc751ZLn8sjx/7jC4yvK4hM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p1/rux+dB2ue+u77r+Lmx539KLyGVCKrU+T8EBWwu5M=;
        b=gMQ1YEcMrxDlWhYRux4LrC6swKOrv3hj/nXwVAv8WJrIc0QuuxKrNpHZFsS8QnuZIm
         f1EP9FpKyzsIV3ZZQr1g/OlqlXG8Tq1dCLdeiDa5fsFGXqiqUQyslDkUfUZCj7QeLd45
         +i+Ldg8EvSar7bIS5/sHI8J0a9ULl+eNdIlKxv8QUGq1EM1lw0wGZiZhMJ+NxYG43dto
         sDOZsSO53ABkhg6acKev9t+Mgnu+fdndvXO+bfvOnZI9gYhF2hoX06l1MehYxuoBxmN7
         CcCh6Y/vNVyUEA1ETbXtVeYby5uudmyibN35lENxlg4yaGKKS+tfRTSIkGeSgXkDJXgk
         GOEg==
X-Gm-Message-State: AFqh2koc0iqpPbs/YGigqJ0i77OrbYekA3j4I7wHLf5viblbgnzc0exK
        /qLV4i9Ua4JEIqfDzd7gU49BcA==
X-Google-Smtp-Source: AMrXdXvvv+eJ86qAtMbNzubFkNTlO6sPiXQQ7ZKeX1Q9Rm3iJwd5iL8ITW89Y+lRnw4PHtUZb1OFBQ==
X-Received: by 2002:a17:902:f60b:b0:194:a663:675b with SMTP id n11-20020a170902f60b00b00194a663675bmr532235plg.19.1673898281606;
        Mon, 16 Jan 2023 11:44:41 -0800 (PST)
Received: from doug-ryzen-5700G.. ([192.183.212.197])
        by smtp.gmail.com with ESMTPSA id t13-20020a170902b20d00b001926a76e8absm19734663plr.114.2023.01.16.11.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 11:44:40 -0800 (PST)
From:   Doug Brown <doug@schmorgal.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Doug Brown <doug@schmorgal.com>
Subject: [PATCH v5 3/8] mmc: sdhci-pxav2: add register workaround for PXA168 silicon bug
Date:   Mon, 16 Jan 2023 11:43:56 -0800
Message-Id: <20230116194401.20372-4-doug@schmorgal.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230116194401.20372-1-doug@schmorgal.com>
References: <20230116194401.20372-1-doug@schmorgal.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The PXA168 has a documented silicon bug that results in a data abort
exception when accessing the SDHCI_HOST_VERSION register on SDH2 and
SDH4 through a 16-bit read. Implement the workaround described in the
errata, which performs a 32-bit read from a lower address instead. This
is safe to use on all four SDH peripherals.

Signed-off-by: Doug Brown <doug@schmorgal.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-pxav2.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-pxav2.c
index 5707d597ecae..5e01dab94426 100644
--- a/drivers/mmc/host/sdhci-pxav2.c
+++ b/drivers/mmc/host/sdhci-pxav2.c
@@ -80,6 +80,15 @@ static void pxav2_reset(struct sdhci_host *host, u8 mask)
 	}
 }
 
+static u16 pxav1_readw(struct sdhci_host *host, int reg)
+{
+	/* Workaround for data abort exception on SDH2 and SDH4 on PXA168 */
+	if (reg == SDHCI_HOST_VERSION)
+		return readl(host->ioaddr + SDHCI_HOST_VERSION - 2) >> 16;
+
+	return readw(host->ioaddr + reg);
+}
+
 static void pxav2_mmc_set_bus_width(struct sdhci_host *host, int width)
 {
 	u8 ctrl;
@@ -107,6 +116,7 @@ struct sdhci_pxa_variant {
 };
 
 static const struct sdhci_ops pxav1_sdhci_ops = {
+	.read_w        = pxav1_readw,
 	.set_clock     = sdhci_set_clock,
 	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
 	.set_bus_width = pxav2_mmc_set_bus_width,
-- 
2.34.1

