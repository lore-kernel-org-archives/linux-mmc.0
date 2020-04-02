Return-Path: <SRS0=tKpl=5S=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 235B9C43331
	for <linux-mmc@archiver.kernel.org>; Thu,  2 Apr 2020 11:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0BE220787
	for <linux-mmc@archiver.kernel.org>; Thu,  2 Apr 2020 11:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="LkH/JJNw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388164AbgDBLy7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 2 Apr 2020 07:54:59 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:53370 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388036AbgDBLy4 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 2 Apr 2020 07:54:56 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48tM1q2kCPzHd;
        Thu,  2 Apr 2020 13:54:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1585828495; bh=1uCh1WDcEq7ykZh83IGYF9lRjbZGbC9UBX1/WwembVU=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=LkH/JJNwkiGvEKfhcKQ7pBaFC/o9ZRHOB3W8piHiJ89mdz60D3bMGYEd6gSV1s/2i
         Tzfuw2tG4HmgdWqKvl7goizWrQrLzrqfvpbV620+HGtJDFsshUabhsgziWlcXO2qEr
         vbFFy5IjUaVFV7OkXJmVPYVjuF69INx+Hg0PUxvA7HznNloxcjd9LJ5N7gfMFZhtkU
         iGb9ZbzA5OCYJsfgc7zoJjToofTs0gMrxdehjB5IzviherTlbz6HtPdNdk1lEvaRWc
         M3c55IoazFXZ2XVY1IKdYa0aKTMkXBhYkht1ZvY45mU502TSlWwxH07Wzzl5UbDyMZ
         qJL/YpwI5BPDA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Thu, 02 Apr 2020 13:54:55 +0200
Message-Id: <23c3fe72b0ff0eabdbf3a45023a76da1b18a7e90.1585827904.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1585827904.git.mirq-linux@rere.qmqm.pl>
References: <cover.1585827904.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 1/7] mmc: sdhci: fix base clock usage in preset value
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Liu <kliu5@marvell.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Suneel Garapati <suneel.garapati@xilinx.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Fixed commit added an unnecessary read of CLOCK_CONTROL. The value read
is overwritten for programmable clock preset, but is carried over for
divided clock preset. This can confuse sdhci_enable_clk() if the register
has enable bits set for some reason at time time of clock calculation.
value to be ORed with enable flags. Remove the read.

Fixes: 52983382c74f ("mmc: sdhci: enhance preset value function")
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/mmc/host/sdhci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 3f716466fcfd..9aa3af5826df 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1765,7 +1765,6 @@ u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
 		if (host->preset_enabled) {
 			u16 pre_val;
 
-			clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
 			pre_val = sdhci_get_preset_value(host);
 			div = FIELD_GET(SDHCI_PRESET_SDCLK_FREQ_MASK, pre_val);
 			if (host->clk_mul &&
-- 
2.20.1

