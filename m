Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE34C433EF
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Sep 2021 22:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94D1360F41
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Sep 2021 22:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345635AbhIXWwr (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 24 Sep 2021 18:52:47 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:35338
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232123AbhIXWwr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Sep 2021 18:52:47 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 039723F357;
        Fri, 24 Sep 2021 22:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632523872;
        bh=H1PiKCNuxQ0GvKHiEV6SAbFHNf1V73jtCVIifnLCxdo=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=mz6DLpcFvPNspezRYs8cAvMfYvQHHgZ2Ac1YsY6DUcZwKegRodWan4MS7k3xCcrUo
         Yw61oGMNE7U3Zz8L2GIjEWQlihAqOiaFxBpIE03KzWrS3l8ZDKvn+4YotYNISl5HqD
         Qnxe0Y61HJ5ENpYWuAIgJuSdHbmXRZAl6+HH9+EMTwusPkR4tFVIF8IW/eG67+M+tx
         qH66HziuaMBp8FFQS7XnD3r1ihvLSvDWgpNVLa/LTrE1UOz1gidnqOSL0TePWpu0kF
         kYluugAoMQtBNmDEKsmjjSR1v3c5orRlbeQ41eLE8+cUwbqN6CoEd26s3lLBheC1PR
         s2UCYRDF1WBtA==
From:   Colin King <colin.king@canonical.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: sdhci-pci-o2micro: Fix spelling mistake "unsupport" -> "unsupported"
Date:   Fri, 24 Sep 2021 23:51:11 +0100
Message-Id: <20210924225111.143112-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a pr_info message. Fix it. Also
put msi in capital letters.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/mmc/host/sdhci-pci-o2micro.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
index 51d55a87aebe..f045c1ee4667 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -489,7 +489,7 @@ static void sdhci_pci_o2_enable_msi(struct sdhci_pci_chip *chip,
 
 	ret = pci_find_capability(chip->pdev, PCI_CAP_ID_MSI);
 	if (!ret) {
-		pr_info("%s: unsupport msi, use INTx irq\n",
+		pr_info("%s: unsupported MSI, use INTx irq\n",
 			mmc_hostname(host->mmc));
 		return;
 	}
-- 
2.32.0

