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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE2CC11D01
	for <linux-mmc@archiver.kernel.org>; Wed, 19 Feb 2020 21:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59F6B2467E
	for <linux-mmc@archiver.kernel.org>; Wed, 19 Feb 2020 21:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="doGhKwp0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbgBSVB2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 19 Feb 2020 16:01:28 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34964 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728081AbgBSVB1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Feb 2020 16:01:27 -0500
Received: by mail-qk1-f195.google.com with SMTP id v2so1553094qkj.2
        for <linux-mmc@vger.kernel.org>; Wed, 19 Feb 2020 13:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i1G9vXK5FwYFdDTpSlVN/9CUL77AbKR2OD/ycKa/MRs=;
        b=doGhKwp04sx4wvYOFgVZ5CLkTYNQAg0uFBhJQbiarO9VE1L3MgtLXc2Ay7XrzCs+Ta
         QfIkm6hXF8wZQa43dTJJVIgk/anhHSHKCLQHx202BHEECriwI/ZdiiSN/UPryZuOwI02
         V/BqG9LmyQ8Fv/yaTAp3un+sv1B5tAdZrGOj9Ljw0YWQJhv27m435k0mghY9c/lz6cQg
         WRcq7nj8hLDfR8yV6o34YZUW+PkOyhIxfFp0o5FBE2uLsdV0nBSMNfZeE7JHXbVnv+SK
         hfaOyV17AYhfv3uFmCJmIU/l4EZVplnUdYiPmnLifA1WPK4f7ihBtD9tqlD+CrVobXk8
         6Kxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i1G9vXK5FwYFdDTpSlVN/9CUL77AbKR2OD/ycKa/MRs=;
        b=GLcf7W4h/auVGhDcBgCXpWNdXox6pZ/e3hU+0bH/jz+zKUcsYWrAwc4jB19nBtoW1s
         Sn+BQ0sS97SzMaSHyTOggp0N2WwO9yoe44xIckDYbb0P1TVRVgv4KOZjOqTgMF6Eb3Gv
         DpzADLfEqOlYn48lv43rYzFr4O+cKDgT20a5EhGcIteuLKPJaNNkgGxK39O7KvYt7mBC
         Z3i+Sf5bV5YyemphXoS38he1A5epZW+gMnRDvpz9/Hhx0Zx32KcDHOlnGL5fNOQ214Mu
         Wnj3/GSGiRyuRhYbg4JjmuqQ9ge4GYk7xRMrON4TZRa7taY2OQ7foFqcRphuhVA8uS2U
         1vYA==
X-Gm-Message-State: APjAAAV7mz3iVPq5SwhuXBapPM5ExJM95/en3ssxl9hCcBVApUwH/Xs0
        8eE0ncJbLzwYT0TNzBxb+257dOll0PA=
X-Google-Smtp-Source: APXvYqwNrDElK/0WswHAIhq4S1UKQvxuxRcCxtL0jx7h+g3pHCSUw1x23nubael1FdZq04bF6xj6dA==
X-Received: by 2002:a05:620a:988:: with SMTP id x8mr23960396qkx.466.1582146086676;
        Wed, 19 Feb 2020 13:01:26 -0800 (PST)
Received: from jfddesk.Sonatest.net (ipagstaticip-d73c7528-4de5-0861-800b-03d8b15e3869.sdsl.bell.ca. [174.94.156.236])
        by smtp.gmail.com with ESMTPSA id m20sm509858qke.17.2020.02.19.13.01.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Feb 2020 13:01:26 -0800 (PST)
From:   Jean-Francois Dagenais <jeff.dagenais@gmail.com>
To:     linux-mmc@vger.kernel.org
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Subject: [PATCH] mmc: sdhci: make sure SDHCI_CLOCK_CARD_EN bit sticks
Date:   Wed, 19 Feb 2020 16:00:56 -0500
Message-Id: <20200219210056.22843-1-jeff.dagenais@gmail.com>
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
 drivers/mmc/host/sdhci.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 63db84481dff..d1e8eac6b15f 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1894,6 +1894,22 @@ void sdhci_enable_clk(struct sdhci_host *host, u16 clk)
 
 	clk |= SDHCI_CLOCK_CARD_EN;
 	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+
+	wmb();
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

