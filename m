Return-Path: <SRS0=RjyY=7H=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA53C433DF
	for <linux-mmc@archiver.kernel.org>; Mon, 25 May 2020 10:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F01CA2078B
	for <linux-mmc@archiver.kernel.org>; Mon, 25 May 2020 10:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=timesys-com.20150623.gappssmtp.com header.i=@timesys-com.20150623.gappssmtp.com header.b="EQT6LeAv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389505AbgEYKR6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 25 May 2020 06:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389398AbgEYKR6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 25 May 2020 06:17:58 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D0FC05BD43
        for <linux-mmc@vger.kernel.org>; Mon, 25 May 2020 03:17:57 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id f189so17024476qkd.5
        for <linux-mmc@vger.kernel.org>; Mon, 25 May 2020 03:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xmqzWXeKcpGL2o7jr9BgSfqs5CcyjlGtbhwaWdaxAfA=;
        b=EQT6LeAvuiHuF5jVSf4sQFwv36qdNoXts3+4jk4YpPXekYeciKVklgNO3nb76YdYLN
         tVLmITtv239cqoSRA4BuELzplyoRKsmKo8BnIqzBFKu6Zaxt4faPplO8dmKN4l2Qr16Q
         MG526CQGCWQYCClAndSLrGOep/XREjzlgetD8BBiK5OnfCyd1HrzDCQYjJZxbH8DStih
         Gx7/LjIFFZM0BQFaMWtB/WDQAztrwfyynsyCAjf6wnQN3TtlG0LXb484WnxZkJ36k22W
         ECcwvHbbrvP58tBXiNAw8+PPvR4sKw0NmDK+3f6yRATE32lIy/fDkasn3UHJtH8rbYYT
         R3rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xmqzWXeKcpGL2o7jr9BgSfqs5CcyjlGtbhwaWdaxAfA=;
        b=mK6rXq6H5z027/2fMusnXZfvakPCcEpJtrlykL3j7hRcyiZrI+CyT1i8lBCqeskY5x
         YTxql9br1eyQhmh4d6lTShMmwR7OobJGRfUHm1GsDiQA6pLIW845qcI+sgYbS3qMmjOx
         CYsEZLZp6rf0MsRexzolLT0DMZP+tDuJVEAXtLrG7D2/oqW1eHHrA7x7umWiYM6aH2pp
         0Tc+y+f62ucivzNpD95LtUqxJuHB5N6PDRLJ+jryVoQUw66ffHAkJM93XWiVFf+yAuJ6
         NxrvN+R4X50FE7nM0vtjsEV2/ekUqGfzzIjTs1e1gzc3R3u5ZKok6rB6u4DgiIhlKeYS
         EWnw==
X-Gm-Message-State: AOAM5317Z1NMvuUv6TgzKv7xzHjjzaKbhgFjocTsvzNj8LscZ7guOUsQ
        Vj37V62lxCio+Y+6RUWpewc+mA==
X-Google-Smtp-Source: ABdhPJwJIdqHygan4azZPTufJFTn0xdHt69at/vHlBGZNdgZA7af8Fa6lgHRapZPY63ol75kQTKqhA==
X-Received: by 2002:a37:a710:: with SMTP id q16mr16555934qke.23.1590401876888;
        Mon, 25 May 2020 03:17:56 -0700 (PDT)
Received: from dfj.bfc.timesys.com (host203-36-dynamic.30-79-r.retail.telecomitalia.it. [79.30.36.203])
        by smtp.gmail.com with ESMTPSA id 99sm14407626qte.93.2020.05.25.03.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 03:17:56 -0700 (PDT)
From:   Angelo Dureghello <angelo.dureghello@timesys.com>
To:     gerg@linux-m68k.org
Cc:     linux-m68k@vger.kernel.org, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        Angelo Dureghello <angelo.dureghello@timesys.com>
Subject: [PATCH for-next] m68k: coldfire/clk.c: move m5441x specific code
Date:   Mon, 25 May 2020 12:23:24 +0200
Message-Id: <20200525102324.2723438-1-angelo.dureghello@timesys.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Moving specific m5441x clk-related code in more appropriate location,
since breaking compilation for other targets.

Signed-off-by: Angelo Dureghello <angelo.dureghello@timesys.com>
---
 arch/m68k/coldfire/clk.c    | 15 ---------------
 arch/m68k/coldfire/m5441x.c | 15 +++++++++++++++
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/m68k/coldfire/clk.c b/arch/m68k/coldfire/clk.c
index 75a057445472..7bc666e482eb 100644
--- a/arch/m68k/coldfire/clk.c
+++ b/arch/m68k/coldfire/clk.c
@@ -73,21 +73,6 @@ struct clk_ops clk_ops1 = {
 #endif /* MCFPM_PPMCR1 */
 #endif /* MCFPM_PPMCR0 */
 
-static void __clk_enable2(struct clk *clk)
-{
-	__raw_writel(__raw_readl(MCFSDHC_CLK) | (1 << clk->slot), MCFSDHC_CLK);
-}
-
-static void __clk_disable2(struct clk *clk)
-{
-	__raw_writel(__raw_readl(MCFSDHC_CLK) & ~(1 << clk->slot), MCFSDHC_CLK);
-}
-
-struct clk_ops clk_ops2 = {
-	.enable		= __clk_enable2,
-	.disable	= __clk_disable2,
-};
-
 struct clk *clk_get(struct device *dev, const char *id)
 {
 	const char *clk_name = dev ? dev_name(dev) : id ? id : NULL;
diff --git a/arch/m68k/coldfire/m5441x.c b/arch/m68k/coldfire/m5441x.c
index ffa02de1a3fb..1e5259a652d1 100644
--- a/arch/m68k/coldfire/m5441x.c
+++ b/arch/m68k/coldfire/m5441x.c
@@ -204,6 +204,21 @@ static struct clk * const disable_clks[] __initconst = {
 	&__clk_1_29, /* uart 9 */
 };
 
+static void __clk_enable2(struct clk *clk)
+{
+	__raw_writel(__raw_readl(MCFSDHC_CLK) | (1 << clk->slot), MCFSDHC_CLK);
+}
+
+static void __clk_disable2(struct clk *clk)
+{
+	__raw_writel(__raw_readl(MCFSDHC_CLK) & ~(1 << clk->slot), MCFSDHC_CLK);
+}
+
+struct clk_ops clk_ops2 = {
+	.enable		= __clk_enable2,
+	.disable	= __clk_disable2,
+};
+
 static void __init m5441x_clk_init(void)
 {
 	unsigned i;
-- 
2.26.2

