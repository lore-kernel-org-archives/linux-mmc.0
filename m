Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E5A4C4320A
	for <linux-mmc@archiver.kernel.org>; Sun, 25 Jul 2021 04:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0FFC60BD3
	for <linux-mmc@archiver.kernel.org>; Sun, 25 Jul 2021 04:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbhGYDvc (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 24 Jul 2021 23:51:32 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:47596 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230077AbhGYDvb (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sat, 24 Jul 2021 23:51:31 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4GXVMw2gk7zQ4;
        Sun, 25 Jul 2021 06:25:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1627187116; bh=n4tm9awV3n8UWCA4HHMvEDV8yXB7gzSUySmWHxD0+vs=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=DX3eQvrVT8ICox9QlqW7PUFy/rzo0ebRf53PlNHU6soL7KwQresQvwAGU27L/gHsj
         0G+nBF1seKdAXZJpcE1uKgjals/C3tK6IRWp6SZyjcvxTu2FXjLfUmjfJBsj3J6v2K
         KYRVf2h+rssZI4wGr3VSP03OUzOaQ5CPM/EOLNRr+xcy5Hpi/zUp6q4KMVqCN+B8V7
         xWly68niUwUnd4sybkhgONKpCaocVuxDpE9lqFoe/I6Q9V1f3nfOSlyGtvTex2beto
         wbOtg2gn8HfdgxpxbYoT7hEqICih/sTV6qy+F4C8hgVTdF5Y2lc+6oLZBfRa3HuyGi
         EsHK+QR9bHzTw==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.2 at mail
Date:   Sun, 25 Jul 2021 06:25:16 +0200
Message-Id: <2fea541c7e679dcda64b5a128bf8ff301fdf1af7.1627186831.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1627186831.git.mirq-linux@rere.qmqm.pl>
References: <cover.1627186831.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v3 1/5] mmc: sdhci: fix base clock usage in preset value
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Liu <kliu5@marvell.com>,
        Suneel Garapati <suneel.garapati@xilinx.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Michal Simek <michal.simek@xilinx.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Fixed commit added an unnecessary read of CLOCK_CONTROL. The value read
is overwritten for programmable clock preset, but is carried over for
divided clock preset. This can confuse sdhci_enable_clk() if the register
has enable bits set for some reason at time time of clock calculation.
Remove the read.

Quoting Al Cooper:

sdhci_brcmstb_set_clock() assumed that sdhci_calc_clk() would always
return the divider value without the enable set, so this fixes a case
for DDR52 where the enable was not being cleared when the divider
value was changed.

Cc: stable@kernel.vger.org
Fixes: 52983382c74f ("mmc: sdhci: enhance preset value function")
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Acked-by: Al Cooper <alcooperx@gmail.com>

---
v3: updated commit message
v2: removed truncated sentence from commitmsg

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/mmc/host/sdhci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index aba6e10b8605..c7438dd13e3e 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1857,7 +1857,6 @@ u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
 		if (host->preset_enabled) {
 			u16 pre_val;
 
-			clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
 			pre_val = sdhci_get_preset_value(host);
 			div = FIELD_GET(SDHCI_PRESET_SDCLK_FREQ_MASK, pre_val);
 			if (host->clk_mul &&
-- 
2.30.2

