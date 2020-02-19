Return-Path: <SRS0=5cIg=4H=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD45CC34056
	for <linux-mmc@archiver.kernel.org>; Wed, 19 Feb 2020 21:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 761C7207FD
	for <linux-mmc@archiver.kernel.org>; Wed, 19 Feb 2020 21:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PACDVgxm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbgBSVHv (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 19 Feb 2020 16:07:51 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44992 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbgBSVHu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Feb 2020 16:07:50 -0500
Received: by mail-qk1-f196.google.com with SMTP id j8so1524274qka.11
        for <linux-mmc@vger.kernel.org>; Wed, 19 Feb 2020 13:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uCAG3HaVg4nWNQaJms5zYLHK19fWXNHa4GKrXSnjFKw=;
        b=PACDVgxmkAVlUliwZIPiUrnw98B03hUQYZyXbAzHDn70UWqr4gqeFvCEglNZqOKDmr
         02AXhVV6+Q668nm1Nai/ICmjv/CKituOvPDBmBh0qFOIlrvzeRr8Xub/NYPr1zXl+GFD
         YDmZWAkTOXvZnVT8nhKxmhSDWNiwlZd5S75iK8D37hWjcYX0t3pDwSrTxZ8qyoNTrE8L
         5zJ6kzRo2z/1gWSh+5WDT7wTER81jhVKp+TOK0pVK8OBSdYTyh4HQ4v//g9gsYEPGQH4
         WMrdTYl5VNYMXN6dgdq2UNPUCvjT/d3hgw7eXRGC4fdZeDAJ4qbykjXlqE4daXlp7rSb
         YOsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uCAG3HaVg4nWNQaJms5zYLHK19fWXNHa4GKrXSnjFKw=;
        b=VHaPi/sVMA85FRNx/Xg1NqSPmRu7bboWDoEyBBA3RMYpGgT81od2Jsetn9r+tJA028
         zlTw0+5rsWSHHBrLt+EhNwyGZC6eTCdDGgo3UvS/7fUBWOXoWdmhtkREz8OFLRVYCxRm
         xaDa18xRwwr6hbv/XX4emK5k80KQDoKqv+x73l4DlftZVPvmWFYkR3hZupOGR9qEOdd/
         /c71RLotnYFmYnqKKQWJcGOv8lm2uAMkKwjvUddChO3lIGrBhXQFZkWVs5mtzvLJw6Wr
         SJOJM7G3n8tY7vlN23lj3DUyGAALGj9a4CHxrn92p3XpZfGgO5/3777tmXDz0tov09mO
         f9XQ==
X-Gm-Message-State: APjAAAXAEd2k2nngS6Yh1RixyBCCLNR9aooem843YY8l3pgT3yZOzXf8
        I+0MQ0D6Wqo26WR8tHmTTOf2jWrcq7ddgA==
X-Google-Smtp-Source: APXvYqy4pXR1XTGBubcBEeDZbgMnzPI2NGqufXJaNP7OTmLRHJwFfqMQk3DDf2W2geD6z7/feeG2qQ==
X-Received: by 2002:a37:f518:: with SMTP id l24mr23773768qkk.441.1582146468444;
        Wed, 19 Feb 2020 13:07:48 -0800 (PST)
Received: from jfddesk.Sonatest.net (ipagstaticip-d73c7528-4de5-0861-800b-03d8b15e3869.sdsl.bell.ca. [174.94.156.236])
        by smtp.gmail.com with ESMTPSA id k58sm681805qtb.60.2020.02.19.13.07.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Feb 2020 13:07:48 -0800 (PST)
From:   Jean-Francois Dagenais <jeff.dagenais@gmail.com>
To:     linux-mmc@vger.kernel.org
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Subject: [PATCH v2] mmc: sdhci: make sure SDHCI_CLOCK_CARD_EN bit sticks
Date:   Wed, 19 Feb 2020 16:07:30 -0500
Message-Id: <20200219210730.27640-1-jeff.dagenais@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Regardless of the broken-cd quirk, when it silently doesn't stick,
no clock is applied to the bus lines, yet the code continues to
try to make CMDs and times out after 10 seconds for each. This
process can take up to a minute as mmc_rescan_try_freq tries the
different commands to discover the card.

Short of changing sdhci_enable_clk's signature chain in all
dependent drivers, at least provide a hint that this might be the
problem. This will save tons of time for system integrators.

Signed-off-by: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
---
Changes in v2:
 * removed redundant wmb()
---
 drivers/mmc/host/sdhci.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 63db84481dff..42a02d034fda 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1894,6 +1894,20 @@ void sdhci_enable_clk(struct sdhci_host *host, u16 clk)
 
 	clk |= SDHCI_CLOCK_CARD_EN;
 	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+
+	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+	if (clk & SDHCI_CLOCK_CARD_EN)
+		return;
+
+	/* The controller will clear this bit if card absent condition is
+	 * detected. If card is indeed present, check platform configuration for
+	 * how CD is reported to the SDHCI host controller. There may be an
+	 * "assume present" mechanism in the platform registers, or your pin mux
+	 * may be incorrect.
+	 */
+	pr_err("%s: SDHCI_CLOCK_CARD_EN bit did not stick. Card absent?\n",
+		mmc_hostname(host->mmc));
+	sdhci_dumpregs(host);
 }
 EXPORT_SYMBOL_GPL(sdhci_enable_clk);
 
-- 
2.25.0

