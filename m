From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH 2/3] powerpc/esdhc: add property to disable the CMD23
Date: Tue, 11 Sep 2012 01:04:58 -0700
Message-ID: <20120911080457.GA28235@lizard>
References: <1347347565-17474-1-git-send-email-Chang-Ming.Huang@freescale.com>
 <1347347565-17474-2-git-send-email-Chang-Ming.Huang@freescale.com>
 <20120911075429.GA27028@lizard>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:42664 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751646Ab2IKIHb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Sep 2012 04:07:31 -0400
Received: by ieje11 with SMTP id e11so400455iej.19
        for <linux-mmc@vger.kernel.org>; Tue, 11 Sep 2012 01:07:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120911075429.GA27028@lizard>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chang-Ming.Huang@freescale.com
Cc: linux-mmc@vger.kernel.org, Kumar Gala <galak@kernel.crashing.org>, linuxppc-dev@lists.ozlabs.org

On Tue, Sep 11, 2012 at 12:54:29AM -0700, Anton Vorontsov wrote:
> On Tue, Sep 11, 2012 at 03:12:44PM +0800, Chang-Ming.Huang@freescale.com wrote:
> > From: Jerry Huang <Chang-Ming.Huang@freescale.com>
> > 
> > Below SOCs don't support the cmd23 command for MMC card,
> > therefore, disable it in device tree:
> > P1020, P1021, P1022, P1024, P1025 and P4080
> > 
> > Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> 
> Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>

Btw, although the patch is trivial, I guess you still want to let know
PowerPC folks about it. Adding Cc and copying the patch:

- - - -
From: Jerry Huang <Chang-Ming.Huang@freescale.com>

Below SOCs don't support the cmd23 command for MMC card,
therefore, disable it in device tree:
P1020, P1021, P1022, P1024, P1025 and P4080

Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
CC: Anton Vorontsov <cbouatmailru@gmail.com>
---
 arch/powerpc/boot/dts/fsl/p1020si-post.dtsi |    1 +
 arch/powerpc/boot/dts/fsl/p1021si-post.dtsi |    1 +
 arch/powerpc/boot/dts/fsl/p1022si-post.dtsi |    1 +
 arch/powerpc/boot/dts/fsl/p4080si-post.dtsi |    1 +
 4 files changed, 4 insertions(+)

diff --git a/arch/powerpc/boot/dts/fsl/p1020si-post.dtsi b/arch/powerpc/boot/dts/fsl/p1020si-post.dtsi
index 68cc5e7..793a30b 100644
--- a/arch/powerpc/boot/dts/fsl/p1020si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p1020si-post.dtsi
@@ -154,6 +154,7 @@
 	sdhc@2e000 {
 		compatible = "fsl,p1020-esdhc", "fsl,esdhc";
 		sdhci,auto-cmd12;
+		sdhci,no-cmd23;
 	};
 /include/ "pq3-sec3.3-0.dtsi"
 
diff --git a/arch/powerpc/boot/dts/fsl/p1021si-post.dtsi b/arch/powerpc/boot/dts/fsl/p1021si-post.dtsi
index adb82fd..2b7fd2a 100644
--- a/arch/powerpc/boot/dts/fsl/p1021si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p1021si-post.dtsi
@@ -149,6 +149,7 @@
 /include/ "pq3-esdhc-0.dtsi"
 	sdhc@2e000 {
 		sdhci,auto-cmd12;
+		sdhci,no-cmd23;
 	};
 
 /include/ "pq3-sec3.3-0.dtsi"
diff --git a/arch/powerpc/boot/dts/fsl/p1022si-post.dtsi b/arch/powerpc/boot/dts/fsl/p1022si-post.dtsi
index 06216b8..2334a52 100644
--- a/arch/powerpc/boot/dts/fsl/p1022si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p1022si-post.dtsi
@@ -215,6 +215,7 @@
 	sdhc@2e000 {
 		compatible = "fsl,p1022-esdhc", "fsl,esdhc";
 		sdhci,auto-cmd12;
+		sdhci,no-cmd23;
 	};
 
 /include/ "pq3-sec3.3-0.dtsi"
diff --git a/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi b/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi
index 8d35d2c..5b39952 100644
--- a/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi
@@ -337,6 +337,7 @@
 	sdhc@114000 {
 		voltage-ranges = <3300 3300>;
 		sdhci,auto-cmd12;
+		sdhci,no-cmd23;
 	};
 
 /include/ "qoriq-i2c-0.dtsi"
-- 
1.7.9.5
