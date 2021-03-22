Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB3FC433E5
	for <linux-mmc@archiver.kernel.org>; Mon, 22 Mar 2021 19:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1062E61994
	for <linux-mmc@archiver.kernel.org>; Mon, 22 Mar 2021 19:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbhCVS77 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 22 Mar 2021 14:59:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:40266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232292AbhCVS7g (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 22 Mar 2021 14:59:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E84396199F;
        Mon, 22 Mar 2021 18:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616439572;
        bh=s6ymiQxwePb20Kp2RAPsG0nP87bGAxMicsdfeJT0mC0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ihW3OvOyJmZH+nfKxl3tTK7pmHcaotogYNZlucLYTpV+bfEmX8LFahc17He9AAf/m
         JYU76wRHhuZgoXBcm81UnVqOTWBZ7QZThqPjO/4o4m2uv3HZ6WNpmnNdzByFxdAbOa
         pCwMes1lQIQe1TQCu8sZKhVP9oXMINdp0rSi2DAkN+ZCzhG9xl1FueQeS7894UsLjE
         WRKkaByrfxKF3JudCMmXsq/0BfMly+vdsq6CPGsIJg2k7fJ8HB1lR1B5s5AgCPSPIY
         EPehDR2OZqWhTDuYF86UL5dX8fuH5bVa4VQo97ErS7g8gf1X86AP/Ax1gzrlWGgzvc
         unuKPEE9P1JFQ==
From:   Nicolas Saenz Julienne <nsaenz@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        Saenz Julienne <nsaenz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     f.fainelli@gmail.com, phil@raspberrypi.com,
        tim.gover@raspberrypi.com, adrian.hunter@intel.com,
        sbranden@broadcom.com, alcooperx@gmail.com,
        linux-kernel@vger.kernel.org, ulf.hansson@linaro.org
Subject: [PATCH 4/4] ARM: dts: Fix-up EMMC2 controller's frequency
Date:   Mon, 22 Mar 2021 19:58:17 +0100
Message-Id: <20210322185816.27582-5-nsaenz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210322185816.27582-1-nsaenz@kernel.org>
References: <20210322185816.27582-1-nsaenz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Force emmc2's frequency to 150MHz as the default 100MHz (set by FW)
seems to interfere with the VPU clock when setup at frequencies bigger
than 500MHz (a pretty common case). This ends up causing unwarranted
SDHCI CMD hangs  when no SD card is present.

Signed-off-by: Nicolas Saenz Julienne <nsaenz@kernel.org>
---
 arch/arm/boot/dts/bcm2711-rpi-4-b.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
index 3b4ab947492a..9aa8408d9960 100644
--- a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
+++ b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
@@ -257,6 +257,12 @@ &emmc2 {
 	vqmmc-supply = <&sd_io_1v8_reg>;
 	vmmc-supply = <&sd_vcc_reg>;
 	broken-cd;
+	/*
+	 * Force the frequency to 150MHz as the default 100MHz seems to
+	 * interfere with the VPU clock when setup at frequencies bigger than
+	 * 500MHz, causing unwarranted CMD hangs.
+	 */
+	clock-frequency = <150000000>;
 	status = "okay";
 };
 
-- 
2.30.2

