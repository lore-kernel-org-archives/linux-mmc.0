Return-Path: <SRS0=VpFb=4X=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24C0C10DCE
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Mar 2020 17:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C615A2084E
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Mar 2020 17:44:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbgCFRog (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 6 Mar 2020 12:44:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:60580 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727052AbgCFRoe (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 6 Mar 2020 12:44:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8D8E5AEC5;
        Fri,  6 Mar 2020 17:44:33 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     phil@raspberrypi.com, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, f.fainelli@gmail.com,
        stefan.wahren@i2se.com, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v2 11/11] ARM: dts: bcm2711: Add vmmc regulator in emmc2
Date:   Fri,  6 Mar 2020 18:44:13 +0100
Message-Id: <20200306174413.20634-12-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200306174413.20634-1-nsaenzjulienne@suse.de>
References: <20200306174413.20634-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The SD card power can be controlled trough a pin routed into the board's
external GPIO expander. Turn that into a regulator and provide it to
emmc2.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 arch/arm/boot/dts/bcm2711-rpi-4-b.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
index b0ea8233b636..a2da058396fe 100644
--- a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
+++ b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
@@ -55,6 +55,16 @@ sd_io_1v8_reg: sd_io_1v8_reg {
 			  3300000 0x0>;
 		status = "okay";
 	};
+
+	sd_vcc_reg: sd_vcc_reg {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc-sd";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		enable-active-high;
+		gpio = <&expgpio 6 GPIO_ACTIVE_HIGH>;
+	};
 };
 
 &firmware {
@@ -173,6 +183,7 @@ brcmf: wifi@1 {
 /* EMMC2 is used to drive the SD card */
 &emmc2 {
 	vqmmc-supply = <&sd_io_1v8_reg>;
+	vmmc-supply = <&sd_vcc_reg>;
 	broken-cd;
 	status = "okay";
 };
-- 
2.25.1

