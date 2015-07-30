From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH] DT: mmc: sh_mmcif: document R8A779[34] support
Date: Fri, 31 Jul 2015 00:29:26 +0300
Message-ID: <4675878.582hE3P2Fo@wasted.cogentembedded.com>
References: <201404250239.39150.sergei.shtylyov@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:35850 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750938AbbG3V3b (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Jul 2015 17:29:31 -0400
Received: by lbbud7 with SMTP id ud7so31246648lbb.3
        for <linux-mmc@vger.kernel.org>; Thu, 30 Jul 2015 14:29:29 -0700 (PDT)
In-Reply-To: <201404250239.39150.sergei.shtylyov@cogentembedded.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org

Renesas R8A7793 and R8A7793 SoC also have the MMCIF controller...

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
The patch is against Ulf Hansson's 'mmc.git'  repo's 'next' branch plus the
patch I posted earlier today...

 Documentation/devicetree/bindings/mmc/renesas,mmcif.txt |    2 ++
 1 file changed, 2 insertions(+)

Index: mmc/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
===================================================================
--- mmc.orig/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
+++ mmc/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
@@ -11,6 +11,8 @@ Required properties:
 	- "renesas,mmcif-r8a7740" for the MMCIF found in r8a7740 SoCs
 	- "renesas,mmcif-r8a7790" for the MMCIF found in r8a7790 SoCs
 	- "renesas,mmcif-r8a7791" for the MMCIF found in r8a7791 SoCs
+	- "renesas,mmcif-r8a7793" for the MMCIF found in r8a7793 SoCs
+	- "renesas,mmcif-r8a7794" for the MMCIF found in r8a7794 SoCs
 
 - clocks: reference to the functional clock
 

