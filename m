Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69128C4321E
	for <linux-mmc@archiver.kernel.org>; Wed, 19 Oct 2022 21:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbiJSVzT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 19 Oct 2022 17:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbiJSVzP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Oct 2022 17:55:15 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344514055D
        for <linux-mmc@vger.kernel.org>; Wed, 19 Oct 2022 14:55:07 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id l4so18518826plb.8
        for <linux-mmc@vger.kernel.org>; Wed, 19 Oct 2022 14:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0aSPJogmlylX7KM1RJ0D1MDbzbxw24/coSip2lgP3l8=;
        b=FfeJSmTDi68H718jGTkL3Qo1tO+F4L+j54/kcb1cwGvPvCRoxWbXgrlkIzP8z1mliR
         GZ3uqYlcUUjHj9i+2kUHXcKMhvofvcwCX0imm1RPyUM1cBAIEklypYsyDLGlghvh/Th5
         ePYBz8C0cLy280KU4RVy6tzul8GnmJ1Y48fYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0aSPJogmlylX7KM1RJ0D1MDbzbxw24/coSip2lgP3l8=;
        b=cm3LijQWfOhLUxHw1WfOWjf1jXc3wDv031AsJL44UvsyLMwld/dEXKesro/WuQQ2mW
         N2qFk7e+HR38jmL9JNNM65Xblpt9u7paK6IuBgulXK7CSf7vagZTlkcufnrI6z++f1ix
         qrsx8KOvXrSFSEJMG0SqatbJr+CAPU4/n4wjkzit/HZ264DseCdXxYDLhxUosCkQAVWD
         FLXsFJHdZsG3wEaKj0m9jdNjPm3iZf1wcM391fBsU7+dqQuT+awE79meSbVIxbObdcvY
         xtNuLuRLlGpIwmIFrREsOuINaEK3mHhnOZ2II+gm6oqhbfKH6f8Qv+WISek8O6vsqfjk
         yT/w==
X-Gm-Message-State: ACrzQf26vp95CxaqWEIm3/zhFRgvRwsgwRIq7MRJ6ViQeGG60cFuriqU
        svfeKsn1edF5NhP/ANCP996l6g==
X-Google-Smtp-Source: AMsMyM7Iv6iv4kAIoVGRCrEZHEH/ZPVWrqoEmnkjZdmu4WQ95eSFzTazbt4oPRQx024Pge0QJgZ0DA==
X-Received: by 2002:a17:902:9048:b0:17f:93a5:4638 with SMTP id w8-20020a170902904800b0017f93a54638mr10696224plz.108.1666216506540;
        Wed, 19 Oct 2022 14:55:06 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:57b7:1f0e:44d1:f252])
        by smtp.gmail.com with UTF8SMTPSA id s13-20020aa78bcd000000b00543a098a6ffsm11792418pfd.212.2022.10.19.14.55.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 14:55:06 -0700 (PDT)
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
Subject: [PATCH v2 3/7] mmc: sdhci-brcmstb: Fix SDHCI_RESET_ALL for CQHCI
Date:   Wed, 19 Oct 2022 14:54:36 -0700
Message-Id: <20221019145246.v2.3.I6a715feab6d01f760455865e968ecf0d85036018@changeid>
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

Fixes: d46ba2d17f90 ("mmc: sdhci-brcmstb: Add support for Command Queuing (CQE)")
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

Changes in v2:
 - Rely on cqhci_deactivate() to handle NULL cqe_private, instead of
   moving around CQE capability flags

 drivers/mmc/host/sdhci-brcmstb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
index aff36a933ebe..d479ca39c987 100644
--- a/drivers/mmc/host/sdhci-brcmstb.c
+++ b/drivers/mmc/host/sdhci-brcmstb.c
@@ -55,6 +55,9 @@ static void brcmstb_reset(struct sdhci_host *host, u8 mask)
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_brcmstb_priv *priv = sdhci_pltfm_priv(pltfm_host);
 
+	if ((host->mmc->caps2 & MMC_CAP2_CQE) && (mask & SDHCI_RESET_ALL))
+		cqhci_deactivate(host->mmc);
+
 	sdhci_reset(host, mask);
 
 	/* Reset will clear this, so re-enable it */
-- 
2.38.0.413.g74048e4d9e-goog

