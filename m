From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH v3] DT: mmc: sh_mmcif: fix "compatible" property text
Date: Fri, 16 Oct 2015 01:39:39 +0300
Message-ID: <2188985.g7lrY44qCa@wasted.cogentembedded.com>
References: <201404250239.39150.sergei.shtylyov@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:33056 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753248AbbJOWjr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Oct 2015 18:39:47 -0400
Received: by lbbpp2 with SMTP id pp2so57673204lbb.0
        for <linux-mmc@vger.kernel.org>; Thu, 15 Oct 2015 15:39:46 -0700 (PDT)
In-Reply-To: <201404250239.39150.sergei.shtylyov@cogentembedded.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org

The "compatible" property text contradicts even the example given in the MMCIF
binding document itself;  moreover, the Renesas MMCIF driver only matches  on
the generic "compatible" string and doesn't look for the SoC specific strings
at all. Thus describe "renesas,sh-mmcif" as a fallback value.

Fixes: b4c27763d749 ("mmc: sh_mmcif: Document DT bindings")
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
The patch is against Ulf Hansson's 'mmc.git' repo's 'fixes' or 'next' branches.

Changes in version 3:
- reworded the "compatible" property description to look like the majority of
  the Renesas bindings.

Changes in version 2:
- kept the SoC specific "compatible" property values mandatory and made the
  generic string a fallback.

 Documentation/devicetree/bindings/mmc/renesas,mmcif.txt |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: mmc/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
===================================================================
--- mmc.orig/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
+++ mmc/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
@@ -6,11 +6,11 @@ and the properties used by the MMCIF dev
 
 Required properties:
 
-- compatible: must contain one of the following
+- compatible: should be "renesas,mmcif-<soctype>", "renesas,sh-mmcif" as a
+  fallback. Examples with <soctype> are:
 	- "renesas,mmcif-r8a7740" for the MMCIF found in r8a7740 SoCs
 	- "renesas,mmcif-r8a7790" for the MMCIF found in r8a7790 SoCs
 	- "renesas,mmcif-r8a7791" for the MMCIF found in r8a7791 SoCs
-	- "renesas,sh-mmcif" for the generic MMCIF
 
 - clocks: reference to the functional clock
 

