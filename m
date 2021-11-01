Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD84C433FE
	for <linux-mmc@archiver.kernel.org>; Mon,  1 Nov 2021 09:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63E47610CB
	for <linux-mmc@archiver.kernel.org>; Mon,  1 Nov 2021 09:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbhKAJos (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 1 Nov 2021 05:44:48 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.171]:10050 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233439AbhKAJmJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 1 Nov 2021 05:42:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1635759560;
    s=strato-dkim-0002; d=goldelico.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=TJ0YVmi/NuO/y3MEGu168+AMKkVXNrfAPjqEA0cq6xQ=;
    b=Aw/w8324cu6fGUaXHE/5jI/B5sCJEYKhxXtu16FlSM3R4vAaiaU7JeOdTtZeoucHsA
    fn9ECHbg3wXdlkGTwTlnVZJn6LAP+J8bUUp3QNVf7ogoOhX6RboM3mjRPeKlula5EY4s
    tAqYHonKlBDt7f/KyNAmNf9A09aeVwIsGDrrID/itKLVoll3ILWf+j+3Y9N2iURDTd5X
    qcA8FAsxxXYfFx1JiKjnBAU1ks2DKKPPj/ovFB+zZVNmo/aawtR2Sj4Amtz0Gtii+m9B
    lwyY06u6nBDeu7DmTu5Oyw5q7oHJuzuSl2ch+Euxqg1Q6Oe4zqE6fASTrh0hx/qKKNBN
    /wgg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1KHeBQyh+ITDDJhD74="
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 47.34.1 SBL|AUTH)
    with ESMTPSA id d01d1fxA19dJH5k
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 1 Nov 2021 10:39:19 +0100 (CET)
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
Subject: [RFC v2 1/2] mmc: core: transplant ti,wl1251 quirks from to be retired omap_hsmmc
Date:   Mon,  1 Nov 2021 10:39:11 +0100
Message-Id: <91096a01e37192e2e6f047cd747994fe3c6b2627.1635759337.git.hns@goldelico.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1635759337.git.hns@goldelico.com>
References: <cover.1635759337.git.hns@goldelico.com>
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

This is achieved by the new mmc_fixup_device() option introduced
by ("mmc: allow to match the device tree to apply quirks") to match
through device tree compatible string.

This is called early right after where host->ops->init_card()
and omap_hsmmc_init_card() was previously called.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/mmc/core/card.h   | 19 +++++++++++++++++++
 drivers/mmc/core/mmc.c    |  1 +
 drivers/mmc/core/quirks.h | 22 ++++++++++++++++++++++
 drivers/mmc/core/sd.c     |  2 ++
 drivers/mmc/core/sdio.c   |  1 +
 5 files changed, 45 insertions(+)

diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
index 2f73f8567e14f..a876f4585fbb9 100644
--- a/drivers/mmc/core/card.h
+++ b/drivers/mmc/core/card.h
@@ -153,6 +153,25 @@ static inline void __maybe_unused add_limit_rate_quirk(struct mmc_card *card,
 	card->quirk_max_rate = data;
 }
 
+static inline void __maybe_unused wl1251_quirk(struct mmc_card *card,
+					       int data)
+{
+	/*
+	 * We have TI wl1251 attached to this mmc. Pass this
+	 * information to the SDIO core because it can't be
+	 * probed by normal methods.
+	 */
+
+	dev_info(card->host->parent, "found wl1251\n");
+	card->quirks |= MMC_QUIRK_NONSTD_SDIO;
+	card->cccr.wide_bus = 1;
+	card->cis.vendor = 0x104c;
+	card->cis.device = 0x9066;
+	card->cis.blksize = 512;
+	card->cis.max_dtr = 24000000;
+	card->ocr = 0x80;
+}
+
 /*
  * Quirk add/remove for MMC products.
  */
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 29e58ffae3797..19cd138acaec9 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1634,6 +1634,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	 */
 	if (host->ops->init_card)
 		host->ops->init_card(host, card);
+	mmc_fixup_device(card, sdio_card_init_methods);
 
 	/*
 	 * For native busses:  set card RCA and quit open drain mode.
diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
index ef368386e7112..0ffb69044a749 100644
--- a/drivers/mmc/core/quirks.h
+++ b/drivers/mmc/core/quirks.h
@@ -146,6 +146,28 @@ static const struct mmc_fixup __maybe_unused sdio_fixup_methods[] = {
 	END_FIXUP
 };
 
+static const char * const wl1251_compatible_list[] = { "ti,wl1251", NULL };
+
+// FIXME: this needs a nice macro for initialization
+
+static const struct mmc_fixup __maybe_unused sdio_card_init_methods[] = {
+	{
+		.name = CID_NAME_ANY,
+		.manfid = CID_MANFID_ANY,
+		.oemid = CID_OEMID_ANY,
+		.rev_start = 0,
+		.rev_end = -1ull,
+		.cis_vendor = SDIO_ANY_ID,
+		.cis_device = SDIO_ANY_ID,
+		.vendor_fixup = wl1251_quirk,
+		.data = 0,
+		.ext_csd_rev = EXT_CSD_REV_ANY,
+		.of_compatible = wl1251_compatible_list,
+	},
+
+	END_FIXUP
+};
+
 static inline bool mmc_fixup_of_compatible_match(struct mmc_card *card,
 						 const char *const *compat_list)
 {
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 4646b7a03db6b..0d174fdf47164 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -23,6 +23,7 @@
 #include "host.h"
 #include "bus.h"
 #include "mmc_ops.h"
+#include "quirks.h"
 #include "sd.h"
 #include "sd_ops.h"
 
@@ -1427,6 +1428,7 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 	 */
 	if (host->ops->init_card)
 		host->ops->init_card(host, card);
+	mmc_fixup_device(card, sdio_card_init_methods);
 
 	/*
 	 * For native busses:  get card RCA and quit open drain mode.
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 68edf7a615be5..cf8ee66990508 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -707,6 +707,7 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
 	 */
 	if (host->ops->init_card)
 		host->ops->init_card(host, card);
+	mmc_fixup_device(card, sdio_card_init_methods);
 
 	/*
 	 * If the host and card support UHS-I mode request the card
-- 
2.33.0

