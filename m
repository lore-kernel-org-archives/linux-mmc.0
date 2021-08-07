Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B1E2C4338F
	for <linux-mmc@archiver.kernel.org>; Sat,  7 Aug 2021 11:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0228B60F38
	for <linux-mmc@archiver.kernel.org>; Sat,  7 Aug 2021 11:07:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbhHGLHo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 7 Aug 2021 07:07:44 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:46171 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbhHGLHn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 7 Aug 2021 07:07:43 -0400
Received: from localhost.localdomain ([37.4.249.97]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MZCvh-1mhJHw20lV-00V8CK; Sat, 07 Aug 2021 13:07:09 +0200
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
Subject: [PATCH V2 03/10] dt-bindings: display: bcm2835: add optional property power-domains
Date:   Sat,  7 Aug 2021 13:06:34 +0200
Message-Id: <1628334401-6577-4-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1628334401-6577-1-git-send-email-stefan.wahren@i2se.com>
References: <1628334401-6577-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:fdAi0eW6lkNHxUUv9MAiUpmpsqcYqunqRorRROAxKZe1jnLq6Xo
 AVsERlC42LCsx/Qg5DYKB+dY5EZaNISK8AITwiW/47yAoNQXU5QxIoexcqhXlEnfnbOHbwr
 Uo60f8eUPfoglTt/PTRpHqYTNAANIXfgqzRIHE9ajdhMgI0FoKi239KAeJ9dKrvHgVwMw+U
 DcddPDSfUqSNpFgGDOqpw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4qg6qOIprYg=:rXv5yT/7zrwTlvSl44ePry
 BgfAvIS7vckyq4GQMCq2Gee5zYApbvmbLpeTgZ02nnD+TucCfvmgtpmc/C+uWMRvZueBmXSY3
 CbAY58AvHSefspDsSquzm+uefL5crB1x7YscP81Mmo2lf4WSMPh+7OuAdN14Bn7BqMnLKfvVi
 BHEr4606kKjKq4obhIfYuzx5FNVVX4e0VZHnJHhyl0RMlH7dZXmV1lY2y9mlouprfOrFyPzfC
 8dV9yqYqT0TLht3WeE+PlKuAWvql4NjhjVf2XvxUvDyMtYv2sCEgJRllT/Q0c0LAL/3C7iz6U
 8+q65z3MrGzLw0PkYz7GCMzklf+puFYPc72I2bCJVY1xa2izOWjGMdSnMGMy5yo3StxZVcbOf
 qEVMxPR11mUbLgLCyh2lEBK8eWU7hlrQPqcSdilTBVCfwN9HajBUaR3UueL/+3T/6TN2lCoGm
 f5aQdJlIk9ufqvzMm5P/MYfmx3FylgoTSvUOC92Do4Uel6E3bY1nv847igpd6NmylpHhvWMnW
 2UcG9xxfXy78sp62vzFlk5OSwCp9efI0pZWSGJKO833lczFZYS1dlYmckHJR0LDlMrr8KHw4O
 maFjb90n+NGsk6eY1S+mvBgekvAWvO1/SPWAaxsu500sn+zrwri6rILpymJXiYAn9Ylqkl7Ka
 EMVyVAfIXENQFlW5txgPztnUahIoMoKYGG8bF8qgWDDL8l0ItjMusVSjp8ROcvfK0lFnUqQP4
 ELYPv3+54GAQYqIwFclt1fztgkGmxyRDD4T+GwUKShEwodOvVOEF14YUJbw4zADaB254kz1dH
 1K63epFBNoXogHqBILhbT6VQa2YzrP4sUexqf1P2QkVJb0gHEjznVF3teg+2LZZpS2ryZJidf
 BUxjeCiSClHPrcy2ZjGw==
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The Raspberry Pi boards with BCM283x needs control of the power domains
to get display components running. DT schema warns us that it's used, but not
documented as a optional property:

hdmi@7e902000: 'power-domains' does not match any of the regexes: ...

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/display/brcm,bcm2835-dsi0.yaml | 3 +++
 Documentation/devicetree/bindings/display/brcm,bcm2835-hdmi.yaml | 3 +++
 Documentation/devicetree/bindings/display/brcm,bcm2835-v3d.yaml  | 3 +++
 Documentation/devicetree/bindings/display/brcm,bcm2835-vec.yaml  | 3 +++
 4 files changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/brcm,bcm2835-dsi0.yaml b/Documentation/devicetree/bindings/display/brcm,bcm2835-dsi0.yaml
index 3260857..c8b2459 100644
--- a/Documentation/devicetree/bindings/display/brcm,bcm2835-dsi0.yaml
+++ b/Documentation/devicetree/bindings/display/brcm,bcm2835-dsi0.yaml
@@ -47,6 +47,9 @@ properties:
   interrupts:
     maxItems: 1
 
+  power-domains:
+    maxItems: 1
+
 required:
   - "#clock-cells"
   - compatible
diff --git a/Documentation/devicetree/bindings/display/brcm,bcm2835-hdmi.yaml b/Documentation/devicetree/bindings/display/brcm,bcm2835-hdmi.yaml
index 031e35e..48c8cad 100644
--- a/Documentation/devicetree/bindings/display/brcm,bcm2835-hdmi.yaml
+++ b/Documentation/devicetree/bindings/display/brcm,bcm2835-hdmi.yaml
@@ -51,6 +51,9 @@ properties:
   dma-names:
     const: audio-rx
 
+  power-domains:
+    maxItems: 1
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/display/brcm,bcm2835-v3d.yaml b/Documentation/devicetree/bindings/display/brcm,bcm2835-v3d.yaml
index 8a73780..c55a821 100644
--- a/Documentation/devicetree/bindings/display/brcm,bcm2835-v3d.yaml
+++ b/Documentation/devicetree/bindings/display/brcm,bcm2835-v3d.yaml
@@ -24,6 +24,9 @@ properties:
   interrupts:
     maxItems: 1
 
+  power-domains:
+    maxItems: 1
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/display/brcm,bcm2835-vec.yaml b/Documentation/devicetree/bindings/display/brcm,bcm2835-vec.yaml
index 9b24081..5d921e3 100644
--- a/Documentation/devicetree/bindings/display/brcm,bcm2835-vec.yaml
+++ b/Documentation/devicetree/bindings/display/brcm,bcm2835-vec.yaml
@@ -24,6 +24,9 @@ properties:
   interrupts:
     maxItems: 1
 
+  power-domains:
+    maxItems: 1
+
 required:
   - compatible
   - reg
-- 
2.7.4

