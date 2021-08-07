Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF379C4320A
	for <linux-mmc@archiver.kernel.org>; Sat,  7 Aug 2021 11:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84FA860C51
	for <linux-mmc@archiver.kernel.org>; Sat,  7 Aug 2021 11:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbhHGLHs (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 7 Aug 2021 07:07:48 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:51577 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232049AbhHGLHq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 7 Aug 2021 07:07:46 -0400
Received: from localhost.localdomain ([37.4.249.97]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M4ahC-1mAgH43mUQ-001iZn; Sat, 07 Aug 2021 13:07:09 +0200
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
Subject: [PATCH V2 02/10] ARM: dts: bcm2711-rpi-4-b: fix sd_io_1v8_reg regulator states
Date:   Sat,  7 Aug 2021 13:06:33 +0200
Message-Id: <1628334401-6577-3-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1628334401-6577-1-git-send-email-stefan.wahren@i2se.com>
References: <1628334401-6577-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:rxN6Du+6J5W11kdd5uwIM540sM0r6PGy0faROvYut9l4wc13GTU
 JKIChKg5mSuHWl95yTzni4qvhvBA3XlHscPFKy4N84MyFbeU9CUdmV6huLHf1UFk9yaZvyN
 9GP6iM9jO9nzM+eR82tjGPwe7yf7dN/ErQYpw0F/8xP7VPmsJic1xFySomChY66JycjyENy
 KFasKnyF0brdlqMSrgsBA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:F0HkEPxV324=:LEj0M33wAhbZDwM2sVUHBp
 bcg2Nbd4mHaBYuuU4vSH8S9t64XxMXzRA4G3XA8LJKvd34uKLrgE80f07WyJ3c1v5XRN5EeUb
 cQmlWPhPMZ8d98YFj/DmysH6YcD4T6LMIlvjUMEtBM+LQFL/TLFJ0a8LxlmRZBpUKm0hat1MI
 lkv/yZSCAPwl3D4RFdJdG9ZD7vc3R7/M7N5IDMScKGlpi+6MAGG1CY2MGcN2I51CFxk7nG/DB
 l025Ed7OcSSuhL2AcDySNXeFuKx/tYYhW8vYrP4JNqJMn0JpEXqYfxpmm7iSdenRNXO2R1KVR
 CIN601wmfcd6XX3i5DIQvytG3WIILNXZwa9u1AKy794jsuF7F+fWcy7/wOnGyFtJv6Dl4LPKs
 fTCWBBvmNMxXrp7BmJyqJvwBZu0fM0GWvWd7xCSLLgZmyYxmMFAIhVWYd36dUDJsqUZ7Y12Rb
 sa6Yr/sGqJNtao70kh/VJotzlRl8/m0Rl2b/SG732YJ8oHjXUDXumYvsYqL08y1fqTqM1y1kG
 OKqjXrR1Mflm781wnZDOAWesiBLrPUWCU83jNJallcEPIU/MFKJ16z87h8Tr7PGqnBxAmfVmH
 BSU1fY0QW2y/pmiBzRnOpqF3cReCVXhpPoqYyKK7Bm2Ns1W38bXKZADYSjlSYbxV8LpigxmaW
 MozVRnHuDi5C+emyXqGcN6Xcex9vJ37+MlHxvvGrlxGq5jFXzoyzTj7mw+U1IiXE5gXNR3ASy
 nU6NKYkehUrJmUFmORGTM1BBtgJHGbe1Z1GAUN/8A4HbMGQXi1W7fAnbFlAybwEdDF3Jkaklo
 UadAXTl1SwW24y7t9bl2l9fusTzxsbU6D01FmW/m6S6mjAY/NN83QacLZpk8Z57A9rr0HbXPS
 XUYUDfDXRzbi9kKZOG/Q==
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

DT schema check complains at sd_io_1v8_reg about the following:

 [1800000, 1, 3300000, 0] is too long
 Additional items are not allowed (3300000, 0 were unexpected)

So fix the states definition.

Fixes: 7dbe8c62ceeb ("ARM: dts: Add minimal Raspberry Pi 4 support")
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/boot/dts/bcm2711-rpi-4-b.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
index f24bdd0..abf8298 100644
--- a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
+++ b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
@@ -40,8 +40,8 @@
 		regulator-always-on;
 		regulator-settling-time-us = <5000>;
 		gpios = <&expgpio 4 GPIO_ACTIVE_HIGH>;
-		states = <1800000 0x1
-			  3300000 0x0>;
+		states = <1800000 0x1>,
+			 <3300000 0x0>;
 		status = "okay";
 	};
 
-- 
2.7.4

