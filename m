Return-Path: <SRS0=pl8z=67=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7460DC433DF
	for <linux-mmc@archiver.kernel.org>; Sun, 17 May 2020 22:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52FA320671
	for <linux-mmc@archiver.kernel.org>; Sun, 17 May 2020 22:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="nLfxDJx+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgEQW3h (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 17 May 2020 18:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbgEQW3g (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 17 May 2020 18:29:36 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC0DC061A0C;
        Sun, 17 May 2020 15:29:35 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id 50so9590595wrc.11;
        Sun, 17 May 2020 15:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5kskdNCXUeU43PRE2xrrGH3HyGgk8uIcHaWhxllvRd4=;
        b=nLfxDJx+McTvhZWta20rfp1gsNlKL/qrEtiIceLWUA74Rs9+LRa/hv6if9WC7mCf1p
         9n9iH/m6woofKoeuzmj0tKBQkJLZTltyYraj9gJ5gFQuzfNbe8AfmezC/FOgB7+WhfKS
         XGLCX8Ecyv8FtdiyUb2F8czQCswT6asp2UQbxT2eJQX8k7Hbu738aXMJtWuSmw9Wxf5y
         Meitus7Nuo8x7kY3/NEmneV6vM08w5Ess6hB2Bg12J0TXVJATeEfCSeqLAijuO+Czzfh
         WxEhcm8Dky86RODxr1ph1IcFRlq/hS8+EzVCmSEOf7MMAeB2XbsBXs9Wyi0BkMiKTG3E
         pH6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5kskdNCXUeU43PRE2xrrGH3HyGgk8uIcHaWhxllvRd4=;
        b=idS7ux3B/o5Qz6iJ0bCcxWQy5ddKvy5nkv2aH2blTZ6XyAkMeam/MzmcMB0QTbXgBr
         DSScHIw7VMFF7n+OcSPHo6LH1bR4qFZLQFFuhW2qKcLPSnzV8ErHRe+NQ/hPZjOs9giN
         HePa/ZAI0+D7af6K62rmFERO8cTE/O7rZBnpJlrRzHrQa8cCdCm8zRrLmhxPDXWOihAI
         BW+N5xkqQ9/aJK+dD7FECNaIdzyg3CTTca9mxjweKHBeGWexO8g0vS/WDvXfYIUCzenk
         cjbGXmRlHk1LHfuJilCv83obCxUlPieFaaPq/S1n6YlV8kdnQjT6WwIuokPo+TcKE3p+
         +bJg==
X-Gm-Message-State: AOAM532Gv5SQfuAIZ2JuazLAONRa9zR9Hvk+Q5oLoHTsf7aN1vXv/yXg
        LTMNt31lzwPr23vc/dYnQqnUWNSaO6c=
X-Google-Smtp-Source: ABdhPJz2xthLfydkI05LOcHzz87pllggKjXjXyzZrAp1wsvEsDqdObOgExqdVKlsqRay7E0U3pCAwA==
X-Received: by 2002:a05:6000:12c2:: with SMTP id l2mr15529375wrx.133.1589754574317;
        Sun, 17 May 2020 15:29:34 -0700 (PDT)
Received: from localhost.localdomain (p200300f137132e00428d5cfffeb99db8.dip0.t-ipconnect.de. [2003:f1:3713:2e00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id b65sm14624702wmc.30.2020.05.17.15.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 15:29:33 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH 2/2] mmc: host: meson-mx-sdhc: don't use literal 0 to initialize structs
Date:   Mon, 18 May 2020 00:29:07 +0200
Message-Id: <20200517222907.1277787-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200517222907.1277787-1-martin.blumenstingl@googlemail.com>
References: <20200517222907.1277787-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Kbuild test robot reports the following warning in lines 56 and 87 of
drivers/mmc/host/meson-mx-sdhc-clkc.c:
  Using plain integer as NULL pointer

Drop the integer value from the struct initialization to fix that
warning. This will still ensure that the compiler will zero out the
struct so it's in a well-defined state.

Fixes: 53ded1b676d199 ("mmc: host: meson-mx-sdhc: new driver for the Amlogic Meson SDHC host")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/mmc/host/meson-mx-sdhc-clkc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/meson-mx-sdhc-clkc.c b/drivers/mmc/host/meson-mx-sdhc-clkc.c
index ab0d6c68a078..e1f29b279123 100644
--- a/drivers/mmc/host/meson-mx-sdhc-clkc.c
+++ b/drivers/mmc/host/meson-mx-sdhc-clkc.c
@@ -53,7 +53,7 @@ static int meson_mx_sdhc_clk_hw_register(struct device *dev,
 					 const struct clk_ops *ops,
 					 struct clk_hw *hw)
 {
-	struct clk_init_data init = { 0 };
+	struct clk_init_data init = { };
 	char clk_name[32];
 
 	snprintf(clk_name, sizeof(clk_name), "%s#%s", dev_name(dev),
@@ -84,7 +84,7 @@ static int meson_mx_sdhc_gate_clk_hw_register(struct device *dev,
 int meson_mx_sdhc_register_clkc(struct device *dev, void __iomem *base,
 				struct clk_bulk_data *clk_bulk_data)
 {
-	struct clk_parent_data div_parent = { 0 };
+	struct clk_parent_data div_parent = { };
 	struct meson_mx_sdhc_clkc *clkc_data;
 	int ret;
 
-- 
2.26.2

