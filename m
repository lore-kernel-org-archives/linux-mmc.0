From: Balaji T K <balajitk@ti.com>
Subject: [PATCH 10/13] ARM: dts: omap36xx: Add omap control mmc data
Date: Tue, 30 Apr 2013 19:33:50 +0530
Message-ID: <1367330633-5941-11-git-send-email-balajitk@ti.com>
References: <1367330633-5941-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58096 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760735Ab3D3OEI (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 30 Apr 2013 10:04:08 -0400
In-Reply-To: <1367330633-5941-1-git-send-email-balajitk@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, tony@atomide.com, b-cousson@ti.com
Cc: Balaji T K <balajitk@ti.com>

Add omap-hsmmc-control data to omap630.
Update with pbias and prog_io1 register address.

Signed-off-by: Balaji T K <balajitk@ti.com>
---
 arch/arm/boot/dts/omap36xx.dtsi |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap36xx.dtsi b/arch/arm/boot/dts/omap36xx.dtsi
index 96bf028..9e396c4 100644
--- a/arch/arm/boot/dts/omap36xx.dtsi
+++ b/arch/arm/boot/dts/omap36xx.dtsi
@@ -23,3 +23,10 @@
 		};
 	};
 };
+&omap_control_mmc1 {
+	compatible = "ti,omap-hsmmc-control";
+	reg = <0x48002520 0x4>,
+	      <0x48002448 0x4>;
+	reg-names = "pbias", "prog_io1";
+	ctrl-type = <4>;
+};
-- 
1.7.5.4

