Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5E3C04FE3
	for <linux-mmc@archiver.kernel.org>; Sat,  7 Aug 2021 11:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16E2360C51
	for <linux-mmc@archiver.kernel.org>; Sat,  7 Aug 2021 11:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbhHGLHz (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 7 Aug 2021 07:07:55 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:59179 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbhHGLHq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 7 Aug 2021 07:07:46 -0400
Received: from localhost.localdomain ([37.4.249.97]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1McXwD-1mid7U1zRN-00czTE; Sat, 07 Aug 2021 13:07:13 +0200
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
Subject: [PATCH V2 10/10] arm64: dts: broadcom: Add reference to RPi CM4 IO Board
Date:   Sat,  7 Aug 2021 13:06:41 +0200
Message-Id: <1628334401-6577-11-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1628334401-6577-1-git-send-email-stefan.wahren@i2se.com>
References: <1628334401-6577-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:rHO+Q0xRykZ6BQicZFKXybShSWbEZeqOxy2nEgkMFgnHmdCHpgN
 pmBjG635/s05Mi1P4UG9MgfiwG7vtkeTGfOGhpdhEC1M39feErxnh5sFMWyheGbegk/lS6S
 mp4FGHeHeZqK+JGmnUUNtNLZJSmlP5zpeLyI8O3nSIkll8tMZaWugNO7ZHIf3p+jp9T0LAx
 0qSEJxVvTBsVOMQHJev9w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:F1bWVXoxpWs=:pu7YD8k4Doe16zkcJrUWne
 GB5HtuTbLz++Bsogkny7vFXLKuKLl1I2RqP1UrHYyuwMabdf34Nb25HFmZb2iRjLueV3vo6hX
 11Hv7IhUuI7MJ+1bR0bYe3DE8wf18O+RfRALvIkywSNuWmLZOCIu8LudrHl1LE5+Vqs0On7zj
 /Kp7Cjs7kJqfGPFfoXoqiA2HtrwXCn5D6TUqGnKCc+DN04jmijVjad1/7b/RGh5HMrVBjXN6n
 qAMAoTkHJu86kOukBLy5dM/v2pTplJU1lG8LdXP4P93YUaIf98Oeahw1o7Ol3XGGrjPpy3JZi
 1ucEtSIgDg7HO7idWkjOznrln1R7U7Gazpa0t6Vcr1H29KgTq8Ac3gZIw2qDKfCtEq5cKWNOa
 j2pYpT9d/E+1Wn+pao4OcAxzlGhnq372PmUAUocxGg4HpgiFbSEgvXHoPQrTE/46v64Itjem3
 b0n/8/MIBdCumxGGp11rJnc0GcR1OQ0976+xs1ODMUieCbcP6wrxRtCigSZ8+kHFw27WFLKMf
 AnFLXkYdFWS0jfreIj81TQRkS1XJIpQkBUUHvB8a40teO1wGBD8daTABv6Fx4UtotQ89sjmFE
 WRmXOikhoTEXSApVStLv9InEds+x2nhUMLVk0bEhjzna7IUqtXWV5uurGiQEE9lGR3YZWxuVg
 vqTvnHjTERFuVPI9Xe/0g24zS36NfJK189uJsHDjiHugbBBTdhy02v6Qp37SQLqDAt6HxjeQi
 +w7qFbxF+K0/5ymYBJEhZEXdakD/tpptqUr5QqL70xh3KDQZ+oZ4+0xQ3LjqW8958I9U8QgC9
 yXdIC2Gg3Jtb+bTiBfvYJhGC5XCl6KyR0+qSUIbtOWt1Kv60LFfo40ETMeA5cdIuohMpaHS+Y
 Vl4KXx75HYr8989MjdLQ==
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This adds a reference to the dts of the Raspberry Pi Compute Module 4
IO Board, so we don't need to maintain the content in arm64.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm64/boot/dts/broadcom/Makefile               | 1 +
 arch/arm64/boot/dts/broadcom/bcm2711-rpi-cm4-io.dts | 2 ++
 2 files changed, 3 insertions(+)
 create mode 100644 arch/arm64/boot/dts/broadcom/bcm2711-rpi-cm4-io.dts

diff --git a/arch/arm64/boot/dts/broadcom/Makefile b/arch/arm64/boot/dts/broadcom/Makefile
index 11eae3e..c688203 100644
--- a/arch/arm64/boot/dts/broadcom/Makefile
+++ b/arch/arm64/boot/dts/broadcom/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_ARCH_BCM2835) += bcm2711-rpi-400.dtb \
 			      bcm2711-rpi-4-b.dtb \
+			      bcm2711-rpi-cm4-io.dtb \
 			      bcm2837-rpi-3-a-plus.dtb \
 			      bcm2837-rpi-3-b.dtb \
 			      bcm2837-rpi-3-b-plus.dtb \
diff --git a/arch/arm64/boot/dts/broadcom/bcm2711-rpi-cm4-io.dts b/arch/arm64/boot/dts/broadcom/bcm2711-rpi-cm4-io.dts
new file mode 100644
index 0000000..e36d395
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/bcm2711-rpi-cm4-io.dts
@@ -0,0 +1,2 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "arm/bcm2711-rpi-cm4-io.dts"
-- 
2.7.4

