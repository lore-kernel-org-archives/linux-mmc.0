Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F083C4320A
	for <linux-mmc@archiver.kernel.org>; Sun, 25 Jul 2021 09:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BA9360E09
	for <linux-mmc@archiver.kernel.org>; Sun, 25 Jul 2021 09:20:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbhGYIkU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 25 Jul 2021 04:40:20 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:7280 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230305AbhGYIkS (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 25 Jul 2021 04:40:18 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4GXcwv5CbVz8d;
        Sun, 25 Jul 2021 11:20:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1627204847; bh=d04TklBqxwEHnvQPkhgUpAZEHT2VwJgiULJvHpgtAWA=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=nuL5GcHrE4Y1ZQ+bLGhNiKHD4KWkpBlBXofzNdrf8yUNRV9pz9wOS9h6yh2g4/o8e
         KVYljTQ6I9+gSJO8AyQaT0U8xbg+UJ5uPVsVqEaBohcb2S9x4KhG7hApIDhNm5oH90
         JxWD+mGvmk1tZjWjnffl0SKMf/Yn1vxDKj3GiEb73vZP3kC0FegxBh8NnyO9OySlcH
         ISfvZKiCJ8LORWxfAAqAlAWA+qcmORXvBi+obJca21oHo6ocaUdp0Nm46pVyJp44mG
         K0dPPImsX7NfYKjWDCeC+u5uEIxspfjoW/eZUHqgjcHuxfCuLGJepOjOMYBw4bzFBz
         ezCNfHWF8Bh5g==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.2 at mail
Date:   Sun, 25 Jul 2021 11:20:47 +0200
Message-Id: <fff139f001835efb5ee428093a9522d7761642de.1627204633.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1627204633.git.mirq-linux@rere.qmqm.pl>
References: <cover.1627204633.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v4 1/5] mmc: sdhci: fix base clock usage in preset value
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Liu <kliu5@marvell.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Suneel Garapati <suneel.garapati@xilinx.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Al Cooper <alcooperx@gmail.com>
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

Cc: stable@vger.kernel.org
Fixes: 52983382c74f ("mmc: sdhci: enhance preset value function")
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Acked-by: Al Cooper <alcooperx@gmail.com>

---
v4: no changes
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

