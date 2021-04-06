Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71286C433ED
	for <linux-mmc@archiver.kernel.org>; Tue,  6 Apr 2021 10:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BCCA613C6
	for <linux-mmc@archiver.kernel.org>; Tue,  6 Apr 2021 10:49:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245171AbhDFKta (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 6 Apr 2021 06:49:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:43990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237178AbhDFKtG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 6 Apr 2021 06:49:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4E0FD610C8;
        Tue,  6 Apr 2021 10:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617706138;
        bh=qH4KlpaZXLeo2J5NteL1furYr39Wn2/e7YBQvZKZESc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dVRyE1WbaMTjFkrR5clNrNDxUIaRmixlwQprgIidabaDwFG8bmijxKxpCWWSzKyXK
         sFASHJ2X+6gHsyXkWF7Nivu28WqPx+iz3LE2Siq5X8L8E79nIJS4sF58tODTN6gC8g
         HXWF+aKsNeWQgnAAyHcftnfh6P0MYB4gKK1XagQdEt6tHrcSKUgtEZI7+jPt7Tkt0a
         HC4J2d5H30sANrWPPSpPywcaj6cGA6kGLBNp9y3CkPJhuxL5br26kUDWJqKYpU94Kg
         GHa4b+XeUmnExuSB/xkzqbeiugGhnrlRRYCi/0vbXo9T5H6TnutHwhvGuMTEdGbk7F
         Zskuuao/RoAoQ==
From:   Nicolas Saenz Julienne <nsaenz@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        Ray Jui <ray.jui@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Saenz Julienne <nsaenz@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Stefan Wahren <wahrenst@gmx.net>,
        Matthias Brugger <mbrugger@suse.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     f.fainelli@gmail.com, phil@raspberrypi.com,
        tim.gover@raspberrypi.com, alcooperx@gmail.com,
        nsaenzjulienne@suse.de, linux-kernel@vger.kernel.org,
        robh@kernel.org, stefan.wahren@i2se.com
Subject: [PATCH 2/3] mmc: sdhci-iproc: Cap min clock frequency on BCM2711
Date:   Tue,  6 Apr 2021 12:48:03 +0200
Message-Id: <20210406104802.20898-3-nsaenz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210406104802.20898-1-nsaenz@kernel.org>
References: <20210406104802.20898-1-nsaenz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

There is a known bug on BCM2711's SDHCI core integration where the
controller will hang when the difference between the core clock and the
bus clock is too great. Specifically this can be reproduced under the
following conditions:

- No SD card plugged in, polling thread is running, probing cards at
  100KHz.
- BCM2711's core clock configured at 500MHz or more.

So set 200MHz as the minimum clock frequency available for that board.

For more information on the issue see this:
https://lore.kernel.org/linux-mmc/20210322185816.27582-1-nsaenz@kernel.org/T/#m11f2783a09b581da6b8a15f302625b43a6ecdeca

Fixes: f84e411c85be ("mmc: sdhci-iproc: Add support for emmc2 of the BCM2711")
Signed-off-by: Nicolas Saenz Julienne <nsaenz@kernel.org>
---
 drivers/mmc/host/sdhci-iproc.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
index ddeaf8e1f72f..1ef888e91f73 100644
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
+ *    100KHz.
+ *  - BCM2711's core clock configured at 500MHz or more
+ *
+ * So we set 200MHz as the minimum clock frequency available for that SoC.
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
2.30.2

