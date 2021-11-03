Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FAE2C433F5
	for <linux-mmc@archiver.kernel.org>; Wed,  3 Nov 2021 13:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76A4760F56
	for <linux-mmc@archiver.kernel.org>; Wed,  3 Nov 2021 13:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbhKCNDb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 3 Nov 2021 09:03:31 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.84]:33507 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbhKCNDb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 3 Nov 2021 09:03:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1635944423;
    s=strato-dkim-0002; d=goldelico.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=NRefWqSNfVqu2r1kOvp1l5SvRCw5vKgppbt4PGzWMrM=;
    b=swr+AY5aO8HcOXV4wJszRc4HnthjWF0b2FKrlTSrjN9ChW/r/Jij990ZoMX3AgH1ca
    5vY1B2zJ/vGmmFCagqIYITrilYKba0omMIwHk3ED/ux7nGdwopby4/IP8dHbb24PS4ib
    lIdKC7gt1Vs4vUgv6ePtWBtJE9sptGvuTdZjSf3YPvdQwEVfmGZGRxMpVD/YmQO8L0C2
    4/pjP40253kBb98GUSlgsQkVFWkNGmAPjOJA2znp1esSyHMIJMo6Xh11SzYIeVYL6CuP
    yEso+kKxSXOId89aFQfwpoGq1j0/WBnhXyCZqRQrIP4HPYRUJzBkpGvdxlrSsiCOtn7r
    rtpQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UMf2MwPVbgc7na"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 47.34.1 DYNA|AUTH)
    with ESMTPSA id 902c63xA3D0J0Ea
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 3 Nov 2021 14:00:19 +0100 (CET)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>, Avri Altman <avri.altman@wdc.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tony Lindgren <tony@atomide.com>, Bean Huo <beanhuo@micron.com>
Cc:     notasas@gmail.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com
Subject: [RFC v3 1/6] mmc: core: rewrite mmc_fixup_device()
Date:   Wed,  3 Nov 2021 14:00:09 +0100
Message-Id: <10f243eccdca10ee34b09fb626500f4a56da914a.1635944413.git.hns@goldelico.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1635944413.git.hns@goldelico.com>
References: <cover.1635944413.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Jérôme Pouiller <jerome.pouiller@silabs.com>

Currently, mmc_fixup_device() is a bit difficult to read because of
particularly long condition.

Signed-off-by: Jérôme Pouiller <jerome.pouiller@silabs.com>
---
 drivers/mmc/core/quirks.h | 41 +++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
index d68e6e513a4f4..c7ef2d14b359f 100644
--- a/drivers/mmc/core/quirks.h
+++ b/drivers/mmc/core/quirks.h
@@ -152,22 +152,29 @@ static inline void mmc_fixup_device(struct mmc_card *card,
 	u64 rev = cid_rev_card(card);
 
 	for (f = table; f->vendor_fixup; f++) {
-		if ((f->manfid == CID_MANFID_ANY ||
-		     f->manfid == card->cid.manfid) &&
-		    (f->oemid == CID_OEMID_ANY ||
-		     f->oemid == card->cid.oemid) &&
-		    (f->name == CID_NAME_ANY ||
-		     !strncmp(f->name, card->cid.prod_name,
-			      sizeof(card->cid.prod_name))) &&
-		    (f->cis_vendor == card->cis.vendor ||
-		     f->cis_vendor == (u16) SDIO_ANY_ID) &&
-		    (f->cis_device == card->cis.device ||
-		     f->cis_device == (u16) SDIO_ANY_ID) &&
-		    (f->ext_csd_rev == EXT_CSD_REV_ANY ||
-		     f->ext_csd_rev == card->ext_csd.rev) &&
-		    rev >= f->rev_start && rev <= f->rev_end) {
-			dev_dbg(&card->dev, "calling %ps\n", f->vendor_fixup);
-			f->vendor_fixup(card, f->data);
-		}
+		if (f->manfid != CID_MANFID_ANY &&
+		    f->manfid != card->cid.manfid)
+			continue;
+		if (f->oemid != CID_OEMID_ANY &&
+		    f->oemid != card->cid.oemid)
+			continue;
+		if (f->name != CID_NAME_ANY &&
+		    strncmp(f->name, card->cid.prod_name,
+			    sizeof(card->cid.prod_name)))
+			continue;
+		if (f->cis_vendor != (u16)SDIO_ANY_ID &&
+		    f->cis_vendor != card->cis.vendor)
+			continue;
+		if (f->cis_device != (u16)SDIO_ANY_ID &&
+		    f->cis_device != card->cis.device)
+			continue;
+		if (f->ext_csd_rev != EXT_CSD_REV_ANY &&
+		    f->ext_csd_rev != card->ext_csd.rev)
+			continue;
+		if (rev < f->rev_start || rev > f->rev_end)
+			continue;
+
+		dev_dbg(&card->dev, "calling %ps\n", f->vendor_fixup);
+		f->vendor_fixup(card, f->data);
 	}
 }
-- 
2.33.0

