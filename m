Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5CAEC678D4
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Jan 2023 19:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233746AbjAPToz (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Jan 2023 14:44:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233912AbjAPTov (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Jan 2023 14:44:51 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1201D2CC51
        for <linux-mmc@vger.kernel.org>; Mon, 16 Jan 2023 11:44:50 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id y1so31319665plb.2
        for <linux-mmc@vger.kernel.org>; Mon, 16 Jan 2023 11:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MY5kf847zY0nN9lKzWJgGUhJ3Yit9Nb6tzRd8EwwrE0=;
        b=ZZ/FQ4Pb5VLNmaqh3DetovgycLhPjdlVhGYnnT1PlKhOw6wCs+LUeFb0mWhJ4n00yk
         yGj0AGH8dDXpMoNf9MKu/5f7AOVVUn4L+YUsh0zDqMGXnJEnZST6l3xqmv7MNJhavTP0
         0f+ORcYJCBizuyMkfqdCxEKFMbD144okWIYd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MY5kf847zY0nN9lKzWJgGUhJ3Yit9Nb6tzRd8EwwrE0=;
        b=hYIxA8hQ1mcKK1b/T6mLqhsHNEJQCigHXHEppI+bk210ZBFDIXEMfMA653yoQk21le
         sO+lXP6blBqK6JDVE8/rGNibEbh/PPYoJLAkHzcVeeEqMK2JwVy72Eu5c9qLiqPPHDOH
         L2JbXcO6PEw0DzjaVihkBqiyCHy4J+eVxvRedrdJGA/i0Nf8YsGLGOZO98DHLi6AqnnJ
         a1Fg6f0Xjjx6aoKdn1r5615DU33UrJvo15V6edxNX4WPnp7K8ewo8o0h2X6k5jhuNeLb
         tdLbDw+VlmmnlM8q0OR+3DYk90ZLT1nrmiF1DExW4xBtMgX0hng+82U+iR0ToTvxB1Ib
         43Lw==
X-Gm-Message-State: AFqh2kp63fF3CVGE5p8bVQfnqWxilvUASkL/P7jKjmnteqyKpqi0GlZf
        Wnu4CF2YUe1ch5MtczLG3IG5yw==
X-Google-Smtp-Source: AMrXdXu7LX8J0YgkYfZOFsZB5M2RQdPva+1b3z/ocNn4FConU3pe1sX2UUPpQG0a06B9a6rVjp6Riw==
X-Received: by 2002:a17:902:8a8a:b0:191:13f2:173a with SMTP id p10-20020a1709028a8a00b0019113f2173amr816676plo.36.1673898289317;
        Mon, 16 Jan 2023 11:44:49 -0800 (PST)
Received: from doug-ryzen-5700G.. ([192.183.212.197])
        by smtp.gmail.com with ESMTPSA id t13-20020a170902b20d00b001926a76e8absm19734663plr.114.2023.01.16.11.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 11:44:48 -0800 (PST)
From:   Doug Brown <doug@schmorgal.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Doug Brown <doug@schmorgal.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>
Subject: [PATCH v5 5/8] mmc: sdhci-pxav2: add optional core clock
Date:   Mon, 16 Jan 2023 11:43:58 -0800
Message-Id: <20230116194401.20372-6-doug@schmorgal.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230116194401.20372-1-doug@schmorgal.com>
References: <20230116194401.20372-1-doug@schmorgal.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add ability to have an optional core clock just like the pxav3 driver.
The PXA168 needs this because its SDHC controllers have separate core
and io clocks that both need to be enabled. This also correctly matches
the documented devicetree bindings for this driver.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Doug Brown <doug@schmorgal.com>
---
The Reported-by tags above refer to a missing assignment to ret in an
earlier version of this patch. The kernel test robot caught it.

 drivers/mmc/host/sdhci-pxav2.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-pxav2.c
index f5c86e1ba734..3141901e1558 100644
--- a/drivers/mmc/host/sdhci-pxav2.c
+++ b/drivers/mmc/host/sdhci-pxav2.c
@@ -191,7 +191,7 @@ static int sdhci_pxav2_probe(struct platform_device *pdev)
 	const struct sdhci_pxa_variant *variant;
 
 	int ret;
-	struct clk *clk;
+	struct clk *clk, *clk_core;
 
 	host = sdhci_pltfm_init(pdev, NULL, 0);
 	if (IS_ERR(host))
@@ -214,6 +214,13 @@ static int sdhci_pxav2_probe(struct platform_device *pdev)
 		goto free;
 	}
 
+	clk_core = devm_clk_get_optional_enabled(dev, "core");
+	if (IS_ERR(clk_core)) {
+		ret = PTR_ERR(clk_core);
+		dev_err_probe(dev, ret, "failed to enable core clock\n");
+		goto disable_clk;
+	}
+
 	host->quirks = SDHCI_QUIRK_BROKEN_ADMA
 		| SDHCI_QUIRK_BROKEN_TIMEOUT_VAL
 		| SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN;
-- 
2.34.1

