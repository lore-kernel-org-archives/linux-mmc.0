Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A91EC433EF
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Jul 2022 17:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238778AbiGNRmR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 14 Jul 2022 13:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbiGNRmQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Jul 2022 13:42:16 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548DE4F695;
        Thu, 14 Jul 2022 10:42:16 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id b8so3472114pjo.5;
        Thu, 14 Jul 2022 10:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=7yjL2expcxBKXOQuAJE5MbH5QFMOzJ52MUra63CEevk=;
        b=DRcAN2xwgo/Uxp6vYzqLufhSw3/fvkjTqPz/ZCng/QQjbjoO5bdGJvVu/Kw+q5rII4
         xdgJa9QK+/262nHBzbquVQxcPt/wTK7eB1hR2L8BTS7PWlpDq2KpYZ+e0FfRQz+3ig6s
         HgTQdUEzbV60X0e9VjTRzqofl4POzSN4w0r4UyAnjwVC7LUhqtwMmvk8gESVj7G2Aba0
         QWemcUlkZrXiEY83A4vXljsSFkxWow1hDBX0azTlPfrM9+E5wHUkJpngB3B7KD0SzNyG
         EtztQU2WCrLB2w6bSL7sKvQQ/tfJyrQbCP0SDQBfsZ3NM4r+CODdBCwWJvGVd84eu+kt
         0HCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7yjL2expcxBKXOQuAJE5MbH5QFMOzJ52MUra63CEevk=;
        b=2NABOSPtx160ZP/d3wLtE416VVB9FuZf6HbGE7bZQ7nbqxSxhD+dek7kdqbOER7CPp
         LlYvT9EjRqvBrmHez/XfbSGT0iEjGefo8NULnHUjS2SWwPslTwvfaeYju2MZ7M+MB7oj
         Mg5tZqOdfb2wIjrfs7vf2XYYsfm/n0jW6EKWmZecMYv3OGPXSvDlzDxxNsjfWimOBq2+
         ms9WMWEKx7Lp0yJpjQ51rZW9rN5hjK8afkbYtiEbVeaNZm9XUwx9Sk62U8gLcYRWgGtN
         QYuR6MghzPS1niBfhoBS1Gn/4axFY1zgBsuR4a9XQKKRBAba8NIJV2OGJvkQLUf+ggBg
         dWBQ==
X-Gm-Message-State: AJIora/eStLVmIRDc/1kusmBRyvoJwhQD0gvMGmiethv+7yj7Vb1rpZj
        QernCBS70RMFaMteWT6eug4=
X-Google-Smtp-Source: AGRyM1vw7XtwZtH7FPoxIJ53uJpJ1+HL66UlZ8Xf8qvbh8BcwfgqOCIZmEZcxfoAFotdfAbGihwYRg==
X-Received: by 2002:a17:90b:4a8b:b0:1ef:fba9:1c0b with SMTP id lp11-20020a17090b4a8b00b001effba91c0bmr17387713pjb.239.1657820535896;
        Thu, 14 Jul 2022 10:42:15 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id s13-20020a170902b18d00b0016c35b21901sm1734006plr.195.2022.07.14.10.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 10:42:15 -0700 (PDT)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        alcooperx@gmail.com
Cc:     f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Kamal Dasu <kdasu.kdev@gmail.com>
Subject: [PATCH] mmc: sdhci-brcmstb: use clk_get_rate(base_clk) in PM resume
Date:   Thu, 14 Jul 2022 13:41:32 -0400
Message-Id: <20220714174132.18541-1-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Use clk_get_rate for base_clk on resume before setting new rate.
This change ensures that the clock api returns current rate
and sets the clock to the desired rate and honors CLK_GET_NO_CACHE
attribute used by clock api.

Fixes: 97904a59855c (mmc: sdhci-brcmstb: Add ability to increase max clock rate for 72116b0)
Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
---
 drivers/mmc/host/sdhci-brcmstb.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
index 28e9cf995c41..aff36a933ebe 100644
--- a/drivers/mmc/host/sdhci-brcmstb.c
+++ b/drivers/mmc/host/sdhci-brcmstb.c
@@ -406,7 +406,14 @@ static int sdhci_brcmstb_resume(struct device *dev)
 	ret = sdhci_pltfm_resume(dev);
 	if (!ret && priv->base_freq_hz) {
 		ret = clk_prepare_enable(priv->base_clk);
-		if (!ret)
+		/*
+		 * Note: using clk_get_rate() below as clk_get_rate()
+		 * honors CLK_GET_RATE_NOCACHE attribute, but clk_set_rate()
+		 * may do implicit get_rate() calls that do not honor
+		 * CLK_GET_RATE_NOCACHE.
+		 */
+		if (!ret &&
+		    (clk_get_rate(priv->base_clk) != priv->base_freq_hz))
 			ret = clk_set_rate(priv->base_clk, priv->base_freq_hz);
 	}
 
-- 
2.17.1

