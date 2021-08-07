Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45BFC43214
	for <linux-mmc@archiver.kernel.org>; Sat,  7 Aug 2021 11:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5E6D6115C
	for <linux-mmc@archiver.kernel.org>; Sat,  7 Aug 2021 11:07:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbhHGLHo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 7 Aug 2021 07:07:44 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:59681 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbhHGLHn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 7 Aug 2021 07:07:43 -0400
Received: from localhost.localdomain ([37.4.249.97]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MCKSA-1mKXe80AjK-009SLv; Sat, 07 Aug 2021 13:07:10 +0200
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Maxime Ripard <maxime@cerno.tech>, iivanov@suse.de,
        devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH V2 04/10] mmc: sdhci-iproc: Cap min clock frequency on BCM2711
Date:   Sat,  7 Aug 2021 13:06:35 +0200
Message-Id: <1628334401-6577-5-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1628334401-6577-1-git-send-email-stefan.wahren@i2se.com>
References: <1628334401-6577-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:gfEVCU1kBksYlVlI36+xhO7/PrdkmSafmJw2daC3ONkAk/TcvWc
 QbA5BiTWasSzGIKdzbgsBw83id/EB7tV261L3lcQZ+24eD5YKqNY/BD1odPeEO9UOGMi274
 h8jSBFBwXDRP6dP8cNRty4Hx2F+sLZDFilRGqArfRr+vX/sBPPCBUmp03laUbXzkVrbEDGI
 R9eKOXXrm5BHsK2uM+1tQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/1+GcGykBLo=:R3f+HlLl9XrJ2GPs6Itt1N
 WzI7gF2Yc037Lc4d5MYtmwbhbUlIprhpHAAC7r3JIF1+mbhx2f68nDfoCQmRtrfNuMKB42kIf
 8engvX2fX2mFzLvtt871yHwPDiB5e8LUi5Ojdi02klTIvpwY22FDlLn0cawZAyIITTETLsRz8
 iT5Ql0FdlQzM+RTdi4/WpB4b7qZeGGciY467DyS+xA81eKF/iNyLhix4rjcju6Aeq66y08WwN
 ZJc753VqLIYsBypE/UKQiBkI+7lb4jLaY5ZJHelfx5unkkin86ZeYVJUHoTOHM9OpcjHhjl1l
 +7eNboTtlJu/DygrpDoleSC8OxJd15kvm/hA8ySKgJeIHnhUDNQFU4dyQxu81HuxpQHlHtS0f
 +Cf+0wvdYEWRvGuqvJmvUjKm7Mg7692yLTifZCSqplee4xIgUy1or5SSB1494Dilvht3TdLAq
 /6PlHERi5sAtJgu5EUhvsO7N2kj5+Ee3n3AdCNi2vs6xB3oT3N8yH/TSzZKnczuDkp+NPsVIt
 yLy97gwFDWwH+TJ+OjiKR8mOEOFeV0wvkgUhdeqBYsZQlyS2OEJb8DPEpY44SpFpWHe+LPF5f
 wP5f2X5r9fuJgao/fGtFxVQHHkaSahFViAANQSvTIf9oP8oSD1oNKkmdfBT2ncyEHLi1xGWTW
 uzHlpNWL70UJ/O4T9oBqPd6POwEZkqkHoPQkmDnHCtSYTzBZtQJv+tUaqCwlPIWhPdTRIq0i7
 XNU8aFXhle8mf7aC85TlcBwH/nVtR+ec6tQr9mhNVuN24mPnVdLp0aBsMZHytK74UucWqdZcU
 u9XuqFW98sxRmsZSojG4cPBXSohlrYo/j3FyDr9OjN8Qu0BrodXQEUsenlSLHLupFBAUHhz28
 oO7ARG1ZVhAwofbfKo8Q==
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Nicolas Saenz Julienne <nsaenz@kernel.org>

There is a known bug on BCM2711's SDHCI core integration where the
controller will hang when the difference between the core clock and the
bus clock is too great. Specifically this can be reproduced under the
following conditions:

- No SD card plugged in, polling thread is running, probing cards at
  100 kHz.
- BCM2711's core clock configured at 500MHz or more.

So set 200 kHz as the minimum clock frequency available for that board.

For more information on the issue see this:
https://lore.kernel.org/linux-mmc/20210322185816.27582-1-nsaenz@kernel.org/T/#m11f2783a09b581da6b8a15f302625b43a6ecdeca

Fixes: f84e411c85be ("mmc: sdhci-iproc: Add support for emmc2 of the BCM2711")
Signed-off-by: Nicolas Saenz Julienne <nsaenz@kernel.org>
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/mmc/host/sdhci-iproc.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
index cce390f..032bf85 100644
--- a/drivers/mmc/host/sdhci-iproc.c
+++ b/drivers/mmc/host/sdhci-iproc.c
@@ -173,6 +173,23 @@ static unsigned int sdhci_iproc_get_max_clock(struct sdhci_host *host)
 		return pltfm_host->clock;
 }
 
+/*
+ * There is a known bug on BCM2711's SDHCI core integration where the
+ * controller will hang when the difference between the core clock and the bus
+ * clock is too great. Specifically this can be reproduced under the following
+ * conditions:
+ *
+ *  - No SD card plugged in, polling thread is running, probing cards at
+ *    100 kHz.
+ *  - BCM2711's core clock configured at 500MHz or more
+ *
+ * So we set 200kHz as the minimum clock frequency available for that SoC.
+ */
+static unsigned int sdhci_iproc_bcm2711_get_min_clock(struct sdhci_host *host)
+{
+	return 200000;
+}
+
 static const struct sdhci_ops sdhci_iproc_ops = {
 	.set_clock = sdhci_set_clock,
 	.get_max_clock = sdhci_iproc_get_max_clock,
@@ -271,6 +288,7 @@ static const struct sdhci_ops sdhci_iproc_bcm2711_ops = {
 	.set_clock = sdhci_set_clock,
 	.set_power = sdhci_set_power_and_bus_voltage,
 	.get_max_clock = sdhci_iproc_get_max_clock,
+	.get_min_clock = sdhci_iproc_bcm2711_get_min_clock,
 	.set_bus_width = sdhci_set_bus_width,
 	.reset = sdhci_reset,
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
-- 
2.7.4

