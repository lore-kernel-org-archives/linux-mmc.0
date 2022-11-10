Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C6B4C4332F
	for <linux-mmc@archiver.kernel.org>; Thu, 10 Nov 2022 15:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbiKJPIp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 10 Nov 2022 10:08:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbiKJPIm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Nov 2022 10:08:42 -0500
Received: from mx.msync.work (mx.msync.work [185.250.0.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461121E3C3;
        Thu, 10 Nov 2022 07:08:38 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 34BBB123168;
        Thu, 10 Nov 2022 15:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1668092468; h=from:subject:date:message-id:to:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=Jf+vZoPV0FHlsn9qxpwdS7gnzfJHE2b58/441SOarFU=;
        b=VQY69PSkBelUIGvZKCjlAd2YccpcG8fqZekly+G0yFZrF8r0ErEJ487D4XUuI9kD3H+VO9
        J82upNxvAUq56+os5JMz3NM3WuXqVOWrzz5dX4r4I573Pe7/6oJ3UA5iLvp84r4ZdGBcTM
        0DlTZViQHgjFDQDg1L00+K1BERqUT6ZuyrSVcLolrQ9xNxojOasoMMFJ+g0mpblzpqSt6X
        1LuqhbRCsvk8d3k29GhcXCzzyx87FUJOykY8UwR2WkuSw+21iA8Yx9JF8Mom5u+s1ibnww
        NPKlSy5JVdAL2JSt+aPxbmx3q+eMV42QBMU4J/GY4SlnXC2yff8Qm2Y/baufhw==
From:   Vyacheslav Bocharov <adeep@lexina.in>
To:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] arm64: amlogic: dts: meson: update meson-axg device-tree for new core, tx, rx phase clock settings.
Date:   Thu, 10 Nov 2022 18:00:34 +0300
Message-Id: <20221110150035.2824580-4-adeep@lexina.in>
In-Reply-To: <20221110150035.2824580-1-adeep@lexina.in>
References: <20221110150035.2824580-1-adeep@lexina.in>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Use phase 270 for core MMC clock on axg meson boards.
Tested on JetHub J100/110 devices.

Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index 04f797b5a012..0af4784d84c7 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -13,6 +13,7 @@
 #include <dt-bindings/reset/amlogic,meson-axg-audio-arb.h>
 #include <dt-bindings/reset/amlogic,meson-axg-reset.h>
 #include <dt-bindings/power/meson-axg-power.h>
+#include <dt-bindings/mmc/meson-gx-mmc.h>
 
 / {
 	compatible = "amlogic,meson-axg";
@@ -1891,6 +1892,7 @@ sd_emmc_b: sd@5000 {
 					<&clkc CLKID_SD_EMMC_B_CLK0>,
 					<&clkc CLKID_FCLK_DIV2>;
 				clock-names = "core", "clkin0", "clkin1";
+				amlogic,mmc-phase = <CLK_PHASE_270 CLK_PHASE_0 CLK_PHASE_0>;
 				resets = <&reset RESET_SD_EMMC_B>;
 			};
 
@@ -1904,6 +1906,7 @@ sd_emmc_c: mmc@7000 {
 					<&clkc CLKID_FCLK_DIV2>;
 				clock-names = "core", "clkin0", "clkin1";
 				resets = <&reset RESET_SD_EMMC_C>;
+				amlogic,mmc-phase = <CLK_PHASE_270 CLK_PHASE_0 CLK_PHASE_0>;
 			};
 
 			usb2_phy1: phy@9020 {
-- 
2.30.2

