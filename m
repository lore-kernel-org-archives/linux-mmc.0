Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2AAC49361
	for <linux-mmc@archiver.kernel.org>; Sat, 19 Jun 2021 22:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72E82611C1
	for <linux-mmc@archiver.kernel.org>; Sat, 19 Jun 2021 22:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbhFSWzn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 19 Jun 2021 18:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhFSWzn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 19 Jun 2021 18:55:43 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DAA0C061574
        for <linux-mmc@vger.kernel.org>; Sat, 19 Jun 2021 15:53:30 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id m21so23205040lfg.13
        for <linux-mmc@vger.kernel.org>; Sat, 19 Jun 2021 15:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cKOYKZbl9cSfYG/W7JR30gdvjqHpzjJI/OIK0TN7/5M=;
        b=zoAFGIicsSAcKPNNfvXcauX0oqNhZ/C/3tTNjm+3eRsIiFCF7GHkSXMuXXxfL3Ej3Y
         yOSesUJ3BaczlR3ULawUw7QSlJ5/YyqUqQyj5zjCqAdGdDwnFA0i1d6KEem6HlZWy8YS
         Aukg7ND3ddzqF5+YD+WfHWOn5X4aFX/YMlZ11oVSSbA7B1kvkkjrsB6m8KYWFEMGoJsZ
         dV12yprixZLUqPe1ZpkhB/qLEBbf90y0d7aSdvEIPGp7d6MvqmK943DbDdqo6Tmw8rIF
         kdZ4B2WdIeXaO6mZ8BFJ/Fl60Uh7HYN0VG5o8rx7J7DgtT+QAyoHwTuFQKZ8THX8DUo3
         VkFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cKOYKZbl9cSfYG/W7JR30gdvjqHpzjJI/OIK0TN7/5M=;
        b=Jt6VHXgcl7V1lRMsprjIldjMZ3Ib2GyrOjKfCzc7yLOkfCrcPHWtdCHJrhL2tdVkit
         d/GcJUzKZ8SfI0xKmM60HH2QNAmDu191GJa9FO6+qgg14ct8fZc/RffiyFPPFipfxcyA
         Ab0IF2Q1KKO8ue5v44Qsux//aDQTJOceR+pi2O/4zKm4wWGO/MOISrZnwleO68LinUBy
         ZHwrPeAh2ehNDcEUzoThkIrrLIRmcG3FbO4PIcnk4rvRu03jtDCVrRKBYn2MNaV8nPMW
         Ru8Ap+hh+G/tZ5J59WtFDQs20HbdlhI0+0jYpezvePtvahg2C9UnAs2lDRIdp1hPwkxD
         g0DQ==
X-Gm-Message-State: AOAM533jJ+ZcepbUw6Ipxu/C1pMnYWytFfR+qxZ+E2Z1bib0fFvYvyZ1
        LsaRd1y1U0+yrjVYZ1IJLFLllchnB54nnw==
X-Google-Smtp-Source: ABdhPJwNxGPEe4xpDUwpej/Zqv52q9X6U3bMjdxaF54TVaONFcyK0mbJoF4i5hlXGQDDRjEBvkdbxg==
X-Received: by 2002:a19:7003:: with SMTP id h3mr8738694lfc.537.1624143206730;
        Sat, 19 Jun 2021 15:53:26 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id y5sm1345349lfa.148.2021.06.19.15.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jun 2021 15:53:25 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Yann Gautier <yann.gautier@foss.st.com>,
        Ludovic Barre <ludovic.barre@st.com>
Subject: [PATCH 1/3] mmc: mmci: De-assert reset on probe
Date:   Sun, 20 Jun 2021 00:51:16 +0200
Message-Id: <20210619225118.1862634-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

If we find a reset handle when probing the MMCI block,
make sure the reset is de-asserted. It could happen that
a hardware has reset asserted at boot.

Cc: Russell King <linux@armlinux.org.uk>
Cc: Yann Gautier <yann.gautier@foss.st.com>
Cc: Ludovic Barre <ludovic.barre@st.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/mmci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 984d35055156..af2ed6013ef9 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -2125,6 +2125,10 @@ static int mmci_probe(struct amba_device *dev,
 	if (IS_ERR(host->rst)) {
 		ret = PTR_ERR(host->rst);
 		goto clk_disable;
+	} else {
+		ret = reset_control_deassert(host->rst);
+		if (ret)
+			dev_err(mmc_dev(mmc), "failed to de-assert reset\n");
 	}
 
 	/* Get regulators and the supported OCR mask */
-- 
2.31.1

