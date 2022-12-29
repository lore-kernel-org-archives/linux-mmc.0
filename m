Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B89E8C3DA7A
	for <linux-mmc@archiver.kernel.org>; Thu, 29 Dec 2022 20:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiL2UFF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 29 Dec 2022 15:05:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233504AbiL2UFE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Dec 2022 15:05:04 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D724B165A8
        for <linux-mmc@vger.kernel.org>; Thu, 29 Dec 2022 12:05:02 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id hd14-20020a17090b458e00b0021909875bccso19230837pjb.1
        for <linux-mmc@vger.kernel.org>; Thu, 29 Dec 2022 12:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KFjpQddF6K9jQuFhw0EZBw3KCqxEcEHNGaoCdbNy9Uw=;
        b=kewFcvPnmlK/daoedJ07uHcuNvIXEj8SG32nFgtaneG8Vk00S3miIVACLw+x/4+5XO
         HyhmjbkPjPC72TFziQuJKWLqAk5/0xEgKpvpJkKCC34lngvWsP3QXpTZlj6CswA/ZZA+
         RIYvIBZvUKDbTfqAHDg9Pil8Me3L9Saj5kCFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KFjpQddF6K9jQuFhw0EZBw3KCqxEcEHNGaoCdbNy9Uw=;
        b=0eHoNr5Eg3ZvrL8tHBm7jur1SDUGKHigYeovm8xJPSD5dpucaH5o+ES0VVks5cP5bK
         1+gZTYqKTV3h7zBDmWT6QGGfLkNZjHnhZXPs+aoY5drxqRKsgrKzfR+I1Ywir1/icDJF
         6asOkAW5VBSWeNHUA5jDFk3/2qJQmTlmI2n3UisPe9A8spyYUSk1HScCO6iCP26O96OP
         wYSJ6X4XtKpa/hAA1QNMALEs5DKLSIHWmYp6ymwBGGfkir8jGfBZpqmpC6TK4BVr5wsr
         +tnbvGmELZRpIJVdUU+6X1kEps1ZBMIl5h3avoaBKA14+vTLH6qJP3HnzcwGtDzMBD0o
         TBxg==
X-Gm-Message-State: AFqh2krqXXOmw2nWI548VltFBiQTfJl+bvBLjkRnW9htYS/7T/B9bYFN
        66+nT70AMH7mME3+xux4pRErjw==
X-Google-Smtp-Source: AMrXdXsRMMggph1dSmqk1DtjLX0D9GUCc0yQufbYA5KUQ3uQUn+V2j4jyqiSafsbRuz+q/xqxDV2TA==
X-Received: by 2002:a17:903:12d7:b0:189:854a:fff3 with SMTP id io23-20020a17090312d700b00189854afff3mr28679184plb.23.1672344302232;
        Thu, 29 Dec 2022 12:05:02 -0800 (PST)
Received: from doug-ryzen-5700G.. ([192.183.212.197])
        by smtp.gmail.com with ESMTPSA id w17-20020a170902e89100b00189ac5a2340sm13438589plg.124.2022.12.29.12.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 12:05:01 -0800 (PST)
From:   Doug Brown <doug@schmorgal.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Doug Brown <doug@schmorgal.com>
Subject: [PATCH v3 5/8] mmc: sdhci-pxav2: add optional core clock
Date:   Thu, 29 Dec 2022 12:04:08 -0800
Message-Id: <20221229200411.295339-6-doug@schmorgal.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221229200411.295339-1-doug@schmorgal.com>
References: <20221229200411.295339-1-doug@schmorgal.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add ability to have an optional core clock just like the pxav3 driver.
The PXA168 needs this because its SDHC controllers have separate core
and io clocks that both need to be enabled. This also correctly matches
the documented devicetree bindings for this driver.

Signed-off-by: Doug Brown <doug@schmorgal.com>
---
 drivers/mmc/host/sdhci-pxav2.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-pxav2.c
index f5c86e1ba734..b10f55b478fc 100644
--- a/drivers/mmc/host/sdhci-pxav2.c
+++ b/drivers/mmc/host/sdhci-pxav2.c
@@ -191,7 +191,7 @@ static int sdhci_pxav2_probe(struct platform_device *pdev)
 	const struct sdhci_pxa_variant *variant;
 
 	int ret;
-	struct clk *clk;
+	struct clk *clk, *clk_core;
 
 	host = sdhci_pltfm_init(pdev, NULL, 0);
 	if (IS_ERR(host))
@@ -214,6 +214,12 @@ static int sdhci_pxav2_probe(struct platform_device *pdev)
 		goto free;
 	}
 
+	clk_core = devm_clk_get_optional_enabled(dev, "core");
+	if (IS_ERR(clk_core)) {
+		dev_err_probe(dev, PTR_ERR(clk_core), "failed to enable core clock\n");
+		goto disable_clk;
+	}
+
 	host->quirks = SDHCI_QUIRK_BROKEN_ADMA
 		| SDHCI_QUIRK_BROKEN_TIMEOUT_VAL
 		| SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN;
-- 
2.34.1

