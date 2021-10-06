Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799EFC433EF
	for <linux-mmc@archiver.kernel.org>; Wed,  6 Oct 2021 11:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C08B611C0
	for <linux-mmc@archiver.kernel.org>; Wed,  6 Oct 2021 11:25:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238306AbhJFL1O (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 6 Oct 2021 07:27:14 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.50]:30681 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238225AbhJFL1O (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Oct 2021 07:27:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1633519501;
    s=strato-dkim-0002; d=goldelico.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=XmOcGtT2R465zJ0p3YcHjU0RIWZ17S32hOWrnIUbcrI=;
    b=Wyk3/KpwXB7JBpVWSuZngWq9N+/rbmh5zGCnBQkH6Ys9BTjqtK8jUmkWcLqdM+VWDF
    3cL4VN9mQKJehOdxiWhCMPnR3YuVSh8t+f60LmfFJwQ8kt9WtTSNNpgMBaqW5H1JvIBy
    A1dDbrbYJQlPCOrZyU937frb0G5LujqstD+Ymz7JwvniOLJBxHq6B+9dTaV0LpsiltZb
    s4Rd2pqljo4iXCXeB/VdY3Dlaz3EKN3FwRTGAS7qaIfDOs+TnMQ7q70I8n8Dx6LO5RBc
    SGAeW2b6jDfCOlI9Ibnfx/QQvFvBGHUdIbgS2le34uvL6MLKji9iWg1ZWAuDMAcSfRHj
    QHRg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UMf2MwPVbjdbna"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 47.33.8 DYNA|AUTH)
    with ESMTPSA id I01f74x96BP09II
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 6 Oct 2021 13:25:00 +0200 (CEST)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Avri Altman <avri.altman@wdc.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bean Huo <beanhuo@micron.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [RFC] mmc: core: transplant ti,wl1251 quirks from to be retired omap_hsmmc
Date:   Wed,  6 Oct 2021 13:25:00 +0200
Message-Id: <8ecc5c79c1dd0627d570ede31e18c860786cacca.1633519499.git.hns@goldelico.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The TiWi 5 WiFi module needs special setup of the sdio
interface before it can be probed.

So far, this is done in omap_hsmmc_init_card() in omap_hsmmc.c
which makes it useable only if connected to omap devices
which use the omap_hsmmc. The OpenPandora is the most promient
example.

There are plans to switch to a newer sdhci-omap driver and
retire omap_hsmmc. Hence this quirk must be reworked or moved
somewhere else. Ideally to some location that is not dependent
on the specific SoC mmc host driver.

Analysis has shown that omap_hsmmc_init_card() is called
through the host->ops->init_card hook which itself
is called in three generic locations:

mmc_init_card()
mmc_sd_init_card()
mmc_sdio_init_card()

All these functions share a call to mmc_select_card() shortly
after running the init hook and therefore I assume that
a good place transplanting the special wl1251 handling is
mmc_select_card() - unless we want to copy and maintain the
code to three different places.

After this quirk has been moved there, we can remove
omap_hsmmc_init_card() in omap_hsmmc.c in a separate patch.
Indeed the plan is to remove omap_hsmmc.c completely.

A future development path to generalize could be to make
the code not depend on compatible = "ti,wl1251" but check
for optional device tree properties (non-std-sdio, bus width,
vendor, device, blksize, max_dtr, ocr) which can be defined
for any child device of the mmd/sd port needing such special
setup.

Related-to: commit f6498b922e57 ("mmc: host: omap_hsmmc: add code for special init of wl1251 to get rid of pandora_wl1251_init_card")
Related-to: commit 2398c41d6432 ("omap: pdata-quirks: remove openpandora quirks for mmc3 and wl1251")
Related-to: commit f9d50fef4b64 ("ARM: OMAP2+: omap3-pandora: add wifi support")
Tested-by: H. Nikolaus Schaller <hns@goldelico.com> # on OpenPandora
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/mmc/core/mmc_ops.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 0c54858e89c0..6f9b96be9fe6 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -7,6 +7,7 @@
 
 #include <linux/slab.h>
 #include <linux/export.h>
+#include <linux/of.h>
 #include <linux/types.h>
 #include <linux/scatterlist.h>
 
@@ -107,6 +108,35 @@ static int _mmc_select_card(struct mmc_host *host, struct mmc_card *card)
 
 int mmc_select_card(struct mmc_card *card)
 {
+	if (card->type == MMC_TYPE_SDIO || card->type == MMC_TYPE_SD_COMBO) {
+		struct device_node *np = card->host->parent->of_node;
+
+		/*
+		 * REVISIT: should be made more general
+		 * e.g. by expanding the DT bindings of child nodes to
+		 * optionally provide this information:
+		 * Documentation/devicetree/bindings/mmc/mmc-card.txt
+		 */
+
+		np = of_get_compatible_child(np, "ti,wl1251");
+		if (np) {
+			/*
+			 * We have TI wl1251 attached to this mmc. Pass this
+			 * information to the SDIO core because it can't be
+			 * probed by normal methods.
+			 */
+
+			dev_info(card->host->parent, "found wl1251\n");
+			card->quirks |= MMC_QUIRK_NONSTD_SDIO;
+			card->cccr.wide_bus = 1;
+			card->cis.vendor = 0x104c;
+			card->cis.device = 0x9066;
+			card->cis.blksize = 512;
+			card->cis.max_dtr = 24000000;
+			card->ocr = 0x80;
+			of_node_put(np);
+		}
+	}
 
 	return _mmc_select_card(card->host, card);
 }
-- 
2.33.0

