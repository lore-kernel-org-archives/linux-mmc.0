Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B102CC433EF
	for <linux-mmc@archiver.kernel.org>; Wed,  3 Nov 2021 13:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DB4F6103C
	for <linux-mmc@archiver.kernel.org>; Wed,  3 Nov 2021 13:01:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbhKCNDj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 3 Nov 2021 09:03:39 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.169]:14152 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbhKCNDj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 3 Nov 2021 09:03:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1635944426;
    s=strato-dkim-0002; d=goldelico.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=yzR9nXHIEXU7HQD5ysr5fsEwUzsWWv7a5dYoi7TfWEo=;
    b=FcWjbhWKuYfV4iKIpiXs5hjIsgnmEbitRiGjRsxB6FJBn6+zfQx1hwEnHKsMJxSAUS
    ZM12RLBYEF8Y2eBgMYCJz49swLGjX8i5RxO1+rmrLLdRNLv3xRvVQKHob8eDOraA57af
    BuWWpxg7/Wr9HmsQYfR8p8y25EnktvM59vGJO5yNJu7LG5HMy08kJLXvAZoSnjr+PEaw
    VQEqGZlSwUhSh29E0MJQaD7AIM3oe++RKq3yJSY1ixWN0v0ZxxWxBGYRFNuPYDxaZ83H
    0seqj4USLLIp+8Tzd2U35guTy15affUUWwWkZOJxvV/LYYtBE+N3+KehewIeP6scjUkm
    psoQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UMf2MwPVbgc7na"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 47.34.1 DYNA|AUTH)
    with ESMTPSA id 902c63xA3D0N0Ef
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 3 Nov 2021 14:00:23 +0100 (CET)
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
Subject: [RFC v3 2/6] mmc: core: allow to match the device tree to apply quirks
Date:   Wed,  3 Nov 2021 14:00:10 +0100
Message-Id: <e6a52b238af3022b9a3dad7cad29b632fa34c00b.1635944413.git.hns@goldelico.com>
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
 drivers/mmc/core/quirks.h | 18 ++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
index 7bd392d55cfa5..2f73f8567e14f 100644
--- a/drivers/mmc/core/card.h
+++ b/drivers/mmc/core/card.h
@@ -59,6 +59,9 @@ struct mmc_fixup {
 	/* for MMC cards */
 	unsigned int ext_csd_rev;
 
+	/* Match against functions declared in device tree */
+	const char *const *of_compatible;
+
 	void (*vendor_fixup)(struct mmc_card *card, int data);
 	int data;
 };
diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
index c7ef2d14b359f..a8b82b34dcfd2 100644
--- a/drivers/mmc/core/quirks.h
+++ b/drivers/mmc/core/quirks.h
@@ -10,6 +10,7 @@
  *
  */
 
+#include <linux/of.h>
 #include <linux/mmc/sdio_ids.h>
 
 #include "card.h"
@@ -145,6 +146,20 @@ static const struct mmc_fixup __maybe_unused sdio_fixup_methods[] = {
 	END_FIXUP
 };
 
+static inline bool mmc_fixup_of_compatible_match(struct mmc_card *card,
+						 const char *const *compat_list)
+{
+	struct device_node *of_node;
+	int i;
+
+	for (i = 0; i < 7; i++) {
+		of_node = mmc_of_find_child_device(card->host, i);
+		if (of_node && of_device_compatible_match(of_node, compat_list))
+			return true;
+	}
+	return false;
+}
+
 static inline void mmc_fixup_device(struct mmc_card *card,
 				    const struct mmc_fixup *table)
 {
@@ -173,6 +188,9 @@ static inline void mmc_fixup_device(struct mmc_card *card,
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

