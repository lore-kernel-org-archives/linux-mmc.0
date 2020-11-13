Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E168CC4742C
	for <linux-mmc@archiver.kernel.org>; Fri, 13 Nov 2020 12:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D94072224D
	for <linux-mmc@archiver.kernel.org>; Fri, 13 Nov 2020 12:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="OjGZid0a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgKMMyG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 13 Nov 2020 07:54:06 -0500
Received: from www.zeus03.de ([194.117.254.33]:40624 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726456AbgKMMyG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 13 Nov 2020 07:54:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=2xaZcTNBmlwWE3gKC/8hs239KkH
        hvb28luTKU+KZ9Mc=; b=OjGZid0aA4tVBz4B9HuDuvfkjWJ+pII9Vjkp6U4so6T
        dBufAQtBoM4qb5L0bI0jXW5mmwi7mvgnr4OPkm+JmSCaHnw1JrIwadgIJdAf/iL+
        YnAloGips4wkoTmDWOPmIOTNoXYJSaHHoaso4dfFwZYRhctvykw6vA3DRZedo0AM
        =
Received: (qmail 3160007 invoked from network); 13 Nov 2020 13:54:02 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 13 Nov 2020 13:54:02 +0100
X-UD-Smtp-Session: l3s3148p1@+AbVhfyzjJAgAwDPXxaWAHZio88zPEfF
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-mmc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org
Subject: [RFC PATCH] mmc: sdhci: tegra: fix wrong unit with busy_timeout
Date:   Fri, 13 Nov 2020 13:53:30 +0100
Message-Id: <20201113125354.3507-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

'busy_timeout' is in msecs, not in jiffies. Use the correct factor.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Not tested. Found by code investigation about 'busy_timeout'. A quick
grep showed no other problematic code within the MMC host drivers.

 drivers/mmc/host/sdhci-tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index ed12aacb1c73..ad0dc3adc7d1 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -1272,7 +1272,7 @@ static void tegra_sdhci_set_timeout(struct sdhci_host *host,
 	 * busy wait mode.
 	 */
 	val = sdhci_readl(host, SDHCI_TEGRA_VENDOR_MISC_CTRL);
-	if (cmd && cmd->busy_timeout >= 11 * HZ)
+	if (cmd && cmd->busy_timeout >= 11 * MSECS_PER_SEC)
 		val |= SDHCI_MISC_CTRL_ERASE_TIMEOUT_LIMIT;
 	else
 		val &= ~SDHCI_MISC_CTRL_ERASE_TIMEOUT_LIMIT;
-- 
2.28.0

