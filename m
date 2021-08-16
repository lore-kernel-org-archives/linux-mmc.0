Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13042C4338F
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Aug 2021 14:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF8326109F
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Aug 2021 14:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbhHPOXv (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Aug 2021 10:23:51 -0400
Received: from smtp2.axis.com ([195.60.68.18]:32354 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229880AbhHPOXv (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 16 Aug 2021 10:23:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1629123800;
  x=1660659800;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Kcl9QRsYY7gOlvzbocmCj5cJg0FVeLgsej7ZFRteNhw=;
  b=ldrhsgt/3Q7CvwCKGF2WZhv9LPaKVVsqxUhBmpo3Uszd10raca2XMsoB
   y8PNFhPDrM+08BKrphXTUf9dj2mf3CCcDO6sBYe5akcT5Nr7C9TkcsBK0
   F+KOIX4li7C2cT42EtCINgDMPIfuCMohQysDwtSrvS06FxKOWJ5ST/mW/
   iUXqSpQnBqRVoxDev+oTM4VldX1Wqo5my902k3pjJWSF2jW2J54fdVRfN
   w0WgpUbhj8ot6V35dHNhemMwb3mRkrOq9OTCe3xuSm6ELUvUhsbv8Yte3
   J4vctvFKDoDgfeBSlF9FHrSICvewaUXCuxQ29thNH2ywJbivbGKAnLHwZ
   Q==;
From:   =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
To:     Jesper Nilsson <jesper.nilsson@axis.com>,
        Lars Persson <lars.persson@axis.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     <kernel@axis.com>, <linux-arm-kernel@axis.com>,
        <linux-mmc@vger.kernel.org>,
        =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
Subject: [PATCH v3] mmc: usdhi6rol0: Implement card_busy function
Date:   Mon, 16 Aug 2021 16:23:14 +0200
Message-ID: <20210816142314.1168-1-marten.lindahl@axis.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

When switching card voltage to UHS voltage the mmc framework tries to
check the card busy signal, meaning the card pulling DAT0 line low,
before the switch is made. Drivers that does not implement the card_busy
function will manage to do the switch anyway, but the framework will
print a warning about not being able to verify the voltage signal.

Implement card_busy function.

Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
---

v2:
 - Update commit message, since interface limitation for checking DAT
   lines is not valid for this fix.
 - Skip check of SCLKDIVEN bit, and skip check of DAT3 line since SD
   specification only points out checking DAT0 for busy signal.
 - Update comment about card_busy callback.

v3:
 - Split header file change into separate patch.

 drivers/mmc/host/usdhi6rol0.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mmc/host/usdhi6rol0.c b/drivers/mmc/host/usdhi6rol0.c
index b9b79b1089a0..b5ab133e9add 100644
--- a/drivers/mmc/host/usdhi6rol0.c
+++ b/drivers/mmc/host/usdhi6rol0.c
@@ -1186,6 +1186,15 @@ static int usdhi6_sig_volt_switch(struct mmc_host *mmc, struct mmc_ios *ios)
 	return ret;
 }
 
+static int usdhi6_card_busy(struct mmc_host *mmc)
+{
+	struct usdhi6_host *host = mmc_priv(mmc);
+	u32 tmp = usdhi6_read(host, USDHI6_SD_INFO2);
+
+	/* Card is busy if it is pulling dat[0] low */
+	return !(tmp & USDHI6_SD_INFO2_SDDAT0);
+}
+
 static const struct mmc_host_ops usdhi6_ops = {
 	.request	= usdhi6_request,
 	.set_ios	= usdhi6_set_ios,
@@ -1193,6 +1202,7 @@ static const struct mmc_host_ops usdhi6_ops = {
 	.get_ro		= usdhi6_get_ro,
 	.enable_sdio_irq = usdhi6_enable_sdio_irq,
 	.start_signal_voltage_switch = usdhi6_sig_volt_switch,
+	.card_busy = usdhi6_card_busy,
 };
 
 /*			State machine handlers				*/
-- 
2.20.1

