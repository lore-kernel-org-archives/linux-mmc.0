Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E82C433EF
	for <linux-mmc@archiver.kernel.org>; Tue,  7 Dec 2021 06:40:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233984AbhLGGo1 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 7 Dec 2021 01:44:27 -0500
Received: from marcansoft.com ([212.63.210.85]:51266 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232354AbhLGGo0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 7 Dec 2021 01:44:26 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 8FEAA423BD;
        Tue,  7 Dec 2021 06:40:53 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Marc Zyngier <maz@kernel.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] mmc: sdhci-pci-gli: GL9755: Issue 8/16-bit MMIO reads as 32-bit reads.
Date:   Tue,  7 Dec 2021 15:40:19 +0900
Message-Id: <20211207064019.61444-3-marcan@marcan.st>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211207064019.61444-1-marcan@marcan.st>
References: <20211207064019.61444-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

For some reason, <32-bit reads do not work on Apple ARM64 platforms with
these chips (even though they do on other PCIe devices). Issue them as
32-bit reads instead. This is done unconditionally, as it shouldn't hurt
even if not necessary.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/mmc/host/sdhci-pci-gli.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index ad742743a494..31547fed0952 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -906,7 +906,26 @@ static int gli_probe_slot_gl9763e(struct sdhci_pci_slot *slot)
 	return 0;
 }
 
+#define REG_OFFSET_IN_BITS(reg) ((reg) << 3 & 0x18)
+
+static u16 sdhci_gli_readw(struct sdhci_host *host, int reg)
+{
+	u32 val = readl(host->ioaddr + (reg & ~3));
+	u16 word;
+	word = (val >> REG_OFFSET_IN_BITS(reg)) & 0xffff;
+	return word;
+}
+
+static u8 sdhci_gli_readb(struct sdhci_host *host, int reg)
+{
+	u32 val = readl(host->ioaddr + (reg & ~3));
+	u8 byte = (val >> REG_OFFSET_IN_BITS(reg)) & 0xff;
+	return byte;
+}
+
 static const struct sdhci_ops sdhci_gl9755_ops = {
+	.read_w			= sdhci_gli_readw,
+	.read_b			= sdhci_gli_readb,
 	.set_clock		= sdhci_gl9755_set_clock,
 	.enable_dma		= sdhci_pci_enable_dma,
 	.set_bus_width		= sdhci_set_bus_width,
-- 
2.33.0

