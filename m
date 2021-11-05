Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F5CBC4321E
	for <linux-mmc@archiver.kernel.org>; Fri,  5 Nov 2021 09:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B7D76127B
	for <linux-mmc@archiver.kernel.org>; Fri,  5 Nov 2021 09:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbhKEJJB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 5 Nov 2021 05:09:01 -0400
Received: from mo4-p03-ob.smtp.rzone.de ([85.215.255.100]:31809 "EHLO
        mo4-p03-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232839AbhKEJIz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Nov 2021 05:08:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1636103155;
    s=strato-dkim-0002; d=goldelico.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=ytqJC3tzZimA/vKcRado/QdQBzzBwoUDJjRTyS4f9aA=;
    b=jBH7QDTr7g+eR7GD+GQ5tp/rN31LiCz0PazLAjszxI+5qTXi4kcuIF7vo/iz3HNp21
    PFd7/Kg6/OldVyrnFqPDBPP0krA+ldkRV1g82STC5sTXsgebkU/2Z51nmiwXfQcZyjB3
    0pA0C5VSXwgsY7CBW7KJJ2wWB4V4O45wkKhqi0QSzweV5m9xV0cWD7FWnS39F4SOTePl
    VBdAU9UNgttvNd/fq/Bu+Tgia60EXnWYaTzxMywfDpRBB+XumHWxmLE0H7NDwwXjNqjY
    scRCjHZ8hBkMMr/UYr4nDVMhpPzC1TsVD2wqfV6GstaobF+y/kjndisnifFgr8ObMCGx
    9TcQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o12DNOsPj0lByOdfL1X0"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 47.34.1 DYNA|AUTH)
    with ESMTPSA id 902c63xA595s8uP
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 5 Nov 2021 10:05:54 +0100 (CET)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>, Avri Altman <avri.altman@wdc.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tony Lindgren <tony@atomide.com>, Bean Huo <beanhuo@micron.com>
Cc:     notasas@gmail.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [RFC v4 6/6] mmc: host: omap_hsmmc: revert special init for wl1251
Date:   Fri,  5 Nov 2021 10:05:51 +0100
Message-Id: <229fef6d6c3956b108b040fc34e8c8f3c710f377.1636103151.git.hns@goldelico.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1636103151.git.hns@goldelico.com>
References: <cover.1636103151.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Replaces: commit f6498b922e57 ("mmc: host: omap_hsmmc: add code for special init of wl1251 to get rid of pandora_wl1251_init_card")
Requires: commit ("mmc: core: transplant ti,wl1251 quirks from to be retired omap_hsmmc")

After moving the wl1251 quirks from omap_hsmmc_init_card() to wl1251_quirk()
and sdio_card_init_methods[] we can remove omap_hsmmc_init_card() completely.

This also removes the specialization on the combination of omap_hsmmc and wl1251.

Related-to: commit f6498b922e57 ("mmc: host: omap_hsmmc: add code for special init of wl1251 to get rid of pandora_wl1251_init_card")
Related-to: commit 2398c41d6432 ("omap: pdata-quirks: remove openpandora quirks for mmc3 and wl1251")
Related-to: commit f9d50fef4b64 ("ARM: OMAP2+: omap3-pandora: add wifi support")
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/mmc/host/omap_hsmmc.c | 36 -----------------------------------
 1 file changed, 36 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 6960e305e0a39..9749639ea8977 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1504,41 +1504,6 @@ static void omap_hsmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	omap_hsmmc_set_bus_mode(host);
 }
 
-static void omap_hsmmc_init_card(struct mmc_host *mmc, struct mmc_card *card)
-{
-	struct omap_hsmmc_host *host = mmc_priv(mmc);
-
-	if (card->type == MMC_TYPE_SDIO || card->type == MMC_TYPE_SD_COMBO) {
-		struct device_node *np = mmc_dev(mmc)->of_node;
-
-		/*
-		 * REVISIT: should be moved to sdio core and made more
-		 * general e.g. by expanding the DT bindings of child nodes
-		 * to provide a mechanism to provide this information:
-		 * Documentation/devicetree/bindings/mmc/mmc-card.txt
-		 */
-
-		np = of_get_compatible_child(np, "ti,wl1251");
-		if (np) {
-			/*
-			 * We have TI wl1251 attached to MMC3. Pass this
-			 * information to the SDIO core because it can't be
-			 * probed by normal methods.
-			 */
-
-			dev_info(host->dev, "found wl1251\n");
-			card->quirks |= MMC_QUIRK_NONSTD_SDIO;
-			card->cccr.wide_bus = 1;
-			card->cis.vendor = 0x104c;
-			card->cis.device = 0x9066;
-			card->cis.blksize = 512;
-			card->cis.max_dtr = 24000000;
-			card->ocr = 0x80;
-			of_node_put(np);
-		}
-	}
-}
-
 static void omap_hsmmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
 {
 	struct omap_hsmmc_host *host = mmc_priv(mmc);
@@ -1667,7 +1632,6 @@ static struct mmc_host_ops omap_hsmmc_ops = {
 	.set_ios = omap_hsmmc_set_ios,
 	.get_cd = mmc_gpio_get_cd,
 	.get_ro = mmc_gpio_get_ro,
-	.init_card = omap_hsmmc_init_card,
 	.enable_sdio_irq = omap_hsmmc_enable_sdio_irq,
 };
 
-- 
2.33.0

