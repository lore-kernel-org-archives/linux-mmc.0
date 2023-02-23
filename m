Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3788EC636D6
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Feb 2023 12:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233379AbjBWMhD (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 23 Feb 2023 07:37:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233157AbjBWMhC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Feb 2023 07:37:02 -0500
X-Greylist: delayed 1845 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 23 Feb 2023 04:36:32 PST
Received: from m126.mail.126.com (m126.mail.126.com [220.181.12.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2D51C5328F;
        Thu, 23 Feb 2023 04:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=k4Fjd
        bg6JDTEylD+E4vE7UUfeyw4I0IpjbUzfoCkJhc=; b=U84x9rz1Ozud4kMckliMT
        8qRQqZdZ6nkgWZdCcFvI7SriXtnUrgFaukMJ4i8rb5ZlxpzUcNCTzfrh/UeDCf2a
        Fr4HW3ftCUc33P0wv/wfxGT+fVeJbs9xgxlg6m67m1ftD/JzaAEkj2OjBstnCHYA
        x+nmIrxkMEUklL0BPORHpE=
Received: from bht-Z390-M-GAMING.towerbridgetechnology.com (unknown [58.48.115.170])
        by zwqz-smtp-mta-g2-0 (Coremail) with SMTP id _____wB30oJoVvdjqEj_AA--.44287S2;
        Thu, 23 Feb 2023 20:05:25 +0800 (CST)
From:   fredaibayhubtech@126.com
To:     adrian_hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux.kernel@vger.kernel.org
Cc:     shaper.liu@bayhubtech.com, chevron.li@bayhubtech.com,
        xiaoguang.yu@bayhubtech.com, shirley.her@bayhubtech.com,
        fred.ai@bayhubtech.com
Subject: [PATCH V1 1/1] mmc:sdhci-pci-o2micro: Fix SDR50 mode timing issue
Date:   Thu, 23 Feb 2023 20:04:50 +0800
Message-Id: <20230223120450.16858-1-fredaibayhubtech@126.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wB30oJoVvdjqEj_AA--.44287S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWw13JF1fAF1DCF18KrWkXrb_yoW5Jw1kpr
        Z3tayqya12qrZYvFZrXw10vr15Xw1vyrW0vFyfGw1fZF4xCrW2vrs7Ca45WFy8XrZ3tw1f
        Xrs5tF97Wr1UX37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jMtC7UUUUU=
X-Originating-IP: [58.48.115.170]
X-CM-SenderInfo: xiuhvtpled5x5xewvubk6rjloofrz/1tbiIQcfbWIxlYFUiQAAsO
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Fred <fred.ai@bayhubtech.com>

Change SDR50 mode clock source from DLL output clock to PLL open clock
1.HS200 and SDR104 mode select DLL output clock
2.SDR50 mode select PLL open clock

Signed-off-by: Fred <fred.ai@bayhubtech.com>
---
Change in V1
SDR50 mode select PLL open clock as its clock source.
---
 drivers/mmc/host/sdhci-pci-o2micro.c | 30 +++++++++++++++-------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
index 98cadff47b2b..620f52ad9667 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -339,22 +339,24 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	reg_val &= ~SDHCI_CLOCK_CARD_EN;
 	sdhci_writew(host, reg_val, SDHCI_CLOCK_CONTROL);
 
-	/* UnLock WP */
-	pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch_8);
-	scratch_8 &= 0x7f;
-	pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch_8);
-
-	/* Set pcr 0x354[16] to choose dll clock, and set the default phase */
-	pci_read_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, &reg_val);
-	reg_val &= ~(O2_SD_SEL_DLL | O2_SD_PHASE_MASK);
-	reg_val |= (O2_SD_SEL_DLL | O2_SD_FIX_PHASE);
-	pci_write_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, reg_val);
+	if ((host->timing == MMC_TIMING_MMC_HS200) ||
+		(host->timing == MMC_TIMING_UHS_SDR104)) {
+		/* UnLock WP */
+		pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch_8);
+		scratch_8 &= 0x7f;
+		pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch_8);
 
-	/* Lock WP */
-	pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch_8);
-	scratch_8 |= 0x80;
-	pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch_8);
+		/* Set pcr 0x354[16] to choose dll clock, and set the default phase */
+		pci_read_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, &reg_val);
+		reg_val &= ~(O2_SD_SEL_DLL | O2_SD_PHASE_MASK);
+		reg_val |= (O2_SD_SEL_DLL | O2_SD_FIX_PHASE);
+		pci_write_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, reg_val);
 
+		/* Lock WP */
+		pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch_8);
+		scratch_8 |= 0x80;
+		pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch_8);
+	}
 	/* Start clk */
 	reg_val = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
 	reg_val |= SDHCI_CLOCK_CARD_EN;
-- 
2.37.2

