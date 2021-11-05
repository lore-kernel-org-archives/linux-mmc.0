Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE19C433FE
	for <linux-mmc@archiver.kernel.org>; Fri,  5 Nov 2021 09:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D25886125F
	for <linux-mmc@archiver.kernel.org>; Fri,  5 Nov 2021 09:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232866AbhKEJI7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 5 Nov 2021 05:08:59 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.168]:25467 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232823AbhKEJIy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Nov 2021 05:08:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1636103154;
    s=strato-dkim-0002; d=goldelico.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=NYA7HPQZf9DyTm9alYGShSLnmUJbxej82/KRXkB2LHk=;
    b=Fg/y5Ie4QKvkhRX+w27ADkMH4URh98QZbSiUwOZCJIO+ylU0KLk+Wp00q3jMgyo29/
    nRt3ds1bHppBbIrx4pdwJqEF++98ph+2TWAYqDwZd29aFFNB4Dl232jKkJc/EOumtzg9
    Ut6Rj9Ba7u2UnHrm5vIVMBLop8diDD/iswndU67ZFg9RDYpwGZHv4Ml7liC6V21oSlcv
    7XogTl1uKeoQcIkudcGn4Uoleq7EqeKjzAVx9WtHkiRePVssLf5TcqJYw1CyIgvPBhw0
    tixtL5kmRbybjCcZDH+27VXQIvpY65C2V3Hjzoz9NVydFLw6Y4LcHfce5TvrDem1l1+8
    Lrag==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o12DNOsPj0lByOdfL1X0"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 47.34.1 DYNA|AUTH)
    with ESMTPSA id 902c63xA595s8uN
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
Subject: [RFC v4 4/6] mmc: core: add new calls to mmc_fixup_device(sdio_card_init_methods)
Date:   Fri,  5 Nov 2021 10:05:49 +0100
Message-Id: <73440c0f227778e57167dd9fedd350637a1d737a.1636103151.git.hns@goldelico.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1636103151.git.hns@goldelico.com>
References: <cover.1636103151.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This allows to add quirks based on device tree instead of having
card specific code in the host ops.

We call it just after where host->ops->init_card() can be optionally
called.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/mmc/core/mmc.c  | 1 +
 drivers/mmc/core/sd.c   | 2 ++
 drivers/mmc/core/sdio.c | 1 +
 3 files changed, 4 insertions(+)

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

