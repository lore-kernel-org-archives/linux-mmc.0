From: Loc Ho <lho@apm.com>
Subject: [PATCH v2 3/3] arm64: Add APM X-Gene SoC SDHC controller DTS entry
Date: Tue,  3 Jun 2014 15:13:05 -0600
Message-ID: <1401829985-5212-4-git-send-email-lho@apm.com>
References: <1401829985-5212-1-git-send-email-lho@apm.com>
 <1401829985-5212-2-git-send-email-lho@apm.com>
 <1401829985-5212-3-git-send-email-lho@apm.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og113.obsmtp.com ([64.18.0.26]:35546 "HELO
	exprod5og113.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754670AbaFCVNx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Jun 2014 17:13:53 -0400
Received: by mail-pb0-f49.google.com with SMTP id jt11so5978255pbb.22
        for <linux-mmc@vger.kernel.org>; Tue, 03 Jun 2014 14:13:52 -0700 (PDT)
In-Reply-To: <1401829985-5212-3-git-send-email-lho@apm.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: chris@printf.net, ulf.hansson@linaro.org, michal.simek@xilinx.com
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jcm@redhat.com, patches@apm.com, Loc Ho <lho@apm.com>

This patch adds APM X-Gene SoC SDHC controller DTS entry.

Signed-off-by: Loc Ho <lho@apm.com>
---
 arch/arm64/boot/dts/apm-storm.dtsi |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/boot/dts/apm-storm.dtsi b/arch/arm64/boot/dts/apm-storm.dtsi
index 6042a99..3bd09e9 100644
--- a/arch/arm64/boot/dts/apm-storm.dtsi
+++ b/arch/arm64/boot/dts/apm-storm.dtsi
@@ -436,5 +436,13 @@
 			phys = <&phy3 0>;
 			phy-names = "sata-phy";
 		};
+
+		sdhc0: sdhc@1c000000 {
+			compatible = "apm,arasan,sdhci-8.9a";
+			reg = <0x0 0x1c000000 0x0 0x100>,
+			      <0x0 0x1f2a0094 0x0 0x10>;
+			interrupts = <0x0 0x49 0x4>;
+			no-1-8-v;
+		};
 	};
 };
-- 
1.5.5

