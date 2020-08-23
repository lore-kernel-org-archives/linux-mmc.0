Return-Path: <SRS0=AKDL=CB=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A8EAC433E3
	for <linux-mmc@archiver.kernel.org>; Sun, 23 Aug 2020 16:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5257C2075B
	for <linux-mmc@archiver.kernel.org>; Sun, 23 Aug 2020 16:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598199535;
	bh=IcWdUIpZPLrTFhfMFn5K5VkjUKVluLTxZ3P2v5TWsEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PVF1N5QdJHjoPQjPhAX9ZdHE+D/zf9yePmRJW8nolVoTRy/Wj9FwWEvf2QJ85E/h2
	 4uruXTERgQRm7V+mJ06yFlHrHDkIh7uBbdXY1XNIqZ9mGNYGyIhqy1x9mA1itQci1d
	 izXM/xtLZsW/T3y26M6Q74OT3aRpd009xcHK6fQ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgHWQRX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 23 Aug 2020 12:17:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:46858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728165AbgHWQRQ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 23 Aug 2020 12:17:16 -0400
Received: from kozik-lap.proceq-device.com (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B598F20767;
        Sun, 23 Aug 2020 16:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598199435;
        bh=IcWdUIpZPLrTFhfMFn5K5VkjUKVluLTxZ3P2v5TWsEE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g7c5SyZZT6Zq8zJcs7lELf9ENGqIJrTY1K8TN0SnqUBmDOtVgzwuLqzGeDHKGyVRQ
         lj9S8EE9fqkp5cgD2AX3lCDtvNKRKtootihwVhEMWPId8da+rT2m3wXQtkwVclHGWe
         +3LUdG7rGfwqnbJILBO4DM5BJs/DnK/O2os08ITE=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 17/22] arm64: dts: imx8mq-evk: Add hog suffix to wl-reg-on
Date:   Sun, 23 Aug 2020 18:15:45 +0200
Message-Id: <20200823161550.3981-17-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200823161550.3981-1-krzk@kernel.org>
References: <20200823161550.3981-1-krzk@kernel.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

According to device tree specification, device node names should be
somewhat generic and reflecting the function of the device so add the
"hog" suffix to wl-reg-on GPIO hog.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
index 8aa9cd8e495a..a088831d2e24 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
@@ -157,7 +157,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_wifi_reset>;
 
-	wl-reg-on {
+	wl-reg-on-hog {
 		gpio-hog;
 		gpios = <29 GPIO_ACTIVE_HIGH>;
 		output-high;
-- 
2.17.1

