From: Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH v2 1/2] mmc: sdhci-iproc: Add brcm,sdhci-iproc compat string in bindings document
Date: Tue,  1 Nov 2016 09:37:56 -0700
Message-ID: <1478018277-10097-2-git-send-email-scott.branden@broadcom.com>
References: <1478018277-10097-1-git-send-email-scott.branden@broadcom.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f170.google.com ([209.85.192.170]:35273 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751592AbcKAQiR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Nov 2016 12:38:17 -0400
Received: by mail-pf0-f170.google.com with SMTP id i88so4283954pfk.2
        for <linux-mmc@vger.kernel.org>; Tue, 01 Nov 2016 09:38:16 -0700 (PDT)
In-Reply-To: <1478018277-10097-1-git-send-email-scott.branden@broadcom.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Scott Branden <scott.branden@broadcom.com>, Anup Patel <anup.patel@broadcom.com>

Adds brcm,sdhci-iproc compat string to DT bindings document for
the iProc SDHCI driver.

Signed-off-by: Anup Patel <anup.patel@broadcom.com>
Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt b/Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt
index be56d2b..954561d 100644
--- a/Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt
+++ b/Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt
@@ -7,6 +7,15 @@ Required properties:
 - compatible : Should be one of the following
 	       "brcm,bcm2835-sdhci"
 	       "brcm,sdhci-iproc-cygnus"
+	       "brcm,sdhci-iproc"
+
+Use brcm2835-sdhci for Rasperry PI.
+
+Use sdhci-iproc-cygnus for Broadcom SDHCI Controllers
+restricted to 32bit host accesses to SDHCI registers.
+
+Use sdhci-iproc for Broadcom SDHCI Controllers that allow standard
+8, 16, 32-bit host access to SDHCI register.
 
 - clocks : The clock feeding the SDHCI controller.
 
-- 
2.5.0

