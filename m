Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A2D2C4332F
	for <linux-mmc@archiver.kernel.org>; Sat, 19 Nov 2022 03:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbiKSDE1 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 18 Nov 2022 22:04:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiKSDE0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Nov 2022 22:04:26 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EBCEB4822
        for <linux-mmc@vger.kernel.org>; Fri, 18 Nov 2022 19:04:25 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id bs21so12090099wrb.4
        for <linux-mmc@vger.kernel.org>; Fri, 18 Nov 2022 19:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iPJdTHNAM1d4uLbOJ4Nh1sKzPtELk6RB1/xiZvxNEPc=;
        b=n/eTdnubGh5pyfLdpo62Ug37gwnpmFmO5KXiAffeVPtNnGU8iNNhre80imncySj0vw
         qNMsV3UJuf/hefyBue7ZVg/O7IkS312xh6xm+SYiDVArMCSbZBLVec/qz27W7mxGaKiT
         2Z/ZSz2MUpqCX5zqVoBsRDoGY0fqlyJcNodxBB1JH51EmGYbNnrSWoRixPt12zjq375W
         a/vCFKEpUatLpkY2BNQ/DwVIRNV7Ee5Ju+tYhbuRmg5S1cM6U/S5WTaZ3NQqqOB/6NnG
         4RRWhG4PeTpkiRkWK3EQnw8L6xKZMIphThLNFgSa5OlHptlv7ZYmiuoZNA0VuptgzR0L
         pSzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iPJdTHNAM1d4uLbOJ4Nh1sKzPtELk6RB1/xiZvxNEPc=;
        b=BQksC7F5uWDUFXZYoOeZo47Aah9405GOictfEybt489kDBHoee8g/BES4OWtO7ay5E
         /zExE5a1aEQh9YN57eQRgcA1nttAXoHQPFQ4fRnQ0PILvbx19SRpr1m73HwZtTRbQeGx
         Sj1Kb/2fgvnXnN/yD7gR0YgdguS6YgwMuC3jEg2SuSM0SMp11ShM6gbIw+TUMZ8bWvlQ
         VrS8vtah+MXh+trjcJu5fKfpKWSstAE7y9CWIaVOG5y7dp+9ZRsyu2Hb8oyenBZSSvYV
         BP7Nz6KPyeNImD0ez+hmu4kSQva88kwaUu5OQ6k6xoubfGO3DiTTCwIFw2qBLtJQlufM
         lbaA==
X-Gm-Message-State: ANoB5pnnwNZuu3NUObslR1AtDxUbKxCY8llIybavMlijDgsxFY0qon/9
        e3ia0O710ieQllboWbCOJQ==
X-Google-Smtp-Source: AA0mqf6rNrih0tMxNe+eWlgH+Xiwcu7K23UaOHfapqOwXLUMkeSUgsSO2wkLwheBXFOh+WSBAIaSWw==
X-Received: by 2002:adf:ffd2:0:b0:236:59ab:cf33 with SMTP id x18-20020adfffd2000000b0023659abcf33mr5755519wrs.568.1668827063778;
        Fri, 18 Nov 2022 19:04:23 -0800 (PST)
Received: from v2202209183747202483.. ([2a03:4000:54:fac:a8fb:beff:fe0f:de18])
        by smtp.gmail.com with ESMTPSA id e2-20020adfdbc2000000b00241b95cae91sm4971650wrj.58.2022.11.18.19.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 19:04:23 -0800 (PST)
From:   Sebastian Falbesoner <sebastian.falbesoner@gmail.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org,
        Sebastian Falbesoner <sebastian.falbesoner@gmail.com>
Subject: [PATCH] mmc: sdhci-esdhc-imx: correct CQHCI exit halt state check
Date:   Sat, 19 Nov 2022 04:04:00 +0100
Message-Id: <20221119030400.1789919-1-sebastian.falbesoner@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

With the current logic the "failed to exit halt state" error would be
shown even if any other bit than CQHCI_HALT was set in the CQHCI_CTL
register, since the right hand side is always true. Fix this by using
the correct operator (bit-wise instead of logical AND) to only check for
the halt bit flag, which was obviously intended here.

Signed-off-by: Sebastian Falbesoner <sebastian.falbesoner@gmail.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 31ea0a2fce35..ffeb5759830f 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1512,7 +1512,7 @@ static void esdhc_cqe_enable(struct mmc_host *mmc)
 	 * system resume back.
 	 */
 	cqhci_writel(cq_host, 0, CQHCI_CTL);
-	if (cqhci_readl(cq_host, CQHCI_CTL) && CQHCI_HALT)
+	if (cqhci_readl(cq_host, CQHCI_CTL) & CQHCI_HALT)
 		dev_err(mmc_dev(host->mmc),
 			"failed to exit halt state when enable CQE\n");
 
-- 
2.34.1

