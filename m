Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D06C433EF
	for <linux-mmc@archiver.kernel.org>; Fri,  5 Nov 2021 09:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC5D26125F
	for <linux-mmc@archiver.kernel.org>; Fri,  5 Nov 2021 09:06:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbhKEJIo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 5 Nov 2021 05:08:44 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.80]:25389 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbhKEJIo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Nov 2021 05:08:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1636103154;
    s=strato-dkim-0002; d=goldelico.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=KHpvoFjBsD7DdrWfOIofu+L3oQA3bllZW6D/ah8Y1rg=;
    b=Ze4ACszaH1dBiXK4Bft/3iiry1KY/6RuoZMT1TRiBNPaaYhKsniPLw9Exm/sAkgHWT
    tO9Zn0cMfE9V8fRsj2dwqbXjTDdYtBfXeyN6jyXMZoqS0GNj+R39MzT7anxD3kNnS+fp
    QMEMAwwRQCFZ3YW2xxismZ4GOnuow49hVhaQ+eBR3gQOTFuMZFzTlWBU7z0HlQsk7+GA
    1mUMR56TBbtu6oYLYDeeeeZE3rA6vTgPTnSL4CkgKuvPri8FSS20uPYmDNKGo3WE/evC
    XHMawxR1/1votO9a2dCNMdZOrDsJfxI3iF5KrUTEifrt5mfA+8/dfWnuyV8m8b4wzUv+
    ImSw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o12DNOsPj0lByOdfL1X0"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 47.34.1 DYNA|AUTH)
    with ESMTPSA id 902c63xA595s8uO
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
Subject: [RFC v4 5/6] mmc: core: transplant ti,wl1251 quirks from to be retired omap_hsmmc
Date:   Fri,  5 Nov 2021 10:05:50 +0100
Message-Id: <3ca9a3099d86d631235b6c03ae260bc581cc8d60.1636103151.git.hns@goldelico.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1636103151.git.hns@goldelico.com>
References: <cover.1636103151.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The TiWi WL1251 WiFi chip needs special setup of the sdio
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

This quirk will be called early right after where host->ops->init_card()
and thus omap_hsmmc_init_card() was previously called.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/mmc/core/card.h   | 19 +++++++++++++++++++
 drivers/mmc/core/quirks.h |  7 +++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
index 089ede71d3150..20c8dfd6831cf 100644
--- a/drivers/mmc/core/card.h
+++ b/drivers/mmc/core/card.h
@@ -168,6 +168,25 @@ static inline void __maybe_unused add_limit_rate_quirk(struct mmc_card *card,
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
diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
index 41c418527199c..e9813f1f8b23c 100644
--- a/drivers/mmc/core/quirks.h
+++ b/drivers/mmc/core/quirks.h
@@ -146,7 +146,14 @@ static const struct mmc_fixup __maybe_unused sdio_fixup_methods[] = {
 	END_FIXUP
 };
 
+static const char *__maybe_unused wl1251_compatible_list[] = {
+	"ti,wl1251",
+	NULL
+};
+
 static const struct mmc_fixup __maybe_unused sdio_card_init_methods[] = {
+	SDIO_FIXUP_COMPATIBLE(wl1251_compatible_list, wl1251_quirk, 0),
+
 	END_FIXUP
 };
 
-- 
2.33.0

