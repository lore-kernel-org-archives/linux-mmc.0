Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE1AC433F5
	for <linux-mmc@archiver.kernel.org>; Wed,  3 Nov 2021 13:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83A0760F90
	for <linux-mmc@archiver.kernel.org>; Wed,  3 Nov 2021 13:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbhKCNDr (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 3 Nov 2021 09:03:47 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.83]:16630 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbhKCNDo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 3 Nov 2021 09:03:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1635944433;
    s=strato-dkim-0002; d=goldelico.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=NYA7HPQZf9DyTm9alYGShSLnmUJbxej82/KRXkB2LHk=;
    b=VeBd+ErJQa5TyE4JTm+qg2sUo4LRlOIBKYDD99VJTGhUZjRR2b+qXXylZV7NEgnt3a
    jX0HGY2IF25OKRQjVbD4Ux+lutkpU1VeZ5p1gJwfS7Bcvx29/FZeOwIuIAnP5PaboIlY
    E/n33FkMmMM/hN4fQSTvPEYcQXpePYy8BpIl/hVIGLPmmTVa7Yk2qrvATW/Rdo1WxM0u
    IYW7T0SizUTCLsHKvWTNj+XSu195vZD/UDZw8WeeLFmEGHeczarQqoCxIINNYi7FBf2T
    elahYWprWybLhCOhqRpnh8X0T6/OjEJuVzVg5GTmz1CYw61dCkIV6NgsDc9/bNLmkz3w
    oKLQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UMf2MwPVbgc7na"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 47.34.1 DYNA|AUTH)
    with ESMTPSA id 902c63xA3D0U0Eh
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 3 Nov 2021 14:00:30 +0100 (CET)
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
Subject: [RFC v3 4/6] mmc: core: add new calls to mmc_fixup_device(sdio_card_init_methods)
Date:   Wed,  3 Nov 2021 14:00:12 +0100
Message-Id: <e1337857bbcb044edf4b6fdb4af3f6d887793a37.1635944413.git.hns@goldelico.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1635944413.git.hns@goldelico.com>
References: <cover.1635944413.git.hns@goldelico.com>
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

