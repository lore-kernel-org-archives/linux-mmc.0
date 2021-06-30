Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 884AEC11F65
	for <linux-mmc@archiver.kernel.org>; Wed, 30 Jun 2021 10:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64F1361988
	for <linux-mmc@archiver.kernel.org>; Wed, 30 Jun 2021 10:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233959AbhF3K2m (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 30 Jun 2021 06:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbhF3K2m (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Jun 2021 06:28:42 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31792C061756
        for <linux-mmc@vger.kernel.org>; Wed, 30 Jun 2021 03:26:13 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id k10so4081666lfv.13
        for <linux-mmc@vger.kernel.org>; Wed, 30 Jun 2021 03:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/ffutUjzPFN7qPAJQtcSJsb+UgAvwvkfMxMfZtqu4kw=;
        b=zBhmFUTMbYq22xJ9DpkTAuY9UTNoNpjfAr0+9TA96iShE2YjQV2YiNHe5pr3KHy9is
         Jklc816Ov0rrOZY2pZaDXogiA7ik6AK+WSmb6QkINnbZigm/RjDPzr7mB69l9t/jMkY6
         NeUVs98OAk7PmNvNFsDj3hqFaZJxjdhRBIFIT5KXbZKMUAo8eTyjg771faxGKgEyBvwY
         rkGf1QEjnlU9DX3WKEhAAkbnWyAYuoLvn+72zBwlvPnfJI9H9F9vIDPH3N/14g+1hjO9
         2BtKI+FoLdfJ1o9eiXkDkGv6X9khbWKqKNISYNxZhh2SYDsPmtLEnY3yGj0CEiaeeXqQ
         9LEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/ffutUjzPFN7qPAJQtcSJsb+UgAvwvkfMxMfZtqu4kw=;
        b=LpHyBB2kYyZZcuXtYLC/E2wzld3of7iJeD7JIYtCJKirCkBWB/nT11GIqDXfkh68bz
         lOIm18VV66Q//7CwufVLTKbit9QdC9kHLrlWjh2uU0BYD9BdpdSuPsBGcc2uUNGvVuHn
         q4gWARucCutJH2Ae5D2uax076pP4StyWyjvHEDcpC1ws0hv8FDYEF2iYJch6oSLeXgRZ
         FsuWBh4LJrXxmsuzEvqXz1y44KWOeBpK8NHutc6TIkwFIr6HbZZcugoFeI8W8qqWqooL
         F/vD+wRxmOHUuNs5uWo8OTuR7webH3eD2Z7ht9KNSucGlO4uLvnlpPSV5cCze7Esp/Ht
         xwPA==
X-Gm-Message-State: AOAM533c7UTdZ7g2jwbRmy2l99PsUwJ9VcfR/lttEvRjdC1IkQht5mNc
        MJPaOwFcvVj9wh4wSyg9s3pmzsieBPPnVA==
X-Google-Smtp-Source: ABdhPJz4tbm1eTxMcN+l6DGMDHOND/5VWf0696YBgoQ1Ae4HB35jvg6ldDgzjzYbpS30x9G+u7SFyQ==
X-Received: by 2002:a19:8c03:: with SMTP id o3mr25937182lfd.499.1625048771412;
        Wed, 30 Jun 2021 03:26:11 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id bn23sm2167999ljb.48.2021.06.30.03.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 03:26:11 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Yann Gautier <yann.gautier@foss.st.com>,
        Ludovic Barre <ludovic.barre@st.com>
Subject: [PATCH v2] mmc: mmci: De-assert reset on probe
Date:   Wed, 30 Jun 2021 12:24:08 +0200
Message-Id: <20210630102408.3543024-1-linus.walleij@linaro.org>
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
ChangeLog v1->v2:
- Drop the else {} clause: reset_control_deassert() handles
  NULL just fine.
---
 drivers/mmc/host/mmci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 984d35055156..3765e2f4ad98 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -2126,6 +2126,9 @@ static int mmci_probe(struct amba_device *dev,
 		ret = PTR_ERR(host->rst);
 		goto clk_disable;
 	}
+	ret = reset_control_deassert(host->rst);
+	if (ret)
+		dev_err(mmc_dev(mmc), "failed to de-assert reset\n");
 
 	/* Get regulators and the supported OCR mask */
 	ret = mmc_regulator_get_supply(mmc);
-- 
2.31.1

