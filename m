Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA62DC4320E
	for <linux-mmc@archiver.kernel.org>; Sat,  7 Aug 2021 11:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4A0760C51
	for <linux-mmc@archiver.kernel.org>; Sat,  7 Aug 2021 11:07:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbhHGLHp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 7 Aug 2021 07:07:45 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:57967 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbhHGLHo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 7 Aug 2021 07:07:44 -0400
Received: from localhost.localdomain ([37.4.249.97]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MUpCz-1mctRd1GTZ-00QiM0; Sat, 07 Aug 2021 13:07:08 +0200
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
Subject: [PATCH V2 01/10] ARM: dts: bcm2711: fix MDIO #address- and #size-cells
Date:   Sat,  7 Aug 2021 13:06:32 +0200
Message-Id: <1628334401-6577-2-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1628334401-6577-1-git-send-email-stefan.wahren@i2se.com>
References: <1628334401-6577-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:tqfvKtEzoZCEh33YB92Q1m9qtHEymKKXGP3LyZ4mP61zKuOfW+X
 B60puBofk7GAfiLTncd/XFZQVwvGNwWzXfR4NnmE0C2f8hLNydKcVoAa0wi3m+2SBw+ZoYj
 PS/nggas2vA/5NgzpdOTrfUduIo/rqII9AxAfQ5gpquBVpdK7Q5PqIhwJnXiqyZijUydFTy
 3EqKxewFa9htrjd2F3w9Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:l3vbtDbD13M=:IQbF7pqSLIQFux3euKUThn
 ZnbXABZGeJD2J8AB0VCNbF/vsKtPRPmej7EvraZDLmYBfDWK96j2m2pdIVtViGMS05CRmzyZm
 vNRpQd0948CjW9DHgocq1V5g51AvmEBJ4Wld44W3Q5iscbgUggpvpNOY0Vq91Cm2MhSUKTKjW
 rnVuxfXB9JO4B98bvMJ8CURlUbCb9eBspiMesJ9qZ+Kt48ZbdCy5o50o19sW0Ed2dPNbicEmc
 cRCPElKLXQ8EQQP9BCggWF/n+TGfdW948bUWBUTfLJg5pixFzu77F10Z2CnYb3YxE7SLpi8yn
 LeYzsoDAjEZd7S0scWxp1GF+YtliCommSob/xKefgQuhEhTrfBKI3+7fffJ3IuY7WEeNtZ9n+
 pYkLZbAbZVsZXSQchGFUUHKtUkqYXDMh9HPJiFpkBR5iBkaTUkNKKQJRBYRkOxHe2A4DHXfGw
 9Buxm0CNEar9JCaG1ebZ7MnH2ZHaohbMsxS2YQlOHbtyNuKC3KPwb6xo+xPg7FOmr6sf0xqcJ
 JwmfJkVTAvEFuPn09ybcyXKhvdsW/5z8IKGo98Rf3wxPCqVPXe7ONOb0vslnmUxXHsX1qBLWo
 ViPFfxVDShxd1qMeUsuYn9s5x6nmb3Bvl/25fvdj4b7Etw7j16T43sDGYLWvK9RDC7rpTqyQV
 gyHg42mGdvcWk7UqzqA8sfapgzvGagx82f2ES2TUG98PZrRD94dAuYdQqcdTC5ziXGwDAnZ0l
 At0HvNjQy2IN1PVyzFOXSp9r/uiR/JIjphhAeUcoznIme7BzXNIBapwMRLL3FBpWv1dP319w8
 w4vGm81Z2Q3ga03e/KfOcTJHrWCIRBAzSoDDybbZC/6BHrO2CuLiLxeAigJuQyFdNWrU++5x9
 bccT3qK6+Z5+zAS1ufHQ==
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The values of #address-cells and #size-cells are swapped. Fix this
and avoid the following DT schema warnings for mdio@e14:

 #address-cells:0:0: 1 was expected
 #size-cells:0:0: 0 was expected

Fixes: be8af7a9e3cc ("ARM: dts: bcm2711-rpi-4: Enable GENET support")
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/boot/dts/bcm2711.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/bcm2711.dtsi b/arch/arm/boot/dts/bcm2711.dtsi
index b8a4096..a0db9b0 100644
--- a/arch/arm/boot/dts/bcm2711.dtsi
+++ b/arch/arm/boot/dts/bcm2711.dtsi
@@ -532,8 +532,8 @@
 				compatible = "brcm,genet-mdio-v5";
 				reg = <0xe14 0x8>;
 				reg-names = "mdio";
-				#address-cells = <0x0>;
-				#size-cells = <0x1>;
+				#address-cells = <0x1>;
+				#size-cells = <0x0>;
 			};
 		};
 	};
-- 
2.7.4

