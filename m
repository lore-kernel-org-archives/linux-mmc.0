Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F079FC4338F
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Aug 2021 14:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C308D6101E
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Aug 2021 14:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238166AbhHLOvf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 12 Aug 2021 10:51:35 -0400
Received: from smtp1.axis.com ([195.60.68.17]:52784 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236114AbhHLOvf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 12 Aug 2021 10:51:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1628779870;
  x=1660315870;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=y8NerktKhXY8E3B/F+RMaBVwPBGIQW1kxrEsa+hHLc0=;
  b=MmWPbKkz0xS4LIDtcgGsaBQIV6WhsjOdgx0MU7IksXtmSaBMymuuABEQ
   q1MvfHimlxHVl1JjmV+KrfYYWUDS76W8F47wUJp5lB3McUvKmnjOl3/lL
   7V5kPzAywNVPC92iT59G6wE2yNMnonUqD4A42957SsicPQwffmtJSv9ey
   1S7H3yMeuGg38hmjPCnJPzOKml/DyvLeUkub4aGuXouUVSFJ28hdWmtHo
   EfbZdtgBqjByBa6HSDRIFEP7+e0aJ2dBoFe3gC+Fvcvyxr/pNs4lFtyiS
   2J7PcOUdRBn1092V8W0GE9nHnAGU8KDiFIH2/LA1jtau4RU4+9oYhUbkV
   A==;
From:   =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
To:     Jesper Nilsson <jesper.nilsson@axis.com>,
        Lars Persson <lars.persson@axis.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     <kernel@axis.com>, <linux-arm-kernel@axis.com>,
        <linux-mmc@vger.kernel.org>,
        =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
Subject: [PATCH] mmc: usdhi6rol0: Implement card_busy function
Date:   Thu, 12 Aug 2021 16:50:56 +0200
Message-ID: <20210812145056.11916-1-marten.lindahl@axis.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

When switching card voltage to UHS voltage the mmc framework tries to
check that the card is driving pins CMD, and DAT[0-3] low before the
switch is made. Drivers that does not implement the card_busy function
will manage to do the switch anyway, but the framework will print a
warning about not being able to verify the voltage signal.

Implement card_busy function. Renesas host interface only exposes pins
DAT[0] and DAT[3] for reading the busy state, which is why only these
two pins are checked.

Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
---
 drivers/mmc/host/usdhi6rol0.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/mmc/host/usdhi6rol0.c b/drivers/mmc/host/usdhi6rol0.c
index b9b79b1089a0..e400a646e675 100644
--- a/drivers/mmc/host/usdhi6rol0.c
+++ b/drivers/mmc/host/usdhi6rol0.c
@@ -77,6 +77,7 @@
 #define USDHI6_SD_INFO1_WP		BIT(7)
 #define USDHI6_SD_INFO1_D3_CARD_OUT	BIT(8)
 #define USDHI6_SD_INFO1_D3_CARD_IN	BIT(9)
+#define USDHI6_SD_INFO1_SDDAT3		BIT(10)
 
 #define USDHI6_SD_INFO2_CMD_ERR		BIT(0)
 #define USDHI6_SD_INFO2_CRC_ERR		BIT(1)
@@ -1186,6 +1187,21 @@ static int usdhi6_sig_volt_switch(struct mmc_host *mmc, struct mmc_ios *ios)
 	return ret;
 }
 
+static int usdhi6_card_busy(struct mmc_host *mmc)
+{
+	struct usdhi6_host *host = mmc_priv(mmc);
+	u32 info1 = usdhi6_read(host, USDHI6_SD_INFO1);
+	u32 info2 = usdhi6_read(host, USDHI6_SD_INFO2);
+
+	/* Check if the SD bus is processing a command */
+	if (!(info2 & USDHI6_SD_INFO2_SCLKDIVEN))
+		return 0;
+
+	/* Card is busy if it is pulling dat[0] & dat[3] low */
+	return !(info2 & USDHI6_SD_INFO2_SDDAT0 ||
+		 info1 & USDHI6_SD_INFO1_SDDAT3);
+}
+
 static const struct mmc_host_ops usdhi6_ops = {
 	.request	= usdhi6_request,
 	.set_ios	= usdhi6_set_ios,
@@ -1193,6 +1209,7 @@ static const struct mmc_host_ops usdhi6_ops = {
 	.get_ro		= usdhi6_get_ro,
 	.enable_sdio_irq = usdhi6_enable_sdio_irq,
 	.start_signal_voltage_switch = usdhi6_sig_volt_switch,
+	.card_busy = usdhi6_card_busy,
 };
 
 /*			State machine handlers				*/
-- 
2.20.1

