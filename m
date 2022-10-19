Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F16B7C433FE
	for <linux-mmc@archiver.kernel.org>; Wed, 19 Oct 2022 21:55:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbiJSVzt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 19 Oct 2022 17:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbiJSVzX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Oct 2022 17:55:23 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3B616C22B
        for <linux-mmc@vger.kernel.org>; Wed, 19 Oct 2022 14:55:20 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-13aeccf12fbso244079fac.11
        for <linux-mmc@vger.kernel.org>; Wed, 19 Oct 2022 14:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wydu2mgXy/Ti5pZeMNO0oB2V13SqCsRFUj9VGtENhPc=;
        b=ChDSlokPNsjy2o/57nhAg7mfMjZkGB61uN8KGokp5uFWwk9gAqAvvQdsKuPhhf4Er9
         wmKVQHHL8CkIAihTw0hRaEFTwdI+sSmSvrHn8I7fE03IUF48Nd0r5X/3gjaqFYEsNSKg
         5Er7iJ8I6HnyOcMvqA10t1iAAiUYMokHH21IE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wydu2mgXy/Ti5pZeMNO0oB2V13SqCsRFUj9VGtENhPc=;
        b=cvHx3S7aN50SZYd+xOJxvNoDYXWfJgOnF0V26srlDBnr3rpJ9rTVNdC8RUAzRN3M7X
         gnw2Td04XQ1y8Jn5JbgFqv9iLr1s6LecaLLaSl7IgzQjVV/cgpJT2X1RIBhNsQ0s5Oj4
         lVKZYRbPY4ODaPsjtq9c0sFv19yws7vMjZVi1oXJwPlF8IvkNPyq+Gwv1ZCJM5GeF5Y5
         otnOLkPk8x9q/HSXnZBDyuyy0xxEIkcnES91GbnhYoH7Lr9ArFfqHoZRTmal0mMw2RC1
         u0uFbp2YPUBiPoknZ1Q+3Fzxe0ijuRSEt7avebV4q6PnVqFK3vNHqSmEAqsBOkG1CQ1N
         PHyg==
X-Gm-Message-State: ACrzQf24Vq41yQjrxpmj7g9MdtTZnb1WRuTVEiUWrlhbwq1nVlL8n07C
        MN9SurKu068McqdqcaYkgf/zTCW48UFVgg==
X-Google-Smtp-Source: AMsMyM65zy9w0RdzVEqmld4/qnsBulitgQpGHjJqxSrm9Wcnqk0BhVHkXGaAFZEodAFwIynT26Y3TA==
X-Received: by 2002:a17:90a:c782:b0:202:c73e:5488 with SMTP id gn2-20020a17090ac78200b00202c73e5488mr47000873pjb.202.1666216509347;
        Wed, 19 Oct 2022 14:55:09 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:57b7:1f0e:44d1:f252])
        by smtp.gmail.com with UTF8SMTPSA id l10-20020a170903244a00b0017f637b3e87sm11258807pls.279.2022.10.19.14.55.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 14:55:08 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Shawn Lin <shawn.lin@rock-chips.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Faiz Abbas <faiz_abbas@ti.com>, linux-mmc@vger.kernel.org,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Al Cooper <alcooperx@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2 4/7] mms: sdhci-esdhc-imx: Fix SDHCI_RESET_ALL for CQHCI
Date:   Wed, 19 Oct 2022 14:54:37 -0700
Message-Id: <20221019145246.v2.4.I7d01f9ad11bacdc9213dee61b7918982aea39115@changeid>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
In-Reply-To: <20221019215440.277643-1-briannorris@chromium.org>
References: <20221019215440.277643-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

 [[ NOTE: this is completely untested by the author, but included solely
    because, as noted in commit df57d73276b8 ("mmc: sdhci-pci: Fix
    SDHCI_RESET_ALL for CQHCI for Intel GLK-based controllers"), "other
    drivers using CQHCI might benefit from a similar change, if they
    also have CQHCI reset by SDHCI_RESET_ALL." We've now seen the same
    bug on at least MSM, Arasan, and Intel hardware. ]]

SDHCI_RESET_ALL resets will reset the hardware CQE state, but we aren't
tracking that properly in software. When out of sync, we may trigger
various timeouts.

It's not typical to perform resets while CQE is enabled, but this may
occur in some suspend or error recovery scenarios.

Fixes: bb6e358169bf ("mmc: sdhci-esdhc-imx: add CMDQ support")
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

Changes in v2:
 - Drop unnecessary ESDHC_FLAG_CQHCI check

 drivers/mmc/host/sdhci-esdhc-imx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 55981b0f0b10..c07df7b71b22 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1288,6 +1288,9 @@ static void esdhc_set_uhs_signaling(struct sdhci_host *host, unsigned timing)
 
 static void esdhc_reset(struct sdhci_host *host, u8 mask)
 {
+	if ((host->mmc->caps2 & MMC_CAP2_CQE) && (mask & SDHCI_RESET_ALL))
+		cqhci_deactivate(host->mmc);
+
 	sdhci_reset(host, mask);
 
 	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
-- 
2.38.0.413.g74048e4d9e-goog

