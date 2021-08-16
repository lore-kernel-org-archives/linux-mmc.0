Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90923C4338F
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Aug 2021 12:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70D5563275
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Aug 2021 12:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbhHPMyD (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Aug 2021 08:54:03 -0400
Received: from smtp2.axis.com ([195.60.68.18]:48222 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229593AbhHPMyC (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 16 Aug 2021 08:54:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1629118411;
  x=1660654411;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gVAAKtYSg3GpDX6mczebbC5P31/HSllfnGGcOBiVtPE=;
  b=cTZnX8LB8fv5J2Oh6xW8k+5DKiyD5V329mtfNutZq8nwgcIKQlP0FMQ3
   VktXA+sCv+Jf3ETd4z6avhOebngE9QnYuJym0hhz8zSb8XXWY3MsZVoSo
   jjhkW3OuS7Q43pY9LGCsP0x8LKdlhq/r3PQ/csCYcLbcjNkQYOuvohGDd
   EYwtX2mVYgyKF62Q0+rsDSDPsFtPpo22GbP4puaXjzO/2pT0hGpd55mMP
   cEGHuj9pKGqCPiKvzQhDV2q1em8S3mcOoQOEQdqs9UwbL3KxhH4nJZ7kV
   KgbS1FtXoAIHRHXYfJ2E0CYJiUWzSaSOjK1GMSn10kUVCc06JFLRT6+LJ
   Q==;
From:   =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
To:     Jesper Nilsson <jesper.nilsson@axis.com>,
        Lars Persson <lars.persson@axis.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     <kernel@axis.com>, <linux-arm-kernel@axis.com>,
        <linux-mmc@vger.kernel.org>,
        =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
Subject: [PATCH v2] mmc: usdhi6rol0: Implement card_busy function
Date:   Mon, 16 Aug 2021 14:52:43 +0200
Message-ID: <20210816125243.11623-1-marten.lindahl@axis.com>
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

 drivers/mmc/host/usdhi6rol0.c | 10 ++++++++++
 include/linux/mmc/host.h      |  2 +-
 2 files changed, 11 insertions(+), 1 deletion(-)

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
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 0abd47e9ef9b..ff1a251bb0bc 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -153,7 +153,7 @@ struct mmc_host_ops {
 
 	int	(*start_signal_voltage_switch)(struct mmc_host *host, struct mmc_ios *ios);
 
-	/* Check if the card is pulling dat[0:3] low */
+	/* Check if the card is pulling dat[0] low */
 	int	(*card_busy)(struct mmc_host *host);
 
 	/* The tuning command opcode value is different for SD and eMMC cards */
-- 
2.20.1

