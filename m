Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46E6C433F5
	for <linux-mmc@archiver.kernel.org>; Fri,  5 Nov 2021 09:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C752C61262
	for <linux-mmc@archiver.kernel.org>; Fri,  5 Nov 2021 09:06:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbhKEJIp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 5 Nov 2021 05:08:45 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.83]:36498 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbhKEJIo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Nov 2021 05:08:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1636103153;
    s=strato-dkim-0002; d=goldelico.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=NRefWqSNfVqu2r1kOvp1l5SvRCw5vKgppbt4PGzWMrM=;
    b=syBMySvZJ4fuodKUh5AI4UyIN04jneOFFXYldCP6X7lENeQJtACsqZdSV/z2I73CkA
    HryKOcay6Uy2jRpAWW/yPnBPMNYgbgMXV8jp1lKt5ori1C7iS+appxJfaQubUW0qsua2
    xki8/0V3rwJkbs04kp+tPaa3RGUqcoZv4uM6GXAXFA9p37hhvBJR8eXHGKA5goexmIYq
    r6bwSAe1GLXZJmbKNVSQMpY/CQ9K1xbe99mnEe710ICrWX8jGvCU1bqpQ5hFR73nWv/G
    I54Wxswq3ftQh7sYWyZ5QiA1q2eJ3+uQAmxKau0Ory2MflCKPY5WQknuTiahPiQb8/jp
    87Nw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o12DNOsPj0lByOdfL1X0"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 47.34.1 DYNA|AUTH)
    with ESMTPSA id 902c63xA595q8uK
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 5 Nov 2021 10:05:52 +0100 (CET)
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
Subject: [RFC v4 1/6] mmc: core: rewrite mmc_fixup_device()
Date:   Fri,  5 Nov 2021 10:05:46 +0100
Message-Id: <e9b86c6f569b4b2f399bd1b8c6af34fed7878f7e.1636103151.git.hns@goldelico.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1636103151.git.hns@goldelico.com>
References: <cover.1636103151.git.hns@goldelico.com>
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

