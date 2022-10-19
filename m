Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1110C433FE
	for <linux-mmc@archiver.kernel.org>; Wed, 19 Oct 2022 21:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbiJSVzQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 19 Oct 2022 17:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbiJSVzE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Oct 2022 17:55:04 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3552108DF1
        for <linux-mmc@vger.kernel.org>; Wed, 19 Oct 2022 14:55:01 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id t10-20020a17090a4e4a00b0020af4bcae10so1222763pjl.3
        for <linux-mmc@vger.kernel.org>; Wed, 19 Oct 2022 14:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IbNbprVwcMSh5axZvXvg/6/Lf17+C73zGfmFV0q4APA=;
        b=jtc5lQ401QtVqG1hgM5C8nhqiLVLg/sUDSKTS1D2u8U8fBBwlC0CdcdAz0f5osiCdj
         2xjAgzGdyS3CHjlU1Sk4hXJybQubvQjcO7XWn3h9H8+wa4RBvF1yedA6C43RCQURquc8
         1Kx+U/fZ4Czw7qxoo3ox60jKt3Bdk8T81A02Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IbNbprVwcMSh5axZvXvg/6/Lf17+C73zGfmFV0q4APA=;
        b=suuJAGqMwc6InOtXr49k2UNm0B6FkHavwVy50+bGSut6v7pcGw3/0Ku2Aeqcjr/HqK
         vFFynTUhl8pb7oiwYrGdwgpnjf6ord7f59TsRa9p/QHfdHSdt4d8BOiWRBM/lncbqW9l
         AtSzZlWf0OTjzqdVGzFYo0qoIHvttBXAia2gKi1cTFkwfc8jEKWcXwiRWwLqbVJxxFGH
         qCU+r4muOWjbVjlEMfRMGv+TElDOuzk28PKkv82mBaOUdVYB6HyQMEyakcXhZuDksXN7
         JaY5FhWZF6IB04ky1lcvud2hE2utGSXcab5O2AUnL4wYdAps8xbcfuBEgmkyB3JP1N31
         pJGg==
X-Gm-Message-State: ACrzQf0vsRvVrigCus4Zn1L2vNISPBblDBFVn890E5tAK31Q1BlkWy3L
        7kfzBXenduemjW38nHTE5mQjpw==
X-Google-Smtp-Source: AMsMyM6biSOLBTJXDiepLZa0bJF7XTtefUmddHCt+LNdnoBA/Qap1OlbiXCBCai37p9OD4hzq8ZSUw==
X-Received: by 2002:a17:902:bd46:b0:17e:8ee5:7b61 with SMTP id b6-20020a170902bd4600b0017e8ee57b61mr10878542plx.44.1666216501002;
        Wed, 19 Oct 2022 14:55:01 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:57b7:1f0e:44d1:f252])
        by smtp.gmail.com with UTF8SMTPSA id q13-20020a170902f34d00b0017680faa1a8sm11113715ple.112.2022.10.19.14.54.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 14:55:00 -0700 (PDT)
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
        Brian Norris <briannorris@chromium.org>, stable@vger.kernel.org
Subject: [PATCH v2 1/7] mmc: cqhci: Handle deactivate() when not yet initialized
Date:   Wed, 19 Oct 2022 14:54:34 -0700
Message-Id: <20221019145246.v2.1.Ie85faa09432bfe1b0890d8c24ff95e17f3097317@changeid>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
In-Reply-To: <20221019215440.277643-1-briannorris@chromium.org>
References: <20221019215440.277643-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Several SDHCI drivers need to deactivate command queueing in their reset
hook (see sdhci_cqhci_reset() / sdhci-pci-core.c, for example), and
several more are coming. Such drivers also tend to initialize CQHCI
support after they've already performed one or more resets.

Rather than rely on careful ordering of cqhci_init() within the host
setup and reset sequence, let's do a simple NULL check -- deactivating a
non-initialized CQHCI instance is harmless.

This is an important prerequisite patch for several SDHCI controller
bugfixes that follow.

Cc: <stable@vger.kernel.org>
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

Changes in v2:
 - New in v2

 drivers/mmc/host/cqhci-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
index b3d7d6d8d654..1fa1d24abb2e 100644
--- a/drivers/mmc/host/cqhci-core.c
+++ b/drivers/mmc/host/cqhci-core.c
@@ -315,7 +315,7 @@ int cqhci_deactivate(struct mmc_host *mmc)
 {
 	struct cqhci_host *cq_host = mmc->cqe_private;
 
-	if (cq_host->enabled && cq_host->activated)
+	if (cq_host && cq_host->enabled && cq_host->activated)
 		__cqhci_disable(cq_host);
 
 	return 0;
-- 
2.38.0.413.g74048e4d9e-goog

