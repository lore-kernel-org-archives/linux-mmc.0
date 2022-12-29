Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F38C3DA79
	for <linux-mmc@archiver.kernel.org>; Thu, 29 Dec 2022 20:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiL2UFA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 29 Dec 2022 15:05:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233504AbiL2UE6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Dec 2022 15:04:58 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF4015F1B
        for <linux-mmc@vger.kernel.org>; Thu, 29 Dec 2022 12:04:57 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso23931390pjt.0
        for <linux-mmc@vger.kernel.org>; Thu, 29 Dec 2022 12:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LwLsC88yYEr+DqM5Cbp/GViuH3X6Lo7mSbslRIXTWPU=;
        b=LjH2StdHqe6JYBWUWVbsuH+RmGQIbgDYNdf5tFtjGE6tljxlLRNvV6iZa8Zh8EECch
         2AYa2EV/cDKNSrt0fUPHZuFJ7JmA79xHx691usBv4PJNS+Xfv2SMPJhEVwNx9KwjGqKE
         xzz6nDemAYTZMzKp9cGvz+JD+Q05uuDTKcGSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LwLsC88yYEr+DqM5Cbp/GViuH3X6Lo7mSbslRIXTWPU=;
        b=cFCHN2Qtk9R1wnKNFiklpNkWuNbMx0JalAdxn8ThurjfISVfKxTQNA571O1gWpGbF/
         IVVpT6fHkDacz5J0hulb25oxTZ6mNBn+TH1DyX+tq507eStIQH74xrs0mx1BHgq8VzZ2
         6nKPLJO7aegLww6/tzD5mwz4zqidl8ifycDVt1umLcZo1448juJb8U6mkn+6AVFUSspI
         88XcJi+/3AG12gUXSTeA7ze0Dseizv6zLif7OqPT31bGgYYXMbVpHREUhYggQyr6b0rG
         JZwAp8thrfrBGWELmVaE6yfvkuqj1TkXbI/GeGaUBqcJz/O2JYtfRr3Y6DnNyrBafxJW
         jvCg==
X-Gm-Message-State: AFqh2kpzRnBq/dXKmnj+GuyGJE8uBO3ze1CYboeDPS9CiBvLfcNcK1tu
        iaj1QuOkptfUun/Z1jLYVdkqPA==
X-Google-Smtp-Source: AMrXdXsGuQulywqUBmvyH6G+s9J9Et6wj8YN7mdwrB0SInKmC/Prto+piCu2D0/N7FjRfUHOFD3Q9g==
X-Received: by 2002:a17:902:d2ce:b0:192:a4d5:55b8 with SMTP id n14-20020a170902d2ce00b00192a4d555b8mr3541205plc.52.1672344297022;
        Thu, 29 Dec 2022 12:04:57 -0800 (PST)
Received: from doug-ryzen-5700G.. ([192.183.212.197])
        by smtp.gmail.com with ESMTPSA id w17-20020a170902e89100b00189ac5a2340sm13438589plg.124.2022.12.29.12.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 12:04:56 -0800 (PST)
From:   Doug Brown <doug@schmorgal.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Doug Brown <doug@schmorgal.com>
Subject: [PATCH v3 3/8] mmc: sdhci-pxav2: add register workaround for PXA168 silicon bug
Date:   Thu, 29 Dec 2022 12:04:06 -0800
Message-Id: <20221229200411.295339-4-doug@schmorgal.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221229200411.295339-1-doug@schmorgal.com>
References: <20221229200411.295339-1-doug@schmorgal.com>
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

