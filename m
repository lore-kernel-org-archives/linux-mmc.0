Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97BD8C433FE
	for <linux-mmc@archiver.kernel.org>; Fri,  5 Nov 2021 09:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 661126125F
	for <linux-mmc@archiver.kernel.org>; Fri,  5 Nov 2021 09:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbhKEJIp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 5 Nov 2021 05:08:45 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.170]:11785 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbhKEJIo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Nov 2021 05:08:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1636103153;
    s=strato-dkim-0002; d=goldelico.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=RDfsUFgFWV35Bagb81EFmwtn6fzHPAhE42MBmrM0n6Q=;
    b=jrkoKQKtZKBrxyH7tCTvGE/AyzqdW6uiAKKSpsAydUf/FV8HWRy584RjuCNVoiVU5q
    tb5ZbOQyCaKcmczMdnsl0hWjjLWxzuICuEVnvLF7Py9wkILBEzlCcX+elVKI2whSRymr
    GcTkiYnejhD8Lh2B8dO6pWPIy5x6g2RPgWDXamWWrLf0uz1wbHrI9BGCs5nlAIP1Fjj5
    qi9/PkA8rFxhIIGcvmrjlnUTc844VEiGSFXjQttOrWJYVK8dkHI56oCIOjgzkr3hk2Ij
    SM5JPnVZYNs2WDPA8+YQs1kTYTh627heMmMpwjYz/oI4ZmQY4OJOcX13jq9WBiPo13Rm
    0o7g==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o12DNOsPj0lByOdfL1X0"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 47.34.1 DYNA|AUTH)
    with ESMTPSA id 902c63xA595r8uL
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 5 Nov 2021 10:05:53 +0100 (CET)
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
Subject: [RFC v4 2/6] mmc: core: allow to match the device tree to apply quirks
Date:   Fri,  5 Nov 2021 10:05:47 +0100
Message-Id: <e072de2b480103dbebd941f35be96197534642ee.1636103151.git.hns@goldelico.com>
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

MMC subsystem provides a way to apply quirks when a device match some
properties (VID, PID, etc...) Unfortunately, some SDIO devices does not
comply with the SDIO specification and does not provide reliable VID/PID
(eg. Silabs WF200).

So, the drivers for these devices rely on device tree to identify the
device.

This patch allows the MMC to also rely on the device tree to apply a
quirk.

Signed-off-by: Jérôme Pouiller <jerome.pouiller@silabs.com>
---
 drivers/mmc/core/card.h   |  3 +++
 drivers/mmc/core/quirks.h | 17 +++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
index 7bd392d55cfa5..a3204c19861a4 100644
--- a/drivers/mmc/core/card.h
+++ b/drivers/mmc/core/card.h
@@ -59,6 +59,9 @@ struct mmc_fixup {
 	/* for MMC cards */
 	unsigned int ext_csd_rev;
 
+	/* Match against functions declared in device tree */
+	const char **of_compatible;
+
 	void (*vendor_fixup)(struct mmc_card *card, int data);
 	int data;
 };
diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
index c7ef2d14b359f..ee591fd8aeca2 100644
--- a/drivers/mmc/core/quirks.h
+++ b/drivers/mmc/core/quirks.h
@@ -10,6 +10,7 @@
  *
  */
 
+#include <linux/of.h>
 #include <linux/mmc/sdio_ids.h>
 
 #include "card.h"
@@ -145,6 +146,19 @@ static const struct mmc_fixup __maybe_unused sdio_fixup_methods[] = {
 	END_FIXUP
 };
 
+static inline bool mmc_fixup_of_compatible_match(struct mmc_card *card,
+						 const char *const *compat_list)
+{
+	struct device_node *np;
+
+	for_each_child_of_node(mmc_dev(card->host)->of_node, np) {
+		if (of_device_compatible_match(np, compat_list))
+			return true;
+	}
+
+	return false;
+}
+
 static inline void mmc_fixup_device(struct mmc_card *card,
 				    const struct mmc_fixup *table)
 {
@@ -173,6 +187,9 @@ static inline void mmc_fixup_device(struct mmc_card *card,
 			continue;
 		if (rev < f->rev_start || rev > f->rev_end)
 			continue;
+		if (f->of_compatible &&
+		    !mmc_fixup_of_compatible_match(card, f->of_compatible))
+			continue;
 
 		dev_dbg(&card->dev, "calling %ps\n", f->vendor_fixup);
 		f->vendor_fixup(card, f->data);
-- 
2.33.0

