Return-Path: <SRS0=NlIn=2X=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C8BC2D0DC
	for <linux-mmc@archiver.kernel.org>; Thu,  2 Jan 2020 10:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8ED621655
	for <linux-mmc@archiver.kernel.org>; Thu,  2 Jan 2020 10:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="NXVYrXEL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbgABKzB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 2 Jan 2020 05:55:01 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:8751 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728044AbgABKzB (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 2 Jan 2020 05:55:01 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 47pQ0g0D4Rz9d;
        Thu,  2 Jan 2020 11:54:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1577962499; bh=D1/2s/28BXNTizHnTxB/YGGeDKZsUVBHerPvb8b+Uag=;
        h=Date:From:Subject:To:Cc:From;
        b=NXVYrXELnQNxe2V2UTCsfLSQW693nkL8a0fKXCCNsFWzkr8IqIo3IrxA4XftbNOZc
         h+VlPKaFU5j+bVbQ51ew/79DTkI5bHu8JC1E529I38QdTsQpTcEf7xcNKYFh/TNIfd
         iuR/lQ6ux7KbanxPPEJ4cuUOidttTfWF35vxLdh+5U16Be17URWEkWxNgNEKSsWBkw
         Fmv0j+XvuuHf2XpZ5pvMM32dB0W5s/66j6HKH2xeWe+oG+tpR2cyMfzJcAD2IeUkWJ
         N9php8o6n6cB469UgyYBlNc2rAlhRDWLk1QboEcKQG/2ML+v7UGuVCa7C+aoHY3WSR
         8WrTDzb6XRcVg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.4 at mail
Date:   Thu, 02 Jan 2020 11:54:58 +0100
Message-Id: <f471bceaf237d582d746bd289c4c4f3639cb7b45.1577962382.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH] mmc: core: limit probe clock frequency to configured f_max
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     linux-mmc@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-kernel@vger.kernel.org
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Currently MMC core disregards host->f_max during card initialization
phase. Obey upper boundary for the clock frequency and skip faster
speeds when they are above the limit.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/mmc/core/core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index abf8f5eb0a1c..aa54d359dab7 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2330,7 +2330,13 @@ void mmc_rescan(struct work_struct *work)
 	}
 
 	for (i = 0; i < ARRAY_SIZE(freqs); i++) {
-		if (!mmc_rescan_try_freq(host, max(freqs[i], host->f_min)))
+		unsigned int freq = freqs[i];
+		if (freq > host->f_max) {
+			if (i + 1 < ARRAY_SIZE(freqs))
+				continue;
+			freq = host->f_max;
+		}
+		if (!mmc_rescan_try_freq(host, max(freq, host->f_min)))
 			break;
 		if (freqs[i] <= host->f_min)
 			break;
@@ -2344,7 +2350,7 @@ void mmc_rescan(struct work_struct *work)
 
 void mmc_start_host(struct mmc_host *host)
 {
-	host->f_init = max(freqs[0], host->f_min);
+	host->f_init = max(min(freqs[0], host->f_max), host->f_min);
 	host->rescan_disable = 0;
 	host->ios.power_mode = MMC_POWER_UNDEFINED;
 
-- 
2.20.1

