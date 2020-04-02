Return-Path: <SRS0=tKpl=5S=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1703C43331
	for <linux-mmc@archiver.kernel.org>; Thu,  2 Apr 2020 11:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 870E120757
	for <linux-mmc@archiver.kernel.org>; Thu,  2 Apr 2020 11:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="b8lt+tkv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388156AbgDBLy6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 2 Apr 2020 07:54:58 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:25271 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387988AbgDBLy6 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 2 Apr 2020 07:54:58 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48tM1q4wR6zpX;
        Thu,  2 Apr 2020 13:54:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1585828495; bh=8B8kq1VKlq4SBlVvHVGlJ4PmNNXHAOiZiONRej4jb3Q=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=b8lt+tkv83BaIkNxaetnNQ/mWk/8T1qO+TUUTGQ4cnIm4LiojnPSQHA3MgzCWutjG
         8X0yB0A2q68LALhJk7w5VWP5QZAE7gVC3UGNmAW4+6iKoCsXBqZm1Yrqiu1Ls4C4rK
         NXTZhExHIWOE9jy6FBe7m+nPd8JxDX8GlhoEj43ioxAhxuaQ3qC62ZIeQoE3nXaCMa
         RFMUTmYmVmxkABz3xLbbupYzVu/oAZ1A3Vvomcio5YdCqHk2a6+7WtpKwsSZ/wUqRK
         QRydDwJJ0daSGRI0faDXj5tQaflQ2nKPPESe0bIVUSeI79jZJj4VXlxUYCJTVhyFwD
         oBBAy1kIEKaWA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Thu, 02 Apr 2020 13:54:55 +0200
Message-Id: <0077b8bc2a4da024a3b985dd622674ebebe5b71b.1585827904.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1585827904.git.mirq-linux@rere.qmqm.pl>
References: <cover.1585827904.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 2/7] mmc: sdhci: fix programmable clock config from preset
 value
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Kevin Liu <kliu5@marvell.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Suneel Garapati <suneel.garapati@xilinx.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

When host controller uses programmable clock presets but doesn't
advertise programmable clock support, we can only guess what frequency
it generates. Let's at least return correct SDHCI_PROG_CLOCK_MODE bit
value in this case.

Fixes: 52983382c74f ("mmc: sdhci: enhance preset value function")
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/mmc/host/sdhci.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 9aa3af5826df..b2dc4f1cfa5c 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1767,11 +1767,10 @@ u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
 
 			pre_val = sdhci_get_preset_value(host);
 			div = FIELD_GET(SDHCI_PRESET_SDCLK_FREQ_MASK, pre_val);
-			if (host->clk_mul &&
-				(pre_val & SDHCI_PRESET_CLKGEN_SEL)) {
+			if (pre_val & SDHCI_PRESET_CLKGEN_SEL) {
 				clk = SDHCI_PROG_CLOCK_MODE;
 				real_div = div + 1;
-				clk_mul = host->clk_mul;
+				clk_mul = host->clk_mul ?: 1;
 			} else {
 				real_div = max_t(int, 1, div << 1);
 			}
-- 
2.20.1

