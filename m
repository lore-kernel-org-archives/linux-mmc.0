Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE4BC38A2D
	for <linux-mmc@archiver.kernel.org>; Wed, 26 Oct 2022 19:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234300AbiJZTnd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 26 Oct 2022 15:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234464AbiJZTnN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 26 Oct 2022 15:43:13 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1C5CA8A3
        for <linux-mmc@vger.kernel.org>; Wed, 26 Oct 2022 12:42:45 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id c24so15183355pls.9
        for <linux-mmc@vger.kernel.org>; Wed, 26 Oct 2022 12:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oi/ns2/+lR1+ddU/1Ugq5i2XZ8iCGI8EoPh2M4YhQ8o=;
        b=ne3Bjzj3/Xp33Sha2f/cKqGXdoH6Vyr5pOV6EuuqvioSpyWEaWuiHEeTUPPxMmITZy
         AjpY81WAkjUG4NkFO4CzRkknSFFYVH/HDZGTHQ2cTgwST8YhakPg/9CIkJjqjV7sWNZ6
         sRvl6FHFKEQGE626YqbWeD7+B8j5Ajygbqwxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oi/ns2/+lR1+ddU/1Ugq5i2XZ8iCGI8EoPh2M4YhQ8o=;
        b=0r0CPcCmV5nNx3gQxJExFhe1EYk2SCbjeDpDUUwlJWO/ugZ7xeQLt924Vja3lkn0SZ
         eTJvyUW2RT7RbH89cgYOZGjFknN+q+G5uP2QDX1Dh/a8dTBt3ZNq94p48gYqxwKNZYYt
         4SAKBW68rwgpejYGGsAo1jWDMYJRobTKRU3i6TNRCT9YyGX+fko3LvId5+X30aM1kxrC
         M+ampftNNHCO7WVWw+cWaprzbKbAOKxBEijiltwE40JTUw+vKXULtp3HyKBoP/y9r9CA
         KwGDTtCjXMvXoxElJBZUK86c+liY6YZI5YtU25yU2jQRGh8EZOWNLJO2ntGfg0Rvu+Gw
         lwUw==
X-Gm-Message-State: ACrzQf0YCUhF2YATboQpgMBqtr/35yU+Tcy8EJr9NydwXtwlsjeJew/U
        hCrdNYQ2rM3FcHXh2vhiMtwF9Q==
X-Google-Smtp-Source: AMsMyM7hg0m4kzScSycnp+0BSaCf1uWcEtsyIxRBE+hmz2jWWj4BkNcDgMFKByjg4dC+wFw/YCfYnQ==
X-Received: by 2002:a17:902:da84:b0:186:dd94:bbed with SMTP id j4-20020a170902da8400b00186dd94bbedmr4430426plx.20.1666813365417;
        Wed, 26 Oct 2022 12:42:45 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:c9e3:74f3:6b2b:135])
        by smtp.gmail.com with UTF8SMTPSA id b3-20020a170903228300b00186b55e3cd6sm3293223plh.133.2022.10.26.12.42.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 12:42:45 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Shawn Guo <shawnguo@kernel.org>, linux-mmc@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Andy Gross <agross@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Al Cooper <alcooperx@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v4 7/7] mmc: sdhci-*: Convert drivers to new sdhci_and_cqhci_reset()
Date:   Wed, 26 Oct 2022 12:42:09 -0700
Message-Id: <20221026124150.v4.7.Ia91f031f5f770af7bd2ff3e28b398f277606d970@changeid>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
In-Reply-To: <20221026194209.3758834-1-briannorris@chromium.org>
References: <20221026194209.3758834-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

An earlier patch ("mmc: cqhci: Provide helper for resetting both SDHCI
and CQHCI") does these operations for us.

I keep these as a separate patch, since the earlier patch is a
prerequisite to some important bugfixes that need to be backported via
linux-stable.

Signed-off-by: Brian Norris <briannorris@chromium.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---

Changes in v4:
 - Add Adrian's Ack

Changes in v3:
 - Rewrite to new helper, patch sdhci-msm too

Changes in v2:
 - Factor out ->cqe_private helpers

 drivers/mmc/host/sdhci-msm.c      | 10 ++--------
 drivers/mmc/host/sdhci-pci-core.c | 11 ++---------
 drivers/mmc/host/sdhci-pci-gli.c  | 11 ++---------
 3 files changed, 6 insertions(+), 26 deletions(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 3a091a387ecb..03f76384ab3f 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -19,6 +19,7 @@
 #include <linux/pinctrl/consumer.h>
 #include <linux/reset.h>
 
+#include "sdhci-cqhci.h"
 #include "sdhci-pltfm.h"
 #include "cqhci.h"
 
@@ -2304,13 +2305,6 @@ static void sdhci_msm_set_regulator_caps(struct sdhci_msm_host *msm_host)
 	pr_debug("%s: supported caps: 0x%08x\n", mmc_hostname(mmc), caps);
 }
 
-static void sdhci_msm_reset(struct sdhci_host *host, u8 mask)
-{
-	if ((host->mmc->caps2 & MMC_CAP2_CQE) && (mask & SDHCI_RESET_ALL))
-		cqhci_deactivate(host->mmc);
-	sdhci_reset(host, mask);
-}
-
 static int sdhci_msm_register_vreg(struct sdhci_msm_host *msm_host)
 {
 	int ret;
@@ -2450,7 +2444,7 @@ static const struct of_device_id sdhci_msm_dt_match[] = {
 MODULE_DEVICE_TABLE(of, sdhci_msm_dt_match);
 
 static const struct sdhci_ops sdhci_msm_ops = {
-	.reset = sdhci_msm_reset,
+	.reset = sdhci_and_cqhci_reset,
 	.set_clock = sdhci_msm_set_clock,
 	.get_min_clock = sdhci_msm_get_min_clock,
 	.get_max_clock = sdhci_msm_get_max_clock,
diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 169b84761041..cc039155b5c7 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -38,6 +38,7 @@
 #include "cqhci.h"
 
 #include "sdhci.h"
+#include "sdhci-cqhci.h"
 #include "sdhci-pci.h"
 
 static void sdhci_pci_hw_reset(struct sdhci_host *host);
@@ -234,14 +235,6 @@ static void sdhci_pci_dumpregs(struct mmc_host *mmc)
 	sdhci_dumpregs(mmc_priv(mmc));
 }
 
-static void sdhci_cqhci_reset(struct sdhci_host *host, u8 mask)
-{
-	if ((host->mmc->caps2 & MMC_CAP2_CQE) && (mask & SDHCI_RESET_ALL) &&
-	    host->mmc->cqe_private)
-		cqhci_deactivate(host->mmc);
-	sdhci_reset(host, mask);
-}
-
 /*****************************************************************************\
  *                                                                           *
  * Hardware specific quirk handling                                          *
@@ -703,7 +696,7 @@ static const struct sdhci_ops sdhci_intel_glk_ops = {
 	.set_power		= sdhci_intel_set_power,
 	.enable_dma		= sdhci_pci_enable_dma,
 	.set_bus_width		= sdhci_set_bus_width,
-	.reset			= sdhci_cqhci_reset,
+	.reset			= sdhci_and_cqhci_reset,
 	.set_uhs_signaling	= sdhci_intel_set_uhs_signaling,
 	.hw_reset		= sdhci_pci_hw_reset,
 	.irq			= sdhci_cqhci_irq,
diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index 4d509f656188..633a8ee8f8c5 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -15,6 +15,7 @@
 #include <linux/of.h>
 #include <linux/iopoll.h>
 #include "sdhci.h"
+#include "sdhci-cqhci.h"
 #include "sdhci-pci.h"
 #include "cqhci.h"
 
@@ -922,14 +923,6 @@ static int gl9763e_add_host(struct sdhci_pci_slot *slot)
 	return ret;
 }
 
-static void sdhci_gl9763e_reset(struct sdhci_host *host, u8 mask)
-{
-	if ((host->mmc->caps2 & MMC_CAP2_CQE) && (mask & SDHCI_RESET_ALL) &&
-	    host->mmc->cqe_private)
-		cqhci_deactivate(host->mmc);
-	sdhci_reset(host, mask);
-}
-
 static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
 {
 	struct pci_dev *pdev = slot->chip->pdev;
@@ -1136,7 +1129,7 @@ static const struct sdhci_ops sdhci_gl9763e_ops = {
 	.set_clock		= sdhci_set_clock,
 	.enable_dma		= sdhci_pci_enable_dma,
 	.set_bus_width		= sdhci_set_bus_width,
-	.reset			= sdhci_gl9763e_reset,
+	.reset			= sdhci_and_cqhci_reset,
 	.set_uhs_signaling	= sdhci_set_gl9763e_signaling,
 	.voltage_switch		= sdhci_gli_voltage_switch,
 	.irq                    = sdhci_gl9763e_cqhci_irq,
-- 
2.38.0.135.g90850a2211-goog

